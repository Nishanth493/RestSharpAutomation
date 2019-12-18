Feature: GetHouseHoldDetailsByHouseholdID


	@AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Positive
	@Positive
	Scenario Outline: AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then response should have "householdId,webHouseholdId,advisorContractId,agentSiebelID,riskProfile,firstName,lastName,displayName,sortName,advisorID,phone,fax,email,address1" fields
	Then response should match "response.householdId" as "CA5ZQ9" 
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9|

	@AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Negative
	@Negative
	Scenario Outline: AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/|

	@AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Negative_InvalidHouseHoldID
	@Negative
	Scenario Outline: AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9|

	@AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Negative_HouseHoldIDWithSpecialCharacters
	@Negative
	Scenario Outline: AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA#$Q9|

@AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Negative_WithoutLogin
Scenario Outline: AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                        
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9|


@AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Negative_WithOtherUserLogin
Scenario Outline: AdvisorContracts_GetHouseHoldDetailsByHouseholdID_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                         
	| AG1634 | householdaccountservice_URL,households/CA3KD2|

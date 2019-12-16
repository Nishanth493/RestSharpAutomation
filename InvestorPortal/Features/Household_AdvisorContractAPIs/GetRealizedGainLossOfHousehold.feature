Feature: GetRealizedGainLossOfHousehold
	In order to avoid silly mistakes
	As a math idiot
	I want to be told the sum of two numbers

@Household_GetRealizedGainLossOfHousehold_Positive
@positive
Scenario Outline: Household_GetRealizedGainLossOfHousehold_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then response should have "shortTerm,longTerm,longTermDistribution,shortTermDistribution,firstPurchaseDate,lastPurchaseDate,firstSaleDate,lastSaleDate,proceeds,holdings,gainLossAmount" fields
	#Then response should match "response.advisorContractId" as "AG1634" for household details
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/realizedgainloss/2009-01-06/2019-11-01|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/realizedgainloss/2009-01-06/2019-11-01?page=3&pageSize=500|

@Household_GetRealizedGainLossOfHousehold_Negative
@negative
Scenario Outline: Household_GetRealizedGainLossOfHousehold_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households//realizedgainloss/2009-01-06/2019-11-01|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/realizedgainloss//2019-11-01|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/realizedgainloss/2009-01-06/|


	@Household_GetRealizedGainLossOfHousehold_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: Household_GetRealizedGainLossOfHousehold_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/realizedgainloss/2009-01-06/2019-11-01?page=3&pageSize=500|

	@Household_GetRealizedGainLossOfHousehold_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: Household_GetRealizedGainLossOfHousehold_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5@#$%/realizedgainloss/2009-01-06/2019-11-01?page=3&pageSize=500|

@Household_GetRealizedGainLossOfHousehold_Negative_WithoutLogin
Scenario Outline: Household_GetRealizedGainLossOfHousehold_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                        
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/realizedgainloss/2009-01-06/2019-11-01?page=3&pageSize=500|


@Household_GetRealizedGainLossOfHousehold_Negative_WithOtherUserLogin
Scenario Outline: Household_GetRealizedGainLossOfHousehold_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                         
	| AG1634 | householdaccountservice_URL,households/CA3KD2/realizedgainloss/2009-01-06/2019-11-01?page=3&pageSize=500|

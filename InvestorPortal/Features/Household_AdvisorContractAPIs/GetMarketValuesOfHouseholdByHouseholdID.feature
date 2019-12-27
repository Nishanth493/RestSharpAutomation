Feature: GetMarketValuesOfHouseholdByHouseholdID
API URL : /api/householdaccountservice/v1/households/{householdid}/marketvaluesummary/{fromdate}/{todate}

@positive
Scenario Outline: Household_GetMarketValuesOfHousehold_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketValuesDetails>" API
	Then response should have "beginningValue,endingValue,netContribution,period,periodStartDate,portFolioGainLoss" fields
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetMarketValuesDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/marketvaluesummary/2009-01-06/2019-11-01|

@negative
Scenario Outline: Household_GetMarketValuesOfHousehold_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketValuesDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetMarketValuesDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households//marketvaluesummary//|

	@negative
	Scenario Outline: Household_GetMarketValuesOfHousehold_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketValuesDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetMarketValuesDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5/marketvaluesummary/2009-01-06/2019-11-01|

	@negative
	Scenario Outline: Household_GetMarketValuesOfHousehold_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketValuesDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetMarketValuesDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5@#$/marketvaluesummary/2009-01-06/2019-11-01|

@negative
Scenario Outline: Household_GetMarketValuesOfHousehold_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetMarketValuesDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetMarketValuesDetails                                  |                                        
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/marketvaluesummary/2009-01-06/2019-11-01|

@negative
Scenario Outline: Household_GetMarketValuesOfHousehold_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketValuesDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetMarketValuesDetails                                  |                                         
	| AG1634 | householdaccountservice_URL,households/CA3KD2/marketvaluesummary/2009-01-06/2019-11-01|

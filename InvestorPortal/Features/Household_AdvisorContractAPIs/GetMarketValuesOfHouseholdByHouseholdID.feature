Feature: GetMarketValuesOfHouseholdByHouseholdID
API URL : /api/householdaccountservice/v1/households/{householdid}/marketvaluesummary/{fromdate}/{todate}

@Household_GetMarketValuesOfHouseholdByHouseholdID_Positive
@Positive
Scenario Outline: Household_GetMarketValuesOfHousehold_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then response should have "beginningValue,endingValue,netContribution,period,periodStartDate,portFolioGainLoss" fields
	#Then response should match "response.advisorContractId" as "AG1634" for household details
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/marketvaluesummary/2009-01-06/2019-11-01|

@Household_GetMarketValuesOfHousehold_Negative
@Negative
Scenario Outline: Household_GetMarketValuesOfHousehold_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households//marketvaluesummary//|


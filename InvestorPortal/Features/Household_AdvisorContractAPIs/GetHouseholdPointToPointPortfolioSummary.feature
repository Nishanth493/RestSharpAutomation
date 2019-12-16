Feature: GetHouseholdPointToPointPortfolioSummary


	@Household_GetHouseholdPointToPointPortfolioSummary_Positive
	@positive
	Scenario Outline: Household_GetHouseholdPointToPointPortfolioSummary_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then response should have "accountPerformanceSummary,benchmarkPerformanceSummary,netContribution,grossContribution,netReturn" fields
	Then response should match "response.householdId" as "CA5ZQ9"
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                                              |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/performancesummary/pointtopoint?startDate=2017-08-02&endDate=2019-02-08|

	@Household_GetHouseholdPointToPointPortfolioSummary_Negative
	@negative
	Scenario Outline: Household_GetHouseholdPointToPointPortfolioSummary_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                                              |
	| AG1634 | householdaccountservice_URL,households//performancesummary/pointtopoint|

	@Household_GetHouseholdPointToPointPortfolioSummary_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: Household_GetHouseholdPointToPointPortfolioSummary_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/performancesummary/pointtopoint?startDate=2017-08-02&endDate=2019-02-08|

	@Household_GetHouseholdPointToPointPortfolioSummary_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: Household_GetHouseholdPointToPointPortfolioSummary_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/C@#$@&/performancesummary/pointtopoint?startDate=2017-08-02&endDate=2019-02-08|

@Household_GetHouseholdPointToPointPortfolioSummary_Negative_WithoutLogin
Scenario Outline: Household_GetHouseholdPointToPointPortfolioSummary_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                        
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/performancesummary/pointtopoint?startDate=2017-08-02&endDate=2019-02-08|

@Household_GetHouseholdPointToPointPortfolioSummary_Negative_WithOtherUserLogin
Scenario Outline: Household_GetHouseholdPointToPointPortfolioSummary_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                         
	| AG1634 | householdaccountservice_URL,households/CA3KD2/performancesummary/pointtopoint?startDate=2017-08-02&endDate=2019-02-08|

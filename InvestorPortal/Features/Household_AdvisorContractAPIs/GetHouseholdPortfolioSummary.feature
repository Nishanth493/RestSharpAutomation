Feature: GetHouseholdPortfolioSummary
API URL: /api/householdaccountservice/v1/households/{householdid}/performancesummary


@Household_GetHouseholdPortfolioSummary_Positive
@positive
Scenario Outline: Household_GetHouseholdPortfolioSummary_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then response should have "sinceInceptionPerformance,sinceInceptionPerformanceMonthEnd,mtdPerformance,sixMonthPerformance,ytdPerformance" fields
	Then response should match "response.benchmarks.[*].asOfDate" as "2019-01-31T00:00:00"
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                                              |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/performancesummary?endDate=2019-01-31 |

@Household_GetHouseholdPortfolioSummary_Negative
@negative
Scenario Outline: Household_GetHouseholdPortfolioSummary_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                              |
	| AG1634 | householdaccountservice_URL,households//performancesummary|

	@Household_GetHouseholdPortfolioSummary_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: Household_GetHouseholdPortfolioSummary_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/performancesummary?endDate=2019-01-31 |

	@Household_GetHouseholdPortfolioSummary_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: Household_GetHouseholdPortfolioSummary_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5*&%$/performancesummary?endDate=2019-01-31 |

@Household_GetHouseholdPortfolioSummary_Negative_WithoutLogin
Scenario Outline: Household_GetHouseholdPortfolioSummary_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                        
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/performancesummary?endDate=2019-01-31 |


@Household_GetHouseholdPortfolioSummary_Negative_WithOtherUserLogin
Scenario Outline: Household_GetHouseholdPortfolioSummary_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                         
	| AG1634 | householdaccountservice_URL,households/CA3KD2/performancesummary?endDate=2019-01-31 |

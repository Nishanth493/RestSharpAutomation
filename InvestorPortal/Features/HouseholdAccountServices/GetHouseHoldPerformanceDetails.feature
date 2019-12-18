Feature: GetHouseHoldPerformanceDetails
URL: /api/householdaccountservice/v1/households/{householdid}/householdperformance/{startdate}/{enddate}/{periodtype}

@positive
@HouseHoldPerformanceDetails_StartDate_EndDate_PeriodTye
Scenario Outline: Verify household performance details for period type with parameter as start date end date and period type
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>,<PeriodType>" API
	Then response should have "accountNumber,accountName,beginningMV,endMV,netContributions,portfolioGainLoss,oneYearRoR,sinceInceptionRoR,benchMarkOneYearRoR,benchMarkSinceInceptionRoR,beginDate,endDate,cumPortfolio,accountId" fields
	Then response should match "response.beginDate" as "2009-01-06T00:00:00"
	Then response should match "response.cumPortfolio.accountId" as "CA5ZQ9"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| PeriodType | Agent  | GetHouseHoldPerformanceDetails                                                                     |
		| /Daily     | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/2009-01-06,/2019-11-01 |
		| /Weekly    | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/2009-01-06,/2019-11-01 |
		| /Monthly   | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/2009-01-06,/2019-11-01 |
		| /Quarterly | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/2009-01-06,/2019-11-01 |
		| /Yearly    | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/2009-01-06,/2019-11-01 |

@negative
@HouseHoldPerformanceDetails_InvalidStartDate_InvalidEndDate_InvalidPeriodType
Scenario Outline: Verify household performance details are not displayed for invalid start date, end date and period type
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>,<PeriodType>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| PeriodType | Agent  | GetHouseHoldPerformanceDetails                                                                     |
		| /Daily     | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/,/2019-11-01           |
		| /Weekly    | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/#$%#%#%,/              |
		| /Monthly   | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/2009-01-06,/           |
		| /Quarterly | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/,/                     |
		| /Yearly    | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/,/#$%#%#%              |
		| /#$%#%#%   | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/2009-01-06,/2019-11-01 |

@negative
@HouseHoldPerformanceDetails_WithoutLogin
Scenario Outline: Verify household performance details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldPerformanceDetails>,<PeriodType>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| PeriodType | Agent  | GetHouseHoldPerformanceDetails                                                                     |
		| /Weekly    | AG1634 | householdaccountservice_URL,households/,household_ID,/householdperformance,/2009-01-06,/2019-11-01 |

@negative
@HouseHoldPerformanceDetails_WithOtherUserLogin
Scenario Outline: Verify household performance details are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>,<PeriodType>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| PeriodType | Agent  | GetHouseHoldPerformanceDetails                                                                               |
		| /Monthly   | AG1634 | householdaccountservice_URL,households/,OtherAgentHousehold_ID,/householdperformance,/2009-01-06,/2019-11-01 |

@negative
@HouseHoldPerformanceDetails_InvalidHouseHoldID
Scenario Outline: Verify household performance details are not displayed for invalid householdid that is #$%#%##
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>,<PeriodType>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| PeriodType | Agent  | GetHouseHoldPerformanceDetails                                                                            |
		| /Monthly   | AG1634 | householdaccountservice_URL,households/,Invalidhousehold_ID,/householdperformance,/2009-01-06,/2019-11-01 |
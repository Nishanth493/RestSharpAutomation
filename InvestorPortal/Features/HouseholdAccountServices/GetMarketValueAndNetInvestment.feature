Feature: GetMarketValueAndNetInvestment
URL: /api/householdaccountservice/v1/households/{householdid}/marketvalueandnetinvestment/{startdate}/{enddate}/{periodtype}

@positive @GetMarketValueAndNetInvestment @StartDate_EndDate_PeriodTye
Scenario Outline: Verify market value and investment details for period type with parameter as start date end date and period type
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketValueAndNetInvestment>,<PeriodType>" API
	Then response should have "date,marketValue,netInvestment" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| PeriodType | Agent  | GetMarketValueAndNetInvestment                                                                            |
		| /Daily     | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/2009-01-06,/2019-11-01 |
		| /Weekly    | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/2009-01-06,/2019-11-01 |
		| /Monthly   | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/2009-01-06,/2019-11-01 |
		| /Quarterly | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/2009-01-06,/2019-11-01 |
		| /Yearly    | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/2009-01-06,/2019-11-01 |

@negative @GetMarketValueAndNetInvestment @InvalidStartDate_InvalidEndDate_InvalidPeriodTye
Scenario Outline: Verify market value and investment details are not displayed for invalid start date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketValueAndNetInvestment>,<PeriodType>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| PeriodType | Agent  | GetMarketValueAndNetInvestment                                                                            |
		| /Daily     | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/2009-01-06,/           |
		| /Weekly    | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/#$%#%#%,/              |
		| /Monthly   | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/,/2019-11-01           |
		| /Quarterly | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/,/                     |
		| /Yearly    | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/,/#$%#%#%              |
		| /#$%#%#%   | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/2009-01-06,/2019-11-01 |

@negative @GetMarketValueAndNetInvestment @StartDate_EndDate_PeriodTye_WithoutLogin
Scenario Outline: Verify market value and investment details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetMarketValueAndNetInvestment>,<PeriodType>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| PeriodType | Agent  | GetMarketValueAndNetInvestment                                                                            |
		| /Weekly    | AG1634 | householdaccountservice_URL,households/,household_ID,/marketvalueandnetinvestment,/2009-01-06,/2019-11-01 |

@negative @GetMarketValueAndNetInvestment @StartDate_EndDate_PeriodTye_WithOtherUserLogin
Scenario Outline: Verify market value and investment details are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketValueAndNetInvestment>,<PeriodType>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| PeriodType | Agent  | GetMarketValueAndNetInvestment                                                                                      |
		| /Monthly   | AG1634 | householdaccountservice_URL,households/,OtherAgentHousehold_ID,/marketvalueandnetinvestment,/2009-01-06,/2019-11-01 |

@negative @GetMarketValueAndNetInvestment @StartDate_EndDate_PeriodTye_InvalidHouseHoldID
Scenario Outline: Verify market value and investment details are not displayed for invalid householdid that is #$%#%##
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketValueAndNetInvestment>,<PeriodType>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| PeriodType | Agent  | GetMarketValueAndNetInvestment                                                                                   |
		| /Monthly   | AG1634 | householdaccountservice_URL,households/,Invalidhousehold_ID,/marketvalueandnetinvestment,/2009-01-06,/2019-11-01 |
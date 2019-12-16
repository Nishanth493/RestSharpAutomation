Feature: GetAccountMarketValueAndNetInvestment
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/marketvalueandnetinvestment/{startdate}/{enddate}/{periodtype}

@accounts
@get_account_market_value_and_net_investment
@positive
Scenario Outline: Get account Market value and Net Investment for
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<MarketValueAndNetInvestmentOfAnAccount>,/,<startDate>,/,<endDate>,/,<PeriodType>" API
	Then Status Code is "200"
	Then response should have "date,marketValue,netInvestment" fields
	Then response should match "Response.[0].date" as "<startDate>T00:00:00"
	#Then User validates data for "<PeriodType>" frequency using ".date" element of JSON response

	Examples:
		| PeriodType | Agent  | MarketValueAndNetInvestmentOfAnAccount                                    | startDate  | endDate    |
		| Daily      | AG1634 | householdaccountservice_URL,accounts/,AC5996,/marketvalueandnetinvestment | 2017-08-02 | 2019-02-08 |
		| Weekly     | AG1634 | householdaccountservice_URL,accounts/,AC5996,/marketvalueandnetinvestment | 2017-08-02 | 2017-08-09 |
		| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AC5996,/marketvalueandnetinvestment | 2017-08-02 | 2017-09-03 |
		| Quarterly  | AG1634 | householdaccountservice_URL,accounts/,AC5996,/marketvalueandnetinvestment | 2017-08-02 | 2017-30-04 |
		| Yearly     | AG1634 | householdaccountservice_URL,accounts/,AC5996,/marketvalueandnetinvestment | 2017-08-02 | 2018-30-04 |

@accounts
@get_account_market_value_and_net_investment
@negative
Scenario Outline: Get Market value and Net Investment using invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<MarketValueAndNetInvestmentOfAnAccount>,<PeriodType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | MarketValueAndNetInvestmentOfAnAccount                                                          | PeriodType |
		| AG1634 | householdaccountservice_URL,accounts/,1111,/marketvalueandnetinvestment,/2017-08-02,/2019-02-08 | /Daily     |

@accounts
@get_account_market_value_and_net_investment
@negative
Scenario Outline: Get Market value and Net Investment using blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<MarketValueAndNetInvestmentOfAnAccount>,<PeriodType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | MarketValueAndNetInvestmentOfAnAccount                                                      | PeriodType |
		| AG1634 | householdaccountservice_URL,accounts/,,/marketvalueandnetinvestment,/2017-08-02,/2019-02-08 | /Daily     |

@accounts
@get_account_market_value_and_net_investment
@negative
Scenario Outline: Get Market value and Net Investment using invalid start date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<MarketValueAndNetInvestmentOfAnAccount>,<PeriodType>" API
	Then Status Code is "400"
	Then Response should be returned as empty

	Examples:
		| Agent  | MarketValueAndNetInvestmentOfAnAccount                                                            | PeriodType |
		| AG1634 | householdaccountservice_URL,accounts/,AH0R21,/marketvalueandnetinvestment,/2300-08-02,/2019-02-08 | /Yearly    |

@accounts
@get_account_market_value_and_net_investment
@negative
Scenario Outline: Get Market value and Net Investment without authorization
	Given User is not authorised on eWM
	When User do a get call of "<MarketValueAndNetInvestmentOfAnAccount>,<PeriodType>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| Agent  | MarketValueAndNetInvestmentOfAnAccount                                                            | PeriodType |
		| AG1634 | householdaccountservice_URL,accounts/,AH0R21,/marketvalueandnetinvestment,/2017-08-02,/2019-02-08 | /Weekly    |

@accounts
@get_account_market_value_and_net_investment
@negative
Scenario Outline: Get Market value and Net Investment if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<MarketValueAndNetInvestmentOfAnAccount>,<PeriodType>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| Agent  | MarketValueAndNetInvestmentOfAnAccount                                                            | PeriodType |
		| AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/marketvalueandnetinvestment,/2017-08-02,/2019-02-08 | /Monthly   |

@accounts
@get_account_market_value_and_net_investment
@negative
Scenario Outline: Get Market value and Net Investment for invalid period Type
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<MarketValueAndNetInvestmentOfAnAccount>,<PeriodType>" API
	Then Status Code is "400"
	Then Response should be returned as empty

	Examples:
		| Agent  | MarketValueAndNetInvestmentOfAnAccount                                                            | PeriodType  |
		| AG1634 | householdaccountservice_URL,accounts/,AH0R21,/marketvalueandnetinvestment,/2017-08-02,/2019-02-08 | /PeriodType |

@accounts
@get_account_market_value_and_net_investment
@negative
Scenario Outline: Get Market value and Net Investment for blank period Type
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<MarketValueAndNetInvestmentOfAnAccount>,<PeriodType>" API
	Then Status Code is "400"
	Then Response should be returned as empty

	Examples:
		| Agent  | MarketValueAndNetInvestmentOfAnAccount                                                            | PeriodType |
		| AG1634 | householdaccountservice_URL,accounts/,AH0R21,/marketvalueandnetinvestment,/2017-08-02,/2019-02-08 | /          |
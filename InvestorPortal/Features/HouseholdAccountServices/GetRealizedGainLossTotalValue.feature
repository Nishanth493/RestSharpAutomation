Feature: GetRealizedGainLossTotalValue
URL: /api/householdaccountservice/v1/households/{householdid}/realizedgainlosstotalvalue/{startdate}/{enddate}

@positive @GetRealizedGainLossTotalValue @StartDate_EndDate
Scenario Outline: Verify realizedGainLoss total value of an household with parameter as start date end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetRealizedGainLossTotalValue>" API
	Then response should have "totalCost,totalProceeds,totalGainLossAmount" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| GetRealizedGainLossTotalValue                                                                                                          | Agent  |
		| householdaccountservice_URL,households/,household_ID,/realizedgainlosstotalvalue,/2009-01-06,/2019-11-01                               | AG1634 |
		| householdaccountservice_URL,households/,household_ID,/realizedgainlosstotalvalue,/2009-01-06,/2019-11-01?gainLossType=All              | AG1634 |
		| householdaccountservice_URL,households/,household_ID,/realizedgainlosstotalvalue,/2009-01-06,/2019-11-01?gainLossType=ShortTerm        | AG1634 |
		| householdaccountservice_URL,households/,household_ID,/realizedgainlosstotalvalue,/2009-01-06,/2019-11-01?gainLossType=LongTerm         | AG1634 |
		| householdaccountservice_URL,households/,household_ID,/realizedgainlosstotalvalue,/2009-01-06,/2019-11-01?gainLossType=TermDistribution | AG1634 |
		| householdaccountservice_URL,households/,household_ID,/realizedgainlosstotalvalue,/2009-01-06,/2019-11-01?gainLossType=UnClassified     | AG1634 |

@negative @GetRealizedGainLossTotalValue @InvalidStartDate_InvalidEndDate
Scenario Outline: Verify realizedGainLoss total value of an household details are not displayed for invalid start date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetRealizedGainLossTotalValue>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| GetRealizedGainLossTotalValue                                                                  | Agent  |
		| householdaccountservice_URL,households/,household_ID,/realizedgainlosstotalvalue,/,/2019-11-01 | AG1634 |
		| householdaccountservice_URL,households/,household_ID,/realizedgainlosstotalvalue,/2009-01-06,/ | AG1634 |
		| householdaccountservice_URL,households/,household_ID,/realizedgainlosstotalvalue,/,/           | AG1634 |

@negative @GetRealizedGainLossTotalValue @WithoutLogin
Scenario Outline: Verify realizedGainLoss total value of an household details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetRealizedGainLossTotalValue>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| Agent  | GetRealizedGainLossTotalValue                                                                            |
		| AG1634 | householdaccountservice_URL,households/,household_ID,/realizedgainlosstotalvalue,/2009-01-06,/2019-11-01 |

@negative @GetRealizedGainLossTotalValue @WithOtherUserLogin
Scenario Outline: Verify realizedGainLoss total value of an household are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetRealizedGainLossTotalValue>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| Agent  | GetRealizedGainLossTotalValue                                                                                      |
		| AG1634 | householdaccountservice_URL,households/,OtherAgentHousehold_ID,/realizedgainlosstotalvalue,/2009-01-06,/2019-11-01 |

@negative @GetRealizedGainLossTotalValue @InvalidHouseHoldID
Scenario Outline: Verify realizedGainLoss total value details are not displayed for invalid householdid that is #$%#%##
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetRealizedGainLossTotalValue>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| Agent  | GetRealizedGainLossTotalValue                                                                                   |
		| AG1634 | householdaccountservice_URL,households/,Invalidhousehold_ID,/realizedgainlosstotalvalue,/2009-01-06,/2019-11-01 |
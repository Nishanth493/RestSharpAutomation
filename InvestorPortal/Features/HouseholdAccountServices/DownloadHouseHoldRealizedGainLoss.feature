Feature: DownloadHouseHoldRealizedGainLoss

@DownloadHouseHoldRealizedGainLossDetails_PositiveCase_StartDate_EndDate
Scenario Outline: Verify download realized gain loss file is getting download with parameter as start date end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<DownloadHouseHoldRealizedGainLoss>" API
	Then response should have "Account Name,Account Number,Account Status,Position,Type" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Agent  | DownloadHouseHoldRealizedGainLoss                                                                                  |
		| AG1634 | householdaccountservice_URL,households/,CA0FZ5household_ID,/realizedgainloss/download/2009-01-06/2019-11-01?type=1 |

@DownloadHouseHoldRealizedGainLossDetails_NegativeCase_InvalidStartDate_InvalidEndDate
Scenario Outline: Verify download realized gain loss file in not downloading for invalid start date and end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<DownloadHouseHoldRealizedGainLoss>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| Agent  | DownloadHouseHoldRealizedGainLoss                                                                               |
		| AG1634 | householdaccountservice_URL,households/,CA0FZ5household_ID,/realizedgainloss/download/2009-01-06/#$#^#%@?type=1 |

@DownloadHouseHoldRealizedGainLossDetails_NegativeCase_WithoutLogin
Scenario Outline: Verify download realized gain loss file is not downloading without authorization
	Given User is not authorised on eWM
	When User do a get call of "<DownloadHouseHoldRealizedGainLoss>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| Agent  | DownloadHouseHoldRealizedGainLoss                                                                                  |
		| AG1634 | householdaccountservice_URL,households/,CA0FZ5household_ID,/realizedgainloss/download/2009-01-06/2019-11-01?type=1 |

@DownloadHouseHoldRealizedGainLossDetails_NegativeCase_WithOtherUserLogin
Scenario Outline: Verify download realized gain loss file in not downloading if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<DownloadHouseHoldRealizedGainLoss>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| Agent  | DownloadHouseHoldRealizedGainLoss                                                                                      |
		| AG1634 | householdaccountservice_URL,households/,OtherAgentHousehold_ID,/realizedgainloss/download/2009-01-06/2019-11-01?type=1 |

@DownloadHouseHoldRealizedGainLossDetails_NegativeCase_InvalidHouseHoldID
Scenario Outline: Verify download realized gain loss file in not downloading for invalid householdid that is #$%#%##
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<DownloadHouseHoldRealizedGainLoss>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| Agent  | DownloadHouseHoldRealizedGainLoss                                                                                   |
		| AG1634 | householdaccountservice_URL,households/,Invalidhousehold_ID,/realizedgainloss/download/2009-01-06/2019-11-01?type=1 |
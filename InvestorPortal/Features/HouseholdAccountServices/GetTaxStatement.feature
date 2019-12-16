Feature: GetTaxStatement

@TaxStatementDetails_PositiveCase_StartDate_EndDate
Scenario Outline: Verify tax statement details for with parameter as start date end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetTaxStatement>" API
	#Then response should have "agentId,clientId,clientName,comments,fileName,rawID,storeUrl,createdBy,createdOn,id" fields
	#Then response should be match "response.[*].agentId" as "AgentDetails_ID"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Agent  | GetTaxStatement                                                                          |
		| AG1634 | documentshousehold_URL,CA0FZ5household_ID,/pershing/statements/tax/2009-01-06/2019-12-10 |

@TaxStatementDetails_NegativeCase_InvalidStartDate_InvalidEndDate
Scenario Outline: Verify tax statement details are not displayed for invalid start date and end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetTaxStatement>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| Agent  | GetTaxStatement                                                                       |
		| AG1634 | documentshousehold_URL,CA0FZ5household_ID,/pershing/statements/tax/#$#$#@%/2019-12-10 |

@TaxStatementDetails_NegativeCase_WithoutLogin
Scenario Outline: Verify tax statement details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetTaxStatement>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| Agent  | GetTaxStatement                                                                          |
		| AG1634 | documentshousehold_URL,CA0FZ5household_ID,/pershing/statements/tax/2009-01-06/2019-12-10 |

@TaxStatementDetails_NegativeCase_WithOtherUserLogin
Scenario Outline: Verify tax statement are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetTaxStatement>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| Agent  | GetTaxStatement                                                                              |
		| AG1634 | documentshousehold_URL,OtherAgentHousehold_ID,/pershing/statements/tax/2009-01-06/2019-12-10 |
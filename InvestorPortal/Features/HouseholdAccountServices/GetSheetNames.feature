Feature: GetSheetNames

@SheetNamesDetails_PositiveCase
Scenario Outline: Verify sheet names details
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetSheetNames>" API
	Then response should have "sheetName,modelName,strategistSheetType,managerSheetType" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| GetSheetNames                                             | Agent  |
		| documentshousehold_URL,CA0FZ5household_ID,/factsheetnames | AG1634 |

@SheetNamesDetails_NegativeCase_InvalidURL
Scenario Outline: Verify sheet names are not displayed for invalid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetSheetNames>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| GetSheetNames                                                 | Agent  |
		| documentshousehold_URL,CA0FZ5household_ID,/factsheetnames/abc | AG1634 |

@SheetNamesDetails_NegativeCase_WithoutLogin
Scenario Outline: Verify sheetn names details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetSheetNames>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| GetSheetNames                                             | Agent  |
		| documentshousehold_URL,CA0FZ5household_ID,/factsheetnames | AG1634 |

@SheetNamesDetails_NegativeCase_WithOtherUserLogin
Scenario Outline: Verify sheet names are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetSheetNames>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| GetSheetNames                                             | Agent  |
		| documentshousehold_URL,CA0FZ5household_ID,/factsheetnames | AG1634 |
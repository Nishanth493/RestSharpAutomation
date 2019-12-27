Feature: GetDefaultIntroduction
URL: /api/advisorcontracts/v1/defaultintroduction

@positive @GetDefaultIntroduction @ValidData
Scenario Outline: Verify default introduction text
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDefaultIntroduction>" API
	Then response contains "We believe an investment portfolio should be based on a thorough"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| GetDefaultIntroduction                   | Agent  |
		| advisorcontracts_URL,defaultintroduction | AG1634 |

@negative @GetDefaultIntroduction @InvalidURL
Scenario Outline: Verify default introduction details are not displayed for invalid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDefaultIntroduction>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| GetDefaultIntroduction                       | Agent  |
		| advisorcontracts_URL,defaultintroduction/abc | AG1634 |

@negative @GetDefaultIntroduction @WithoutLogin
Scenario Outline: Verify default introduction details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetDefaultIntroduction>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| GetDefaultIntroduction                   | Agent  |
		| advisorcontracts_URL,defaultintroduction | AG1634 |
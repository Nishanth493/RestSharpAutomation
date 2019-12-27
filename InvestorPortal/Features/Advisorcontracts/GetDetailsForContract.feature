Feature: GetDetailsForContract
URL: /api/advisorcontracts/v1/{id}

@positive @GetDetailsForContract @ValidData
Scenario Outline: Verify details of contract id
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDetailsForContract>" API
	Then response should have "id,logo,proposalLogo,name,address" fields
	Then response should be match "response.id" as "AgentDetails_ID"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| GetDetailsForContract                | Agent  |
		| advisorcontracts_URL,AgentDetails_ID | AG1634 |

@negative @GetDetailsForContract @InvalidURL
Scenario Outline: Verify list of contracts details are not displayed for invalid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDetailsForContract>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| GetDetailsForContract                     | Agent  |
		| advisorcontracts_URL,AgentDetails_ID,/abc | AG1634 |
		| advisorcontracts_URL,AG#&^##              | AG1634 |

@negative @GetDetailsForContract @WithoutLogin
Scenario Outline: Verify lis of contracts details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetDetailsForContract>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| GetDetailsForContract                | Agent  |
		| advisorcontracts_URL,AgentDetails_ID | AG1634 |

@negative @GetDetailsForContract @WithOtherUserLogin
Scenario Outline: Verify contracts id details are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDetailsForContract>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| GetDetailsForContract                    | Agent  |
		| advisorcontracts_URL,OtherClientAgent_ID | AG1634 |
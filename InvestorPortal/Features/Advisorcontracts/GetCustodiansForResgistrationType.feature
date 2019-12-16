Feature: GetCustodiansForResgistrationType

@CustodiansForResgistrationType_PositiveCase
Scenario Outline: Verify list of costodians for the registration id
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCustodiansForResgistrationType>" API
	Then response should have "id,custodianCode,custodianName" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| GetCustodiansForResgistrationType                   | Agent  |
		| advisorcontracts_URL,AgentDetails_ID,/custodians/24 | AG1634 |

@CustodiansForResgistrationType_NegativeCase_InvalidURL
Scenario Outline: Verify list of costodians details are not displayed for invalid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCustodiansForResgistrationType>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| GetCustodiansForResgistrationType                        | Agent  |
		| advisorcontracts_URL,AgentDetails_ID,/custodians/24,/abc | AG1634 |
		| advisorcontracts_URL,AG#&^##,/custodians/24              | AG1634 |

@CustodiansForResgistrationType_NegativeCase_WithoutLogin
Scenario Outline: Verify list of costodians details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetCustodiansForResgistrationType>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| GetCustodiansForResgistrationType                   | Agent  |
		| advisorcontracts_URL,AgentDetails_ID,/custodians/24 | AG1634 |

@CustodiansForResgistrationType_NegativeCase_WithOtherUserLogin
Scenario Outline: Verify list of costodians details are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCustodiansForResgistrationType>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| GetCustodiansForResgistrationType                       | Agent  |
		| advisorcontracts_URL,OtherClientAgent_ID,/custodians/24 | AG1634 |
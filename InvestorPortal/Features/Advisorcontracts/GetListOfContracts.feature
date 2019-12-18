Feature: GetListOfContracts
URL: /api/advisorcontracts/v1

@positive
@ListOfContracts_ValidData
Scenario Outline: Verify the list of contracts
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetListOfContracts>" API
	Then response should have "id,logo,proposalLogo,name,address" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| GetListOfContracts		| Agent  |
	| advisorcontracts_URL		| AG1634 |
	
@negative
@ListOfContracts_InvalidURL
Scenario Outline: Verify list of contracts details are not displayed for invalid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetListOfContracts>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| GetListOfContracts			| Agent	 |
	| advisorcontracts_URL,abc		| AG1634 |

@negative
@ListOfContracts_WithoutLogin
Scenario Outline: Verify list of contracts details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetListOfContracts>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| GetListOfContracts		| Agent  |
	| advisorcontracts_URL		| AG1634 |
Feature: GetHouseholdByHouseholdId
APIURL: /api/households/v1/{householdId}

@household
@GetHouseholdByHouseholdId
@positive
Scenario Outline: Get household by valid householdId
	Given User is Authorised on eWM as an AgentId "<AgentId>"
	When User do a get call of "<BaseURL><HouseholdID>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "clientId,email,address,houseHoldType,isFunded,profileId,sortName" fields
	Then response should match "Response.clientId" as "<HouseholdID>"
	Then response should match "Response.agentId" as "<AgentId>"
	Then response should match "Response.isFunded" as "<IsFunded>"

	Examples:
		| AgentId | HouseholdID | BaseURL         | IsFunded |
		| AG1634  | CA0FZ5      | households_URL, | 1        |

@household
@GetHouseholdByHouseholdId
@negative
Scenario Outline: Get household by invalid householdId
	Given User is Authorised on eWM as an AgentId "<AgentId>"
	When User do a get call of "<BaseURL><HouseholdID>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| HouseholdID | AgentId | BaseURL         |
		| 11111       | AG1634  | households_URL, |
		|             | AG1634  | households_URL, |

@notification
@GetHouseholdByHouseholdId
@negative
Scenario Outline: Get household by householdId using invalid agent
	Given User is Authorised on eWM as an AgentId "<Advisor>"
	When User do a get call of "<BaseURL><HouseholdID>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Advisor      | HouseholdID | BaseURL         |
		| ????***Blank | CA0FZ5      | households_URL, |
		| AG0076       | CA0FZ5      | households_URL, |
		|              | CA0FZ5      | households_URL, |

@notification
@GetHouseholdByHouseholdId
@negative
Scenario Outline: Get household by householdId without authorization
	Given User is not authorised on eWM
	When User do a get call of "<BaseURL><HouseholdID>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| HouseholdID | BaseURL         |
		| CA0FZ5      | households_URL, |

@notification
@GetHouseholdByHouseholdId
@negative
Scenario Outline: Get list of documents for agent if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<BaseURL><HouseholdID>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| Agent  | HouseholdID | BaseURL         |
		| Ag1634 | CA1H79      | households_URL, |
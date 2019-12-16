Feature: GetAccountByAccountId	

@GetAccountByAccountId @positive
Scenario Outline: Verify that Account Details are retrieved for a funded AccountId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "accountId,accountNumber,householdId,registrationType,modelID,marketValue,custodianName,agentId" fields
	Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.isFunded" as "True"
	Then response should match "response.isProposed" as "False"
	Then response should match "response.scenarioName" as "Funded Accounts"
	Then response should match "response.householdId" as "<HouseholdId>"
	Then response should match "response.custodianName" as "Pershing Advisor Solutions"
	Then response should match "response.agentId" as "<Agent>"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                      | AccountId | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U47 | AH9U47    | CA5ZQ9      |

@GetAccountByAccountId @positive
Scenario Outline: Verify that Account Details are retrieved for a closed AccountId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "accountId,accountNumber,householdId,registrationType,modelID,marketValue,custodianName,agentId" fields
    Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.householdId" as "<HouseholdId>"
	Then response should match "response.custodianName" as "Pershing Advisor Solutions"
	Then response should match "response.agentId" as "<Agent>"
	Then response should match "response.isClosed" as "True"
	Then response should match "response.isProposed" as "False"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                      | AccountId | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH22M9 | AH22M9    | CA0FZ5      |

@GetAccountByAccountId @positive
Scenario Outline: Verify that Account Details are retrieved for a pending AccountId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "accountId,accountNumber,householdId,registrationType,modelID,marketValue,custodianName,agentId" fields
    Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.householdId" as "<HouseholdId>"	
	Then response should match "response.agentId" as "<Agent>"
	Then response should match "response.isPendingFunded" as "True"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                      | AccountId | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH6J62 | AH6J62    | CA0FZ5      |

@GetAccountByAccountId @negative
Scenario Outline: Verify that account details are not retrieved when AccountId which belongs to another Agent
    Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API	
	Then Response should be returned as empty
	Then Status Code is "403"
	
	Examples: 
	| Agent  | householdaccountservice                      |
	| AG1634 | householdaccountservice_URL,accounts/,AH12Z8 | 

@GetAccountByAccountId @negative
Scenario Outline: Verify that account details are not retrieved when invalid AccountId is provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| Agent  | householdaccountservice                    |
	| AG1634 | householdaccountservice_URL,accounts/,AJ   | 
	| AG1634 | householdaccountservice_URL,accounts/,@%#% | 
	| AG1634 | householdaccountservice_URL,accounts/,     | 

@GetAccountByAccountId @negative
Scenario Outline: Verify that account details are not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<householdaccountservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | householdaccountservice                      | 
	| AG1634 | householdaccountservice_URL,accounts/,AJ5J43 |		


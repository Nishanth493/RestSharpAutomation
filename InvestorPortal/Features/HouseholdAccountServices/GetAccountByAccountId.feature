Feature: GetAccountByAccountId	
URL: /api/householdaccountservice/v1/accounts/{accountid}

@GetAccountByAccountId @positive
Scenario Outline: Verify that Account Details are retrieved for a funded AccountId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountByAccountIdservice>" API
	Then response should have "accountId,accountNumber,householdId,registrationType,modelID,marketValue,custodianName,agentId" fields
	Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.isFunded" as "True"
	Then response should match "response.isProposed" as "False"
	Then response should match "response.scenarioName" as "Funded Accounts"
	Then response should match "response.householdId" as "<HouseholdId>"	
	Then response should match "response.agentId" as "<Agent>"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetAccountByAccountIdservice                 | AccountId | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U47 | AH9U47    | CA5ZQ9      |

@GetAccountByAccountId @positive @Ambika
Scenario Outline: Verify that Account Details are retrieved for a closed AccountId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountByAccountIdservice>" API
	Then response should have "accountId,accountNumber,householdId,registrationType,modelID,marketValue,custodianName,agentId" fields
    Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.householdId" as "<HouseholdId>"	
	Then response should match "response.agentId" as "<Agent>"
	Then response should match "response.isClosed" as "True"
	Then response should match "response.isProposed" as "False"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetAccountByAccountIdservice                 | AccountId | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH22M9 | AH22M9    | CA0FZ5      |

@GetAccountByAccountId @positive @Ambika
Scenario Outline: Verify that Account Details are retrieved for a pending AccountId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountByAccountIdservice>" API
	Then response should have "accountId,accountNumber,householdId,registrationType,modelID,marketValue,custodianName,agentId" fields
    Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.householdId" as "<HouseholdId>"	
	Then response should match "response.agentId" as "<Agent>"
	Then response should match "response.isPendingFunded" as "True"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetAccountByAccountIdservice                 | AccountId | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH6J62 | AH6J62    | CA0FZ5      |

@GetAccountByAccountId @negative @Ambika
Scenario Outline: Verify that account details are not retrieved when AccountId which belongs to another Agent
    Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountByAccountIdservice>" API	
	Then Response should return as "Forbidden" request
	Then Status Code is "403"
	
	Examples: 
	| Agent  | GetAccountByAccountIdservice                 |
	| AG1634 | householdaccountservice_URL,accounts/,AH12Z8 | 
	 
@GetAccountByAccountId @negative @Ambika
Scenario Outline: Verify that account details are not retrieved when invalid AccountId is provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountByAccountIdservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| Scenario         | Agent  | GetAccountByAccountIdservice               |
	| Invalid          | AG1634 | householdaccountservice_URL,accounts/,AJ   |
	| SpecialCharacter | AG1634 | householdaccountservice_URL,accounts/,@%#% |
	| Blank            |AG1634  | householdaccountservice_URL,accounts/,     | 

@GetAccountByAccountId @negative @Ambika
Scenario Outline: Verify that account details are not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetAccountByAccountIdservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetAccountByAccountIdservice                 | 
	| AG1634 | householdaccountservice_URL,accounts/,AJ5J43 |		


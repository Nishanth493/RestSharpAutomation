Feature: GetHoldingsofAccount
	

@GetHoldingsofAccount @positive
Scenario Outline: Verify that holdings of funded Account is retrieved for an AccountId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "accountId,holdingId,holdings,priceAsofDate,securityDescription,subAssetClass,suppressHoldings,ticker,units" fields	
	Then response should contain AccountId as "<AccountId>"
	Then response should contain HoldingId as "<HoldingId>"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                                | AccountId | HoldingId |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U47,/holdings | AH9U47    | GPANS5    |
	

@GetHoldingsofAccount @positive
Scenario Outline: Verify that holdings of closed Account is retrieved for an AccountId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "accountId,holdingId,holdings,priceAsofDate,securityDescription,subAssetClass,suppressHoldings,ticker,units" fields		
	Then response should contain AccountId as "<AccountId>"
	Then response should contain HoldingId as "<HoldingId>"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                                | AccountId | HoldingId |
	| AG1634 | householdaccountservice_URL,accounts/,AH22M9,/holdings | AH22M9    | SMSA2A    |

@GetHoldingsofAccount @positive
Scenario Outline: Verify that holdings of pending Account is displayed as blank for an AccountId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API	
	Then Status Code is "200"
	Then response contains "[]"

	Examples: 
	| Agent  | householdaccountservice                                |
	| AG1634 | householdaccountservice_URL,accounts/,AH6J62,/holdings |	

@GetHoldingsofAccount @negative
Scenario Outline: Verify that account holding details are not retrieved when AccountId which belongs to another Agent
    Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API	
	Then Response should be returned as empty
	Then Status Code is "403"
	
	Examples: 
	| Agent  | householdaccountservice                               |
	| AG1634 | householdaccountservice_URL,accounts/,AH12Z8,/holding | 

@GetHoldingsofAccount @negative
Scenario Outline: Verify that account details are not retrieved when invalid AccountId is provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| Agent  | householdaccountservice                              |
	| AG1634 | householdaccountservice_URL,accounts/,AJ,/holdings   | 
	| AG1634 | householdaccountservice_URL,accounts/,@%#%,/holdings | 
	| AG1634 | householdaccountservice_URL,accounts/,,/holdings |	

@GetHoldingsofAccount @negative
Scenario Outline: Verify that account holding details are not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<householdaccountservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | householdaccountservice                                |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U47,/holdings |

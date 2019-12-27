Feature: GetAccountHoldingByStrategy
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/holdingbystrategy

@accounts
@GetAccountHoldingByStrategy
@positive
Scenario Outline: Get holding by strategy for an account
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingByStrategy>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "percentage,sleeveHoldings,sleeveValue,strategistGroupName" fields
	Then response should match "Response.[0].sleeveHoldings.[0].securityDescription" as "<SecurityDescription>"
	Then response should match "Response.[0].sleeveHoldings.[0].accountId" as "<AccountID>"

	Examples:
		| Agent  | HoldingByStrategy                                               | SecurityDescription             | AccountID |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingbystrategy | BlackRock Liquidity T-Fund Mgmt | AC5996    |

@accounts
@GetAccountHoldingByStrategy
@negative
Scenario Outline: Get holding by strategy for invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingByStrategy>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | HoldingByStrategy                                             |
		| AG1634 | householdaccountservice_URL,accounts/,1111,/holdingbystrategy |

@accounts
@GetAccountHoldingByStrategy
@negative
Scenario Outline: Get holding by strategy for blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingByStrategy>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | HoldingByStrategy                                         |
		| AG1634 | householdaccountservice_URL,accounts/,,/holdingbystrategy |

@accounts
@GetAccountHoldingByStrategy
@negative
Scenario Outline: Get holding by strategy without authorization
	Given User is not authorised on eWM
	When User do a get call of "<HoldingByStrategy>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| Agent  | HoldingByStrategy                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingbystrategy |

@accounts
@GetAccountHoldingByStrategy
@negative
Scenario Outline: Get holding by strategy if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingByStrategy>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| Agent  | HoldingByStrategy                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/holdingbystrategy |

@accounts
@GetAccountHoldingByStrategy
@negative
Scenario Outline: Get holding by strategy using special charachter in AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingByStrategy>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | HoldingByStrategy                                            |
		| AG1634 | householdaccountservice_URL,accounts/, AH23Z*,/custodialinfo |
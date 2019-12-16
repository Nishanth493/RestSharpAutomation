Feature: GetAccountHoldingsByAssetClass
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/holdingsbyassetclass

@accounts
@get_account_holdings_by_assetclass
@positive
Scenario Outline: Get holdings by asset class for an account
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "200"
	Then response should have "id,name,amount,assetClasses,hasAssetClasses,percentage,className" fields
	Then response should match "Response.[0].name" as "<name>"

	Examples:
		| Agent  | HoldingsByAssetClass                                               | name                            |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbyassetclass | BlackRock Liquidity T-Fund Mgmt |

@accounts
@get_account_holdings_by_assetclass
@negative
Scenario Outline: Get holdings by asset class using invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | HoldingsByAssetClass                                             |
		| AG1634 | householdaccountservice_URL,accounts/,1111,/holdingsbyassetclass |

@accounts
@get_account_holdings_by_assetclass
@negative
Scenario Outline: Get holdings by asset class using blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | HoldingsByAssetClass                                         |
		| AG1634 | householdaccountservice_URL,accounts/,,/holdingsbyassetclass |

@accounts
@get_account_holdings_by_assetclass
@negative
Scenario Outline: Get holdings by asset class without authorization
	Given User is not authorised on eWM
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| Agent  | HoldingsByAssetClass                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbyassetclass |

@accounts
@get_account_holdings_by_assetclass
@negative
Scenario Outline: Get holdings by asset class if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| Agent  | HoldingsByAssetClass                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/holdingsbyassetclass |

@accounts
@get_account_holdings_by_assetclass
@negative
Scenario Outline: Get holdings by asset class using special charachter in AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | HoldingsByAssetClass                                                |
		| AG1634 | householdaccountservice_URL,accounts/, AH23Z*,/holdingsbyassetclass |
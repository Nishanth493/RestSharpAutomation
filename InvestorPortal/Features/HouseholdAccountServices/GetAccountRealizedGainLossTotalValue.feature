Feature: GetAccountRealizedGainLossTotalValue
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/realizedgainlosstotalvalue/{startdate}/{enddate}

@accounts
@GetAccountRealizedGainLossTotalValue
@positive
Scenario Outline: Get account realizedGainLoss total value by asset class for gainLoss type
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><gainLossType>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "totalCost,totalProceeds,totalGainLossAmount" fields

	Examples:
		| gainLossType     | Agent  | realizedgainlosstotalvalue                                                                                       |
		| All              | AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainlosstotalvalue,/2011-3-1/,2019-11-18/,?gainLossType=   |
		| ShortTerm        | AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019,?gainLossType=All |
		| LongTerm         | AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019,?gainLossType=All |
		| TermDistribution | AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019,?gainLossType=All |
		| UnClassified     | AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019,?gainLossType=All |

@accounts
@GetAccountRealizedGainLossTotalValue
@positive
Scenario Outline: Get account realizedGainLoss total value by asset class
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><gainLossType>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "totalCost,totalProceeds,totalGainLossAmount" fields

	Examples:
		| Agent  | realizedgainlosstotalvalue                                                                                       |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019,?gainLossType=All |

@accounts
@GetAccountRealizedGainLossTotalValue
@negative
Scenario Outline: Get account realizedGainLoss total value using invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><gainLossType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| gainLossType | Agent  | realizedgainlosstotalvalue                                                                                   |
		| All          | AG1634 | householdaccountservice_URL,accounts/,1111,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019/,?gainLossType= |

@accounts
@GetAccountRealizedGainLossTotalValue
@negative
Scenario Outline: Get account realizedGainLoss total value using blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><gainLossType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| gainLossType | Agent  | realizedgainlosstotalvalue                                                                               |
		| All          | AG1634 | householdaccountservice_URL,accounts/,,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019/,?gainLossType= |

@accounts
@GetAccountRealizedGainLossTotalValue
@negative
Scenario Outline: Get account realizedGainLoss total value without authorization
	Given User is not authorised on eWM
	When User do a get call of "<realizedgainlosstotalvalue><gainLossType>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| gainLossType | Agent  | realizedgainlosstotalvalue                                                                                       |
		| All          | AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019,?gainLossType=All |

@accounts
@GetAccountRealizedGainLossTotalValue
@negative
Scenario Outline: Get account realizedGainLoss total value if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><gainLossType>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| gainLossType | Agent  | realizedgainlosstotalvalue                                                                                     |
		| All          | AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019/,?gainLossType= |

@accounts
@GetAccountRealizedGainLossTotalValue
@negative
Scenario Outline: Get account realizedGainLoss total value using special charachter in AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><gainLossType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| gainLossType | Agent  | realizedgainlosstotalvalue                                                                                     |
		| All          | AG1634 | householdaccountservice_URL,accounts/,AH23Z*,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019/,?gainLossType= |

@accounts
@GetAccountRealizedGainLossTotalValue
@negative
Scenario Outline: Get account realizedGainLoss total value for blank gainLossType
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><gainLossType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| gainLossType | Agent  | realizedgainlosstotalvalue                                                                                       |
		|              | AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainlosstotalvalue,/3-1-2011/,11-18-2019,?gainLossType=All |
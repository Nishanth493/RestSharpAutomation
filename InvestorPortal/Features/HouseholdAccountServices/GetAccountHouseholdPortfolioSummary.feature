Feature: GetAccountHouseholdPortfolioSummary

@GetAccountHouseholdPortfolioSummary @positive
Scenario Outline: Verify that Portfolio Summary of funded Account is retrieved based on the provided end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "accountId,accountName,accountNumber,benchmarks" fields
	Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.benchmarks[0].benchmarkCode" as "BLEND5"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Agent  | householdaccountservice                                                               | AccountId |
		| AG1634 | householdaccountservice_URL,accounts/,AH9U47,/performancesummary?,endDate=,2019-11-18 | AH9U47    |

@GetAccountHouseholdPortfolioSummary @positive
Scenario Outline: Verify that Portfolio Summary of closed Account is retrieved based on the provided end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "accountId,accountName,accountNumber,benchmarks" fields
	Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.benchmarks[0].benchmarkCode" as "MSACWD"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Agent  | householdaccountservice                                                               | AccountId |
		| AG1634 | householdaccountservice_URL,accounts/,AH22M9,/performancesummary?,endDate=,2019-11-18 | AH22M9    |

@GetAccountHouseholdPortfolioSummary @positive
Scenario Outline: Verify that Portfolio Summary of pending Account is displayed as blank for provided end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "accountId,accountName,accountNumber,benchmarks" fields
	Then response should match "response.accountId" as "<AccountId>"
	#Then response should match "response.benchmarks" as "null"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Agent  | householdaccountservice                                                               | AccountId |
		| AG1634 | householdaccountservice_URL,accounts/,AH6J62,/performancesummary?,endDate=,2019-11-18 | AH6J62    |

@GetAccountHouseholdPortfolioSummary @negative
Scenario Outline: Verify that Portfolio Summary of an Account is not retrieved when invalid parameter is passed
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| Agent  | householdaccountservice                                                     |
		| AG1634 | householdaccountservice_URL,accounts/,AH22M9,/performancesummary?           |
		| AG1634 | householdaccountservice_URL,accounts/,AH22M9,/performanc$!@#$@#$            |
		| AG1634 | householdaccountservice_URL,accounts/,AH22M9,/performancesummary?,endDate=, |

@GetAccountHouseholdPortfolioSummary @negative
Scenario Outline: Verify that Portfolio Summary of another Agent's Account is not retrieved
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then Response should be returned as empty
	Then Status Code is "403"

	Examples:
		| Agent  | householdaccountservice                                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AH12Z8,/performancesummary?,endDate=,2019-11-18 |

@GetAccountHouseholdPortfolioSummary @negative
Scenario Outline: Verify that Portfolio Summary of an Account is not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<householdaccountservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| Agent  | householdaccountservice                                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AH9U48,/performancesummary?,endDate=,2019-11-18 |
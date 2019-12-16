Feature: GetAccountPerformanceByStrategy
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/performancebystrategy


@accounts
@get_account_performance_by_strategy
@positive
Scenario Outline: Get account performance by strategy for account type
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<accountPerformanceByStrategy>" API
	Then Status Code is "200"
	Then response should have "accountId,accountName,accountNumber,benchMarksPerformance,sleevesPerformance" fields
	Examples: 
	 | AccountType | Agent  | accountPerformanceByStrategy                                        |
	 | Funded      | AG1634 | householdaccountservice_URL,accounts/,AC5996,/performancebystrategy |
	 | Closed      | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/performancebystrategy |
	 | Pending     | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/performancebystrategy |
	 

@accounts
@get_account_performance_by_strategy
@negative
Scenario Outline: Get account performance by strategy using invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<accountPerformanceByStrategy>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	Examples: 
	| Agent  | accountPerformanceByStrategy                                      |
	| AG1634 | householdaccountservice_URL,accounts/,1111,/performancebystrategy |


@accounts
@get_account_performance_by_strategy
@negative
Scenario Outline: Get account performance by strategy using blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<accountPerformanceByStrategy>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	Examples: 
	| Agent  | accountPerformanceByStrategy                                  |
	| AG1634 | householdaccountservice_URL,accounts/,,/performancebystrategy |


@accounts
@get_account_performance_by_strategy
@negative
Scenario Outline: Get account performance by strategy without authorization
	Given User is not authorised on eWM
	When User do a get call of "<accountPerformanceByStrategy>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request
	Examples: 
	| Agent  | accountPerformanceByStrategy                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AC5996,/performancebystrategy |
	

@accounts
@get_account_performance_by_strategy
@negative
Scenario Outline: Get account performance by strategy if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<accountPerformanceByStrategy>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request
	Examples: 
	| Agent  | accountPerformanceByStrategy                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/performancebystrategy |


@accounts
@get_account_performance_by_strategy
@negative
Scenario Outline: Get account performance by strategy using special charachter in AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<accountPerformanceByStrategy>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	Examples: 
	| Agent  | accountPerformanceByStrategy                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AH23Z*,/performancebystrategy |
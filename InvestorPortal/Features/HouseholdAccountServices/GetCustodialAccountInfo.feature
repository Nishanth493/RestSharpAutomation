Feature: GetCustodialAccountInfo
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/custodialinfo

@accounts
@get_custodial_account_info
@positive
Scenario Outline: Get custodial account info
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<CustodialAccountInfo>" API
	Then Status Code is "200"
	Then response should have "accountFeaturesSection,accountInfoDataAvailable,accountName,beneficiariesSection" fields
	Examples: 
	| Agent  | CustodialAccountInfo                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AC5996,/custodialinfo |


@accounts
@get_custodial_account_info
@negative
Scenario Outline: Get custodial account info using invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<CustodialAccountInfo>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	Examples: 
	| Agent  | CustodialAccountInfo                                        |
	| AG1634 | householdaccountservice_URL,accounts/,1111,/custodialinfo |


@accounts
@get_custodial_account_info
@negative
Scenario Outline: Get custodial account info using blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<CustodialAccountInfo>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	Examples: 
	| Agent  | CustodialAccountInfo                                        |
	| AG1634 | householdaccountservice_URL,accounts/,,/custodialinfo |


@accounts
@get_custodial_account_info
@negative
Scenario Outline: Get custodial account info without authorization
	Given User is not authorised on eWM
	When User do a get call of "<CustodialAccountInfo>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request
	Examples: 
	| Agent  | CustodialAccountInfo                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AC5996,/custodialinfo |
	

@accounts
@get_custodial_account_info
@negative
Scenario Outline: Get custodial account info if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<CustodialAccountInfo>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request
	Examples: 
	| Agent  | CustodialAccountInfo                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/custodialinfo |


@accounts
@get_custodial_account_info
@negative
Scenario Outline: Get custodial account info using special charachter in AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<CustodialAccountInfo>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	Examples: 
	| Agent  | CustodialAccountInfo                                         |
	| AG1634 | householdaccountservice_URL,accounts/, AH23Z*,/custodialinfo |
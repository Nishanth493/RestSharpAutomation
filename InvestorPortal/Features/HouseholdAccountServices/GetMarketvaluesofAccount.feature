Feature: GetMarketvaluesofAccount

@GetMarketvaluesofAccount @positive
Scenario Outline: Verify that market value of funded Account is retrieved periodically based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketvaluesofAccountservice>,<periodType>" API
	Then response should have "aplId,asOfDate,value" fields		
	Then response should contain AplId as "<AplId>"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| periodType | Agent  | GetMarketvaluesofAccountservice                                                     | AplId  |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/marketvalues,/2015-03-16,/2019-11-18/ | AH9U47 |
	| Weekly     | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/marketvalues,/2015-03-16,/2019-11-18/ | AH9U47 |
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/marketvalues,/2015-03-16,/2019-11-18/ | AH9U47 |
	| Quarterly  | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/marketvalues,/2015-03-16,/2019-11-18/ | AH9U47 |
	| Yearly     | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/marketvalues,/2015-03-16,/2019-11-18/ | AH9U47 |
	
@GetMarketvaluesofAccount @positive
Scenario Outline: Verify that market value of closed Account is retrieved periodically based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketvaluesofAccountservice>,<periodType>" API
	Then response should have "aplId,asOfDate,value" fields		
	Then response should contain AplId as "<AplId>"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| periodType | Agent  | GetMarketvaluesofAccountservice                                                     | AplId  |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/marketvalues,/2013-03-04,/2019-11-18/ | AH22M9 |
	| Weekly     | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/marketvalues,/2013-03-04,/2019-11-18/ | AH22M9 |
	

@GetMarketvaluesofAccount @positive
Scenario Outline: Verify that  market value of pending Account is displayed as blank periodically when start and end dates are provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketvaluesofAccountservice>,<periodType>" API
	Then response should have "aplId,asOfDate,value" fields	
	Then response should contain AplId as "<AplId>"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| periodType | Agent  | GetMarketvaluesofAccountservice                                                     | AplId  |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/marketvalues,/2013-03-04,/2019-11-18/ | AH6J62 |
	| Weekly     | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/marketvalues,/2013-03-04,/2019-11-18/ | AH6J62 |
	

@GetMarketvaluesofAccount @negative
Scenario Outline: Verify that market value of an Account is not retrieved when invalid request is passed
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketvaluesofAccountservice>,<periodType>" API
	Then Response should be returned as empty
	Then Status Code is "404"
	
	Examples: 
	| Scenario         | periodType | Agent  | GetMarketvaluesofAccountservice                                                     |
	| Blank            |            | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/marketvalues,/2015-03-16,/2019-11-18/ |
	| Invalid          | Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/marketvalues,/2015                    |
	| SpecialCharacter |Monthly     | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/marketvalues,/#$@@#$@$                |
    

@GetMarketvaluesofAccount @negative
Scenario Outline: Verify that market value of another Agent's Account is not retrieved 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketvaluesofAccountservice>,<periodType>" API
	Then Response should be returned as empty
	Then Status Code is "403"
	
	Examples: 
	| periodType | Agent  | GetMarketvaluesofAccountservice                                                    |
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH12Z8,/marketvalues,/2015-03-16,/2019-11-18 |

@GetMarketvaluesofAccount @negative
Scenario Outline: Verify that market value of an Account is not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetMarketvaluesofAccountservice>,<periodType>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| periodType | Agent  | GetMarketvaluesofAccountservice                                                     |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/marketvalues,/2015-03-16,/2019-11-18/ |	

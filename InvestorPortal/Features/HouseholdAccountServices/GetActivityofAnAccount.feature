Feature: GetActivityofAnAccount

@GetActivityofAnAccount @positive
Scenario Outline: Verify that activity details of funded Account is retrieved based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "activity,activityTypes,activityHoldingNames" fields	
	Then response should match "response.activity[*].groupById" as "1"
	Then response should match "response.activity[*].isClosed" as "0"
	Then response should match "response.activity[*].householdId" as "<HouseholdId>"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                                                        | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U47,/activity,/2015-03-16,/2019-11-18 | CA5ZQ9      |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U48,/activity,/2015-03-16,/2019-11-18 | CA5ZQ9      |


@GetActivityofAnAccount @positive
Scenario Outline: Verify that activity types of funded Account is retrieved based on the start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "activity,activityTypes,activityHoldingNames" fields
	Then response should match "response.activityTypes[0].categoryId" as "100003"
	Then response should match "response.activityTypes[0].tType" as "Fees"
	Then response should match "response.activityTypes[1].categoryId" as "100005"
	Then response should match "response.activityTypes[1].tType" as "Buys"
	Then response should match "response.activityTypes[2].categoryId" as "100006"
	Then response should match "response.activityTypes[2].tType" as "Sells"
	Then response should match "response.activityTypes[3].categoryId" as "100007"
	Then response should match "response.activityTypes[3].tType" as "Dividends/Interest"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U48,/activity,/2015-03-16,/2019-11-18 |

@GetActivityofAnAccount @positive
Scenario Outline: Verify that activity details of closed Account is retrieved based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "activity,activityTypes,activityHoldingNames" fields	
	Then response should match "response.activity[*].groupById" as "1"
	Then response should match "response.activity[*].isClosed" as "1"
	Then response should match "response.activity[*].householdId" as "<HouseholdId>"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                                                        | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH22M9,/activity,/2013-03-04,/2019-11-18 | CA0FZ5      |


@GetActivityofAnAccount @positive
Scenario Outline: Verify that activity types of closed Account is retrieved based on the start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "activity,activityTypes,activityHoldingNames" fields	
	Then response should match "response.activityTypes[0].categoryId" as "100006"
	Then response should match "response.activityTypes[0].tType" as "Sells"
	Then response should match "response.activityTypes[1].categoryId" as "100007"
	Then response should match "response.activityTypes[1].tType" as "Dividends/Interest"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AH22M9,/activity,/2013-03-04,/2019-11-18 |	

@GetActivityofAnAccount @positive
Scenario Outline: Verify that activity details of pending Account is displayed as blank when start and end dates are provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then response should have "activity,activityTypes,activityHoldingNames" fields	
	Then response should match "response.activityTypes" as "[]"
	Then response should match "response.activity" as "[]"
	Then response should match "response.activityHoldingNames" as "[]"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AH6J62,/activity,/2013-03-04,/2019-11-18 |	

@GetActivityofAnAccount @negative
Scenario Outline: Verify that activity details of an Account is not retrieved when invalid input is provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"
	
	Examples: 
	| Agent  | householdaccountservice                                          |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U48,/activity,/,/       |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U48,/activity,/#$@@#$@$ |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U48,/activity,/2019-11  |

@GetActivityofAnAccount @negative
Scenario Outline: Verify that activity details of another Agent's Account is not retrieved 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then Response should be returned as empty
	Then Status Code is "403"
	
	Examples: 
	| Agent  | householdaccountservice                                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AH12Z8,/activity,/2015-03-16,/2019-11-18 |

@GetActivityofAnAccount @negative
Scenario Outline: Verify that activity details of an Account is not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<householdaccountservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | householdaccountservice                                                        | 
	| AG1634 | householdaccountservice_URL,accounts/,AH9U48,/activity,/2015-03-16,/2019-11-18 |		

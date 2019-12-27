Feature: GetCumulativeReturnHistoryofAccount	

@GetCumulativeReturnHistoryofAccount @positive @Ambika
Scenario Outline: Verify that Cumulative Return History of funded Account is retrieved periodically based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeReturnHistoryofAccountservice>,<periodType>" API	
	Then response should have "beginDate,endDate,benchmarks,cumPortfolio,accountId,cumulativeReturnPercentage,dataPoints,householdId" fields
	Then User verify "<periodType>" data returned within dates "2015-03-16" to "2019-11-18" for ".date" field
	Then response should match "response.cumPortfolio.accountId" as "<AccountId>"
	Then response should match "response.beginDate" as "2015-03-16T00:00:00"
	Then response should match "response.endDate" as "2019-11-18T00:00:00"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| periodType | Agent  | GetCumulativeReturnHistoryofAccountservice                                                     | AccountId |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ | AH9U47    |
	| Weekly     | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ | AH9U47    |
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ | AH9U47    |
	| Quarterly  | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ | AH9U47    |
	| Yearly     | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ | AH9U47    |
	
@GetCumulativeReturnHistoryofAccount @positive @Ambika
Scenario Outline: Verify that Cumulative Return History of closed Account is retrieved periodically based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeReturnHistoryofAccountservice>,<periodType>" API
	Then response should have "beginDate,endDate,benchmarks,cumPortfolio,accountId,cumulativeReturnPercentage,dataPoints,householdId" fields	
	Then response should match "response.cumPortfolio.accountId" as "<AccountId>"	
	Then response should match "response.cumPortfolio.dataPoints[0].date" as "2013-03-04T00:00:00"	
	Then User verify "<periodType>" data returned within dates "2013-03-04" to "2019-11-18" for ".date" field
	Then Status Code is "200"
	Then Response is Not Empty
	Then User verify "Daily" data returned within dates "2013-03-04" to "2019-11-18" for ".date" field

	Examples: 
	| periodType | Agent  | GetCumulativeReturnHistoryofAccountservice                                                     | AccountId |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH22M9    |
	| Weekly     | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH22M9    |
	
@GetCumulativeReturnHistoryofAccount @positive @Ambika
Scenario Outline: Verify that Cumulative Return History  of pending Account is displayed as blank periodically when start and end dates are provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeReturnHistoryofAccountservice>,<periodType>" API
	Then response should have "beginDate,endDate,benchmarks,cumPortfolio,accountId,cumulativeReturnPercentage,dataPoints,householdId" fields	
	Then response should match "response.cumPortfolio.accountId" as "<AccountId>"
	Then response should match "response.cumPortfolio.cumulativeReturnPercentage" as "0"	
	Then response should match "response.cumPortfolio.dataPoints[0].netInvestment" as "0"
	Then Status Code is "200"
	Then Response is Not Empty


	Examples: 
	| periodType | Agent  | GetCumulativeReturnHistoryofAccountservice                                                     | AccountId |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH6J62    |
	| Weekly     | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH6J62    |
	
@GetCumulativeReturnHistoryofAccount @negative @Ambika
Scenario Outline: Verify that Cumulative Return History of an Account is not retrieved when invalid request is passed
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeReturnHistoryofAccountservice>,<periodType>" API
	Then Response should be returned as empty
	Then Status Code is "404"
	
	Examples: 
	| Scenario         | periodType | Agent  | GetCumulativeReturnHistoryofAccountservice                                                     |
	| Blank            |            | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ |
	| Invalid          | Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015                    |
	| SpecialCharacter | Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/#$@@#$@$                |    

@GetCumulativeReturnHistoryofAccount @negative @Ambika
Scenario Outline: Verify thatCumulative Return History of another Agent's Account is not retrieved 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeReturnHistoryofAccountservice>,<periodType>" API
	Then Response should return as "Forbidden" request
	Then Status Code is "403"
	
	Examples: 
	| periodType | Agent  | GetCumulativeReturnHistoryofAccountservice                                                    |
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH12Z8,/cumulativereturnhistory,/2015-03-16,/2019-11-18 |

@GetCumulativeReturnHistoryofAccount @negative @Ambika
Scenario Outline: Verify that market value of an Account is not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetCumulativeReturnHistoryofAccountservice>,<periodType>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| periodType | Agent  | GetCumulativeReturnHistoryofAccountservice                                                     |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ |	

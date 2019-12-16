Feature: GetCumulativeReturnHistoryofAccount	

@GetCumulativeReturnHistoryofAccount @positive
Scenario Outline: Verify that Cumulative Return History of funded Account is retrieved periodically based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>,<periodType>" API
	Then response should have "beginDate,endDate,benchmarks,cumPortfolio,accountId,cumulativeReturnPercentage,dataPoints,householdId" fields	
	Then response should match "response.cumPortfolio.accountId" as "<AccountId>"
	Then response should match "response.cumPortfolio.cumulativeReturnPercentage" as "19.357"
	Then response should match "response.cumPortfolio.dataPoints[0].date" as "2015-03-16T00:00:00"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| periodType | Agent  | householdaccountservice                                                                        | AccountId |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ | AH9U47    |
	| Weekly     | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ | AH9U47    |
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ | AH9U47    |
	| Quarterly  | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ | AH9U47    |
	| Yearly     | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ | AH9U47    |
	
@GetCumulativeReturnHistoryofAccount @positive
Scenario Outline: Verify that Cumulative Return History of closed Account is retrieved periodically based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>,<periodType>" API
	Then response should have "beginDate,endDate,benchmarks,cumPortfolio,accountId,cumulativeReturnPercentage,dataPoints,householdId" fields	
	Then response should match "response.cumPortfolio.accountId" as "<AccountId>"
	Then response should match "response.cumPortfolio.cumulativeReturnPercentage" as "0.156"
	Then response should match "response.cumPortfolio.dataPoints[0].date" as "2013-03-04T00:00:00"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| periodType | Agent  | householdaccountservice                                                                        | AccountId |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH22M9    |
	| Weekly     | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH22M9    |
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH22M9    |
	| Quarterly  | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH22M9    |
	| Yearly     | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH22M9    |

@GetCumulativeReturnHistoryofAccount @positive
Scenario Outline: Verify that Cumulative Return History  of pending Account is displayed as blank periodically when start and end dates are provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>,<periodType>" API
	Then response should have "beginDate,endDate,benchmarks,cumPortfolio,accountId,cumulativeReturnPercentage,dataPoints,householdId" fields	
	Then response should match "response.cumPortfolio.accountId" as "<AccountId>"
	Then response should match "response.cumPortfolio.cumulativeReturnPercentage" as "0"	
	Then response should match "response.cumPortfolio.dataPoints[0].netInvestment" as "0"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| periodType | Agent  | householdaccountservice                                                                        | AccountId |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH6J62    |
	| Weekly     | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH6J62    |
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH6J62    |
	| Quarterly  | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH6J62    |
	| Yearly     | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/cumulativereturnhistory,/2013-03-04,/2019-11-18/ | AH6J62    |


@GetCumulativeReturnHistoryofAccount @negative
Scenario Outline: Verify that Cumulative Return History of an Account is not retrieved when invalid request is passed
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>,<periodType>" API
	Then Response should be returned as empty
	Then Status Code is "404"
	
	Examples: 
	| periodType | Agent  | householdaccountservice                                                             |
	|            | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ |
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,//           |	
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory                          |
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/#$@@#$@$                |    

@GetCumulativeReturnHistoryofAccount @negative
Scenario Outline: Verify thatCumulative Return History of another Agent's Account is not retrieved 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>,<periodType>" API
	Then Response should be returned as empty
	Then Status Code is "403"
	
	Examples: 
	| periodType | Agent  | householdaccountservice                                                                       |
	| Monthly    | AG1634 | householdaccountservice_URL,accounts/,AH12Z8,/cumulativereturnhistory,/2015-03-16,/2019-11-18 |

@GetCumulativeReturnHistoryofAccount @negative
Scenario Outline: Verify that market value of an Account is not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<householdaccountservice>,<periodType>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| periodType | Agent  | householdaccountservice                                                                        |
	| Daily      | AG1634 | householdaccountservice_URL,accounts/,AH9U47,/cumulativereturnhistory,/2015-03-16,/2019-11-18/ |	

Feature: GetHouseholdPortfolioSummaryPtToPt
URL: /api/householdaccountservice/v1.0/accounts/{accountId}/performancesummary/pointtopoint?startDate=&endDate=

@GetHouseholdPortfolioSummaryPtToPt @positive @Ambika
Scenario Outline: Verify that Point to Point Portfolio Summary of funded Account is retrieved based on the provided start date and end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseholdPortfolioSummaryPtToPtservice>" API
	Then response should have "accountId,accountName,accountNumber,benchmarkPerformanceSummary" fields	
	Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.benchmarkPerformanceSummary[0].benchmarkCode" as "MSACWD"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetHouseholdPortfolioSummaryPtToPtservice                                                                                  | AccountId |
	| AG1634 | householdaccountservice_URL,accounts/,AC5996,/performancesummary/,pointtopoint?,startDate=,2015-03-16,&endDate=,2019-11-18 | AC5996    |

@GetHouseholdPortfolioSummaryPtToPt @positive @Ambika
Scenario Outline: Verify that Point to Point Portfolio Summary of closed Account is retrieved based on the provided start date and end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseholdPortfolioSummaryPtToPtservice>" API
	Then response should have "accountId,accountName,accountNumber,benchmarkPerformanceSummary" fields	
	Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.benchmarkPerformanceSummary[0].benchmarkCode" as "MSACWD"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetHouseholdPortfolioSummaryPtToPtservice                                                                                  | AccountId |
	| AG1634 | householdaccountservice_URL,accounts/,AH22M9,/performancesummary/,pointtopoint?,startDate=,2015-03-16,&endDate=,2019-11-18 | AH22M9    |

@GetHouseholdPortfolioSummaryPtToPt @positive @Ambika
Scenario Outline: Verify that Point to Point Portfolio Summary of pending Account is displayed as blank for provided start date and end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseholdPortfolioSummaryPtToPtservice>" API
	Then response should have "accountId,accountName,accountNumber,benchmarkPerformanceSummary" fields
	Then response should match "response.accountId" as "<AccountId>"
	Then response should match "response.benchmarkPerformanceSummary" as "[]"		
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetHouseholdPortfolioSummaryPtToPtservice                                                                                  | AccountId |
	| AG1634 | householdaccountservice_URL,accounts/,AH6J62,/performancesummary/,pointtopoint?,startDate=,2015-03-16,&endDate=,2019-11-18 | AH6J62    |

@GetHouseholdPortfolioSummaryPtToPt @negative @Ambika
Scenario Outline: Verify that Point to Point Portfolio Summary of an Account is not retrieved when invalid parameter is passed
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseholdPortfolioSummaryPtToPtservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"
	
	Examples: 
	| Scenario         | Agent  | GetHouseholdPortfolioSummaryPtToPtservice                                                                        |
	| SpecialCharacter | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/performancesummary/,point%@%@%%                                    |
	| Blank            | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/performancesummary/,pointtopoint?,startDate=,,&endDate=,2019-11-18 |	

@GetHouseholdPortfolioSummaryPtToPt @negative @Ambika
Scenario Outline: Verify that Point to Point Portfolio Summary of another Agent's Account is not retrieved 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseholdPortfolioSummaryPtToPtservice>" API
	Then Response should return as "Forbidden" request
	Then Status Code is "403"
	
	Examples: 
	| Agent  | GetHouseholdPortfolioSummaryPtToPtservice                                                                                  |
	| AG1634 | householdaccountservice_URL,accounts/,AH12Z8,/performancesummary/,pointtopoint?,startDate=,2015-03-16,&endDate=,2019-11-18 |

@GetHouseholdPortfolioSummaryPtToPt @negative @Ambika
Scenario Outline: Verify that Point to Point Portfolio Summary of an Account is not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseholdPortfolioSummaryPtToPtservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetHouseholdPortfolioSummaryPtToPtservice                                                                                  |
	| AG1634 | householdaccountservice_URL,accounts/,AC5996,/performancesummary/,pointtopoint?,startDate=,2015-03-16,&endDate=,2019-11-18 |		

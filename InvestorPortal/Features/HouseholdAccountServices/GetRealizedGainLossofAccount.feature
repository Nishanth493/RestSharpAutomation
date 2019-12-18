Feature: GetRealizedGainLossofAccount
URL:/api/householdaccountservice/v1/accounts/{accountid}/realizedgainloss/{startdate}/{enddate}

@GetRealizedGainLossofAccount @positive
Scenario Outline: Verify that Realized Gain Loss of funded Account is retrieved based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetRealizedGainLossofAccountservice>" API
	Then response should have "shortTerm,longTerm,termDistribution,isPRSDataStale" fields	
	Then response should match "response.termDistribution[*].category" as "TermDistribution"
	Then response should match "response.activity[*].isClosed" as "0"
	Then response should match "response.activity[*].householdId" as "<HouseholdId>"	
	Then response should match "response.activity[*].advisorContractId" as "<Agent>"	
	Then response should match "response.activity[*].custodianId" as "PRS"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetRealizedGainLossofAccountservice                                                    | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U47,/realizedgainloss,/2015-03-16,/2019-11-18 | CA5ZQ9      |

@GetRealizedGainLossofAccount @positive
Scenario Outline: Verify that Realized Gain Loss of funded Account is retrieved based on the provided start and end dates and optional paramerters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetRealizedGainLossofAccountservice>" API
	Then response should have "shortTerm,longTerm,termDistribution,isPRSDataStale" fields	
	Then response should not contain "BFRIX"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetRealizedGainLossofAccountservice                                                                        | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U47,/realizedgainloss,/2015-03-16,/2019-11-18?,page=1&,pageSize=2 | CA5ZQ9      |

@GetRealizedGainLossofAccount @positive
Scenario Outline: Verify that Realized Gain Loss of closed Account is retrieved based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetRealizedGainLossofAccountservice>" API
	Then response should have "shortTerm,longTerm,termDistribution,isPRSDataStale" fields
	Then response should match "response.termDistribution[*].category" as "TermDistribution"
	Then response should match "response.activity[*].isClosed" as "1"
	Then response should match "response.activity[*].householdId" as "<HouseholdId>"	
	Then response should match "response.activity[*].advisorContractId" as "<Agent>"	
	Then response should match "response.activity[*].custodianId" as "PRS"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetRealizedGainLossofAccountservice                                                    | HouseholdId |
	| AG1634 | householdaccountservice_URL,accounts/,AH22M9,/realizedgainloss,/2013-03-04,/2019-11-18 | CA0FZ5      |

@GetRealizedGainLossofAccount @positive
Scenario Outline: Verify that Realized Gain Loss of pending Account is displayed as blank for provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetRealizedGainLossofAccountservice>" API
	Then response should have "shortTerm,longTerm,termDistribution,isPRSDataStale" fields
	Then response should match "response.shortTerm" as "[]"
	Then response should match "response.longTerm" as "[]"
	Then response should match "response.termDistribution" as "[]"		
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetRealizedGainLossofAccountservice                                                    |
	| AG1634 | householdaccountservice_URL,accounts/,AH6J62,/realizedgainloss,/2013-03-04,/2019-11-18 |

@GetRealizedGainLossofAccount @negative
Scenario Outline: Verify that Realized Gain Loss of an Account is not retrieved when invalid input is provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetRealizedGainLossofAccountservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"
	
	Examples: 
	| Scenario         | Agent  | GetRealizedGainLossofAccountservice                                      |
	| Blank            | AG1634 | householdaccountservice_URL,accounts/,AH9U48,/realizedgainloss,/,/       |
	| SpecialCharacter | AG1634 | householdaccountservice_URL,accounts/,AH9U48,/realizedgainloss,/#$@@#$@$ |
	| Invalid          |AG1634  | householdaccountservice_URL,accounts/,AH9U48,/realizedgainloss,/2019-11  |

@GetRealizedGainLossofAccount @negative
Scenario Outline: Verify that Realized Gain Loss of another Agent's Account is not retrieved 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetRealizedGainLossofAccountservice>" API
	Then Response should be returned as empty
	Then Status Code is "403"
	
	Examples: 
	| Agent  | GetRealizedGainLossofAccountservice                                                    |
	| AG1634 | householdaccountservice_URL,accounts/,AH12Z8,/realizedgainloss,/2015-03-16,/2019-11-18 |

@GetRealizedGainLossofAccount @negative
Scenario Outline: Verify that Realized Gain Loss of an Account is not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetRealizedGainLossofAccountservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetRealizedGainLossofAccountservice                                                    | 
	| AG1634 | householdaccountservice_URL,accounts/,AH9U48,/realizedgainloss,/2015-03-16,/2019-11-18 |		

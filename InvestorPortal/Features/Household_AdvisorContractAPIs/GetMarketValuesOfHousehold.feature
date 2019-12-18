Feature: GetMarketvaluesofHousehold
URL: /api/householdaccountservice/v1/accounts/{accountid}/marketvaluesummary/{fromdate}/{todate}

@GetMarketvaluesofHousehold @positive
Scenario Outline: Verify that market value summary of household of funded Account is retrieved based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketvaluesofHouseholdservice>" API
	Then response should have "beginningValue,endingValue,netContribution,period,periodStartDate,portFolioGainLoss" fields		
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetMarketvaluesofHouseholdservice                                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U47,/marketvaluesummary,/2015-03-16,/2019-11-18 |
	| AG1634 | householdaccountservice_URL,accounts/,AH9U48,/marketvaluesummary,/2015-03-16,/2019-11-18 |

	
@GetMarketvaluesofHousehold @positive
Scenario Outline: Verify that market value summary of household of closed Account is retrieved based on the provided start and end dates
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketvaluesofHouseholdservice>" API
	Then response should have "beginningValue,endingValue,netContribution,period,periodStartDate,portFolioGainLoss" fields
	Then response should match "response.advisorContractId" as "AG1634" 
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetMarketvaluesofHouseholdservice                                                                  |
	| AG1634 | householdaccountservice_URL,accounts/,AH22M9,/marketvaluesummary,/2013-03-04,/2019-11-18 |	

@GetMarketvaluesofHousehold @positive
Scenario Outline: Verify that  market value summary of household of pending Account is displayed as blank when start and end dates are provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketvaluesofHouseholdservice>" API
	Then response should have "beginningValue,endingValue,netContribution,period,periodStartDate,portFolioGainLoss" fields
	Then response should match "response.[0].beginningValue" as "0"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetMarketvaluesofHouseholdservice                                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AH6J62,/marketvaluesummary,/2013-03-04,/2019-11-18 |

@GetMarketvaluesofHousehold @negative
Scenario Outline: Verify that market value summary of household of an Account is not retrieved when invalid input is provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketvaluesofHouseholdservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"
	
	Examples: 
	| Scenario         | Agent  | GetMarketvaluesofHouseholdservice                                              |
	| Blank            | AG1634 | householdaccountservice_URL,accounts/,AH9U48,/marketvaluesummary,/2015-03-16,/ |
	| SpecialCharacter | AG1634 | householdaccountservice_URL,accounts/,AH9U48,/marketvaluesummary,/#$@@#$@$     |
	| Invalid          |AG1634  | householdaccountservice_URL,accounts/,AH9U48,/marketvalue                      |

@GetMarketvaluesofHousehold @negative
Scenario Outline: Verify that market value summary of household of another Agent's Account is not retrieved 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetMarketvaluesofHouseholdservice>" API
	Then Response should be returned as empty
	Then Status Code is "403"
	
	Examples: 
	| Agent  | GetMarketvaluesofHouseholdservice                                                        |
	| AG1634 | householdaccountservice_URL,accounts/,AH12Z8,/marketvaluesummary,/2015-03-16,/2019-11-18 |

@GetMarketvaluesofHousehold @negative
Scenario Outline: Verify that market value summary of household of an Account is not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetMarketvaluesofHouseholdservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetMarketvaluesofHouseholdservice                                                        | 
	| AG1634 | householdaccountservice_URL,accounts/,AH9U48,/marketvaluesummary,/2015-03-16,/2019-11-18 |		

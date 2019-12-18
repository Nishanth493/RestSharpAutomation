Feature: GetCumulativeReturnHistoryOfHousehold

@Household_GetCumulativeReturnHistoryOfHousehold_Positive
@Positive
Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Positive_Daily
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeDetails>" API
	Then response should have "cumulativeReturnPercentage" fields
	Then response should match "response.beginDate" as "2015-03-17T00:00:00"
	Then response should match "response.endDate" as "2019-11-30T00:00:00"
	Then Status Code is "200"
	Then Response is Not Empty
	Then User validates data for daily frequency for dates "2015-03-17" and "2019-11-30" using ".date" element of JSON response
	
	Examples: 
	| Agent  | GetCumulativeDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/cumulativereturnhistory/2015-03-17/2019-11-30/Daily|

	Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Positive_Weekly
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeDetails>" API
	Then response should have "cumulativeReturnPercentage" fields
	Then response should match "response.beginDate" as "2017-08-02T00:00:00"
	Then response should match "response.endDate" as "2017-08-09T00:00:00"
	Then Status Code is "200"
	Then Response is Not Empty
	Then User validates data for "Weekly" frequency for dates "2017-08-02" and "2017-08-09" using ".date" element of JSON response
	Examples: 
	| Agent  | GetCumulativeDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/cumulativereturnhistory/2017-08-02/2017-08-09/Weekly|

	Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Positive_Monthly
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeDetails>" API
	Then response should have "cumulativeReturnPercentage" fields
	Then response should match "response.beginDate" as "2015-03-17T00:00:00"
	Then response should match "response.endDate" as "2019-11-30T00:00:00"
	Then Status Code is "200"
	Then Response is Not Empty
	Then User validates data for monthly frequency for dates "2015-03-17" and "2019-11-30" using ".date" element of JSON response
	
	Examples: 
	| Agent  | GetCumulativeDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/cumulativereturnhistory/2015-03-17/2019-11-30/Monthly|

	Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Positive_Quarterly
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeDetails>" API
	Then response should have "cumulativeReturnPercentage" fields
	Then response should match "response.beginDate" as "2015-03-17T00:00:00"
	Then response should match "response.endDate" as "2019-11-30T00:00:00"
	Then Status Code is "200"
	Then Response is Not Empty
	Then User validates data for quarterly frequency for dates "2015-03-17" and "2019-11-30" using ".date" element of JSON response
	
	Examples: 
	| Agent  | GetCumulativeDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/cumulativereturnhistory/2015-03-17/2019-11-30/Quarterly|

	Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Positive_Yearly
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeDetails>" API
	Then response should have "cumulativeReturnPercentage" fields
	Then response should match "response.beginDate" as "2015-03-17T00:00:00"
	Then response should match "response.endDate" as "2019-12-30T00:00:00"
	Then Status Code is "200"
	Then Response is Not Empty
	Then User validates data for Yearly frequency for dates "2015-03-17" and "2019-12-30" using ".date" element of JSON response
	
	Examples: 
	| Agent  | GetCumulativeDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/cumulativereturnhistory/2015-03-17/2019-12-30/Yearly|

@Household_GetCumulativeReturnHistoryOfHousehold_Negative
@Negative
Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetCumulativeDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households//cumulativereturnhistory//2019-11-01/|

	@Household_GetCumulativeReturnHistoryOfHousehold_Negative_InvalidHouseHoldID
	@Negative
	Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetCumulativeDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5/accounts/download |

	@Household_GetCumulativeReturnHistoryOfHousehold_Negative_HouseHoldIDWithSpecialCharacters
	@Negative
	Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetCumulativeDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetCumulativeDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5@$%/accounts/download |

@Household_GetCumulativeReturnHistoryOfHousehold_Negative_WithoutLogin
@Negative
Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                        
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download |


@Household_GetCumulativeReturnHistoryOfHousehold_Negative_WithOtherUserLogin
@Negative
Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                         
	| AG1634 | householdaccountservice_URL,households/CA3KD2/accounts/download |

	Scenario: Household_JSON
	Then User validates data for "Monthly" frequency for dates "31" "03" "2015" and "30" "04" "2015"


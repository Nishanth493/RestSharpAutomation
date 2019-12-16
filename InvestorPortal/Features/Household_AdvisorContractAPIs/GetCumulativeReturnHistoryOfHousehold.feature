Feature: GetCumulativeReturnHistoryOfHousehold

@Household_GetCumulativeReturnHistoryOfHousehold_Positive
@positive
Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then response should have "cumulativeReturnPercentage,netReturnCumulative,netInvestment,marketValue,accountId" fields
	Then response should match "response.beginDate" as "2009-01-06T00:00:00"
	Then response should match "response.endDate" as "2019-11-01T00:00:00"
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/cumulativereturnhistory/2009-01-06/2019-11-01/Daily|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/cumulativereturnhistory/2009-01-06/2019-11-01/Weekly|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/cumulativereturnhistory/2009-01-06/2019-11-01/Monthly|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/cumulativereturnhistory/2009-01-06/2019-11-01/Quarterly|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/cumulativereturnhistory/2009-01-06/2019-11-01/Yearly|

@Household_GetCumulativeReturnHistoryOfHousehold_Negative
@negative
Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetHouseHoldDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households//cumulativereturnhistory//2019-11-01/|

	@Household_GetCumulativeReturnHistoryOfHousehold_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5/accounts/download |

	@Household_GetCumulativeReturnHistoryOfHousehold_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5@$%/accounts/download |

@Household_GetCumulativeReturnHistoryOfHousehold_Negative_WithoutLogin
@negative
Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                        
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download |


@Household_GetCumulativeReturnHistoryOfHousehold_Negative_WithOtherUserLogin
@negative
Scenario Outline: Household_GetCumulativeReturnHistoryOfHousehold_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                         
	| AG1634 | householdaccountservice_URL,households/CA3KD2/accounts/download |

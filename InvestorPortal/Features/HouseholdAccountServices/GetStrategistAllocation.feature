Feature: GetStrategistAllocation
URL: /api/householdaccountservice/v1/households/{householdid}/strategistallocation

@positive @GetStrategistAllocation @ValidData
Scenario Outline: Verify strategist allocation details are displayed for valid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetStrategistAllocation>" API
	Then response should have "strategistGroupName,sleeveValue,percentage,sleeveHoldings" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Agent  | GetStrategistAllocation                                                    |
		| AG1634 | householdaccountservice_URL,households/,household_ID,/strategistallocation |

@negative @GetStrategistAllocation @InvalidHOuseHoldID
Scenario Outline: Verify strategist allocation details are not displayed for invalid householdid that is #$%#%##
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetStrategistAllocation>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| Agent  | GetStrategistAllocation                                                           |
		| AG1634 | householdaccountservice_URL,households/,Invalidhousehold_ID,/strategistallocation |

@negative @GetStrategistAllocation @WithoutLogin
Scenario Outline: Verify strategist allocation details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetStrategistAllocation>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| Agent  | GetStrategistAllocation                                                    |
		| AG1634 | householdaccountservice_URL,households/,household_ID,/strategistallocation |

@negative @GetStrategistAllocation @WithOtherUserLogin
Scenario Outline: Verify strategist allocation details are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetStrategistAllocation>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| Agent  | GetStrategistAllocation                                                              |
		| AG1634 | householdaccountservice_URL,households/,OtherAgentHousehold_ID,/strategistallocation |
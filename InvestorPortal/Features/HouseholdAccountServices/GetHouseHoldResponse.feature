Feature: GetHouseHoldResponse
URL: /api/householdaccountservice/v1/households/households/bypage

@positive
@HouseHoldResponseDetails_ValidData
Scenario Outline: Verify strategist allocation details are displayed for valid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldResponse>" API
	Then response should have "householdId,webHouseholdId,advisorContractId,agentSiebelID,riskProfile,firstName,lastName,displayName,sortName,advisorID" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Agent  | GetHouseHoldResponse                                     |
		| AG1634 | householdaccountservice_URL,households/households/bypage |

@negative
@HouseHoldResponseDetails_InvalidHOuseHoldID
Scenario Outline: Verify strategist allocation details are not displayed for invalid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldResponse>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| GetHouseHoldResponse                                          | Agent  |
		| householdaccountservice_URL,households/households/bypage,/ABC | AG1634 |

@negative
@HouseHoldResponseDetails_WithoutLogin
Scenario Outline: Verify strategist allocation details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldResponse>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| Agent  | GetHouseHoldResponse                                     |
		| AG1634 | householdaccountservice_URL,households/households/bypage |

@negative
@HouseHoldResponseDetails_WithOtherUserLogin
Scenario Outline: Verify strategist allocation details are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldResponse>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| Agent  | GetHouseHoldResponse                                     |
		| AG1634 | householdaccountservice_URL,households/households/bypage |
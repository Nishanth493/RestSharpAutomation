Feature: GetAssetclass
URL: /api/householdaccountservice/v1/households/{householdid}/assetclass

@positive
@AssetclassDetails_ValidData
Scenario Outline: Verify assetclass details are displayed for valid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAssetclass>" API
	Then response should have "id,name,amount,percentage,assetClasses" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Agent  | GetAssetclass                                                    |
		| AG1634 | householdaccountservice_URL,households/,household_ID,/assetclass |

@negative
@AssetclassDetails_InvalidHOuseHoldID
Scenario Outline: Verify assetclass details are not displayed for invalid householdid that is #$%#%##
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAssetclass>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| Agent  | GetAssetclass                                                           |
		| AG1634 | householdaccountservice_URL,households/,Invalidhousehold_ID,/assetclass |

@negative
@AssetclassDetails_WithoutLogin
Scenario Outline: Verify assetclass details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetAssetclass>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| Agent  | GetAssetclass                                                    |
		| AG1634 | householdaccountservice_URL,households/,household_ID,/assetclass |

@negative
@AssetclassDetails_WithOtherUserLogin
Scenario Outline: Verify assetclass details are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAssetclass>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| Agent  | GetAssetclass                                                              |
		| AG1634 | householdaccountservice_URL,households/,OtherAgentHousehold_ID,/assetclass |
Feature: GetPageSetting
URL: /api/preferences/v{api-version}/agent/{agentId}/pagesetting 

@positive
@PageSetting_ValidData
Scenario Outline: Verify that user is able to get page settings for a specific AgentId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetPageSetting>" API
	Then response should have "WEALTHBUILDER_PREVIEW_PROPOSAL_ALLOCATION_BYAPPROACH,WEALTHBUILDER_PREVIEW_PROPOSAL_CLIENTSIGNATURE,WEALTHBUILDER_PREVIEW_PROPOSAL_CUMULATIVEPERFORMANCE,WEALTHBUILDER_PREVIEW_PROPOSAL_GEO_DIVERSIFICATION" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| GetPageSetting                                      | Agent  |
		| preferences_URL,agent/,AgentDetails_ID,/pagesetting | AG1634 |

@negative
@PageSetting_InvalidURL
Scenario Outline: Verify page settings details are not displayed for invalid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetPageSetting>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| GetPageSetting                                           | Agent  |
		| preferences_URL,agent/,AgentDetails_ID,/pagesetting,/abc | AG1634 |
		| preferences_URL,agent/,AG#$#%#,/pagesetting              | AG1634 |

@negative
@PageSetting_WithoutLogin
Scenario Outline: Verify page settings details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetPageSetting>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| GetPageSetting                                      | Agent  |
		| preferences_URL,agent/,AgentDetails_ID,/pagesetting | AG1634 |

@negative
@PageSetting_WithOtherUserLogin
Scenario Outline: Verify page settings details are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetPageSetting>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| GetPageSetting                                          | Agent  |
		| preferences_URL,agent/,OtherClientAgent_ID,/pagesetting | AG1634 |
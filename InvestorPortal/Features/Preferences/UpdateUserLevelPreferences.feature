Feature: UpdateUserLevelPreferences
	
@UpdateUserLevelPreferences @positive @Ambika
Scenario Outline: Verify that user is able to Add/Update user level preference settings 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a put call of "<UpdateUserLevelPreferencesservice>" API to Update user level preference settings
	Then response should have "id,key,value,,agentPreferences,aplid,preferenceId" fields	
	Then response should match "Response.[0].key" as "WEALTHBUILDER_PREVIEW_PROPOSAL_SHORTFALLVSSURPLUS"	
	Then response should match "Response.[0].value" as "true"
	Then response should match "Response.agentPreferences.aplid" as "AG1634"	
	Then response should match "Response.[1].key" as "WEALTHBUILDER_REVIEW_PERFORMANCE_PERIOD"	
	Then response should match "Response.[1].value" as "3"	
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | UpdateUserLevelPreferencesservice          |
	| AG1634 | Preferences_URL,agent/,AG1634,/pagesetting |

@UpdateUserLevelPreferences @negative @Ambika
Scenario Outline: Verify that user is not able to update user level preferences when invalid request is provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a put call of "<UpdateUserLevelPreferencesservice>" API to Update user level preference with invalid data
	Then Status Code is "400"
	Then Response should return as "BadRequest" request
	
	Examples: 
	| Agent  | UpdateUserLevelPreferencesservice          |
	| AG1634 | Preferences_URL,agent/,AG1634,/pagesetting |

@UpdateUserLevelPreferences @negative @Ambika
Scenario Outline: Verify that user is not able to update user level preferences when blank request is provided
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a put call of "<UpdateUserLevelPreferencesservice>" API to Update user level preference with blank data
	Then Status Code is "400"
	Then Response should return as "BadRequest" request
	

	Examples: 
	| Agent  | UpdateUserLevelPreferencesservice          |
	| AG1634 | Preferences_URL,agent/,AG1634,/pagesetting |

@UpdateUserLevelPreferences @negative @Ambika
Scenario Outline: Verify that user is not able to update user level preferences for another Agent
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a put call of "<UpdateUserLevelPreferencesservice>" API to Update user level preference settings
	Then Status Code is "403"
	Then Response should return as "Forbidden" request	

	Examples: 
	| Agent  | UpdateUserLevelPreferencesservice          |
	| AG1634 | Preferences_URL,agent/,AGAE32,/pagesetting |

@UpdateUserLevelPreferences @negative @Ambika
Scenario Outline: Verify that user is not able to update user level preferences without authorization
	Given User is not authorised on eWM
	When User do a put call of "<UpdateUserLevelPreferencesservice>" API to Update user level preference settings
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | UpdateUserLevelPreferencesservice          |
	| AG1634 | Preferences_URL,agent/,AG1634,/pagesetting |


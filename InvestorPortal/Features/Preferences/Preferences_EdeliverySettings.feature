Feature: Preferences_EdeliverySettings
API URL: /api/preferences/v1/households/{householdId}/edeliverysettings


		@Preferences_EdeliverySettings_Positive
		@positive
Scenario Outline: Preferences_EdeliverySettings_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEdeliverySettings>" API
	Then response should have "docTypeCD,docTypeDescription,prefTypeCD,prefTypeCDDescription" fields
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetEdeliverySettings                           |                                  
	| AG1634 | preferences_URL,households/CA5ZQ9/edeliverysettings|

		@Preferences_EdeliverySettings_Negative
		@negative
Scenario Outline: Preferences_EdeliverySettings_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEdeliverySettings>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetEdeliverySettings                           |                                  
	| AG1634 | preferences_URL,households//edeliverysettings|

	@Preferences_EdeliverySettings_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: GetAccountsByHouseholdID_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEdeliverySettings>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetEdeliverySettings                                             |
	| AG1634 | preferences_URL,households/CA5Z9/edeliverysettings |

	@Preferences_EdeliverySettings_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: Preferences_EdeliverySettings_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEdeliverySettings>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetEdeliverySettings                                             |
	| AG1634 | preferences_URL,households/@A5Z*&^/edeliverysettings |

@Preferences_EdeliverySettings_Negative_WithoutLogin
@negative
Scenario Outline: Preferences_EdeliverySettings_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetEdeliverySettings>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetEdeliverySettings                                 |                                        
	| AG1634 | preferences_URL,households/CA5ZQ9/edeliverysettings |


@Preferences_EdeliverySettings_Negative_WithOtherUserLogin
@negative
Scenario Outline: Preferences_EdeliverySettings_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEdeliverySettings>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetEdeliverySettings                                  |                                         
	| AG1634 | preferences_URL,households/CA3KD2/edeliverysettings |


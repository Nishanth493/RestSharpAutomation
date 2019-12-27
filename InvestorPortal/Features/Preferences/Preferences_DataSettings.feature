Feature: Preferences_DataSettings
API URL: /api/preferences/v1/households/{householdId}/datasettings

		@Preferences_DataSettings_Positive
		@positive
Scenario Outline: Preferences_DataSettings_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDataSettings>" API
	Then response should have "preferenceTypeCD,displaySetting,preferenceTypeDescription" fields
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetDataSettings                           |                                  
	| AG1634 | preferences_URL,households/CA5ZQ9/datasettings|

		@Preferences_DataSettings_Negative
		@negative
Scenario Outline: Preferences_DataSettings_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDataSettings>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetDataSettings                           |                                  
	| AG1634 | preferences_URL,households//datasettings|

	@Preferences_DataSettings_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: GetAccountsByHouseholdID_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDataSettings>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetDataSettings                                             |
	| AG1634 | preferences_URL,households/CA5Z/datasettings |

	@Preferences_DataSettings_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: Preferences_DataSettings_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDataSettings>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetDataSettings                                             |
	| AG1634 | preferences_URL,households/C$@!#/datasettings |

@Preferences_DataSettings_Negative_WithoutLogin
@negative
Scenario Outline: Preferences_DataSettings_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                        
	| AG1634 | preferences_URL,households/CA5ZQ9/datasettings |


@Preferences_DataSettings_Negative_WithOtherUserLogin
@negative
Scenario Outline: Preferences_DataSettings_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                         
	| AG1634 | preferences_URL,households/CA3KD2/datasettings |


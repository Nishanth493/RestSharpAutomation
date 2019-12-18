Feature: Preferences_WebAccess
API URL: /api/preferences/v1/households/{householdId}/webaccess


		@Preferences_WebAccess_Positive
		@positive
Scenario Outline: Preferences_WebAccess_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetWebAccessDetails>" API
	Then response should have "webAccessTypeCD,webAccessTypeDescription,eDeliveryStatusCD,eDeliveryStatusDescription" fields
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetWebAccessDetails                           |                                  
	| AG1634 | preferences_URL,households/CA5ZQ9/webaccess|

		@Preferences_WebAccess_Negative
		@negative
Scenario Outline: Preferences_WebAccess_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetWebAccessDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetWebAccessDetails                           |                                  
	| AG1634 | preferences_URL,households//webaccess|

	@Preferences_WebAccess_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: GetAccountsByHouseholdID_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetWebAccessDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetWebAccessDetails                                             |
	| AG1634 | preferences_URL,households/ZQ9/webaccess |

	@Preferences_WebAccess_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: Preferences_WebAccess_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetWebAccessDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetWebAccessDetails                                             |
	| AG1634 | preferences_URL,households/CA@$Q9/webaccess |

@Preferences_WebAccess_Negative_WithoutLogin
Scenario Outline: Preferences_WebAccess_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetWebAccessDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetWebAccessDetails                                  |                                        
	| AG1634 | preferences_URL,households/CA5ZQ9/webaccess |


@Preferences_WebAccess_Negative_WithOtherUserLogin
Scenario Outline: Preferences_WebAccess_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetWebAccessDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetWebAccessDetails                                  |                                         
	| AG1634 | preferences_URL,households/CA3KD2/webaccess |


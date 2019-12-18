Feature: Preferences_EdeliveryStatus
API URL: /api/preferences/v1/households/{householdId}/webaccess/edeliverystatus

		@Preferences_EdeliveryStatus_Positive
		@positive
Scenario Outline: Preferences_EdeliveryStatus_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEdeliveryStatus>" API
	Then response should have "electronicDeliveryPending" fields
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetEdeliveryStatus                           |                                  
	| AG1634 | preferences_URL,households/CA5ZQ9/webaccess/edeliverystatus|

		@Preferences_EdeliveryStatus_Negative
		@negative
Scenario Outline: Preferences_EdeliveryStatus_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEdeliveryStatus>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetEdeliveryStatus                           |                                  
	| AG1634 | preferences_URL,households//webaccess/edeliverystatus|

	@Preferences_EdeliveryStatus_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: Preferences_EdeliveryStatus_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEdeliveryStatus>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetEdeliveryStatus                                             |
	| AG1634 | preferences_URL,households/CA5/webaccess/edeliverystatus |

	@Preferences_EdeliveryStatus_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: Preferences_EdeliveryStatus_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEdeliveryStatus>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetEdeliveryStatus                                             |
	| AG1634 | preferences_URL,households/CA5*@#/webaccess/edeliverystatus |

@Preferences_EdeliveryStatus_Negative_WithoutLogin
Scenario Outline: Preferences_EdeliveryStatus_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetEdeliveryStatus>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetEdeliveryStatus                                  |                                        
	| AG1634 | preferences_URL,households/CA5ZQ9/webaccess/edeliverystatus |


@Preferences_EdeliveryStatus_Negative_WithOtherUserLogin
Scenario Outline: Preferences_EdeliveryStatus_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEdeliveryStatus>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetEdeliveryStatus                                  |                                         
	| AG1634 | preferences_URL,households/CA3KD2/webaccess/edeliverystatus |


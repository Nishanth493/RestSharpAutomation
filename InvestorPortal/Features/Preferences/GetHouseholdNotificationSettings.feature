Feature: GetHouseholdNotificationSettings
APIURL: /api/preferences/v1/notifications/{notificationType}/advisorcontracts/{advisorContractId}/households/{householdId}

@notification
@get_household_notification_settings
@positive
Scenario Outline: Get Household Notification Settings for valid advisor and client
	Given User is Authorised on eWM as an AgentId "<Advisor>"
	When User do a get call of "<BaseURL><Advisor><Households><HouseholdID>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "id,notificationType,householdId,householdId,accessType,advisorContractId" fields
	Then response should match "Response.[*].householdId" as "<HouseholdID>"
	Then response should match "Response.[*].advisorContractId" as "<Advisor>"

	Examples:
		| Advisor | HouseholdID | BaseURL                                                | Households   |
		| AG1634  | CA0FZ5      | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ |

@notification
@get_household_notification_settings
@positive
Scenario Outline: Get Household Notification Settings having AccessType
	Given User is Authorised on eWM as an AgentId "<Advisor>"
	When User do a get call of "<BaseURL><Advisor><Households><HouseholdID><endURL><AccessTypeEnum>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "id,notificationType,householdId,householdId,accessType,advisorContractId" fields
	Then response should match "Response.[*].householdId" as "<HouseholdID>"
	Then response should match "Response.[*].advisorContractId" as "<Advisor>"
	Then response should match "Response.[*].accessType" as "<AccessTypeEnum>"

	Examples:
		| AccessTypeEnum    | Advisor | HouseholdID | BaseURL                                                | Households   | endURL           |
		| FullAccess        | AG1634  | CA0FZ5      | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ | ?accessTypeEnum= |
		| NoPerformanceRisk | AG1634  | CA0FZ5      | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ | ?accessTypeEnum= |

@notification
@get_household_notification_settings
@negative
Scenario Outline: Get Household Notification Settings having invalid AccessType
	Given User is Authorised on eWM as an AgentId "<Advisor>"
	When User do a get call of "<BaseURL><Advisor><Households><HouseholdID><endURL><AccessTypeEnum>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| AccessTypeEnum | Advisor | HouseholdID | BaseURL                                                | Households   | endURL           |
		| ????***Blank   | AG1634  | CA0FZ5      | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ | ?accessTypeEnum= |

@notification
@get_household_notification_settings
@negative
Scenario Outline: Get Household Notification Settings having for invalid householdID
	Given User is Authorised on eWM as an AgentId "<Advisor>"
	When User do a get call of "<BaseURL><Advisor><Households><HouseholdID>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Advisor | HouseholdID | BaseURL                                                | Households   |
		| AG1634  | 11111       | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ |

@notification
@get_household_notification_settings
@negative
Scenario Outline: Get Household Notification Settings having for blank householdID
	Given User is Authorised on eWM as an AgentId "<Advisor>"
	When User do a get call of "<BaseURL><Advisor><Households><HouseholdID>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Advisor | HouseholdID | BaseURL                                                | Households   |
		| AG1634  |             | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ |

@notification
@get_household_notification_settings
@negative
Scenario Outline: Get Household Notification Settings having for invalid advisor
	Given User is Authorised on eWM as an AgentId "<Advisor>"
	When User do a get call of "<BaseURL><Advisor><Households><HouseholdID>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Advisor      | HouseholdID | BaseURL                                                | Households   |
		| ????***Blank | CA0FZ5      | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ |
		| AG0076       | CA0FZ5      | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ |
		|              | CA0FZ5      | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ |

@notification
@get_household_notification_settings
@negative
Scenario Outline: Get Household Notification Settings without authorization
	Given User is not authorised on eWM
	When User do a get call of "<BaseURL><HouseholdID>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| HouseholdID | BaseURL                                                | Households   |
		| CA0FZ5      | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ |

@notification
@get_household_notification_settings
@negative
Scenario Outline: Get Household Notification Settings if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<BaseURL><HouseholdID>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| Agent  | HouseholdID | BaseURL                                                | Households   |
		| Ag1634 | CA1H79      | preferences_URL,notifications/,Goal/,advisorcontracts/ | /households/ |
Feature: GetAdvisorContractsDataSettings
	
@GetAdvisorContractsDataSettings @positive
Scenario Outline: Verify that Data setting details are retrieved for an Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAdvisorContractsDataSettingsservice>" API
	Then response should have "preferenceTypeCD,displaySetting,preferenceTypeDescription" fields	
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetAdvisorContractsDataSettingsservice                 |
	| AG1634 | Preferences_URL,advisorcontracts/,AG1634/,datasettings |

@GetAdvisorContractsDataSettings @negative
Scenario Outline: Verify that Data setting details are not retrieved for an invalid Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAdvisorContractsDataSettingsservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| Acenario         | Agent  | GetAdvisorContractsDataSettingsservice                 |
	| Invalid          | AG1634 | Preferences_URL,advisorcontracts/,AG/,datasettings     |
	| SpecialCharacter | AG1634 | Preferences_URL,advisorcontracts/,@#$@#@/,datasettings |
	| Blank            | AG1634 | Preferences_URL,advisorcontracts/,/,datasettings       |

@GetAdvisorContractsDataSettings @negative
Scenario Outline: Verify that Data setting details are not retrieved for an another Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAdvisorContractsDataSettingsservice>" API
	Then Response should be returned as empty
	Then Status Code is "403"

	Examples: 
	| Agent  | GetAdvisorContractsDataSettingsservice                 |
	| AG1634 | Preferences_URL,advisorcontracts/,AGAE32/,datasettings |

@GetAdvisorContractsDataSettings @negative
Scenario Outline:Verify that Data setting details are not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetAdvisorContractsDataSettingsservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetAdvisorContractsDataSettingsservice                 |
	| AG1634 | Preferences_URL,advisorcontracts/,AG1634/,datasettings |	


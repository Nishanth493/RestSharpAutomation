Feature: GetAdvisorContractsDataSettings
	
@GetAdvisorContractsDataSettings @positive
Scenario Outline: Verify that Data setting details are retrieved for an Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<preferenceservice>" API
	Then response should have "displaySetting,preferenceTypeCD,preferenceTypeDescription" fields	
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | preferenceservice                                            |
	| AG1634 | preferenceservice_URL,advisorcontracts/,AG1634/,datasettings |

@GetAdvisorContractsDataSettings @positive
Scenario Outline: Verify that Data setting details are not retrieved for an invalid Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<preferenceservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| Agent  | preferenceservice                                            |
	| AG1634 | preferenceservice_URL,advisorcontracts/,AG/,datasettings     |
	| AG1634 | preferenceservice_URL,advisorcontracts/,@#$@#@/,datasettings |
	| AG1634 | preferenceservice_URL,advisorcontracts/,/,datasettings       |

@GetAdvisorContractsDataSettings @positive
Scenario Outline: Verify that Data setting details are not retrieved for an another Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<preferenceservice>" API
	Then Response should be returned as empty
	Then Status Code is "403"

	Examples: 
	| Agent  | preferenceservice                                            |
	| AG1634 | preferenceservice_URL,advisorcontracts/,AGAE32/,datasettings |

@GetAdvisorContractsDataSettings @negative
Scenario Outline:Verify that Data setting details are not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<preferenceservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | preferenceservice                                            |
	| AG1634 | preferenceservice_URL,advisorcontracts/,AG1634/,datasettings |		


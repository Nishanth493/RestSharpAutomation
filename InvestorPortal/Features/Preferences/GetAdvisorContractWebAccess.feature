Feature: GetAdvisorContractWebAccess	
URL: /api/preferences/v1/advisorcontracts/{advisorcontractid}/webaccess
	
@GetAdvisorContractWebAccess @positive
Scenario Outline: Verify that Web Access details are retrieved for an Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAdvisorContractWebAccessservice>" API
	Then response should have "webAccessTypeCD,webAccessTypeDescription,eDeliveryStatusCD,eDeliveryStatusDescription" fields	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetAdvisorContractWebAccessservice                  |
	| AG1634 | Preferences_URL,advisorcontracts/,AG1634/,webaccess |

@GetAdvisorContractWebAccess @negative
Scenario Outline: Verify that Web Access details are not retrieved for an invalid Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAdvisorContractWebAccessservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| Scenario         | Agent  | GetAdvisorContractWebAccessservice                  |
	| Invalid          | AG1634 | Preferences_URL,advisorcontracts/,AG/,webaccess     |
	| SpecialCharacter | AG1634 | Preferences_URL,advisorcontracts/,@#$@#@/,webaccess |
	| Blank            |AG1634  | Preferences_URL,advisorcontracts/,/,webaccess       |

@GetAdvisorContractWebAccess @negative
Scenario Outline: Verify that Web Access details are not retrieved for an another Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAdvisorContractWebAccessservice>" API
	Then Response should be returned as empty
	Then Status Code is "403"

	Examples: 
	| Agent  | GetAdvisorContractWebAccessservice                  |
	| AG1634 | Preferences_URL,advisorcontracts/,AGAE32/,webaccess |

@GetAdvisorContractWebAccess @negative
Scenario Outline:Verify that Web Access details are not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetAdvisorContractWebAccessservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetAdvisorContractWebAccessservice                  |
	| AG1634 | Preferences_URL,advisorcontracts/,AG1634/,webaccess |	


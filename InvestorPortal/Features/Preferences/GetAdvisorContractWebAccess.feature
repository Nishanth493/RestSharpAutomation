Feature: GetAdvisorContractWebAccess	
	
@GetAdvisorContractWebAccess @positive
Scenario Outline: Verify that Web Access details are retrieved for an Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<preferenceservice>" API
	Then response should have "webAccessTypeCD,webAccessTypeDescription,eDeliveryStatusCD,eDeliveryStatusDescription" fields	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | preferenceservice                                         |
	| AG1634 | preferences_URL,advisorcontracts/,AG1634/,webaccess |

@GetAdvisorContractWebAccess @negative
Scenario Outline: Verify that Web Access details are not retrieved for an invalid Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<preferenceservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| Agent  | preferenceservice                                         |
	| AG1634 | preferences_URL,advisorcontracts/,AG/,webaccess     |
	| AG1634 | preferences_URL,advisorcontracts/,@#$@#@/,webaccess |
	| AG1634 | preferences_URL,advisorcontracts/,/,webaccess       |

@GetAdvisorContractWebAccess @negative
Scenario Outline: Verify that Web Access details are not retrieved for an another Advisor ContractId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<preferenceservice>" API
	Then Response should be returned as empty
	Then Status Code is "403"

	Examples: 
	| Agent  | preferenceservice                                         |
	| AG1634 | preferences_URL,advisorcontracts/,AGAE32/,webaccess |

@GetAdvisorContractWebAccess @negative
Scenario Outline:Verify that Web Access details are not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<preferenceservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | preferenceservice                                         |
	| AG1634 | preferences_URL,advisorcontracts/,AG1634/,webaccess |	


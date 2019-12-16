﻿Feature: CreateWebAccess
	
@CreateDataSettings @positive
Scenario Outline: Verify that user is able to create web access for a specific householdId 
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a post call of "<preferenceservice>" API to create web access for householdId "CA5ZQ9"
	Then response should have "householdId,webAccessTypeCD,webAccessTypeDescription,eDeliveryStatusCD,eDeliveryStatusDescription" fields	
	Then Status Code is "201"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | preferenceservice                           |
	| AG1634 | preferences_URL,households/,webaccess |

@CreateDataSettings @negative
Scenario Outline: Verify that user is not able to create web access for an invalid householdId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a post call of "<preferenceservice>" API to create web access for householdId ""
	Then Response should be returned as empty
	Then Status Code is "400"

	Examples: 
	| Agent  | preferenceservice                           |
	| AG1634 | preferences_URL,households/,webaccess |

@CreateDataSettings @negative
Scenario Outline: Verify that user is not able to create web access for an another agents's householdId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a post call of "<preferenceservice>" API to create web access for householdId "CA33G6"
	Then Response should be returned as empty
	Then Status Code is "403"

	Examples: 
	| Agent  | preferenceservice                           |
	| AG1634 | preferences_URL,households/,webaccess |

@CreateDataSettings @negative
Scenario Outline: Verify that user is not able to create web access without authorization
	Given User is not authorised on eWM
	When User do a get call of "<preferenceservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | preferenceservice                           |
	| AG1634 | preferences_URL,households/,webaccess |	


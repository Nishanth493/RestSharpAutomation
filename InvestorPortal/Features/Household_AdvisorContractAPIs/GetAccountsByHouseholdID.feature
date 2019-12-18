Feature: GetAccountsByHouseholdID
API URL: /api/householdaccountservice/v1/households/{householdid}/accounts


		@AdvisorContracts_GetAccountsByHouseholdID_Positive
		@positive
Scenario Outline: AdvisorContracts_GetAccountsByHouseholdID_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountDetails>" API
	Then response should have "accountId,web_AccountID,accountNumber,householdId,advisorContractId,owner,registrationType,registrationTypeText,registrationTypeID,accountType,registeredName,isFunded,isClosed,isProposed" fields
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetAccountDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts|


	Scenario Outline: AdvisorContracts_GetAccountsByHouseholdID_Positive_SpecificAccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountDetails>" API
	Then response should have "accountId,web_AccountID,accountNumber,householdId,advisorContractId,owner,registrationType,registrationTypeText,registrationTypeID,accountType,registeredName,isFunded,isClosed,isProposed" fields
	Then response should match "response.[0].accountId" as "AH9U47"
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetAccountDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts?accountId=AH9U47|

	Scenario Outline: AdvisorContracts_GetAccountsByHouseholdID_Positive_SpecificProposedAccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountDetails>" API
	Then response should have "accountId,web_AccountID,accountNumber,householdId,advisorContractId,owner,registrationType,registrationTypeText,registrationTypeID,accountType,registeredName,isFunded,isClosed,isProposed" fields
	Then response should match "response.[0].web_AccountID" as "1390121" 
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetAccountDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts?proposedAccountId=1390121|

	Scenario Outline: AdvisorContracts_GetAccountsByHouseholdID_Positive_SpecificAccountID&ProposedAccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountDetails>" API
	Then response should have "accountId,web_AccountID,accountNumber,householdId,advisorContractId,owner,registrationType,registrationTypeText,registrationTypeID,accountType,registeredName,isFunded,isClosed,isProposed" fields
	Then response should match "response.[0].accountId" as "AH9U47"
	Then response should match "response.[0].web_AccountID" as "0"
	Then response should match "response.[1].web_AccountID" as "1390121"
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | GetAccountDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts?accountId=AH9U47&proposedAccountId=1390121|


		@AdvisorContracts_GetAccountsByHouseholdID_Negative
		@negative
Scenario Outline: AdvisorContracts_GetAccountsByHouseholdID_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	
	Examples: 
	| Agent  | GetAccountDetails                           |                                  
	| AG1634 | householdaccountservice_URL,households//accounts|

	@AdvisorContracts_GetAccountsByHouseholdID_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: GetAccountsByHouseholdID_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetAccountDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5/accounts |

	@AdvisorContracts_GetAccountsByHouseholdID_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: AdvisorContracts_GetAccountsByHouseholdID_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetAccountDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetAccountDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5@$%/accounts |

@AdvisorContracts_GetAccountsByHouseholdID_Negative_WithoutLogin
Scenario Outline: AdvisorContracts_GetAccountsByHouseholdID_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                        
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts |


@AdvisorContracts_GetAccountsByHouseholdID_Negative_WithOtherUserLogin
Scenario Outline: AdvisorContracts_GetAccountsByHouseholdID_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                         
	| AG1634 | householdaccountservice_URL,households/CA3KD2/accounts |


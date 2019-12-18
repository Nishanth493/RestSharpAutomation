﻿Feature: DownloadAccounts
	In order to avoid silly mistakes
	As a math idiot
	I want to be told the sum of two numbers

@Household_DownloadAccounts_Positive
@positive
Scenario Outline: Household_DownloadAccounts_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then response should have "AccountType,RegistrationType,RegisteredName,FundingAccount,AccountNumber,TerminationDate,ModelName,InceptionDate,MarketValue,% of Total,AsOfDate" fields
	Then Status Code is "200"
	Then Response is Not Empty
	Then User verfies download file type is "EXCEL" 
 

	
	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?filetype=EXCEL |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?filetype=CSV |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?filetype=EXCEL&showNetInvestment=0 |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?filetype=EXCEL&showNetInvestment=1 |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?filetype=CSV&showNetInvestment=0 |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?filetype=CSV&showNetInvestment=1 |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funding |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=closed |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=pending |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funded |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funding?filetype=EXCEL|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funding?filetype=CSV|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funding?filetype==EXCEL&showNetInvestment=0|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funding?filetype==EXCEL&showNetInvestment=1|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funding?filetype==CSV&showNetInvestment=0|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funding?filetype==CSV&showNetInvestment=0|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=closed?filetype=EXCEL|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=closed?filetype=CSV|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=closed?filetype==EXCEL&showNetInvestment=0|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=closed?filetype==EXCEL&showNetInvestment=1|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=closed?filetype==CSV&showNetInvestment=0|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=closed?filetype==CSV&showNetInvestment=1|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funded?filetype=EXCEL|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funded?filetype=CSV|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funded?filetype==EXCEL&showNetInvestment=0|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funded?filetype==EXCEL&showNetInvestment=1|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funded?filetype==CSV&showNetInvestment=0|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=funded?filetype==CSV&showNetInvestment=0|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=pending?filetype=EXCEL|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=pending?filetype=CSV|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=pending?filetype==EXCEL&showNetInvestment=0|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=pending?filetype==EXCEL&showNetInvestment=1|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=pending?filetype==CSV&showNetInvestment=0|
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download?accounttype=pending?filetype==CSV&showNetInvestment=0|

@Household_DownloadAccounts_Negative
@negative
Scenario Outline: Household_DownloadAccounts_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households//accounts/download |

	@Household_DownloadAccounts_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: Household_DownloadAccounts_InvalidHouseHoldID_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5/accounts/download |

	@Household_DownloadAccounts_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: Household_DownloadAccounts_HouseHoldIDWithSpecialCharacters_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldDetails>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | GetHouseHoldDetails                                             |
	| AG1634 | householdaccountservice_URL,households/CA5@$%/accounts/download |

@Household_DownloadAccounts_Negative_WithoutLogin
Scenario Outline: Household_DownloadAccounts_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                        
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/accounts/download |


@Household_DownloadAccounts_Negative_WithOtherUserLogin
Scenario Outline: Household_DownloadAccounts_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetHouseHoldPerformanceDetails>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | GetHouseHoldPerformanceDetails                                  |                                         
	| AG1634 | householdaccountservice_URL,households/CA3KD2/accounts/download |
	


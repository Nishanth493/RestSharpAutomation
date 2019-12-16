Feature: GetLastPriceUpdateDate

@GetLastPriceUpdateDate @positive
Scenario Outline: Verify that Last price update date is displayed for a specifc AgentId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | householdaccountservice                                   | 
	| AG1634 | householdaccountservice_URL,accounts/,lastpriceupdatedate |			  
	

@GetLastPriceUpdateDate @negative
Scenario Outline: Verify that Last price update date is not displayed for an invalid request
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<householdaccountservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| Agent  | householdaccountservice                         |
	| AG1634 | householdaccountservice_URL,accounts/,#%@#$%#@% |
	| AG1634 | householdaccountservice_URL,accounts/,          | 
	| AG1634 | householdaccountservice_URL,accounts/,last      | 

@GetLastPriceUpdateDate @negative
Scenario Outline: Verify that Last price update date is not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<householdaccountservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | householdaccountservice                                   | 
	| AG1634 | householdaccountservice_URL,accounts/,lastpriceupdatedate |		



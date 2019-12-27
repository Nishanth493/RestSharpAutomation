Feature: GetLastPriceUpdateDate
URL: /api/householdaccountservice/v1/accounts/lastpriceupdatedate

@GetLastPriceUpdateDate @positive @Ambika
Scenario Outline: Verify that Last price update date is displayed for a specifc AgentId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetLastPriceUpdateDateservice>" API	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| Agent  | GetLastPriceUpdateDateservice                             | 
	| AG1634 | householdaccountservice_URL,accounts/,lastpriceupdatedate |			  
	

@GetLastPriceUpdateDate @negative @Ambika
Scenario Outline: Verify that Last price update date is not displayed for an invalid request
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetLastPriceUpdateDateservice>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| Scenario         | Agent  | GetLastPriceUpdateDateservice                   |
	| SpecialCharacter | AG1634 | householdaccountservice_URL,accounts/,#%@#$%#@% |
	| Blank            | AG1634 | householdaccountservice_URL,accounts/,          |
	| Invalid          |AG1634  | householdaccountservice_URL,accounts/,last      | 

@GetLastPriceUpdateDate @negative @Ambika
Scenario Outline: Verify that Last price update date is not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetLastPriceUpdateDateservice>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | GetLastPriceUpdateDateservice                             | 
	| AG1634 | householdaccountservice_URL,accounts/,lastpriceupdatedate |		



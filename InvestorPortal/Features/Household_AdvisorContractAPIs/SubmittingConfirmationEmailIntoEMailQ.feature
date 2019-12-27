Feature: SubmittingConfirmationEmailIntoEMailQ
API URL: /api/householdaccountservice/v1/households/{householdid}/edeliveryconfirmation

	@Household_SubmittingConfirmationEmailIntoEMailQ_Positive
	@positive
Scenario Outline: Household_SubmittingConfirmationEmailIntoEMailQ_Positive
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a post call of "<SubmittingConfirmationEmail>" API
	Then response should have "true" fields
	Then Status Code is "200"
	Then Response is Not Empty
	
	Examples: 
	| Agent  | SubmittingConfirmationEmail                           |                                  
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/edeliveryconfirmation|

	@Household_SubmittingConfirmationEmailIntoEMailQ_Negative
	@negative
Scenario Outline: Household_SubmittingConfirmationEmailIntoEMailQ_Negative
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a post call of "<SubmittingConfirmationEmail>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | SubmittingConfirmationEmail                           |                                  
	| AG1634 | householdaccountservice_URL,households//edeliveryconfirmation|

	@Household_SubmittingConfirmationEmailIntoEMailQ_Negative_InvalidHouseHoldID
	@negative
	Scenario Outline: Household_SubmittingConfirmationEmailIntoEMailQ_Negative_InvalidHouseHoldID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<SubmittingConfirmationEmail>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | SubmittingConfirmationEmail                                             |
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/edeliveryconfirmation|

	@Household_SubmittingConfirmationEmailIntoEMailQ_Negative_HouseHoldIDWithSpecialCharacters
	@negative
	Scenario Outline: Household_SubmittingConfirmationEmailIntoEMailQ_Negative_HouseHoldIDWithSpecialCharacters
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<SubmittingConfirmationEmail>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples: 
	| Agent  | SubmittingConfirmationEmail                                             |
	| AG1634 | householdaccountservice_URL,households/CA5^%$/edeliveryconfirmation|

@Household_SubmittingConfirmationEmailIntoEMailQ_Negative_WithoutLogin
Scenario Outline: Household_SubmittingConfirmationEmailIntoEMailQ_Negative_WithoutLogin
	Given User is not authorised on eWM
	When User do a get call of "<SubmittingConfirmationEmail>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| Agent  | SubmittingConfirmationEmail                                  |                                        
	| AG1634 | householdaccountservice_URL,households/CA5ZQ9/edeliveryconfirmation|

@Household_SubmittingConfirmationEmailIntoEMailQ_Negative_WithOtherUserLogin
Scenario Outline: Household_SubmittingConfirmationEmailIntoEMailQ_Negative_WithOtherUserLogin
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<SubmittingConfirmationEmail>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples: 
	| Agent  | SubmittingConfirmationEmail                                  |                                         
	| AG1634 | householdaccountservice_URL,households/CA3KD2/edeliveryconfirmation|


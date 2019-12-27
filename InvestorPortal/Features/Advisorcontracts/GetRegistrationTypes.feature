Feature: GetRegistrationTypes
URL: /api/advisorcontracts/v1/{id}/registrationtypes

@positive @GetRegistrationTypes @ValidData
Scenario Outline: Verify list of registration types for the advisor contract
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<RegistrationTypes>" API
	Then response should have "regType_ID,isActive,isErisa,isGivingFund,sortOrder,groupTypeID,groupTypeDesc" fields
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| RegistrationTypes                                       | Agent  |
		| advisorcontracts_URL,AgentDetails_ID,/registrationtypes | AG1634 |

@negative @GetRegistrationTypes @InvalidURL
Scenario Outline: Verify list of registration details are not displayed for invalid data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<RegistrationTypes>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| RegistrationTypes                                            | Agent  |
		| advisorcontracts_URL,AgentDetails_ID,/registrationtypes,/abc | AG1634 |
		| advisorcontracts_URL,AG#&^##,/registrationtypes              | AG1634 |

@negative @GetRegistrationTypes @NegativeCase_WithoutLogin
Scenario Outline: Verify list of registration details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<RegistrationTypes>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| RegistrationTypes                                       | Agent  |
		| advisorcontracts_URL,AgentDetails_ID,/registrationtypes | AG1634 |

@negative @GetRegistrationTypes @NegativeCase_WithOtherUserLogin
Scenario Outline: Verify list of registration details are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<RegistrationTypes>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| RegistrationTypes                                           | Agent  |
		| advisorcontracts_URL,OtherClientAgent_ID,/registrationtypes | AG1634 |
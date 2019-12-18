Feature: GetDocumentsByType
URL: /api/documents/v1/household/{householdId}/odr?startDate={StartDate}&endDate={EndDate}&docType=ODR

@positive
@DocumentsByTypeDetails_StartDate_EndDate_docType
Scenario Outline: Verify documents details for doc type with parameter as start date end date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDocumentsByType>,<docType>" API
	Then response should have "agentId,clientId,clientName,comments,fileName,rawID,storeUrl,createdBy,createdOn,id" fields
	Then response should be match "response.[*].agentId" as "AgentDetails_ID"
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| docType | Agent  | GetDocumentsByType                                                                              |
		| QDR     | AG1634 | documentshousehold_URL,CA0FZ5household_ID,/ODR?startDate=2009-01-06&endDate=2019-12-10&docType= |
		| QPR     | AG1634 | documentshousehold_URL,CA0FZ5household_ID,/ODR?startDate=2009-01-06&endDate=2019-12-10&docType= |

@negative
@DocumentsByTypeDetails_InvalidStartDate_InvalidEndDate_InvaliddocType
Scenario Outline: Verify documents details are not displayed for invalid start date, end date and doc type
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDocumentsByType>,<docType>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples:
		| docType | Agent  | GetDocumentsByType                                                                              |
		| /QDR    | AG1634 | documentshousehold_URL,CA0FZ5household_ID,/ODR?startDate=&endDate=2019-12-10&docType=           |
		| /QPR    | AG1634 | documentshousehold_URL,CA0FZ5household_ID,/ODR?startDate=2009-01-06&endDate=#$#%##%&docType=    |
		|         | AG1634 | documentshousehold_URL,CA0FZ5household_ID,/ODR?startDate=2009-01-06&endDate=2019-12-10&docType= |

@negative
@DocumentsByTypeDetails_WithoutLogin
Scenario Outline: Verify documents details are not displayed without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetDocumentsByType>,<docType>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples:
		| docType | Agent  | GetDocumentsByType                                                                              |
		| /QDP    | AG1634 | documentshousehold_URL,CA0FZ5household_ID,/ODR?startDate=2009-01-06&endDate=2019-12-10&docType= |

@negative
@DocumentsByTypeDetails_WithOtherUserLogin
Scenario Outline: Verify documentsdetails are not displayed if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDocumentsByType>,<docType>" API
	Then Response should return as "forbidden" request
	Then Status Code is "403"

	Examples:
		| docType | Agent  | GetDocumentsByType                                                                                  |
		| /QDR    | AG1634 | documentshousehold_URL,OtherAgentHousehold_ID,/ODR?startDate=2009-01-06&endDate=2019-12-10&docType= |
Feature: GetListOfDocumentsForClient
APIURL: /api/documents/v1/household/{householdId}

@documents
@GetListOfDocumentsForClient
@positive
Scenario Outline: Get list of documents for client having DocType as
	Given User is Authorised on eWM as an AgentId "<AgentId>"
	When User do a get call of "<BaseURL><HouseholdID><p0><startDate><p1><endDate><p2><DocType>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "documentName,savedReportId,storeName,accountID,createdDate,period,accountNumber" fields
	Then response should match "Response.[*].docType" as "<DocType>"
	Then response should match "Response.[*].storeName" as "<storeName>"

	Examples:
		| DocType | AgentId | HouseholdID | BaseURL                 | p0          | startDate  | p1        | endDate    | p2        | storeName |
		| QPR     | AG1634  | CA5ZQ9      | documentshousehold_URL, | ?startDate= | 1969-12-31 | &endDate= | 2019-12-17 | &docType= | CS        |

@documents
@GetListOfDocumentsForClient
@negative
Scenario Outline: Get list of documents for client having invalid DocType as
	Given User is Authorised on eWM as an AgentId "<AgentId>"
	When User do a get call of "<BaseURL><HouseholdID><p0><startDate><p1><endDate><p2><DocType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| DocType | AgentId | HouseholdID | BaseURL                 | p0          | startDate  | p1        | endDate    | p2        |
		|         | AG1634  | CA5ZQ9      | documentshousehold_URL, | ?startDate= | 1969-12-31 | &endDate= | 2019-12-17 | &docType= |
		| AAA     | AG1634  | CA5ZQ9      | documentshousehold_URL, | ?startDate= | 1969-12-31 | &endDate= | 2019-12-17 | &docType= |

@documents
@GetListOfDocumentsForClient
@negative
Scenario Outline: Get list of documents for invalid client
	Given User is Authorised on eWM as an AgentId "<AgentId>"
	When User do a get call of "<BaseURL><HouseholdID><p0><startDate><p1><endDate><p2><DocType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| HouseholdID | DocType | AgentId | BaseURL                 | p0          | startDate  | p1        | endDate    | p2        |
		| 1111        | QPR     | AG1634  | documentshousehold_URL, | ?startDate= | 1969-12-31 | &endDate= | 2019-12-17 | &docType= |
		|             | QPR     | AG1634  | documentshousehold_URL, | ?startDate= | 1969-12-31 | &endDate= | 2019-12-17 | &docType= |

@documents
@GetListOfDocumentsForClient
@negative
Scenario Outline: Get list of documents for invalid agent
	Given User is Authorised on eWM as an AgentId "<AgentId>"
	When User do a get call of "<BaseURL><HouseholdID><p0><startDate><p1><endDate><p2><DocType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| AgentId | DocType | HouseholdID | BaseURL                 | p0          | startDate  | p1        | endDate    | p2        |
		| 1111    | QPR     | CA5ZQ9      | documentshousehold_URL, | ?startDate= | 1969-12-31 | &endDate= | 2019-12-17 | &docType= |
		|         | QPR     | CA5ZQ9      | documentshousehold_URL, | ?startDate= | 1969-12-31 | &endDate= | 2019-12-17 | &docType= |

@documents
@GetListOfDocumentsForClient
@negative
Scenario Outline: Get list of documents for agent without authorization
	Given User is not authorised on eWM
	When User do a get call of "<BaseURL><HouseholdID><p0><startDate><p1><endDate><p2><DocType>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| DocType | HouseholdID | BaseURL                 | p0          | startDate  | p1        | endDate    | p2        |
		| QPR     | CA5ZQ9      | documentshousehold_URL, | ?startDate= | 1969-12-31 | &endDate= | 2019-12-17 | &docType= |

@documents
@GetListOfDocumentsForClient
@negative
Scenario Outline: Get list of documents for agent if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<BaseURL><HouseholdID><p0><startDate><p1><endDate><p2><DocType>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| AgentId | DocType | HouseholdID | BaseURL                 | p0          | startDate  | p1        | endDate    | p2        |
		| AG1634  | QPR     | CA1H79      | documentshousehold_URL, | ?startDate= | 1969-12-31 | &endDate= | 2019-12-17 | &docType= |
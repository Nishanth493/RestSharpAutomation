Feature: GetDASproposalsforClient	
URL: /api/documents/v1/household/{householdId}/proposal


@GetDASproposalsforClient @positive
Scenario Outline: Verify that DAS Proposal data is retrieved for a client using HouseholdId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDASproposalsforClientService>" API
	Then response should have "accountID,accountName,accountNumber,batchID,createdDate,docType,documentName,period,storeName,savedReportId" fields
	Then response should match "response.[*].docType" as "<DocType>"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| DocType | Agent  | GetDASproposalsforClientService                                           | HouseholdId |
	| CIP_WBA | AG1634 | Documentservice_URL,household/,CA5ZQ9/,proposal?,savedReportType=,CIP_WBA | CA5ZQ9      |
	| CIP     | AG1634 | Documentservice_URL,household/,CA5ZQ9/,proposal?,savedReportType=,CIP     | CA5ZQ9      |
	| LGL     | AG1634 | Documentservice_URL,household/,CA5ZQ9/,proposal?,savedReportType=,LGL     | CA5ZQ9      |
	| GNW     | AG1634 | Documentservice_URL,household/,CA5ZQ9/,proposal?,savedReportType=,GNW     | CA5ZQ9      |
	| CSA     | AG1634 | Documentservice_URL,household/,CA5ZQ9/,proposal?,savedReportType=,CSA     | CA5ZQ9      |	

@GetDASproposalsforClient @negative
Scenario Outline: Verify that DAS Proposal data is not retrieved for a client using HouseholdId which belongs to another Agent
    Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDASproposalsforClientService>" API	
	Then Response should be returned as empty
	Then Status Code is "403"
	
	Examples: 
	| DocType | Agent  | GetDASproposalsforClientService                                           | HouseholdId |
	| CIP     | AG1634 | Documentservice_URL,household/,CA33G6/,proposal?,savedReportType=,CIP     | CA33G6      |

@GetDASproposalsforClient @negative
Scenario Outline:  Verify that DAS Proposal data is not retrieved for a client using invalid HouseholdId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetDASproposalsforClientService>" API
	Then Response should be returned as empty
	Then Status Code is "404"

	Examples: 
	| Scenario         | Agent  | GetDASproposalsforClientService                                        |
	| Invalid          | AG1634 | Documentservice_URL,household/,CA5ZQ91/,proposal?,savedReportType=,CSA |
	| SpecialCharacter | AG1634 | Documentservice_URL,household/,#$@$@#/,proposal?,savedReportType=,CSA  |
	| Blank            | AG1634 | Documentservice_URL,household/,/,proposal?,savedReportType=,CSA        | 

@GetDASproposalsforClient @negative
Scenario Outline: Verify that account details are not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetDASproposalsforClientService>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| DocType | Agent  | GetDASproposalsforClientService                                           | HouseholdId |
	| CIP_WBA | AG1634 | Documentservice_URL,household/,CA5ZQ9/,proposal?,savedReportType=,CIP_WBA | CA5ZQ9      |

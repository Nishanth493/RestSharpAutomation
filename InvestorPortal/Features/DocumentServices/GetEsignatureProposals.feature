Feature: GetEsignatureProposals	
URL: /api/documents/v1/household/{clientwebId}/esignproposal


@GetEsignatureProposals @positive
Scenario Outline: Verify that ESignature proposal is retrieved for a client using clientwebId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEsignatureProposalsService>" API
	Then response should have "accountID,accountName,accountNumber,batchID,createdDate,docType,documentName,period,storeName,savedReportId" fields
	Then response should match "response.[*].docType" as "<DocType>"	
	Then Status Code is "200"
	Then Response is Not Empty

	Examples: 
	| DocType | Agent  | GetEsignatureProposalsService                                                 | clientwebId |	
	| CIP     | AG1634 | Documentservice_URL,household/,W0NF39/,esigproposal?,savedReportType=,CIP     | W0NF39      |
	| LGL     | AG1634 | Documentservice_URL,household/,W0NF39/,esigproposal?,savedReportType=,LGL     | W0NF39      |
	| GNW     | AG1634 | Documentservice_URL,household/,W0NF39/,esigproposal?,savedReportType=,GNW     | W0NF39      |
	| CSA     | AG1634 | Documentservice_URL,household/,W0NF39/,esigproposal?,savedReportType=,CSA     | W0NF39      |	

@GetEsignatureProposals @negative
Scenario Outline: Verify that ESignature proposal is not retrieved for a document type CIP_WBA using clientwebId 
    Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEsignatureProposalsService>" API	
	Then response contains "[]"
	Then Status Code is "200"
	
	Examples: 
	| DocType | Agent  | GetEsignatureProposalsService                                                 | clientwebId |
	| CIP_WBA | AG1634 | Documentservice_URL,household/,W0NF39/,esigproposal?,savedReportType=,CIP_WBA | W0NF39      |


@GetEsignatureProposals @negative
Scenario Outline: Verify that ESignature proposal is not retrieved for a client using clientwebId which belongs to another Agent
    Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEsignatureProposalsService>" API	
	Then Response should be returned as empty
	Then Status Code is "403"
	
	Examples: 
	| DocType | Agent  | GetEsignatureProposalsService                                               | clientwebId |
	| CIP     | AG1634 | Documentservice_URL,household/,W0G3V2/,esigproposal?,savedReportType=,CIP   | W0G3V2      |

@GetEsignatureProposals @negative
Scenario Outline:  Verify that DAS Proposal data is not retrieved for a client using invalid HouseholdId
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<GetEsignatureProposalsService>" API
	Then Status Code is "404"
	Then Response should be returned as empty
	

	Examples: 
	| Scenario         | Agent  | GetEsignatureProposalsService                                              |
	| Invalid          | AG1634 | Documentservice_URL,household/,W0NF391/,esigproposal?,savedReportType=,CSA |
	| SpecialCharacter | AG1634 | Documentservice_URL,household/,#$@$@#/,esigproposal?,savedReportType=,CSA  |
	| Blank            | AG1634 | Documentservice_URL,household/,/,esigproposal?,savedReportType=,CSA        | 

@GetEsignatureProposals @negative
Scenario Outline: Verify that account details are not retrieved without authorization
	Given User is not authorised on eWM
	When User do a get call of "<GetEsignatureProposalsService>" API
	Then Response should return as "unauthorized" request
	Then Status Code is "401"

	Examples: 
	| DocType | Agent  | GetEsignatureProposalsService                                                 | clientwebId |
	| CIP     | AG1634 | Documentservice_URL,household/,W0NF39/,esigproposal?,savedReportType=,CIP     | W0NF39      |

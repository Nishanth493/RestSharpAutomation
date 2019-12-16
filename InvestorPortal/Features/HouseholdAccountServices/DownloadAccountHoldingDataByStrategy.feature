Feature: DownloadAccountholdingdataByStrategy
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/holdingsbystrategy/download

@accounts
@download_account_holding_data_by_strategy
@positive
Scenario Outline: Download account holding data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<AccountholdingdataByStrategy>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Strategist,Strategist Market Value,Strategy,Strategy Market Value,Strategy % of Total,Holding Name,Symbol,Market Value,% of Total" fields

	Examples:
		| Agent  | AccountholdingdataByStrategy                                              |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbystrategy/download |

@accounts
@download_account_holding_data_by_strategy
@positive
Scenario Outline: Download account holding data with fileType
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<AccountholdingdataByStrategy><fileType>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then download file type is "<fileType>"

	Examples:
		| fileType | Agent  | AccountholdingdataByStrategy                                                         |
		| CSV      | AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbystrategy/download,?filetype= |
		| EXCEL    | AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbystrategy/download,?filetype= |

@accounts
@download_account_holding_data_by_strategy
@positive
Scenario Outline: Download account holding data with fileType blank
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<AccountholdingdataByStrategy>" API
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Agent  | AccountholdingdataByStrategy                                                         |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbystrategy/download,?filetype= |

@accounts
@download_account_holding_data_by_strategy
@negative
Scenario Outline: Download account holding data with fileType invalid
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<AccountholdingdataByStrategy><fileType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| fileType | Agent  | AccountholdingdataByStrategy                                                         |
		| text     | AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbystrategy/download,?filetype= |

@accounts
@download_account_holding_data_by_strategy
@negative
Scenario Outline: Download account holding data using invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<AccountholdingdataByStrategy>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | AccountholdingdataByStrategy                                            |
		| AG1634 | householdaccountservice_URL,accounts/,1111,/holdingsbystrategy/download |

@accounts
@download_account_holding_data_by_strategy
@negative
Scenario Outline: Download account holding data using blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<AccountholdingdataByStrategy>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | AccountholdingdataByStrategy                                        |
		| AG1634 | householdaccountservice_URL,accounts/,,/holdingsbystrategy/download |

@accounts
@download_account_holding_data_by_strategy
@negative
Scenario Outline: Download account holding data without authorization
	Given User is not authorised on eWM
	When User do a get call of "<AccountholdingdataByStrategy>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| Agent  | AccountholdingdataByStrategy                                              |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbystrategy/download |

@accounts
@download_account_holding_data_by_strategy
@negative
Scenario Outline: Download account holding data if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<AccountholdingdataByStrategy>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| Agent  | AccountholdingdataByStrategy                                              |
		| AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/holdingsbystrategy/download |

@accounts
@download_account_holding_data_by_strategy
@negative
Scenario Outline: Download account holding data using special charachter in AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<AccountholdingdataByStrategy>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | AccountholdingdataByStrategy                                              |
		| AG1634 | householdaccountservice_URL,accounts/,AH23Z*,/holdingsbystrategy/download |
Feature: DownloadAccountHoldingData
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/holdings/download

@accounts
@download_account_holding_data
@positive
Scenario Outline: Download Account holding data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<Accountholdingdata>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Holding,CUSIPNO,Symbol,Quantity,Price,As of,Value,Cost,Gain/Loss,% of Total" fields

	Examples:
		| Agent  | Accountholdingdata                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdings,/download |

@accounts
@download_account_holding_data
@positive
Scenario Outline: Download Account holding data with fileType
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<Accountholdingdata><fileType>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then download file type is "<fileType>"

	Examples:
		| fileType | Agent  | Accountholdingdata                                                          |
		| CSV      | AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdings,/download,?filetype= |
		| EXCEL    | AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdings,/download,?filetype= |

@accounts
@download_account_holding_data
@positive
Scenario Outline: Download Account holding data with columnName and sorting order
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<Accountholdingdata>" API
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Agent  | Accountholdingdata                                                                                             |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdings,/download,?sortcolumnname=Quantity&sortorder=Descending |

@accounts
@download_account_holding_data
@negative
Scenario Outline: Download Account holding data with fileType blank
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<Accountholdingdata>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | Accountholdingdata                                                          |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdings,/download,?filetype= |

@accounts
@download_account_holding_data
@negative
Scenario Outline: Download Account holding data with fileType invalid
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<Accountholdingdata><fileType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| fileType | Agent  | Accountholdingdata                                                          |
		| text     | AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdings,/download,?filetype= |

@accounts
@download_account_holding_data
@negative
Scenario Outline: Download Account holding data using invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<Accountholdingdata>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | Accountholdingdata                                             |
		| AG1634 | householdaccountservice_URL,accounts/,1111,/holdings,/download |

@accounts
@download_account_holding_data
@negative
Scenario Outline: Download Account holding data using blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<Accountholdingdata>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | Accountholdingdata                                         |
		| AG1634 | householdaccountservice_URL,accounts/,,/holdings,/download |

@accounts
@download_account_holding_data
@negative
Scenario Outline: Download Account holding data without authorization
	Given User is not authorised on eWM
	When User do a get call of "<Accountholdingdata>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| Agent  | Accountholdingdata                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdings,/download |

@accounts
@download_account_holding_data
@negative
Scenario Outline: Download Account holding data if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<Accountholdingdata>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| Agent  | Accountholdingdata                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/holdings,/download |

@accounts
@download_account_holding_data
@negative
Scenario Outline: Download Account holding data using special charachter in AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<Accountholdingdata><fileType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| fileType | Agent  | Accountholdingdata                                                                                             |
		| CSV      | AG1634 | householdaccountservice_URL,accounts/,AH23Z*,/holdings,/download,?type=string,&page=1,&pageSize=250,&filetype= |
Feature: DownloadAccountActivityData
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/activity/download/{startdate}/{enddate}

@accounts
@download_account_activity_data
@positive
Scenario Outline: Download account activity data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Date,Type,Description,Holding,Quantity,Dollars,CUSIPNO,Ticker" fields

	Examples:
		| Agent  | ActivityAccountData                                                                    |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/activity,/download,/3-1-2011,/11-18-2019 |

@accounts
@download_account_activity_data
@positive
Scenario Outline: Download account activity data by All holding
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Date,Type,Description,Holding,Quantity,Dollars,CUSIPNO,Ticker" fields

	Examples:
		| Agent  | ActivityAccountData                                                                                 |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/activity,/download,/3-1-2011,/11-18-2019,?holding=All |

@accounts
@download_account_activity_data
@positive
Scenario Outline: Download account activity data using sortby and orderby
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Date,Type,Description,Holding,Quantity,Dollars,CUSIPNO,Ticker" fields

	Examples:
		| Agent  | ActivityAccountData                                                                                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/activity,/download,/3-1-2011,/11-18-2019,?sortby=TransactionDate&orderby=Descending |

@accounts
@download_account_activity_data
@positive
Scenario Outline: Download account activity data without type, fileType, holding, sortby, orderby, page and pageSize
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Date,Type,Description,Holding,Quantity,Dollars,CUSIPNO,Ticker" fields

	Examples:
		| Agent  | ActivityAccountData                                                                                                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/activity,/download,/3-1-2011,/11-18-2019,?page=&pageSize=&sortby=&orderby=&type=&holding=&filetype= |

@accounts
@download_account_activity_data
@positive
Scenario Outline: Download account activity data with fileType blank
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Date,Type,Description,Holding,Quantity,Dollars,CUSIPNO,Ticker" fields

	Examples:
		| Agent  | ActivityAccountData                                                                               |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/activity,/download,/3-1-2011,/11-18-2019,?filetype= |

@accounts
@download_account_activity_data
@positive
Scenario Outline: Download account activity data with fileType
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData><fileType>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Date,Type,Description,Holding,Quantity,Dollars,CUSIPNO,Ticker" fields
	Then download file type is "<fileType>"

	Examples:
		| fileType | Agent  | ActivityAccountData                                                                               |
		| CSV      | AG1634 | householdaccountservice_URL,accounts/,AC5996,/activity,/download,/3-1-2011,/11-18-2019,?filetype= |
		| EXCEL    | AG1634 | householdaccountservice_URL,accounts/,AC5996,/activity,/download,/3-1-2011,/11-18-2019,?filetype= |

@accounts
@download_account_activity_data
@negative
Scenario Outline: Download account activity data with fileType invalid
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData><fileType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| fileType | Agent  | ActivityAccountData                                                                               |
		| text     | AG1634 | householdaccountservice_URL,accounts/,AC5996,/activity,/download,/3-1-2011,/11-18-2019,?filetype= |

@accounts
@download_account_activity_data
@negative
Scenario Outline: Download account activity data using invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | ActivityAccountData                                                                  |
		| AG1634 | householdaccountservice_URL,accounts/,1111,/activity,/download,/3-1-2011,/11-18-2019 |

@accounts
@download_account_activity_data
@negative
Scenario Outline: Download account activity data using blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | ActivityAccountData                                                              |
		| AG1634 | householdaccountservice_URL,accounts/,,/activity,/download,/3-1-2011,/11-18-2019 |

@accounts
@download_account_activity_data
@negative
Scenario Outline: Download account activity data without authorization
	Given User is not authorised on eWM
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| Agent  | ActivityAccountData                                                                    |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/activity,/download,/3-1-2011,/11-18-2019 |

@accounts
@download_account_activity_data
@negative
Scenario Outline: Download account activity data if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| Agent  | ActivityAccountData                                                                    |
		| AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/activity,/download,/3-1-2011,/11-18-2019 |

@accounts
@download_account_activity_data
@negative
Scenario Outline: Download account activity data using special charachter in AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | ActivityAccountData                                                                     |
		| AG1634 | householdaccountservice_URL,accounts/,*AC5996,/activity,/download,/3-1-2011,/11-18-2019 |

@accounts
@download_account_activity_data
@negative
Scenario Outline: Download account activity data with blank start date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<ActivityAccountData>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | ActivityAccountData                                                            |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/activity,/download,/,/11-18-2019 |
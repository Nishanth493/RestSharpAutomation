Feature: DownloadRealizedGainLoss
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/realizedgainloss/download/{startdate}/{enddate}

@accounts
@download_realized_gain_loss
@positive
Scenario Outline: Download all types of realizedGainLoss value
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><Type>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Account Name,Account Number,Account Status,Position,Type,Symbol,Quantity,Purchase Date,Sale Date,Cost Basis,Proceeds,Gain/Loss,CUSIPNO,Wash sale Loss Disallowed,Date,Income" fields
	Then User verify downloaded file type is "<CSV>"

	Examples:
		| Type | Agent  | realizedgainlosstotalvalue                                                                              |
		| 1    | AG1634 | householdaccountservice_URL,accounts/,AC8SB3,/realizedgainloss,/download,/2019-01-01,/2019-11-15,?type= |

@accounts
@download_realized_gain_loss
@positive
Scenario Outline: Download Short Term type of realizedGainLoss value
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><Type>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Account Name,Account Number,Account Status,Position,Type,Symbol,Quantity,Purchase Date,Sale Date,Cost Basis,Proceeds,Gain/Loss,CUSIPNO,Wash sale Loss Disallowed,Date,Income" fields
	Then User verify downloaded file type is "<CSV>"

	Examples:
		| Type | Agent  | realizedgainlosstotalvalue                                                                              |
		| 2    | AG1634 | householdaccountservice_URL,accounts/,AC8SB3,/realizedgainloss,/download,/2019-01-01,/2019-11-15,?type= |

@accounts
@download_realized_gain_loss
@positive
Scenario Outline: Download Long Term type of realizedGainLoss value
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><Type>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Account Name,Account Number,Account Status,Position,Type,Symbol,Quantity,Purchase Date,Sale Date,Cost Basis,Proceeds,Gain/Loss,CUSIPNO,Wash sale Loss Disallowed,Date,Income" fields
	Then User verify downloaded file type is "<CSV>"

	Examples:
		| Type | Agent  | realizedgainlosstotalvalue                                                                              |
		| 3    | AG1634 | householdaccountservice_URL,accounts/,AC8SB3,/realizedgainloss,/download,/2019-01-01,/2019-11-15,?type= |

@accounts
@download_realized_gain_loss
@positive
Scenario Outline: Download Dividend, Interest, Other types of realizedGainLoss value
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><Type>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "Account Name,Account Number,Account Status,Position,Type,Symbol,Quantity,Purchase Date,Sale Date,Cost Basis,Proceeds,Gain/Loss,CUSIPNO,Wash sale Loss Disallowed,Date,Income" fields
	Then User verify downloaded file type is "<CSV>"

	Examples:
		| Type | Agent  | realizedgainlosstotalvalue                                                                              |
		| 4    | AG1634 | householdaccountservice_URL,accounts/,AC8SB3,/realizedgainloss,/download,/2019-01-01,/2019-11-15,?type= |

@accounts
@download_realized_gain_loss
@positive
Scenario Outline: Download closed account realizedGainLoss value
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><Type>" API
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Type | Agent  | realizedgainlosstotalvalue                                                                            |
		| 1    | AG1634 | householdaccountservice_URL,accounts/,AH22M9,/realizedgainloss,/download,/3-1-2011,/11-18-2019,?type= |

@accounts
@download_realized_gain_loss
@positive
Scenario Outline: Download pending account realizedGainLoss value
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><Type>" API
	Then Status Code is "200"
	Then Response is Not Empty

	Examples:
		| Type | Agent  | realizedgainlosstotalvalue                                                                            |
		| 1    | AG1634 | householdaccountservice_URL,accounts/,AH6J62,/realizedgainloss,/download,/3-1-2011,/11-18-2019,?type= |

@accounts
@download_realized_gain_loss
@positive
Scenario Outline: Download Account realizedGainLoss value with fileType
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><fileType>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then User verify downloaded file type is "<fileType>"

	Examples:
		| fileType | Agent  | realizedgainlosstotalvalue                                                                                                |
		| CSV      | AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainloss,/download,/3-1-2011,/11-18-2019,?type=1&filetype=  |
		| EXCEL    | AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainloss,/download,/3-1-2011,/11-18-2019,??type=1&filetype= |


@accounts
@download_realized_gain_loss
@positive
Scenario Outline: Download Account realizedGainLoss value with fileType blank
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then User verify downloaded file type is "<CSV>"

	Examples:
		| Agent  | realizedgainlosstotalvalue                                                                                      |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainloss,/download,/3-1-2011,/11-18-2019,?type=1filetype= |

@accounts
@download_realized_gain_loss
@negative
Scenario Outline: Download Account realizedGainLoss value with fileType invalid
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue><fileType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| fileType | Agent  | realizedgainlosstotalvalue                                                                                               |
		| text     | AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainloss,/download,/3-1-2011,/11-18-2019,?type=1&filetype= |

@accounts
@download_realized_gain_loss
@negative
Scenario Outline: Download Account realizedGainLoss value using invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | realizedgainlosstotalvalue                                                                           |
		| AG1634 | householdaccountservice_URL,accounts/,1111,/realizedgainloss,/download,/3-1-2011,/11-18-2019,?type=1 |

@accounts
@download_realized_gain_loss
@negative
Scenario Outline: Download Account realizedGainLoss value using blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | realizedgainlosstotalvalue                                                                       |
		| AG1634 | householdaccountservice_URL,accounts/,,/realizedgainloss,/download,/3-1-2011,/11-18-2019,?type=1 |

@accounts
@download_realized_gain_loss
@negative
Scenario Outline: Download Account realizedGainLoss value without authorization
	Given User is not authorised on eWM
	When User do a get call of "<realizedgainlosstotalvalue>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| Agent  | realizedgainlosstotalvalue                                                                             |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainloss,/download,/3-1-2011,/11-18-2019,?type=1 |

@accounts
@download_realized_gain_loss
@negative
Scenario Outline: Download Account realizedGainLoss value if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| Agent  | realizedgainlosstotalvalue                                                                             |
		| AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/realizedgainloss,/download,/3-1-2011,/11-18-2019,?type=1 |

@accounts
@download_realized_gain_loss
@negative
Scenario Outline: Download Account realizedGainLoss value using special charachter in AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | realizedgainlosstotalvalue                                                                              |
		| AG1634 | householdaccountservice_URL,accounts/,*AC5996,/realizedgainloss,/download,/3-1-2011,/11-18-2019,?type=1 |

@accounts
@download_realized_gain_loss
@negative
Scenario Outline: Download Account realizedGainLoss value with blank start date
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<realizedgainlosstotalvalue>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | realizedgainlosstotalvalue                                                                     |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/realizedgainloss,/download,/,/11-18-2019,?type=1 |
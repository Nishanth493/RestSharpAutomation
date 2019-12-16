Feature: DownloadAccountHoldingAssetclassData
APIURL: /api/householdaccountservice/v1.0/accounts/{accountid}/holdingsbyassetclass/download

@accounts
@download_account_holding_assetclass_data
@positive
Scenario Outline: Download holdings by asset class data
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then response should have "AssetType,AssetTypeValue,AssetTypePercentage,AssetClass,AssetClass_Value,AssetClass_Percentage,AssetSubClass,AssetSubClass_Value,AssetSubClass_Percentage,Holding,CUSIPNO,Quantity,Price,Symbol,As of" fields

	Examples:
		| Agent  | HoldingsByAssetClass                                                        |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbyassetclass/download |

@accounts
@download_account_holding_assetclass_data
@positive
Scenario Outline: Download holdings by asset class data with fileType
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass><fileType>" API
	Then Status Code is "200"
	Then Response is Not Empty
	Then download file type is "<fileType>"

	Examples:
		| fileType | Agent  | HoldingsByAssetClass                                                                   |
		| CSV      | AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbyassetclass/download,?filetype= |
		| EXCEL    | AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbyassetclass/download,?filetype= |

@accounts
@download_account_holding_assetclass_data
@negative
Scenario Outline: Download holdings by asset class data with fileType invalid
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass><fileType>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| fileType | Agent  | HoldingsByAssetClass                                                                   |
		| text     | AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbyassetclass/download,?filetype= |

@accounts
@download_account_holding_assetclass_data
@negative
Scenario Outline: Download holdings by asset class data using invalid AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | HoldingsByAssetClass                                                      |
		| AG1634 | householdaccountservice_URL,accounts/,1111,/holdingsbyassetclass/download |

@accounts
@download_account_holding_assetclass_data
@negative
Scenario Outline: Download holdings by asset class data using blank AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | HoldingsByAssetClass                                                  |
		| AG1634 | householdaccountservice_URL,accounts/,,/holdingsbyassetclass/download |

@accounts
@download_account_holding_assetclass_data
@negative
Scenario Outline: Download holdings by asset class data without authorization
	Given User is not authorised on eWM
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "401"
	Then Response should return as "unauthorized" request

	Examples:
		| Agent  | HoldingsByAssetClass                                                        |
		| AG1634 | householdaccountservice_URL,accounts/,AC5996,/holdingsbyassetclass/download |

@accounts
@download_account_holding_assetclass_data
@negative
Scenario Outline: Download holdings by asset class data if user don't have proper authorization
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "403"
	Then Response should return as "forbidden" request

	Examples:
		| Agent  | HoldingsByAssetClass                                                        |
		| AG1634 | householdaccountservice_URL,accounts/,AH23Z5,/holdingsbyassetclass/download |

@accounts
@download_account_holding_assetclass_data
@negative
Scenario Outline: Download holdings by asset class data using special charachter in AccountID
	Given User is Authorised on eWM as an AgentId "<Agent>"
	When User do a get call of "<HoldingsByAssetClass>" API
	Then Status Code is "404"
	Then Response should be returned as empty

	Examples:
		| Agent  | HoldingsByAssetClass                                                         |
		| AG1634 | householdaccountservice_URL,accounts/, AH23Z*,/holdingsbyassetclass/download |
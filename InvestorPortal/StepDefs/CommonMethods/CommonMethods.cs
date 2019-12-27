using APIAutomationTestingFW.Base;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using TechTalk.SpecFlow;
using RestSharp;
using static GFG;

namespace InvestorPortal.StepDefs.CommonMethods
{
    [Binding]
    public class CommonMethods : BaseClass

    {
        [Given(@"User is Authorised on eWM as an AgentId ""(.*)""")]
        public void GivenUserIsAuthorisedOnEWMAsAnAgentId(String agentID)
        {
            DoLogin("Username", "Password", "GUID1");
        }

        public void DoLogin(String username, String password, String guid)
        {
            if (restClient().CookieContainer.Count == 0 || (int)restApi().GetResponseData.StatusCode == 401)
            {
                Console.WriteLine("Inside if loop");
                restApi().ExecuteGetCall("eWMLogin/account/login/");
                restApi().CreatePostRequest("authenticate");
                restApi().CommonLoginParameters(username, password);
                CommomLoginHeaders();
                restApi().ExecuteRequest();

                restApi().LoginHelperCookie();
                SwitchUserHeaders();
                restApi().CreatePostRequest("eWMLogin/account/Impersonate?SSOGuid=" + restApi().GetDataFromConfig(guid));
                restApi().ExecuteRequest();
            }


        }

        [Then(@"Status Code is ""(.*)""")]
        public void GivenStatusCodeIs(int statuscode)
        {
            int APIStatusCode = (int)restApi().GetResponseData.StatusCode;
            Console.WriteLine("APIStatusCode is " + APIStatusCode);
            Assert.AreEqual(statuscode, APIStatusCode);
        }

        [Then(@"Response is Not Empty")]
        public void ResponseIsNotEmpty()
        {
            restApi().VerifyResponseIsNotNull();
            
        }

        [Then(@"response should have ""(.*)"" fields")]
        public void ValueIsPresent(string values)
        {
            restApi().VerifyValueIsPresent(values);
        }

        [Then(@"response should not have ""(.*)"" fields")]
        public void ValueIsNotPresent(string values)
        {
            restApi().VerifyValueIsNotPresent(values);
        }


        [Then(@"response contains ""(.*)""")]
        public void ThenResponseContains(string value)
        {
            restApi().VerifyValueIsPresent(value);
        }

        [Then(@"Response should be returned as empty")]
        public void ThenResponseShouldBeReturnedAsEmpty()
        {
            restApi().VerifyExactResponse("");
        }

        [Then(@"Response should return as ""(.*)"" request")]
        public void ThenResponseShouldReturnAsRequest(string status)
        {
            restApi().VerifyStatusCode(status);
        }

        [Given(@"User is not authorised on eWM")]
        public void GivenUserIsNotAuthorisedOnEWM()
        {
            restApi().ExecuteGetCall("eWMLogin/account/login/");
        }

        [Then(@"User verify downloaded file type is ""(.*)""")]
        public void ThenDownloadFileTypeIs(string fileType)
        {
            string type = restApi().GetResponseData.ContentType;
            if (fileType.ToUpper() == "EXCEL")
            {
                Assert.IsTrue(type.Contains("ms-excel"), "Download File type NOT found as EXCEL.");
                Console.WriteLine("Download File type is found as EXCEL.");
            }
            else if (fileType.ToUpper() == "CSV")
            {
                Assert.IsTrue(type.Contains("csv"), "Download File type NOT found as CSV.");
                Console.WriteLine("Download File type is found as CSV.");
            }
            else if (fileType.ToUpper() == "TEXT")
            {
                Assert.IsTrue(type.Contains("text"), "Download File type NOT found as TEXT.");
                Console.WriteLine("Download File type is found as TEXT.");
            }
            else if (fileType.ToUpper() == "XML")
            {
                Assert.IsTrue(type.Contains("xml"), "Download File type NOT found as XML.");
                Console.WriteLine("Download File type is found as XML.");
            }
            else if (fileType.ToUpper() == "JSON")
            {
                Assert.IsTrue(type.Contains("json"), "Download File type NOT found as Json.");
                Console.WriteLine("Download File type is found as Json.");
            }
        }

        public void SwitchUserHeaders()
        {
            restApi().AddHeader("Referer", "https://" + restApi().GetDataFromConfig("baseUrl") + "/DNeWM/User/LoginHelper.aspx?parent%3dAGARSL%26level%3d81003%26click%3d1%26table%3d2%26perparent%3dADA094%2cBROYAL%26perlevel%3d81002%26preclick%3d1%2c1%26search%3dAGARSL");
            restApi().AddHeader("Sec-Fetch-Mode", "navigate");
            restApi().AddHeader("Sec-Fetch-Site", "same-origin");
            restApi().AddHeader("Sec-Fetch-User", "?1");
            restApi().AddHeader("Connection", "keep-alive");
            restApi().AddHeader("Upgrade-Insecure-Requests", "1");
        }

        public void CommomLoginHeaders()
        {
            restApi().AddHeader("Connection", "keep-alive");
            restApi().AddHeader("Upgrade-Insecure-Requests", "1");
            restApi().AddHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3");
            restApi().AddHeader("Content-Type", "application/x-www-form-urlencoded");
        }

        [When(@"User do a get call of ""(.*)"" API")]
        public void GivenUserDoAGetCallOfAPI(string values)
        {
            restApi().CreateGetRequest(restApi().GetACombinedString(values.Split(',').ToList()));
            restApi().ExecuteRequest();
            Console.WriteLine("First 1000 characters of response is " + (restApi().GetResponseData.Content.Length <= 1000 ? restApi().GetResponseData.Content : restApi().GetResponseData.Content.Substring(0, 1000)));
        }

        [When(@"User do a get call of ""(.*)"" API with request url as ""(.*)""")]
        public void WhenUserDoAGetCallOfAPIWithRequestUrlAs(string p0, string values)
        {
            restApi().CreateGetRequest(restApi().GetACombinedString(values.Split(',').ToList()));
            restApi().ExecuteRequest();
            Console.WriteLine("First 1000 characters of response is " + (restApi().GetResponseData.Content.Length <= 1000 ? restApi().GetResponseData.Content : restApi().GetResponseData.Content.Substring(0, 1000)));
        }


        public void SetHeadersForHouseHoldsPerformance()
        {
            restApi().AddHeader("Accept", "*/*");
            restApi().AddHeader("Accept-Encoding", "gzip, deflate, br");
            restApi().AddHeader("Accept-Language", "en-US,en;q=0.9");
            restApi().AddHeader("ADRUM", "isAjax:true");
            restApi().AddHeader("Connection", "keep-alive");
            restApi().AddHeader("Content-Type", "application/json; charset=UTF-8");
            restApi().AddHeader("Referer", restApi().GetDataFromConfig("baseUrl") + "investorportal/overview");
            restApi().AddHeader("Sec-Fetch-Mode", "navigate");
            restApi().AddHeader("Sec-Fetch-Site", "none");
            restApi().AddHeader("Sec-Fetch-User", "1");
            restApi().AddHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36");
            restApi().AddHeader("X-Application", "IPA");
            restApi().AddHeader("Upgrade-Insecure-Requests", "1");
            restApi().AddHeader("Host", "test12.ewealthmanager.com");
        }

        [Then(@"response should match ""(.*)"" as ""(.*)""")]
        public void MatchJSONFieldValueInResponse(string fieldname, string fieldvalue)
        {
            fieldname = fieldname.Substring(9);
            restApi().VerifyJSONFieldValueInResponse(fieldname, fieldvalue);
        }

        [When(@"User do a post call of ""(.*)"" API")]
        public void GivenUserDoAPostCallOfAPI(string values)
        {
            restApi().CreatePostRequest(restApi().GetACombinedString(values.Split(',').ToList()));
            restApi().ExecuteRequest();
            Console.WriteLine("First 1000 characters of response is " + (restApi().GetResponseData.Content.Length <= 1000 ? restApi().GetResponseData.Content : restApi().GetResponseData.Content.Substring(0, 1000)));
        }

        [Then(@"User verify ""(.*)"" data returned within dates ""(.*)"" to ""(.*)"" for ""(.*)"" field")]
        public void json(string frequency, string StartDate, string EndDate, string JSONElement)
        {
            if (frequency.ToUpper() == "DAILY")
            {
                jsonDaily(StartDate, EndDate, JSONElement);
            }
            else if (frequency.ToUpper() == "MONTHLY")
            {
                jsonmonth(StartDate, EndDate, JSONElement);
            }
            else if (frequency.ToUpper() == "WEEKLY")
            {
                String NextDate = null;
                String FirstDateRaw = null;
                DayOfWeek day = 0;
                var json = JToken.Parse(restApi().GetResponseData.Content);
                var fieldsCollector = new JsonFieldsCollector(json);
                var fields = fieldsCollector.GetAllFields();
                IDictionary<string, string> field2 = new Dictionary<string, string>();
                //for (int i = 0; i < fields.Count(); i++)
                //{
                //    if (fields.ElementAt(i).Key.Contains(JSONElement))
                //    {
                //        field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());
                //    }
                //}

                for (int i = 0; i < fields.Count(); i++)
                {
                    if (fields.ElementAt(i).Key.Contains("cumPortfolio.dataPoints"))
                    {
                        if (fields.ElementAt(i).Key.Contains(JSONElement))
                        {
                            field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());

                        }

                    }
                    if (fields.ElementAt(i).Key.Contains(JSONElement) && !(fields.ElementAt(i).Key.ToString().Split('.').ElementAt(1).Contains("dataPoints")))
                    {
                        field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());
                    }

                }

                Console.WriteLine("Total data sets : " + field2.Count());
                for (int i = 0; i <= field2.Count; i++)
                {
                    DateTime StartDateConverted = Convert.ToDateTime(StartDate);
                    FirstDateRaw = field2.ElementAt(i).Value;
                    DateTime FirstDateConvertedone = Convert.ToDateTime(FirstDateRaw);
                    if (i == 0 && StartDateConverted.ToString() == FirstDateRaw)
                    {
                        Console.WriteLine("First date in dataset : " + FirstDateRaw+"\n User given start date : "+StartDate+"\n Both dates are same \n Expected : Next date in dataset should be friday");
                        day = FirstDateConvertedone.DayOfWeek;
                        Console.WriteLine("Day on first date of dataset : " + day);
                        if (day.ToString() != "Friday")
                        {
                            Console.WriteLine("Rolling off to next friday date");
                        }
                        if (day.ToString() == "Monday")
                        {
                            DateTime FridayDate = FirstDateConvertedone.AddDays(4);
                            Console.WriteLine("Rolled off next friday date : " + FridayDate);
                            FirstDateRaw = FridayDate.ToString();
                            NextDate = field2.ElementAt(i + 1).Value;
                            Console.WriteLine("Next date in dataset : " + NextDate);
                            DateTime NextDateActual = Convert.ToDateTime(NextDate);
                            Assert.IsTrue(NextDateActual == FridayDate,"Date on position 1 in dataset is nor friday");
                            Console.WriteLine("Validation Passed");
                        }
                        if (day.ToString() == "Tuesday")
                        {
                            DateTime FridayDate = FirstDateConvertedone.AddDays(3);
                            Console.WriteLine("Rolled off next friday date : " + FridayDate);
                            FirstDateRaw = FridayDate.ToString();
                            NextDate = field2.ElementAt(i + 1).Value;
                            Console.WriteLine("Next date in dataset : " + NextDate);
                            DateTime NextDateActual = Convert.ToDateTime(NextDate);
                            Assert.IsTrue(NextDateActual == FridayDate,"Date on position 1 in dataset is nor friday");
                            Console.WriteLine("Validation Passed");
                        }
                        if (day.ToString() == "Wednesday")
                        {
                            DateTime FridayDate = FirstDateConvertedone.AddDays(2);
                            Console.WriteLine("Rolled off next friday date : " + FridayDate);
                            FirstDateRaw = FridayDate.ToString();
                            NextDate = field2.ElementAt(i + 1).Value;
                            Console.WriteLine("Next date in dataset : " + NextDate);
                            DateTime NextDateActual = Convert.ToDateTime(NextDate);
                            Assert.IsTrue(NextDateActual == FridayDate, "Date on position 1 in dataset is nor friday");
                            Console.WriteLine("Validation Passed");
                        }
                        if (day.ToString() == "Thursday")
                        {
                            DateTime FridayDate = FirstDateConvertedone.AddDays(1);
                            Console.WriteLine("Rolled off next friday date : " + FridayDate);
                            FirstDateRaw = FridayDate.ToString();
                            NextDate = field2.ElementAt(i + 1).Value;
                            Console.WriteLine("Next date in dataset : " + NextDate);
                            DateTime NextDateActual = Convert.ToDateTime(NextDate);
                            Assert.IsTrue(NextDateActual == FridayDate, "Date on position 1 in dataset is nor friday");
                            Console.WriteLine("Validation Passed");
                        }
                        if (day.ToString() == "Friday")
                        {
                            DateTime FridayDate = FirstDateConvertedone.AddDays(0);
                            Console.WriteLine("Rolled off next friday date : " + FridayDate);
                            FirstDateRaw = FridayDate.ToString();
                            NextDate = field2.ElementAt(i + 1).Value;
                            Console.WriteLine("Next date in dataset : " + NextDate);
                            DateTime NextDateActual = Convert.ToDateTime(NextDate);
                            Assert.IsTrue(NextDateActual == FridayDate, "Date on position 1 in dataset is nor friday");
                            Console.WriteLine("Validation Passed");
                        }
                        if (day.ToString() == "Saturday")
                        {
                            DateTime FridayDate = FirstDateConvertedone.AddDays(6);
                            Console.WriteLine("Rolled off next friday date : " + FridayDate);
                            FirstDateRaw = FridayDate.ToString();
                            NextDate = field2.ElementAt(i + 1).Value;
                            Console.WriteLine("Next date in dataset : " + NextDate);
                            DateTime NextDateActual = Convert.ToDateTime(NextDate);
                            Assert.IsTrue(NextDateActual == FridayDate, "Date on position 1 in dataset is nor friday");
                            Console.WriteLine("Validation Passed");
                        }
                        if (day.ToString() == "Sunday")
                        {
                            DateTime FridayDate = FirstDateConvertedone.AddDays(5);
                            Console.WriteLine("Rolled off next friday date : " + FridayDate);
                            FirstDateRaw = FridayDate.ToString();
                            NextDate = field2.ElementAt(i + 1).Value;
                            Console.WriteLine("Next date in dataset : " + NextDate);
                            DateTime NextDateActual = Convert.ToDateTime(NextDate);
                            Assert.IsTrue(NextDateActual == FridayDate, "Date on position 1 in dataset is nor friday");
                            Console.WriteLine("Validation Passed");
                        }
                    }
                    if (i == 0 && StartDateConverted.ToString() != field2.ElementAt(i).Value)
                    {
                        Console.WriteLine("First date in dataset : " + FirstDateRaw + "\n User given start date : " + StartDate + "\n Both dates are NOT same \n Expected : First date in dataset should be friday");
                        day = FirstDateConvertedone.DayOfWeek;
                        Assert.IsTrue(day.ToString() == "Friday","Day on first date of dataset is NOT friday");
                        Console.WriteLine("Day on first date of dataset : " + day);
                        Console.WriteLine("Validation Passed" + "\n");
                        NextDate = field2.ElementAt(i + 1).Value;
                        string FirstDateOnly = FirstDateRaw.Substring(0, FirstDateRaw.IndexOf("12:00:00"));
                        string NextDateOnly = NextDate.Substring(0, NextDate.IndexOf("12:00:00"));
                        DateTime FirstDateConverted = Convert.ToDateTime(FirstDateOnly);
                        DateTime NextDateConverted = Convert.ToDateTime(NextDateOnly);
                        TimeSpan value = NextDateConverted.Subtract(FirstDateConverted);
                        Console.WriteLine("Data set : " + (i) + "& " + (i + 1) + " :\n");
                        Console.WriteLine("First date is : " + FirstDateConverted);
                        Console.WriteLine("Next date is : " + NextDateConverted);
                        Assert.IsTrue((int)value.TotalDays == 7, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                        Console.WriteLine(" Difference between dates : "+ (int)value.TotalDays+"\n Validation Passed" + "\n");
                    }
                    if (i > 0)
                    {
                        FirstDateRaw = field2.ElementAt(i).Value;
                        if (i != field2.Count() - 1)
                        {
                            NextDate = field2.ElementAt(i + 1).Value;
                        }
                        string FirstDateOnly = FirstDateRaw.Substring(0, FirstDateRaw.IndexOf("12:00:00"));
                        string NextDateOnly = NextDate.Substring(0, NextDate.IndexOf("12:00:00"));
                        DateTime FirstDateConverted = Convert.ToDateTime(FirstDateOnly);
                        DateTime NextDateConverted = Convert.ToDateTime(NextDateOnly);
                        TimeSpan value = NextDateConverted.Subtract(FirstDateConverted);
                        if (i != field2.Count() - 1)
                        {
                            Console.WriteLine("Data set : " + (i) + "& " + (i + 1) + " :\n");
                            Console.WriteLine("First date is : " + FirstDateConverted);
                            Console.WriteLine("Next date is : " + NextDateConverted);
                        }
                        else
                        {
                            Console.WriteLine("Last date is : " + FirstDateConverted);
                            break;
                        }
                        if (frequency == "Daily")
                        {
                            Assert.IsTrue((int)value.TotalDays == 1, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation Passed" + "\n");
                        }
                        if (frequency == "Weekly" && (i + 1) != field2.Count() - 1)
                        {
                            Assert.IsTrue((int)value.TotalDays == 7, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation Passed" + "\n");
                        }
                        if (frequency == "Weekly" && (i + 1) == field2.Count() - 1)
                        {
                            Thread.Sleep(1000);
                        }
                        if (frequency == "Monthly")
                        {
                            Assert.IsTrue((int)value.TotalDays == 30, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation Passed" + "\n");
                        }
                        if (frequency == "Yearly")
                        {
                            Assert.IsTrue((int)value.TotalDays == 365, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation Passed" + "\n");
                        }
                        if (frequency == "Quarterly")
                        {
                            Assert.IsTrue((int)value.TotalDays == 90, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation Passed" + "\n");
                        }
                    }
                }
            }
            else if (frequency.ToUpper() == "QUARTERLY")
            {
                jsonQuarter(StartDate, EndDate, JSONElement);
            }
            else if (frequency.ToUpper() == "YEARLY")
            {
                jsonYearly(StartDate, EndDate, JSONElement);
            }
            else
            {
                Console.WriteLine(frequency+" is Not a valid period type.");
            }
        }

        //[Then(@"User validates data for daily frequency for dates ""(.*)"" and ""(.*)"" using ""(.*)"" element of JSON response")]
        public void jsonDaily(string StartDate, string EndDate, string JSONElement)
        {
            String NextDate = null;
            String FirstDateRaw = null;
            var json = JToken.Parse(restApi().GetResponseData.Content);
            var fieldsCollector = new JsonFieldsCollector(json);
            var fields = fieldsCollector.GetAllFields();
            IDictionary<string, string> field2 = new Dictionary<string, string>();

            for (int i = 0; i < fields.Count(); i++)
            {
                if (fields.ElementAt(i).Key.Contains("cumPortfolio.dataPoints"))
                {
                    if (fields.ElementAt(i).Key.Contains(JSONElement))
                    {
                        field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());

                    }
                }
                if (fields.ElementAt(i).Key.Contains(JSONElement) && !(fields.ElementAt(i).Key.ToString().Split('.').ElementAt(1).Contains("dataPoints")))
                {
                    field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());
                }
            }
            Console.WriteLine("Total data sets : " + field2.Count());
            for (int i = 0; i <= field2.Count; i++)
            {
                DateTime StartDateConverted = Convert.ToDateTime(StartDate);
                FirstDateRaw = field2.ElementAt(i).Value;
                DateTime FirstDateConvertedone = Convert.ToDateTime(FirstDateRaw);
                if (i == 0)
                {
                    FirstDateRaw = field2.ElementAt(i).Value;
                    Console.WriteLine("Data set : " + (i) + "& " + (i + 1) + " :\n");
                    Console.WriteLine("First date is : " + FirstDateRaw);
                    NextDate = field2.ElementAt(i + 1).Value;
                    Console.WriteLine("Next date is : " + NextDate);
                    string FirstDateOnly = FirstDateRaw.Substring(0, FirstDateRaw.IndexOf("12:00:00"));
                    string NextDateOnly = NextDate.Substring(0, NextDate.IndexOf("12:00:00"));
                    DateTime FirstDateConverted = Convert.ToDateTime(FirstDateOnly);
                    DateTime NextDateConverted = Convert.ToDateTime(NextDateOnly);
                    TimeSpan value = NextDateConverted.Subtract(FirstDateConverted);
                    Assert.IsTrue((int)value.TotalDays == 1, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                    Console.WriteLine("Difference between dates : "+ (int)value.TotalDays+"\nValidation Passed" + "\n");
                }
                if (i > 0)
                {
                    FirstDateRaw = field2.ElementAt(i).Value;
                    if (i != field2.Count() - 1)
                    {
                        NextDate = field2.ElementAt(i + 1).Value;
                    }
                    string FirstDateOnly = FirstDateRaw.Substring(0, FirstDateRaw.IndexOf("12:00:00"));
                    string NextDateOnly = NextDate.Substring(0, NextDate.IndexOf("12:00:00"));
                    DateTime FirstDateConverted = Convert.ToDateTime(FirstDateOnly);
                    DateTime NextDateConverted = Convert.ToDateTime(NextDateOnly);
                    TimeSpan value = NextDateConverted.Subtract(FirstDateConverted);
                    if (i != field2.Count() - 1)
                    {
                        Console.WriteLine("Data set : " + (i) + "& " + (i + 1) + " :\n");
                        Console.WriteLine("First date is : " + FirstDateConverted);
                        Console.WriteLine("Next date is : " + NextDateConverted);
                    }
                    else
                    {
                        Console.WriteLine("Last date is : " + FirstDateConverted);
                        break;
                    }
                    Assert.IsTrue((int)value.TotalDays == 1, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                    Console.WriteLine("Difference between dates : " + (int)value.TotalDays + "\nValidation Passed" + "\n");

                }
            }
        }

        //[Then(@"User validates data for monthly frequency for dates ""(.*)"" and ""(.*)"" using ""(.*)"" element of JSON response")]
        public void jsonmonth(string StartDate, string EndDate, string JSONElement)
        {
            String NextDate = null;
            String FirstDateRaw = null;
            DateTime FirstDateConverted = DateTime.Now;
            var json = JToken.Parse(restApi().GetResponseData.Content);
            var fieldsCollector = new JsonFieldsCollector(json);
            var fields = fieldsCollector.GetAllFields();
            IDictionary<string, string> field2 = new Dictionary<string, string>();
            //for (int i = 0; i < fields.Count(); i++)
            //{
            //    if (fields.ElementAt(i).Key.Contains(JSONElement))
            //    {
            //        field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());
            //    }
            //}

            for (int i = 0; i < fields.Count(); i++)
            {
                if (fields.ElementAt(i).Key.Contains("cumPortfolio.dataPoints"))
                {
                    if (fields.ElementAt(i).Key.Contains(JSONElement))
                    {
                        field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());

                    }

                }
                if (fields.ElementAt(i).Key.Contains(JSONElement) && !(fields.ElementAt(i).Key.ToString().Split('.').ElementAt(1).Contains("dataPoints")))
                {
                    field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());
                }

            }
            Console.WriteLine("Total data sets : " + field2.Count());
            for (int i = 0; i < field2.Count; i++)
            {
                DateTime StartDateConverted = Convert.ToDateTime(StartDate);
                FirstDateRaw = field2.ElementAt(i).Value;
                DateTime FirstDateConvertedone = Convert.ToDateTime(FirstDateRaw);
                string[] s = FirstDateConvertedone.ToString().Split('/');
                string Month = s[0];
                string Date = s[1];
                string Year = s[2];
                string YearOnly = Year.Substring(0, Year.IndexOf("12:00:00"));
                if (i == 0 && StartDateConverted.ToString() != field2.ElementAt(i).Value)
                {
                    Console.WriteLine("First date in dataset : " + FirstDateRaw);
                    int TotalMonthDays = DateTime.DaysInMonth(Convert.ToInt32(YearOnly), Convert.ToInt32(Month));
                    Assert.IsTrue(Convert.ToInt32(Date) == TotalMonthDays, "User given begin date : " + StartDate + " is different from first date in dataset : " + FirstDateRaw + "\n Expected : First date in dataset should be last date of month \n" + "Actual : First date of dataset is NOT equal to last date of month");
                    Console.WriteLine("User given begin date : "+StartDate+ " is different from first date in dataset : " + FirstDateRaw+ "/ n Expected: First date in dataset should be last date of month \n Actual: First date of dataset : " + FirstDateRaw + " is equal to last date of month \n Validation passed");
                }
                if (i == 0 && StartDateConverted.ToString() == field2.ElementAt(i).Value)
                {
                    Console.WriteLine("First date in dataset : " + FirstDateRaw);
                    NextDate = field2.ElementAt(i + 1).Value;
                    DateTime NextDateConvertedone = Convert.ToDateTime(NextDate);
                    string[] s1 = NextDateConvertedone.ToString().Split('/');
                    string Month1 = s1[0];
                    string Date1 = s1[1];
                    string Year1 = s1[2];
                    string YearOnly1 = Year1.Substring(0, Year1.IndexOf("12:00:00"));
                    int TotalMonthDays = DateTime.DaysInMonth(Convert.ToInt32(YearOnly1), Convert.ToInt32(Month1));
                    Assert.IsTrue(Convert.ToInt32(Date1) == TotalMonthDays, "User given begin date : " + StartDate + " is same as first date in dataset : " + FirstDateRaw + "\n Expected : Next date in dataset should be last date of month \n" +
                        "Actual : Next date of dataset is NOT equal to last date of month");
                    Console.WriteLine("User given begin date : " + StartDate + " is same as first date in dataset : " + FirstDateRaw + "\n Expected : Next date in dataset should be last date of month \n" +
                        "Actual : Next date of dataset : "+ NextDate+ " is equal to last date of month \n Validation passed");
                }
                if (i > 0)
                {
                    FirstDateRaw = field2.ElementAt(i).Value;
                    Date dt1 = new Date(Convert.ToInt32(Date), Convert.ToInt32(Month), Convert.ToInt32(YearOnly));

                    if (i != field2.Count() - 1)
                    {
                        NextDate = field2.ElementAt(i + 1).Value;
                    }
                    DateTime NextDateConvertedone = Convert.ToDateTime(NextDate);
                    string[] s1 = NextDateConvertedone.ToString().Split('/');
                    string Month1 = s1[0];
                    string Date1 = s1[1];
                    string Year1 = s1[2];
                    string YearOnly1 = Year1.Substring(0, Year1.IndexOf("12:00:00"));
                    Date dt2 = new Date(Convert.ToInt32(Date1), Convert.ToInt32(Month1), Convert.ToInt32(YearOnly1));
                    GFG.getDifference(dt1, dt2);
                    string FirstDateOnly = FirstDateRaw.Substring(0, FirstDateRaw.IndexOf("12:00:00"));
                    string NextDateOnly = NextDate.Substring(0, NextDate.IndexOf("12:00:00"));
                    FirstDateConverted = Convert.ToDateTime(FirstDateOnly);
                    DateTime NextDateConverted = Convert.ToDateTime(NextDateOnly);

                    if (i != field2.Count() - 1)
                    {
                        Console.WriteLine("Data set : " + (i) + "& " + (i + 1) + " :\n");
                        Console.WriteLine("First date is : " + FirstDateConverted);
                        Console.WriteLine("Next date is : " + NextDateConverted);
                    }
                    Console.WriteLine("Difference between dates : "+GFG.getDifference(dt1, dt2));
                    if (i != field2.Count() - 1)
                    {
                        Assert.IsTrue(Convert.ToDateTime(field2.ElementAt(i).Value) != Convert.ToDateTime(EndDate), "Found end date at position : " + i + " ,Expected position of given end date : " + (field2.Count() - 1));
                        Assert.IsTrue((Date == "31") || (Date == "30") || (Date == "29") || (Date == "28"));
                        if (Convert.ToDateTime(field2.ElementAt(i + 1).Value) != Convert.ToDateTime(EndDate))
                        {
                            Assert.IsTrue((Date1 == "31") || (Date1 == "30") || (Date1 == "29") || (Date1 == "28"));
                        }
                        if (Date == "30" && Date1 == "31")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 31, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation passed");
                        }
                        if (Date == "31" && Date1 == "30")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 30, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation passed");
                        }
                        if (Date == "31" && Date1 == "31")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 31, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation passed");
                        }
                        if (Date == "31" && Date1 == "29")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 29, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation passed");
                        }
                        if (Date == "29" && Date1 == "31")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 31, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation passed");
                        }
                        if (Date == "31" && Date1 == "28")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 28, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation passed");

                        }
                        if (Date == "28" && Date1 == "31")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 31, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Validation passed");
                        }
                    }
                    if (i == field2.Count() - 1 && NextDateConverted == Convert.ToDateTime(EndDate))
                    {
                        Console.WriteLine("Last date is : " + FirstDateConverted);
                        break;
                    }
                }
            }
        }

        //[Then(@"User validates data for quarterly frequency for dates ""(.*)"" and ""(.*)"" using ""(.*)"" element of JSON response")]
        public void jsonQuarter(string StartDate, string EndDate, string JSONElement)
        {
            String NextDate = null;
            String FirstDateRaw = null;
            DateTime FirstDateConverted = DateTime.Now;
            var json = JToken.Parse(restApi().GetResponseData.Content);
            var fieldsCollector = new JsonFieldsCollector(json);
            var fields = fieldsCollector.GetAllFields();
            IDictionary<string, string> field2 = new Dictionary<string, string>();
            //for (int i = 0; i < fields.Count(); i++)
            //{
            //    if (fields.ElementAt(i).Key.Contains(JSONElement))
            //    {
            //        field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());
            //    }
            //}

            for (int i = 0; i < fields.Count(); i++)
            {
                if (fields.ElementAt(i).Key.Contains("cumPortfolio.dataPoints"))
                {
                    if (fields.ElementAt(i).Key.Contains(JSONElement))
                    {
                        field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());

                    }

                }
                if (fields.ElementAt(i).Key.Contains(JSONElement) && !(fields.ElementAt(i).Key.ToString().Split('.').ElementAt(1).Contains("dataPoints")))
                {
                    field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());
                }

            }

            Console.WriteLine("Total data sets : " + field2.Count());
            for (int i = 0; i < field2.Count; i++)
            {
                DateTime StartDateConverted = Convert.ToDateTime(StartDate);
                FirstDateRaw = field2.ElementAt(i).Value;
                DateTime FirstDateConvertedone = Convert.ToDateTime(FirstDateRaw);
                string[] s = FirstDateConvertedone.ToString().Split('/');
                string Month = s[0];
                string Date = s[1];
                string Year = s[2];
                string YearOnly = Year.Substring(0, Year.IndexOf("12:00:00"));
                if (i == 0&& Convert.ToDateTime(FirstDateRaw) != Convert.ToDateTime(StartDate))
                {

                    
                    Console.WriteLine("First date in dataset : " + FirstDateRaw + "\n User given start date : " + StartDate + "\n Both dates are NOT same \n Expected : First date in dataset should be last date of month");
                    int TotalMonthDays = DateTime.DaysInMonth(Convert.ToInt32(YearOnly), Convert.ToInt32(Month));
                    Assert.IsTrue(Convert.ToInt32(Date) == TotalMonthDays);
                    Console.WriteLine("Validation Passed");
                }
                if (i == 0 && Convert.ToDateTime(FirstDateRaw) == Convert.ToDateTime(StartDate))
                {
                    Console.WriteLine("First date in dataset : " + FirstDateRaw + "\n User given start date : " + StartDate + "\n Both dates are same \n Expected : Next date in dataset should be last date of month");
                    NextDate = field2.ElementAt(i + 1).Value;
                    Console.WriteLine("Next date in dataset : " + NextDate);
                    DateTime NextDateConvertedone = Convert.ToDateTime(NextDate);
                    string[] s1 = NextDateConvertedone.ToString().Split('/');
                    string Month1 = s1[0];
                    string Date1 = s1[1];
                    string Year1 = s1[2];
                    string YearOnly1 = Year1.Substring(0, Year1.IndexOf("12:00:00"));
                    int TotalMonthDays = DateTime.DaysInMonth(Convert.ToInt32(YearOnly1), Convert.ToInt32(Month1));
                    Assert.IsTrue(Convert.ToInt32(Date1) == TotalMonthDays);
                    Console.WriteLine("Validation Passed");
                }
                if (i > 0)
                {
                    FirstDateRaw = field2.ElementAt(i).Value;
                    Date dt1 = new Date(Convert.ToInt32(Date), Convert.ToInt32(Month), Convert.ToInt32(YearOnly));

                    if (i != field2.Count() - 1)
                    {
                        NextDate = field2.ElementAt(i + 1).Value;
                    }
                    DateTime NextDateConvertedone = Convert.ToDateTime(NextDate);
                    string[] s1 = NextDateConvertedone.ToString().Split('/');
                    string Month1 = s1[0];
                    string Date1 = s1[1];
                    string Year1 = s1[2];
                    string YearOnly1 = Year1.Substring(0, Year1.IndexOf("12:00:00"));
                    Date dt2 = new Date(Convert.ToInt32(Date1), Convert.ToInt32(Month1), Convert.ToInt32(YearOnly1));

                    GFG.getDifference(dt1, dt2);
                    string FirstDateOnly = FirstDateRaw.Substring(0, FirstDateRaw.IndexOf("12:00:00"));
                    string NextDateOnly = NextDate.Substring(0, NextDate.IndexOf("12:00:00"));
                    FirstDateConverted = Convert.ToDateTime(FirstDateOnly);
                    DateTime NextDateConverted = Convert.ToDateTime(NextDateOnly);

                    if (i != field2.Count() - 1)
                    {
                        Console.WriteLine("Data set : " + (i) + "& " + (i + 1) + " :\n");
                        Console.WriteLine("First date is : " + FirstDateConverted);
                        Console.WriteLine("Next date is : " + NextDateConverted);
                    }
                    Console.WriteLine("Difference between dates : " + GFG.getDifference(dt1, dt2) + " days");
                    if (i != field2.Count() - 1 && (i + 1) != field2.Count() - 1)
                    {
                        Assert.IsTrue(Convert.ToDateTime(field2.ElementAt(i).Value) != Convert.ToDateTime(EndDate), "Found end date at position : " + i + " ,Expected position of given end date : " + field2.Count());
                        Assert.IsTrue((Date == "31") || (Date == "30") || (Date == "29") || (Date == "28"), "Date at position " + i + " is " + FirstDateConvertedone);
                        Assert.IsTrue((Date == "31") || (Date == "30") || (Date == "29") || (Date == "28"), "Date at position " + i + " is " + NextDateConvertedone);
                        if (Date == "30" && Date1 == "30" && Month != "12")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 92, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Both years are not leap years");
                            Console.WriteLine("Validation passed");
                        }
                        if (Date == "30" && Date1 == "31" && Month != "12")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 92, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Both years are not leap years");
                            Console.WriteLine("Validation passed");

                        }
                        if (Date == "31" && Date1 == "31" && Month != "12")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 91, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Both years are not leap years");
                            Console.WriteLine("Validation passed");

                        }
                        if (Date == "31" && Date1 == "30" && Month != "12")
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 91, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Both years are not leap years");
                            Console.WriteLine("Validation passed");

                        }
                        if (Date == "31" && Date1 == "31" && Month == "12" && !(DateTime.IsLeapYear(Convert.ToInt32(YearOnly1))))
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 90, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Month of starting date is 12 & both years are not leap years");
                            Console.WriteLine("Validation passed");

                        }
                        if (Date == "31" && Date1 == "31" && Month == "12" && (DateTime.IsLeapYear(Convert.ToInt32(YearOnly1))))
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 91, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                            Console.WriteLine("Month of starting date is 12 & " + YearOnly1 + "is leap year");
                            Console.WriteLine("Validation passed");

                        }
                    }
                    if (i == field2.Count() - 1 && NextDateConverted == Convert.ToDateTime(EndDate))
                    {
                        Console.WriteLine("Last date is : " + FirstDateConverted);
                        break;
                    }
                }
            }
        }

        //[Then(@"User validates data for Yearly frequency for dates ""(.*)"" and ""(.*)"" using ""(.*)"" element of JSON response")]
        public void jsonYearly(string StartDate, string EndDate, string JSONElement)
        {
            String NextDate = null;
            String FirstDateRaw = null;
            DateTime FirstDateConverted = DateTime.Now;
            var json = JToken.Parse(restApi().GetResponseData.Content);
            var fieldsCollector = new JsonFieldsCollector(json);
            var fields = fieldsCollector.GetAllFields();
            IDictionary<string, string> field2 = new Dictionary<string, string>();
            //for (int i = 0; i < fields.Count(); i++)
            //{
            //    if (fields.ElementAt(i).Key.Contains(JSONElement))
            //    {
            //        field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());
            //    }
            //}

            for (int i = 0; i < fields.Count(); i++)
            {
                if (fields.ElementAt(i).Key.Contains("cumPortfolio.dataPoints"))
                {
                    if (fields.ElementAt(i).Key.Contains(JSONElement))
                    {
                        field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());

                    }
                }
                if (fields.ElementAt(i).Key.Contains(JSONElement) && !(fields.ElementAt(i).Key.ToString().Split('.').ElementAt(1).Contains("dataPoints")))
                {
                    field2.Add(fields.ElementAt(i).Key, fields.ElementAt(i).Value.ToString());
                }

            }

            Console.WriteLine("Total data sets : " + field2.Count());
            for (int i = 0; i < field2.Count; i++)
            {
                DateTime StartDateConverted = Convert.ToDateTime(StartDate);
                FirstDateRaw = field2.ElementAt(i).Value;
                DateTime FirstDateConvertedone = Convert.ToDateTime(FirstDateRaw);
                string[] s = FirstDateConvertedone.ToString().Split('/');
                string Month = s[0];
                string Date = s[1];
                string Year = s[2];
                string YearOnly = Year.Substring(0, Year.IndexOf("12:00:00"));
                if (i == 0 && Convert.ToDateTime(FirstDateRaw) != Convert.ToDateTime(StartDate))
                {
                    Console.WriteLine("First date in dataset : " + FirstDateRaw + "\n User given start date : " + StartDate + "\n Both dates are NOT same \n Expected : First date in dataset should be last date of month");
                    int TotalMonthDays = DateTime.DaysInMonth(Convert.ToInt32(YearOnly), Convert.ToInt32(Month));
                    Assert.IsTrue(Convert.ToInt32(Date) == TotalMonthDays);
                    Console.WriteLine("Validation Passed");
                }
                if (i == 0 && Convert.ToDateTime(FirstDateRaw) == Convert.ToDateTime(StartDate))
                {
                    Console.WriteLine("First date in dataset : " + FirstDateRaw + "\n User given start date : " + StartDate + "\n Both dates are same \n Expected : Next date in dataset should be last date of month");
                    NextDate = field2.ElementAt(i + 1).Value;
                    Console.WriteLine("Next date in dataset : " + NextDate);
                    DateTime NextDateConvertedone = Convert.ToDateTime(NextDate);
                    string[] s1 = NextDateConvertedone.ToString().Split('/');
                    string Month1 = s1[0];
                    string Date1 = s1[1];
                    string Year1 = s1[2];
                    string YearOnly1 = Year1.Substring(0, Year1.IndexOf("12:00:00"));
                    int TotalMonthDays = DateTime.DaysInMonth(Convert.ToInt32(YearOnly1), Convert.ToInt32(Month1));
                    Assert.IsTrue(Convert.ToInt32(Date1) == TotalMonthDays);
                    Console.WriteLine("Validation Passed");
                }
                if (i > 0)
                {
                    FirstDateRaw = field2.ElementAt(i).Value;
                    Date dt1 = new Date(Convert.ToInt32(Date), Convert.ToInt32(Month), Convert.ToInt32(YearOnly));
                    if (i != field2.Count() - 1)
                    {
                        NextDate = field2.ElementAt(i + 1).Value;
                    }
                    DateTime NextDateConvertedone = Convert.ToDateTime(NextDate);
                    string[] s1 = NextDateConvertedone.ToString().Split('/');
                    string Month1 = s1[0];
                    string Date1 = s1[1];
                    string Year1 = s1[2];
                    string YearOnly1 = Year1.Substring(0, Year1.IndexOf("12:00:00"));
                    Date dt2 = new Date(Convert.ToInt32(Date1), Convert.ToInt32(Month1), Convert.ToInt32(YearOnly1));
                    GFG.getDifference(dt1, dt2);
                    string FirstDateOnly = FirstDateRaw.Substring(0, FirstDateRaw.IndexOf("12:00:00"));
                    string NextDateOnly = NextDate.Substring(0, NextDate.IndexOf("12:00:00"));
                    FirstDateConverted = Convert.ToDateTime(FirstDateOnly);
                    DateTime NextDateConverted = Convert.ToDateTime(NextDateOnly);
                    if (i != field2.Count() - 1)
                    {
                        Console.WriteLine("Data set : " + (i) + "& " + (i + 1) + " :\n");
                        Console.WriteLine("First date is : " + FirstDateConverted);
                        Console.WriteLine("Next date is : " + NextDateConverted);
                    }
                    Console.WriteLine(GFG.getDifference(dt1, dt2));
                    if (i != field2.Count() - 1)
                    {
                        Assert.IsTrue(Convert.ToDateTime(field2.ElementAt(i).Value) != Convert.ToDateTime(EndDate), "Found end date at position : " + i + " ,Expected position of given end date : " + field2.Count());
                        Assert.IsTrue((Date == "31") || (Date == "30") || (Date == "29") || (Date == "28"), "Date at position " + i + " is " + FirstDateConvertedone);
                        Assert.IsTrue((Date == "31") || (Date == "30") || (Date == "29") || (Date == "28"), "Date at position " + i + " is " + NextDateConvertedone);
                        if (Date == "31" && Date1 == "31" && DateTime.IsLeapYear(Convert.ToInt32(YearOnly1)))
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 366, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                        }
                        if (Date == "31" && Date1 == "31" && !(DateTime.IsLeapYear(Convert.ToInt32(YearOnly1))))
                        {
                            Assert.IsTrue(GFG.getDifference(dt1, dt2) == 365, "Validation failed for following combination:" + "\n" + "First date : " + FirstDateConverted + "\n" + "Next date : " + NextDateConverted);
                        }
                    }
                    if (i == field2.Count() - 1 && NextDateConverted == Convert.ToDateTime(EndDate))
                    {
                        Console.WriteLine("Last date is : " + FirstDateConverted);
                        break;
                    }
                }
            }
        }

        [Then(@"response should not contain ""(.*)""")]
        public void ThenResponseShouldNotContain(string fieldvalue)
        {
            restApi().VerifyValueIsNotPresent(fieldvalue);
        }

    }
}
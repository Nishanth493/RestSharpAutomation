using APIAutomationTestingFW.Base;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MongoDB.Bson.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechTalk.SpecFlow;

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
            if (restClient().CookieContainer.Count==0 || (int)restApi().GetResponseData.StatusCode == 401) 
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
            Console.WriteLine("APIStatusCode is "+ APIStatusCode);
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


        [Then(@"download file type is ""(.*)""")]
        public void ThenDownloadFileTypeIs(string fileType)
        {
            string type = restApi().GetResponseData.ContentType;
            if (fileType.ToUpper() == "EXCEL")
            {
                Assert.IsTrue(type.Contains("ms-excel"),"Download File type NOT found as EXCEL.");
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

        
        
    }
}


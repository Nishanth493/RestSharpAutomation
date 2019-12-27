using APIAutomationTestingFW.Base;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using Newtonsoft.Json.Linq;

namespace APIAutomationTestingFW.CommonMethods
{
    public class RestAPI : BaseClass
    {
        public RestRequest restRequest;
        private String url = "";
        public IRestResponse GetResponseData;

        public RestClient SetUrl(String endpoint)
        {
            url = GetDataFromConfig("baseUrl") + endpoint;
            return BaseClass.restClient(url);
        }

        public RestRequest CreateGetRequest(String endpoint)
        {
            url = GetDataFromConfig("baseUrl") + endpoint;
            PrintConsole("URL is ", url);
            restRequest = new RestRequest(url, Method.GET);
            return restRequest;
        }

        public RestRequest CreatePostRequest(String endpoint)
        {
            url = GetDataFromConfig("baseUrl") + endpoint;
            PrintConsole("URL is ", url);
            restRequest = new RestRequest(url, Method.POST);
            return restRequest;
        }
        public RestRequest CreatePutRequest(String endpoint)
        {
            url = GetDataFromConfig("baseUrl") + endpoint;
            PrintConsole("URL is ", url);
            restRequest = new RestRequest(url, Method.PUT);
            return restRequest;
        }


        public IRestResponse ExecuteRequest()
        {
            return GetResponseData = BaseClass.restClient().Execute(restRequest);
        }

        public IRestResponse ExecuteGetCall(String endpoint)
        {
            restRequest = CreateGetRequest(endpoint);
            return ExecuteRequest();
        }

        public IRestResponse ExecutePostCall(String endpoint)
        {
            restRequest = CreatePostRequest(endpoint);
            return ExecuteRequest();
        }

        public String GetDataFromConfig(String textValue)
        {
            string value = ConfigurationManager.AppSettings[textValue];
            PrintConsole("Value from config file: ", value);
            return value;
        }

        public void AddHeader(String name, String value)
        {
            restRequest.AddHeader(name, value);
        }

        public void AddParameter(String name, String value)
        {
            restRequest.AddParameter(name, value);
        }

        public void AddParameter(String name, String value,ParameterType type)
        {
            restRequest.AddParameter(name, value,type);
        }

        public void AddCookie(String name, String value)
        {
            restRequest.AddCookie(name, value);
        }

        public void VerifyStatusCode(String status)
        {
            switch (status.ToLower())
            {
                case "ok":
                    PrintConsole("Actual status is ", GetResponseData.StatusCode.ToString());
                    Assert.IsTrue(GetResponseData.StatusCode.Equals(System.Net.HttpStatusCode.OK));
                    break;
                case "notfound":
                    PrintConsole("Actual status is ", GetResponseData.StatusCode.ToString());
                    Assert.IsTrue(GetResponseData.StatusCode.Equals(System.Net.HttpStatusCode.NotFound));
                    break;
                case "forbidden":
                    PrintConsole("Actual status is ", GetResponseData.StatusCode.ToString());
                    Assert.IsTrue(GetResponseData.StatusCode.Equals(System.Net.HttpStatusCode.Forbidden));
                    break;
                case "unauthorized":
                    PrintConsole("Actual status is ", GetResponseData.StatusCode.ToString());
                    Assert.IsTrue(GetResponseData.StatusCode.Equals(System.Net.HttpStatusCode.Unauthorized));
                    break;
                case "badRequest":
                    PrintConsole("Actual status is ", GetResponseData.StatusCode.ToString());
                    Assert.IsTrue(GetResponseData.StatusCode.Equals(System.Net.HttpStatusCode.BadRequest));
                    break;
                default:
                    throw new Exception("Status " + status + " is not found.");
            }
        }

        public void VerifyResponseIsNotNull()
        {
            Console.WriteLine("First 1000 characters of response is " + (GetResponseData.Content.Length <= 1000 ? GetResponseData.Content : GetResponseData.Content.Substring(0, 1000)));
            Assert.IsNotNull(GetResponseData.Content);
        }

        public void VerifyValueIsPresent(string value)
        {
            string[] fields = value.Split(',');
            for (int i = 0; i < fields.Length; i++)
            {
                fields[i] = fields[i].Trim();
                Assert.IsTrue(GetResponseData.Content.Contains(fields[i]),"Value : "+fields[i]+" not found");
            }
        }

        public void VerifyExactResponse(string Response)
        {
            var jsonObject = JsonConvert.DeserializeObject<dynamic>(GetResponseData.Content);
            Console.WriteLine(GetResponseData.Content);// raw content as string
            Assert.AreEqual(Response, GetResponseData.Content);
        }

        public void VerifyValueIsNotPresent(string value)
        {
            Assert.IsFalse(GetResponseData.Content.Contains(value));
        }

        public void VerifyFieldValueInResponseFirstGroup(string field, int value)
        {
            // var jsonObject = JsonConvert.DeserializeObject<dynamic>(_settings.Response.Content);
            dynamic stuff = Newtonsoft.Json.JsonConvert.DeserializeObject(GetResponseData.Content);
            int ActualValue = (int)stuff[0].field;
            Console.WriteLine("Field " + field + " value is ", ActualValue);
            Console.WriteLine(GetResponseData.Content);
            Assert.AreEqual(value, ActualValue);
        }

        string temp = string.Empty;
        public void VerifyJSONFieldValueInResponse(string fieldname, string fieldvalue)
        {
            try
            {
                int count = 0;
                JToken token = JObject.Parse(restApi().GetResponseData.Content);
                var actual = token.SelectTokens(fieldname);
                foreach (var item in actual)
                {
                    temp = JsonConvert.DeserializeObject(item.ToString(Formatting.None), new JsonSerializerSettings { DateParseHandling = DateParseHandling.None }).ToString();
                    if (temp == fieldvalue)
                    {
                        count++;
                        Assert.AreEqual(fieldvalue, temp);
                    }
                    else
                    {
                        Assert.Fail("Value not matched. Actual Value is " + temp);
                    }
                }
            }
            catch (Exception e) when (e.Message.Contains("Error reading JObject from JsonReader"))
            {
                int count = 0;
                string temp = string.Empty;

                JArray token = JArray.Parse(restApi().GetResponseData.Content);
                var srchItem = token.SelectTokens("$.." + fieldname);
                foreach (var item in srchItem)
                {
                    temp = JsonConvert.DeserializeObject(item.ToString(Formatting.None), new JsonSerializerSettings { DateParseHandling = DateParseHandling.None }).ToString();
                    if (temp == fieldvalue)
                    {
                        count++;
                        Assert.AreEqual(fieldvalue, temp);
                    }
                    else
                    {
                        Assert.Fail("Value not matched. Actual Value is " + temp);
                    }
                }
                if (count == 0)
                {
                    Assert.Fail("Json path not found!");
                }
            }
        }

        public String GetACombinedString(List<String> listofstring)
        {
            String url = null;
            for (int i = 0; i <= listofstring.Count - 1; i++)
            {
                if (listofstring[i].Contains("_URL") || listofstring[i].Contains("_ID"))
                {
                    url = url + restApi().GetDataFromConfig(listofstring[i]);
                }
                else
                    url = url + listofstring[i].ToString();
            }
            return url;
        }

        public void PrintConsole(string statement, string value)
        {
            Console.WriteLine(statement + value);
        }

        public void LoginHelperCookie()
        {
            foreach (var cookie in restApi().GetResponseData.Cookies)
            {
                Console.WriteLine(cookie.Name);
                Console.WriteLine(cookie.Value);
                restApi().AddCookie(cookie.Name, cookie.Value);
            }
            AddCookie("ewm_ns", BaseClass.restClient().CookieContainer.GetCookieHeader(new Uri(GetDataFromConfig("baseUrl").ToString())).Split(';')[0].Substring(7));
            AddCookie("ASP.NET_SessionId", BaseClass.restClient().CookieContainer.GetCookieHeader(new Uri(GetDataFromConfig("baseUrl").ToString())).Split(';')[1].Substring(19));
            AddCookie("GFWMSessionId", BaseClass.restClient().CookieContainer.GetCookieHeader(new Uri(GetDataFromConfig("baseUrl").ToString())).Split(';')[2].Substring(15));
            AddCookie("FSSESSION", BaseClass.restClient().CookieContainer.GetCookieHeader(new Uri(GetDataFromConfig("baseUrl").ToString())).Split(';')[4].Substring(11));
        }

        public void CommonLoginParameters(String Username, String Password)
        {
            AddParameter("Username", GetDataFromConfig(Username));
            AddParameter("Password", GetDataFromConfig(Password));
            AddParameter("Rememberme", "false");
            AddParameter("AltLoginUrl", "https://login.microsoftonline.com/AssetmarkPOCB2CTenant.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_eWealthManager_SignUp_or_SignIn&amp;client_id=4deb1c1e-8195-47ed-a1ff-b096cee99a36&amp;nonce=defaultNonce&amp;redirect_uri=" + GetDataFromConfig("baseurl") + "b2coauth&amp;scope=openid&amp;response_type=id_token&amp;prompt=login");
            AddParameter("IsAccountLocked", "False");
            AddParameter("UserNameMinLength", "3 ");
            AddParameter("PasswordMinLength", "3");
        }

        public String SetHeaders(string HeaderName)
        {
            String returnValue = null;
            switch (HeaderName)
            {
                case "Connection":
                    returnValue = "keep-alive";
                    break;
                case "Upgrade-Insecure-Requests":
                    returnValue = "1";
                    break;
                case "Accept":
                    returnValue = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3";
                    break;
                case "Content-Type":
                    returnValue = "application/x-www-form-urlencoded";
                    break;
                case "Accept-Language":
                    returnValue = "en-US,en;q=0.9";
                    break;
                case "Accept-Encoding":
                    returnValue = "gzip, deflate, br";
                    break;
                case "User-Agent":
                    returnValue = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36";
                    break;
                case "Sec-Fetch-Mode":
                    returnValue = "navigate";
                    break;
                case "Sec-Fetch-Site":
                    returnValue = "same-origin";
                    break;
                case "Sec-Fetch-User":
                    returnValue = "?1";
                    break;
                default:
                    throw new Exception("Header " + HeaderName + " is not found.");
            }
            return returnValue;
        }
    }
}

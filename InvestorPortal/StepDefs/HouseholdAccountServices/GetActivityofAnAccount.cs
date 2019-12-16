using APIAutomationTestingFW.Base;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechTalk.SpecFlow;

namespace InvestorPortal.StepDefs.HouseholdAccountServices
{
    [Binding]

    class GetActivityofAnAccount : BaseClass
    {

        [Then(@"response should match ""(.*)"" is present")]
        public void ThenResponseShouldMatchIsPresent(string fieldname)
        {
            //    string temp = string.Empty;

            //    Newtonsoft.Json.Linq.JToken token = JObject.Parse(restApi().GetResponseData.Content);
            //    var name = token.SelectTokens(fieldname);
            //    //Console.WriteLine(_settings.Response.Content);
            //    Console.WriteLine(name);
            //    Assert.AreEqual(fieldname, name);
            //    //var actual = token.SelectTokens(fieldname);
            //}

        }

        [Then(@"response ""(.*)"" should contain ""(.*)"" as field")]
        public void ThenResponseShouldContainAsField(string response, string field)
        {
            string temp = string.Empty;
            Newtonsoft.Json.Linq.JToken token = JObject.Parse(restApi().GetResponseData.Content);


            var name = token.SelectTokens(response);
            Console.WriteLine(name);
            foreach (var respons in name)
            {
                temp = JsonConvert.DeserializeObject(respons.ToString(Formatting.None), new JsonSerializerSettings { DateParseHandling = DateParseHandling.None }).ToString();
                if (temp == field)
                {
                    Assert.AreEqual(field, temp);
                }
                else
                {
                    Assert.Fail("Value not matched. Actual Value is " + temp);
                }
            }

        }
    }
}

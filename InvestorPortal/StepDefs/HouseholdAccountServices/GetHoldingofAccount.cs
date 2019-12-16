using APIAutomationTestingFW.Base;
using InvestorPortal.JSON;
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
    public class GetHoldingofAccount : BaseClass
    {
        [Then(@"response should contain AccountId as ""(.*)""")]
        public void ThenResponseShouldContainAs(string AccountId)
        {
            
            var jsonObject = JsonConvert.DeserializeObject<dynamic>(restApi().GetResponseData.Content);
            Console.WriteLine(restApi().GetResponseData.Content);

            var tmp = JsonConvert.DeserializeObject<List<GetHoldingsofAccountjson>>(restApi().GetResponseData.Content);

            var IdCount = tmp.Where(x => x.accountId == AccountId).Count();
            if (IdCount == tmp.Count)
            {
                Assert.AreEqual(IdCount, tmp.Count);

            }
            else
            {
                Assert.AreEqual(IdCount, tmp.Count);
            }
        }
        [Then(@"response should contain HoldingId as ""(.*)""")]
        public void ThenResponseShouldContainHoldingIdAs(string HoldingId)
        {
            var jsonObject = JsonConvert.DeserializeObject<dynamic>(restApi().GetResponseData.Content);
            Console.WriteLine(restApi().GetResponseData.Content);

            var tmp = JsonConvert.DeserializeObject<List<GetHoldingsofAccountjson>>(restApi().GetResponseData.Content);

            var IdCount = tmp.Where(x => x.holdingId == HoldingId).Count();
            if (IdCount == tmp.Count)
            {
                Assert.AreEqual(IdCount, tmp.Count);

            }
            else
            {
                Assert.AreEqual(IdCount, tmp.Count);
            }
        }
        [Then(@"response should contain AplId as ""(.*)""")]
        public void ThenResponseShouldContainAplIdAs(string AplId)
        {
            var jsonObject = JsonConvert.DeserializeObject<dynamic>(restApi().GetResponseData.Content);
            Console.WriteLine(restApi().GetResponseData.Content);

            var tmp = JsonConvert.DeserializeObject<List<GetHoldingsofAccountjson>>(restApi().GetResponseData.Content);

            var IdCount = tmp.Where(x => x.aplId == AplId).Count();
            if (IdCount == tmp.Count)
            {
                Assert.AreEqual(IdCount, tmp.Count);

            }
            else
            {
                Assert.AreEqual(IdCount, tmp.Count);
            }
        }

        

    }
}

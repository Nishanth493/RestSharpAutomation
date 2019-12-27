using APIAutomationTestingFW.Base;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechTalk.SpecFlow;

namespace InvestorPortal.StepDefs.PrefrencesServices
{
    [Binding]
    class UpdateUserLevelPreferencessteps : BaseClass
    {
        [When(@"User do a put call of ""(.*)"" API to Update user level preference settings")]
        public void WhenUserDoAPutCallOfAPIToUpdateUserLevelPreferenceSettings(string values)
        {

            var body = "{ \"WEALTHBUILDER_REVIEW_PERFORMANCE_PERIOD\": \"3\",\"WEALTHBUILDER_PREVIEW_PROPOSAL_SHORTFALLVSSURPLUS\": \"true\"}";
            restApi().CreatePutRequest(restApi().GetACombinedString(values.Split(',').ToList()));
            restApi().AddParameter("application/json", body, ParameterType.RequestBody);
            restApi().ExecuteRequest();
            Console.WriteLine("First 1000 characters of response is " + (restApi().GetResponseData.Content.Length <= 1000 ? restApi().GetResponseData.Content : restApi().GetResponseData.Content.Substring(0, 1000)));
        }

        [When(@"User do a put call of ""(.*)"" API to Update user level preference with invalid data")]
        public void WhenUserDoAPutCallOfAPIToUpdateUserLevelPreferenceWithInvalidData(string values)
        {
            var body = "{ \"WEALTHBUILDER_REVIEW_PERFORMANCE_PERIOD\" \"3\"}";
            restApi().CreatePutRequest(restApi().GetACombinedString(values.Split(',').ToList()));
            restApi().AddParameter("application/json", body, ParameterType.RequestBody);
            restApi().ExecuteRequest();
            Console.WriteLine("First 1000 characters of response is " + (restApi().GetResponseData.Content.Length <= 1000 ? restApi().GetResponseData.Content : restApi().GetResponseData.Content.Substring(0, 1000)));
        }
        [When(@"User do a put call of ""(.*)"" API to Update user level preference with blank data")]
        public void WhenUserDoAPutCallOfAPIToUpdateUserLevelPreferenceWithBlankData(string values)
        {
            var body = "{ }";
            restApi().CreatePutRequest(restApi().GetACombinedString(values.Split(',').ToList()));
            restApi().AddParameter("application/json", body, ParameterType.RequestBody);
            restApi().ExecuteRequest();
            Console.WriteLine("First 1000 characters of response is " + (restApi().GetResponseData.Content.Length <= 1000 ? restApi().GetResponseData.Content : restApi().GetResponseData.Content.Substring(0, 1000)));
        }
    }



}



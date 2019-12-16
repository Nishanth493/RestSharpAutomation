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
    class CreateDataSettingsSteps : BaseClass
    {
        [When(@"User do a post call of ""(.*)"" API to create data settings for householdId ""(.*)""")]
        public void WhenUserDoAPostCallOfAPIToCreateDataSettingsForHouseholdId(string values, string householdId)
        {
            var body = "[\""+ householdId+"\"]";            
            restApi().CreatePostRequest(restApi().GetACombinedString(values.Split(',').ToList()));
            restApi().AddParameter("application/json", body, ParameterType.RequestBody);
            restApi().ExecuteRequest();
            Console.WriteLine("First 1000 characters of response is " + (restApi().GetResponseData.Content.Length <= 1000 ? restApi().GetResponseData.Content : restApi().GetResponseData.Content.Substring(0, 1000)));
        }
    }

   }


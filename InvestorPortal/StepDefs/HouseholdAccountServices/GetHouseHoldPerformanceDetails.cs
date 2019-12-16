using APIAutomationTestingFW.Base;
using TechTalk.SpecFlow;

namespace InvestorPortal.StepDefs.HouseholdAccountServices
{
    [Binding]
    public class GetHouseHoldPerformanceDetails : BaseClass
    {
        public static string DownloadDirectory;

        [Then(@"response contains ""(.*)"" as begindate")]
        public void ThenResponseContainsAsBegindate(string value)
        {
            restApi().VerifyValueIsPresent(value);
        }

        [Then(@"response should be match ""(.*)"" as ""(.*)""")]
        public void ThenResponseShouldBeMatchAs(string fieldname, string fieldvalue)
        {
            fieldname = fieldname.Substring(9);
            if (fieldvalue.Contains("_ID"))
            {
                fieldvalue = restApi().GetDataFromConfig(fieldvalue);
            }
            restApi().VerifyJSONFieldValueInResponse(fieldname, fieldvalue);
        }
    }
}

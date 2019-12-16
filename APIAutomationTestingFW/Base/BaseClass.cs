using APIAutomationTestingFW.CommonMethods;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace APIAutomationTestingFW.Base
{
    public class BaseClass
    {
        private static RestAPI RestApiObj =null /*= new RestAPI()*/;
        private static RestClient client = null /*= new RestClient()*/;
        static BaseClass()
        {
            BaseClass.restClient().CookieContainer = new CookieContainer();
        }

        public static RestAPI restApi()
        {
            if (RestApiObj == null)
            {
                RestApiObj = new RestAPI();
            }
            return RestApiObj;
        }

        public static RestClient restClient()
        {
            if (client == null)
            {
                client = new RestClient();
            }
            return client;
        }

        public static RestClient restClient(string baseURL)
        {
            if (client == null)
            {
                client = new RestClient(baseURL);
            }
            return client;
        }

        public static RestClient restClient(Uri baseURL)
        {
            if (client == null)
            {
                client = new RestClient(baseURL);
            }
            return client;
        }
    }
}

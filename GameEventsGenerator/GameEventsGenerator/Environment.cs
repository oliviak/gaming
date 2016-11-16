using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace GameEventsGenerator
{
    internal class Environment
    {
        internal static string EventHubConnectionString = ConfigurationManager.AppSettings["EventHubConnectionString"];
        internal static string EventHubPath = ConfigurationManager.AppSettings["EventHub"];

        public static void SetupEventHubs()
        {
            EventHubHelper.CreateEventHubIfNotExists(EventHubConnectionString, EventHubPath);
        }

        public static void Cleanup()
        {
            EventHubHelper.DeleteAllEventHubs(EventHubConnectionString);
        }

        internal static void Setup()
        {
            SetupEventHubs();
        }
    }
}

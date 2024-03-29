﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Web.Script.Serialization;
using System.IO;
using System.Net;
using System.Text;

namespace AnushreeDairy
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        
        // requires the reference 
        class WaMessageSender
        {
            // TODO: Replace the following with your gateway instance ID, Forever Green client ID and secret:
            private static string INSTANCE_ID = "YOUR_INSTANCE_ID_HERE";
            private static string CLIENT_ID = "YOUR_CLIENT_ID_HERE";
            private static string CLIENT_SECRET = "YOUR_CLIENT_SECRET_HERE";
            private static string API_URL = "INSTANCE_ID";
            static void Main(string[] args)
            {
                WaMessageSender msgSender = new WaMessageSender();
                msgSender.sendMessage("12025550108", "Isn't this excting?");
                // Specify the recipient's number here. NOT the gateway number
                Console.WriteLine("Press Enter to exit.");Console.ReadLine();
            }
            public bool sendMessage(string number, string message)
            {
                bool success = true;
                try
                {
                    using (WebClient client = new WebClient())
                    {
                        client.Headers[HttpRequestHeader.ContentType] = "application/json";
                        client.Headers["X-WM-CLIENT-ID"] = CLIENT_ID;
                        client.Headers["X-WM-CLIENT-SECRET"] = CLIENT_SECRET;
                        Payload payloadObj = new Payload() { number = number, message = message };
                        string postData = (new JavaScriptSerializer()).Serialize(payloadObj);
                        client.Encoding = Encoding.UTF8;
                        string response = client.UploadString(API_URL, postData);
                        Console.WriteLine(response);
                    }
                }
                catch (WebException webEx)
                {
                    Console.WriteLine(((HttpWebResponse)webEx.Response).StatusCode);
                    Stream stream = ((HttpWebResponse)webEx.Response).GetResponseStream();
                    StreamReader reader = new StreamReader(stream);String body = reader.ReadToEnd();
                    Console.WriteLine(body);success = false;
                }
                return success;
            }
            public class Payload{public string number { get; set; }
            public string message { get; set; }
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BEL
{
    public class BEL_Customer
    {
        public int customerID { get; set; }
        public string customerName { get; set; }
        public string customerUserName { get; set; }
        public string customerPassword { get; set; }
        public string customerMobile { get; set; }
        public string customerEmail { get; set; }
        public DateTime dateOfRegister { get; set; }
        public string flatNo { get; set; }
        public string buildingName { get; set; }
        public string street { get; set; }
        public int areaID { get; set; }
        public string Latitude { get; set; }
        public string Longitude { get; set; }
        public int deliveryBoyID { get; set; }
        public bool isActive { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BEL
{
    public class BEL_Area
    {
        public int areaID { get; set; }
        public string area { get; set; }
        public string city { get; set; }
        public string pincode { get; set; }
        public Boolean isActive { get; set; }
    }
}
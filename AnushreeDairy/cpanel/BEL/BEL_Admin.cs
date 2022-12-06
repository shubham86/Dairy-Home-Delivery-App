using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BEL
{
    public class BEL_Admin
    {
        public int adminID { get; set; }
        public string adminName { get; set; }
        public string adminUserName { get; set; }
        public string password { get; set; }
        public string role { get; set; }
        public string adminEmail { get; set; }
        public string adminMobile { get; set; }
    }
}
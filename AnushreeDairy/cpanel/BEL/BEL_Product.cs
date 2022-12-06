using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BEL
{
    public class BEL_Product
    {
        public int productID { get; set; }
        public string productName { get; set; }
        public string productDesc { get; set; }

        public int productRateID { get; set; }
        public decimal productRate { get; set; }
        public DateTime dateOfDeclare { get; set; }
        public Boolean isActive { get; set; }
    }
}
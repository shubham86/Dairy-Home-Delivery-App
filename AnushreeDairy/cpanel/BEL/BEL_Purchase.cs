using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BEL
{
    public class BEL_Purchase
    {
        public int purchaseID {get; set;}
        public int productID {get; set;}
        public decimal quantity {get; set;}
        public decimal oldStock {get; set;}
        public decimal rate { get; set; }
    }
}
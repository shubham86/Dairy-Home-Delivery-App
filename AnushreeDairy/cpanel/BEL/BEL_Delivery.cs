using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BEL
{
    public class BEL_Delivery
    {
       public int deliveryID { get; set; }
       public int customerID { get; set; } 
       public DateTime deliveryDate { get; set; } 
       public string batch { get; set; } 
       public decimal milkQuatity { get; set; } 
       public int productID { get; set; } 
       public int deliveryBoyID { get; set; } 
    }
}
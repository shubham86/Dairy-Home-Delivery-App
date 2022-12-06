using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BEL
{
    public class BEL_PaymentDetails
    {
       public int paymentID{ get; set; }
       public int customerID{ get; set; }
       public DateTime paymentDate{ get; set; }
       public int paymentMonth{ get; set; }
       public int paymentYear{ get; set; }
       public decimal paymentAmount{ get; set; }
       public decimal paidAmount{ get; set; }
       public decimal balanceAmount{ get; set; }
       public string paymentMode{ get; set; }
       public int deliveryBoyID{ get; set; }
    }
}
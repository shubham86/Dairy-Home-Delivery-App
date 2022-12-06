using AnushreeDairy.cpanel.BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BAL
{
    public class BAL_PaymentDetails
    {
        public Boolean addPayment(BEL_PaymentDetails objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_SalerPaymentAdd";

                objDAL.SetParameters("@customerID", "integer", objBEL.customerID, 4);
                objDAL.SetParameters("@paymentDate", "date", objBEL.paymentDate, 10);
                objDAL.SetParameters("@paymentMonth", "integer", objBEL.paymentMonth, 5);
                objDAL.SetParameters("@paymentYear", "integer", objBEL.paymentYear, 10);
                objDAL.SetParameters("@paymentAmount", "decimal", objBEL.paymentAmount, 4);
                objDAL.SetParameters("@paidAmount", "decimal", objBEL.paidAmount, 4);
                objDAL.SetParameters("@balanceAmount", "decimal", objBEL.balanceAmount, 10);
                objDAL.SetParameters("@paymentMode", "varchar", objBEL.paymentMode, 10);
                objDAL.SetParameters("@deliveryBoyID", "integer", objBEL.deliveryBoyID, 10);

                return objDAL.IUDData();
            }
            catch (Exception ex)
            {

            }
            finally
            {
                objDAL.Dispose();
            }
            return _retVal;
        }
    }
}
using AnushreeDairy.cpanel.BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BAL
{
    public class BAL_Delivery
    {
        public Boolean addDelivery(BEL_Delivery objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Saler_DeliveryAdd";

                objDAL.SetParameters("@customerID", "integer", objBEL.customerID, 4);
                objDAL.SetParameters("@deliveryDate", "date", objBEL.deliveryDate, 10);
                objDAL.SetParameters("@batch", "varchar", objBEL.batch, 5);
                objDAL.SetParameters("@milkQuatity", "decimal", objBEL.milkQuatity, 10);
                objDAL.SetParameters("@productID", "integer", objBEL.productID, 4);
                objDAL.SetParameters("@deliveryBoyID", "varchar", objBEL.deliveryBoyID, 4);

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
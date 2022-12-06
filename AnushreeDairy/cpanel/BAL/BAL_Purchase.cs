using AnushreeDairy.cpanel.BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BAL
{
    public class BAL_Purchase
    {
        //add purchase entry
        public Boolean addPurchase(BEL_Purchase objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Purchase_Add";

                objDAL.SetParameters("@productID", "integer", objBEL.productID, 4);
                objDAL.SetParameters("@quantity", "decimal", objBEL.quantity, 13);
                objDAL.SetParameters("@oldStock", "decimal", objBEL.oldStock, 13);
                objDAL.SetParameters("@rate", "decimal", objBEL.rate, 13);

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

        //update purchase entry
        public Boolean updatePurchase(BEL_Purchase objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Purchase_Update";

                objDAL.SetParameters("@purchaseID", "integer", objBEL.productID, 4);
                objDAL.SetParameters("@productID", "integer", objBEL.productID, 4);
                objDAL.SetParameters("@quantity", "decimal", objBEL.quantity, 13);
                objDAL.SetParameters("@rate", "decimal", objBEL.rate, 13);

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
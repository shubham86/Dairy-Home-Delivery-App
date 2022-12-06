using AnushreeDairy.cpanel.BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BAL
{
    public class BAL_Product
    {
        //Add product
        public bool addProduct(BEL_Product objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();
            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Product_Add";

                objDAL.SetParameters("@productName", "varchar", objBEL.productName, 100);
                objDAL.SetParameters("@productDesc", "varchar", objBEL.productDesc, 500);

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

        //Update product Details
        public Boolean updateProduct(BEL_Product objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Product_Update";

                objDAL.SetParameters("@productID", "integer", objBEL.productID, 4);
                objDAL.SetParameters("@productName", "varchar", objBEL.productName, 100);
                objDAL.SetParameters("@productDesc", "varchar", objBEL.productDesc, 500);
                objDAL.SetParameters("@isActive", "bit", objBEL.isActive, 1);

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

        //Add product Price
        public bool addProductPrice(BEL_Product objBEL)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            Boolean _retVal = false;
            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_ProductRate_Add";

                objDAL.SetParameters("@rate", "decimal", objBEL.productRate, 10);
                objDAL.SetParameters("@dateOfDeclare", "date", objBEL.dateOfDeclare, 10);
                objDAL.SetParameters("@productID", "integer", objBEL.productID, 10);

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

        //Update product Price
        public Boolean updateProductPrice(BEL_Product objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_ProductRate_Update";

                objDAL.SetParameters("@rate", "decimal", objBEL.productRate, 10);
                objDAL.SetParameters("@dateOfDeclare", "date", objBEL.dateOfDeclare, 10);
                objDAL.SetParameters("@isActive", "bit", objBEL.isActive, 1);

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
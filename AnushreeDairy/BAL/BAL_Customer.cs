using AnushreeDairy.cpanel.BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace AnushreeDairy.BAL
{
    public class BAL_Customer
    {
        //Add Customer
        public bool addCustomer(BEL_Customer objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Customer_Add";

                objDAL.SetParameters("@customerName", "varchar", objBEL.customerName, 120);
                objDAL.SetParameters("@customerUserName", "varchar", objBEL.customerUserName, 120);
                objDAL.SetParameters("@customerPassword", "varchar", objBEL.customerPassword, 50);
                objDAL.SetParameters("@customerMobile", "varchar", objBEL.customerMobile, 10);
                objDAL.SetParameters("@customerEmail", "varchar", objBEL.customerEmail, 150);
                objDAL.SetParameters("@dateOfRegister", "datetime", objBEL.dateOfRegister, 50);
                objDAL.SetParameters("@flatNo", "varchar", objBEL.flatNo, 10);
                objDAL.SetParameters("@buildingName", "varchar", objBEL.buildingName, 50);
                objDAL.SetParameters("@street", "varchar", objBEL.street, 150);
                objDAL.SetParameters("@areaID", "integer", objBEL.areaID, 4);
                objDAL.SetParameters("@Latitude", "varchar", objBEL.Latitude, 150);
                objDAL.SetParameters("@Longitude", "varchar", objBEL.Longitude, 150);

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

        //Update Area Details
        public Boolean updateCustomer(BEL_Customer objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Customer_Update";

                objDAL.SetParameters("@customerID", "integer", objBEL.customerID, 4);
                objDAL.SetParameters("@customerName", "varchar", objBEL.customerName, 120);
                objDAL.SetParameters("@customerUserName", "varchar", objBEL.customerUserName, 120);
                objDAL.SetParameters("@customerPassword", "varchar", objBEL.customerPassword, 50);
                objDAL.SetParameters("@customerMobile", "varchar", objBEL.customerMobile, 10);
                objDAL.SetParameters("@customerEmail", "varchar", objBEL.customerEmail, 150);
                objDAL.SetParameters("@dateOfRegister", "datetime", objBEL.dateOfRegister, 50);
                objDAL.SetParameters("@flatNo", "varchar", objBEL.flatNo, 10);
                objDAL.SetParameters("@buildingName", "varchar", objBEL.buildingName, 50);
                objDAL.SetParameters("@street", "varchar", objBEL.street, 150);
                objDAL.SetParameters("@areaID", "integer", objBEL.areaID, 4);
                objDAL.SetParameters("@Latitude", "varchar", objBEL.Latitude, 150);
                objDAL.SetParameters("@Longitude", "varchar", objBEL.Longitude, 150);

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
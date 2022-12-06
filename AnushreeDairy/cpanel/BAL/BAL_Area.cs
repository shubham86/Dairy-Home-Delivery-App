using AnushreeDairy.cpanel.BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BAL
{
    public class BAL_Area
    {
        //Add Area
        public bool addArea(BEL_Area objBEL)
        {
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Area_Add";
                                
                objDAL.SetParameters("@area", "varchar", objBEL.area, 100);
                objDAL.SetParameters("@city", "varchar", objBEL.city, 50);
                objDAL.SetParameters("@pincode", "varchar", objBEL.pincode, 6);
                objDAL.SetParameters("@isActive", "bit", objBEL.isActive, 1);

                return objDAL.IUDData();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                objDAL.Dispose();
            }
        }

        //Update Area Details
        public Boolean updateArea(BEL_Area objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Area_Update";

                objDAL.SetParameters("@areaID", "integer", objBEL.areaID, 4);
                objDAL.SetParameters("@area", "varchar", objBEL.area, 100);
                objDAL.SetParameters("@city", "varchar", objBEL.city, 50);
                objDAL.SetParameters("@pincode", "varchar", objBEL.pincode, 10);
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
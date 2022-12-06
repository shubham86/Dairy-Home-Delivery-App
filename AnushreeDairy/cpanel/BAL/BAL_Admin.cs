using AnushreeDairy.cpanel.BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

namespace AnushreeDairy.cpanel.BAL
{
    public class BAL_Admin
    {
        //add Admin
        public Boolean addAdmin(BEL_Admin objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Admin_AddAdmin";

                objDAL.SetParameters("@adminName", "varchar", objBEL.adminName, 100);
                objDAL.SetParameters("@adminUserName", "varchar", objBEL.adminUserName, 100);
                objDAL.SetParameters("@password", "varchar", objBEL.password, 20);
                objDAL.SetParameters("@role", "varchar", objBEL.role, 10);
                objDAL.SetParameters("@email", "varchar", objBEL.adminEmail, 150);
                objDAL.SetParameters("@mobile", "varchar", objBEL.adminMobile, 15);

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

        //update Admin
        public Boolean updateAdmin(BEL_Admin objBEL)
        {
            Boolean _retVal = false;
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Admin_Update";

                objDAL.SetParameters("@adminID", "integer", objBEL.adminID, 4);
                objDAL.SetParameters("@adminName", "varchar", objBEL.adminName, 100);
                objDAL.SetParameters("@adminUserName", "varchar", objBEL.adminUserName, 100);
                objDAL.SetParameters("@password", "varchar", objBEL.password, 20);
                objDAL.SetParameters("@role", "varchar", objBEL.role, 10);
                objDAL.SetParameters("@email", "varchar", objBEL.adminEmail, 150);
                objDAL.SetParameters("@mobile", "varchar", objBEL.adminMobile, 15);

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

        //Add Validation
        public Boolean addValidation(BEL_Admin objBEL)
        {
            DataTable dt = new DataTable();
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Admin_AddValidation";

                objDAL.SetParameters("@userName", "varchar", objBEL.adminUserName, 50);
                dt = objDAL.FetchDatainDT();
                if (dt.Rows.Count > 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
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

        //Allow Login
        public DataTable VerifyAdmin(BEL_Admin objBEL)
        {
            DataTable dt = new DataTable();
            WIHO.DHO objDAL = new WIHO.DHO();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Admin_Verify";

                objDAL.SetParameters("@userName", "varchar", objBEL.adminUserName, 50);
                objDAL.SetParameters("@password", "varchar", objBEL.password, 20);
                dt = objDAL.FetchDatainDT();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                objDAL.Dispose();
            }
            return dt;

        }
    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnushreeDairy
{
    public partial class ManageDeliveryBoy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("LoginPage.aspx", false);
                return;
            }
            if (!Page.IsPostBack)
            {
                if (Request.Cookies["AdminRole"].Value != "admin")
                {
                    Response.Redirect("Logout.aspx");
                }

                if (Request.QueryString["action"] == "insert")
                {
                   MessageBox("Record Inserted successfully !!!");
                }
                else if (Request.QueryString["action"] == "update")
                {
                    MessageBox("Record Updated successfully !!!");
                }
                else if (Request.QueryString["action"] == "delete")
                {
                    MessageBox("Record Delete successfully !!!");
                }
                fillrepeater();
            }
        }

        public void fillrepeater()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Admin_FetchInRepeater";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    rpterDBoy.DataSource = DT;
                    rpterDBoy.DataBind();
                }
                else
                {
                    rpterDBoy.DataSource = null;
                    rpterDBoy.DataBind();
                }
            }
            catch (Exception ex)
            {
               MessageBox("ERROR !!! Please try after some time");
            }
        }

        protected void rptrDBoy_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                Response.Redirect("AddDeliveryBoy.aspx?ID=" + e.CommandArgument);
                return;
            }

            if (e.CommandName == "delete")
            {
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
                string adminID = commandArgs[0];
                string role = commandArgs[1];

                if (role == "admin")
                {
                    WIHO.DHO objDAL = new WIHO.DHO();
                    DataTable DT = new DataTable();

                    try
                    {

                        objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                        objDAL.QueryType = "procedure";
                        objDAL.QueryName = "proc_AnushreeDairy_Admin_FetchCountOfMasterAdmin";

                        DT = objDAL.FetchDatainDT();
                        if (DT.Rows.Count > 0)
                        {
                            if (DT.Rows.Count > 1)
                            {
                                deleteAdmin(Convert.ToInt32(adminID));
                            }
                            else
                            {
                                MessageBox("You can not delete last master Admin");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox("ERROR !!! Please try after some time");
                    }
                }
                else
                {
                    deleteAdmin(Convert.ToInt32(adminID));
                }                
            }
        }

        private void deleteAdmin(int ID)
        {
            WIHO.BHO objBAL = new WIHO.BHO();

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
            objBAL.QueryType = "procedure";
            try
            {
                objBAL.QueryName = "proc_AnushreeDairy_Admin_delete";
                if (objBAL.DeleteRecord("@adminID", ID))
                {
                    Response.Redirect("ManageDeliveryBoy.aspx?action=delete", false);
                    return;
                }
                else
                {
                    MessageBox("Unable to Delete Record...Please try again !!!");
                    return;
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
                return;
            }
        }

        protected void imgbtnadd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("AddDeliveryBoy.aspx", false);
            return;
        }

        public string getrole(Boolean Master)
        {
            if (Master)
            {
                return "Master Admin";
            }
            else
            {
                return "Admin";
            }
        }

        public void fetchAdminDetails()
        {

            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Admin_FetchInForm";

                objDAL.SetParameters("@adminID", "integer", Convert.ToInt32(Request.Cookies["AdminID"].Value), 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    if (DT.Rows[0]["role"].ToString() != "admin")
                    {
                        Response.Redirect("Logout.aspx", false);
                    }
                }
                else
                {
                    Response.Redirect("Logout.aspx", false);
                }
            }
            catch (Exception ex)
            {
               MessageBox("ERROR !!! Please try after some time");
            }
        }

        #region "Message Box"
        private void MessageBox(String msg)
        {
            Label lbl = new Label();
            msg = msg.Replace("'", "");
            msg = msg.Replace(".", "");
            lbl.Text = "<script language='javascript'>" + Environment.NewLine + "window.alert('" + msg + "')</script>";
            ScriptManager.RegisterClientScriptBlock(this, typeof(string), lbl.Text, lbl.Text, false);
        }
        #endregion
    }
}
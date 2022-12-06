using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnushreeDairy.cpanel
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.Cookies["AdminID"] != null)
                {
                    fetchAdminDetails();
                    AdminName.Text = Request.Cookies["AdminName"].Value.ToString();
                }
                else
                {
                    Response.Redirect("LoginPage.aspx");
                    return;
                }
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
                        admin1.Visible = false;
                        admin2.Visible = false;
                        admin3.Visible = false;
                        admin4.Visible = false;
                        admin5.Visible = false;
                        admin6.Visible = false;
                        admin7.Visible = false;
                        saler1.Visible = true;
                        saler2.Visible = true;
                    }
                    else
                    {
                        admin1.Visible = true;
                        admin2.Visible = true;
                        admin3.Visible = true;
                        admin4.Visible = true;
                        admin5.Visible = true;
                        admin6.Visible = true;
                        admin7.Visible = true;
                        saler1.Visible = false;
                        saler2.Visible = false;
                    }
                }
                else
                {
                    Response.Redirect("Logout.aspx", false);

                    //MessageBox("No record Found ...");
                    //return;
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        protected void Home_Onclick(object sender, EventArgs e)
        {
            if (Request.Cookies["AdminRole"] != null)
            { 
                if (Request.Cookies["AdminRole"].Value.ToString() == "admin")
                {
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    Response.Redirect("Dashboard2.aspx");
                }
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
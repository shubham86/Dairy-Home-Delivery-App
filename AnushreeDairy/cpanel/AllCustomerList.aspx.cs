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
    public partial class AllCustomerList : System.Web.UI.Page
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

                fetchActiveCustomer();
            }
        }

        public void fetchActiveCustomer()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Customer_FetchActiveCustomerInRepeater";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    rptrCustomer.DataSource = DT;
                    rptrCustomer.DataBind();
                }
                else
                {
                    rptrCustomer.DataSource = null;
                    rptrCustomer.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        public void fetchAllCustomer()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Customer_FetchAllCustomerInRepeater";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    rptrCustomer.DataSource = DT;
                    rptrCustomer.DataBind();
                }
                else
                {
                    rptrCustomer.DataSource = null;
                    rptrCustomer.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        public string getImageURL(string ID)
        {
            if (Convert.ToBoolean(ID))
            {
                return "images/tickIcon.png";
            }
            else
            {
                return "images/crossIcon.png";
            }
        }

        public string getAlternateText(string ID)
        {
            if (Convert.ToBoolean(ID))
            {
                return "Active";
            }
            else
            {
                return "InActive";
            }
        }

        protected void ddl_SelectedIndexChange(object sender, System.EventArgs e)
        {
            if (ddlAll.SelectedItem.Value == "2")
            {
                fetchAllCustomer();
            }
            else
            {
                fetchActiveCustomer();
            }
        }

        protected void rptrCustomer_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                Response.Redirect("CustomerDetails.aspx?ID=" + e.CommandArgument, false);
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
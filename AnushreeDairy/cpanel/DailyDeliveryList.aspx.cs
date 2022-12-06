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
    public partial class DailyDeliveryList : System.Web.UI.Page
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
                fillrepeater();
            }
        }

        private void fillrepeater()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Saler_FetchDailyDeliveryListInRepeater";

                objDAL.SetParameters("@deliveryBoyID", "integer", Convert.ToInt32(Request.Cookies["AdminID"].Value), 4);

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
                string x = ex.Message;
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        public string getDeliveryStatus(string ID)
        {
            if (ID != "")
            {
                return "images/tickIcon_green.png";
            }
            else
            {
                return "images/crossIcon_red.png";
            }
        }

        public string getAlternateText(string ID)
        {
            if (ID != "")
            {
                return "Deliverd";
            }
            else
            {
                return "Pending";
            }
        }

        protected void rptrCustomer_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string customerID = commandArgs[0];
            string deliveryID = commandArgs[1];


            if (e.CommandName == "view")
            {
                if (deliveryID == "")
                {
                    Response.Redirect("AddDeliveryEntry.aspx?ID=" + customerID, false);
                    return;
                }
                else
                {
                    return;
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
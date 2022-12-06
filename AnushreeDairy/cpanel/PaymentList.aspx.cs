using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnushreeDairy.cpanel
{
    public partial class PaymentList : System.Web.UI.Page
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
                fillYearDDL();
                ddlMonth.Items.FindByValue(((Convert.ToInt32(DateTime.Now.ToString("MM")) - 1) == 0 ? 12 : (Convert.ToInt32(DateTime.Now.ToString("MM")) - 1)).ToString("00")).Selected = true;
                if ((Convert.ToInt32(DateTime.Now.ToString("MM")) - 1) == 0)
                {
                    ddlYear.Items.FindByText((Convert.ToInt32(DateTime.Now.Year)-1).ToString()).Selected = true;
                }
                else
                {
                    ddlYear.Items.FindByText(DateTime.Now.Year.ToString()).Selected = true;
                }               

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
                objDAL.QueryName = "proc_AnushreeDairy_Saler_FetchPaymentListInRepeater";

                objDAL.SetParameters("@deliveryBoyID", "integer", Convert.ToInt32(Request.Cookies["AdminID"].Value), 4);
                objDAL.SetParameters("@month", "integer", Convert.ToInt32(ddlMonth.SelectedItem.Value), 4);
                objDAL.SetParameters("@year", "integer", Convert.ToInt32(ddlYear.SelectedItem.Value), 4);

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

        private void fillYearDDL()
        {
            var years = Enumerable.Range(DateTime.Now.Year - 2, 3).OrderByDescending(x => x);

            ddlYear.Items.Clear();
            ddlYear.Items.Add("--Year--");

            foreach (var year in years)
            {
                ddlYear.Items.Add(year.ToString());
            }
        }

        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            fillrepeater();
        }
        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            fillrepeater();
        }

        public string getPaymentStatus(string ID)
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
                return "Paid";
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
            string paymentID = commandArgs[1];

            if (e.CommandName == "view")
            {
                if (paymentID == "")
                {
                    Response.Redirect("GetPaymentRechord.aspx?ID=" + customerID + "&M=" + ddlMonth.SelectedItem.Value + "&Y=" + ddlYear.SelectedItem.Value, false);
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
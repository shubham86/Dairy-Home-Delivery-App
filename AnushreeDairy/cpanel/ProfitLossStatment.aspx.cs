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
    public partial class ProfitLossStatment : System.Web.UI.Page
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
                fillYearDDL();
                ddlMonth.Items.FindByValue((Convert.ToInt32(DateTime.Now.ToString("MM")) - 1).ToString() == "0" ? "12" : (string.Format("{0:00}",Convert.ToInt32(DateTime.Now.ToString("MM")) - 1))).Selected = true;
                ddlYear.Items.FindByText((Convert.ToInt32(DateTime.Now.ToString("MM")) - 1).ToString() == "0" ? (Convert.ToInt32(DateTime.Now.Year) - 1).ToString() : DateTime.Now.Year.ToString()).Selected = true;
                fetchReport();
            }
        }

        private void fillYearDDL()
        {
            var years = Enumerable.Range(DateTime.Now.Year - 2, 3).OrderByDescending(x => x);

            ddlYear.Items.Clear();

            foreach (var year in years)
            {
                ddlYear.Items.Add(year.ToString());
            }
        }

        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            fetchReport();
        }
        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            fetchReport();
        }

        public void fetchReport()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Report_FetchDetails";

                objDAL.SetParameters("@month", "integer", Convert.ToInt32(ddlMonth.SelectedItem.Value), 4);
                objDAL.SetParameters("@year", "integer", Convert.ToInt32(ddlYear.SelectedItem.Value), 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    lblSoldQty.Text = string.Format("{0:0.00}", DT.Rows[0]["totalSoldQty"].ToString() == "" ? "0.00" : DT.Rows[0]["totalSoldQty"]);
                    lblSoldAmount.Text = string.Format("{0:0.00}", DT.Rows[0]["totalSoldAmt"].ToString() == "" ? "0.00" : DT.Rows[0]["totalSoldAmt"]);
                    lblPurchasedQty.Text = string.Format("{0:0.00}", DT.Rows[0]["totalPurchasedQty"].ToString() == "" ? "0.00" : DT.Rows[0]["totalPurchasedQty"]);
                    lblPurchasedAmt.Text = string.Format("{0:0.00}", DT.Rows[0]["totalPurchasedAmt"].ToString() == "" ? "0.00" : DT.Rows[0]["totalPurchasedAmt"]);
                    lblProfit.Text = (Convert.ToDecimal(lblSoldAmount.Text) - Convert.ToDecimal(lblPurchasedAmt.Text)).ToString();
                }
                else
                {
                    MessageBox("No rechord found...");
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
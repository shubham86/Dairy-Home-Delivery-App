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
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            if(!Page.IsPostBack)
            {
                if (Request.Cookies["AdminRole"].Value != "admin")
                {
                    Response.Redirect("Logout.aspx");
                }
                fetchDesktopDetails();
            }
        }

        public void fetchDesktopDetails()
        {

            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Dashoboard_FetchDetails";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    lblRevenue.Text = DT.Rows[0]["totalRevenue"].ToString() == "" ? "0.00" : string.Format("{0:0.00}",DT.Rows[0]["totalRevenue"]);
                    lblSale.Text = DT.Rows[0]["totalSale"].ToString() == "" ? "0.00" : string.Format("{0:0.00}", DT.Rows[0]["totalSale"]);
                    lblDeliveryBoy.Text = DT.Rows[0]["totalDeliveryBoy"].ToString();
                    lblCustomer.Text = DT.Rows[0]["totalCustomer"].ToString();
                    lblCollection.Text = DT.Rows[0]["totalCollection"].ToString() == "" ? "0.00" : string.Format("{0:0.00}", DT.Rows[0]["totalCollection"]);
                    if (lblRevenue.Text != "0.00")
                    {
                        lblCollectionPercentage.Text = string.Format("{0:0}", ((Convert.ToDecimal(lblCollection.Text) / Convert.ToDecimal(lblRevenue.Text)) * 100));
                    }
                    else
                    {
                        lblCollectionPercentage.Text = "0";
                    }
                    
                    lblBalance.Text = (Convert.ToDecimal(lblRevenue.Text)- Convert.ToDecimal(lblCollection.Text)).ToString();
                    if (lblRevenue.Text != "0.00")
                    {
                        lblBalancePercentage.Text = string.Format("{0:0}", ((Convert.ToDecimal(lblBalance.Text) / Convert.ToDecimal(lblRevenue.Text)) * 100));
                    }
                    else
                    {
                        lblBalancePercentage.Text = "0";
                    }                    

                    progressBar1.Attributes.Add("style", "width:"+ lblCollectionPercentage.Text + "%; height: 8px;background-color:#7460ee");
                    progressBar2.Attributes.Add("style", "width:" + lblBalancePercentage.Text + "%; height: 8px;background-color:#ef5350");
                }
                else
                {
                    MessageBox("No data is found ...");
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
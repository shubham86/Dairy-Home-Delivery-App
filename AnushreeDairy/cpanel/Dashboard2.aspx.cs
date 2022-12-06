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
    public partial class Dashboard2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            if (!Page.IsPostBack)
            {
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
                objDAL.QueryName = "proc_AnushreeDairy_Dashoboard2_FetchDetails";

                objDAL.SetParameters("@deliveryBoyID", "varchar", Convert.ToInt32(Request.Cookies["AdminID"].Value), 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    lblDeliverd.Text = DT.Rows[0]["deliverdCustomer"].ToString()=="" ? "0" : DT.Rows[0]["deliverdCustomer"].ToString();
                    lblPending.Text = (Convert.ToInt32(DT.Rows[0]["allCustomer"]) - Convert.ToInt32(DT.Rows[0]["deliverdCustomer"])).ToString();

                    lblCollection.Text = DT.Rows[0]["totalCollection"].ToString() == "" ? "0.00" : string.Format("{0:0.00}", DT.Rows[0]["totalCollection"]);
                    if (string.Format("{0:0.00}",DT.Rows[0]["totalRevenue"]) != "0.00")
                    {
                        lblCollectionPercentage.Text = string.Format("{0:0}", ((Convert.ToDecimal(lblCollection.Text) / Convert.ToDecimal(DT.Rows[0]["totalRevenue"])) * 100));
                    }
                    else
                    {
                        lblCollectionPercentage.Text = "0";
                    }

                    lblBalance.Text = string.Format("{0:0.00}", (Convert.ToDecimal(DT.Rows[0]["totalRevenue"]) - Convert.ToDecimal(lblCollection.Text)));
                    if (string.Format("{0:0.00}", DT.Rows[0]["totalRevenue"]) != "0.00")
                    {
                        lblBalancePercentage.Text = string.Format("{0:0}", ((Convert.ToDecimal(lblBalance.Text) / Convert.ToDecimal(DT.Rows[0]["totalRevenue"])) * 100));
                    }
                    else
                    {
                        lblBalancePercentage.Text = "0";
                    }

                    progressBar1.Attributes.Add("style", "width:" + lblCollectionPercentage.Text + "%; height: 8px;background-color:#213c02");
                    progressBar2.Attributes.Add("style", "width:" + lblBalancePercentage.Text + "%; height: 8px;background-color:#660000");
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
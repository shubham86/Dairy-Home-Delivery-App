using AnushreeDairy.cpanel.BAL;
using AnushreeDairy.cpanel.BEL;
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
    public partial class GetPaymentRechord : System.Web.UI.Page
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
                    ddlYear.Items.FindByText((Convert.ToInt32(DateTime.Now.Year) - 1).ToString()).Selected = true;
                }
                else
                {
                    ddlYear.Items.FindByText(DateTime.Now.Year.ToString()).Selected = true;
                }

                fillDDL();
                if (Request.QueryString["ID"] != null)
                {
                    ddlID.ClearSelection();
                    ddlID.Items.FindByValue(Request.QueryString["ID"].ToString()).Selected = true;
                    ddlName.ClearSelection();
                    ddlName.Items.FindByValue(Request.QueryString["ID"].ToString()).Selected = true;
                    ddlMonth.ClearSelection();
                    ddlMonth.Items.FindByValue(Request.QueryString["M"].ToString()).Selected = true;
                    ddlYear.ClearSelection();
                    ddlYear.Items.FindByValue(Request.QueryString["Y"].ToString()).Selected = true;
                }
            }
        }

        private void fillDDL()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            ListItem lstItem = new ListItem();
            ListItem lstItemID = new ListItem();

            lstItem = new ListItem();
            lstItem.Text = "--- Select Customer Name ---";
            lstItem.Value = "0";
            ddlName.Items.Add(lstItem);

            lstItemID = new ListItem();
            lstItemID.Text = "--- Select Customer ID ---";
            lstItemID.Value = "0";
            ddlID.Items.Add(lstItemID);
            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Saler_FetchPaymentListInRepeater";

                objDAL.SetParameters("@deliveryBoyID", "integer", Convert.ToInt32(Request.Cookies["AdminID"].Value), 4);
                objDAL.SetParameters("@month", "integer", Convert.ToInt32(ddlMonth.SelectedItem.Value), 4);
                objDAL.SetParameters("@year", "integer", Convert.ToInt32(ddlYear.SelectedItem.Value), 4);

                DT = objDAL.FetchDatainDT();

                if (DT != null)
                {
                    if (DT.Rows.Count > 0)
                    {
                        for (int i = 0; i < DT.Rows.Count; i++)
                        {
                            lstItem = new ListItem();
                            lstItem.Text = DT.Rows[i]["customerName"].ToString();
                            lstItem.Value = DT.Rows[i]["customerID"].ToString();
                            if (DT.Rows[i]["paymentID"].ToString() != "")
                            {
                                lstItem.Attributes.Add("style", "background-color:#dddddd");
                            }
                            ddlName.Items.Add(lstItem);

                            lstItemID = new ListItem();
                            lstItemID.Text = DT.Rows[i]["customerID"].ToString();
                            lstItemID.Value = DT.Rows[i]["customerID"].ToString();
                            if (DT.Rows[i]["paymentID"].ToString() != "")
                            {
                                lstItemID.Attributes.Add("style", "background-color:#dddddd");
                            }
                            ddlID.Items.Add(lstItemID);
                        }
                    }
                }
                else
                {
                    MessageBox("No Record Found ...");
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

        protected void ddlID_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlName.ClearSelection();
            ddlName.Items.FindByValue(ddlID.SelectedItem.Value).Selected = true;
        }
        protected void ddlName_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlID.ClearSelection();
            ddlID.Items.FindByValue(ddlName.SelectedItem.Value).Selected = true;
        }


        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            Response.Redirect("AddPaymentEntry.aspx?ID=" + ddlID.SelectedItem.Value + "&M=" + ddlMonth.SelectedItem.Value + "&Y=" +ddlYear.SelectedItem.Value, false);
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
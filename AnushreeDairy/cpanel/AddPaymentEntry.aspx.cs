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
    public partial class AddPaymentEntry : System.Web.UI.Page
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
                if (Request.QueryString["ID"] != null)
                {
                    fillrepeater(Convert.ToInt32(Request.QueryString["ID"]), Convert.ToInt32(Request.QueryString["M"]), Convert.ToInt32(Request.QueryString["Y"]));
                }
                //else if (Request.QueryString["customerID"] != null)
                //{
                //    fillrepeater(Convert.ToInt32(Request.QueryString["customerID"]), Convert.ToInt32(DateTime.Now.ToString("MM")), Convert.ToInt32(DateTime.Now.ToString("yyyy")));
                //}
            }
        }

        private void fillrepeater(int ID, int M, int Y)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataSet DS = new DataSet();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Saler_FetchMonthlyDetailsInRepeater";

                objDAL.SetParameters("@customerID", "integer", ID, 4);
                objDAL.SetParameters("@month", "integer", M, 4);
                objDAL.SetParameters("@year", "integer", Y, 4);

                DS = objDAL.FetchDatainDS();
                if (DS.Tables[0].Rows.Count > 0)
                {
                    rptrCustomer.DataSource = DS.Tables[0];
                    rptrCustomer.DataBind();

                    //Finding the FooterTemplate and access its controls
                    Control FooterTemplate = rptrCustomer.Controls[rptrCustomer.Controls.Count - 1].Controls[0];
                    Label lblTQuantity = FooterTemplate.FindControl("lblTotalQuantity") as Label;
                    Label lblTAmount = FooterTemplate.FindControl("lblTotalAmount") as Label;
                    lblTQuantity.Text = DS.Tables[1].Rows[0]["tQuantity"].ToString();
                    lblTAmount.Text = DS.Tables[1].Rows[0]["tAmount"].ToString();
                }
                else
                {
                    rptrCustomer.DataSource = null;
                    rptrCustomer.DataBind();
                }
                if (DS.Tables[1].Rows.Count > 0)
                {                   
                    lblBalancePayment.Text = DS.Tables[1].Rows[0]["balanceAmount"].ToString() == "Null" ? "0.00" : DS.Tables[1].Rows[0]["balanceAmount"].ToString();
                    lblCurrentPayment.Text = DS.Tables[1].Rows[0]["tAmount"].ToString() == "Null" ? "0.00" : DS.Tables[1].Rows[0]["tAmount"].ToString();
                    lblTotalPayment.Text = string.Format("{0:0.00}", (Convert.ToDecimal(lblBalancePayment.Text) + Convert.ToDecimal(lblCurrentPayment.Text)));
                    lblCustomerName.Text = DS.Tables[1].Rows[0]["customerName"].ToString();
                    lblMonthYear.Text = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(M) + " " + Y.ToString();
                }
            }
            catch (Exception ex)
            {
                string x = ex.Message;
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            BEL_PaymentDetails objBEL = new BEL_PaymentDetails();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_PaymentDetails objBALL = new BAL_PaymentDetails();

            try
            {
                objBEL.customerID = Convert.ToInt32(Request.QueryString["ID"]);
                objBEL.paymentDate = Convert.ToDateTime(DateTime.Now.ToString("MM/dd/yyyy"));
                objBEL.paymentMonth = Convert.ToInt32(Request.QueryString["M"]);
                objBEL.paymentYear = Convert.ToInt32(Request.QueryString["Y"]);
                objBEL.paymentAmount = Convert.ToDecimal(lblTotalPayment.Text);
                objBEL.paidAmount = Convert.ToDecimal(txtRecivedPayment.Value);
                objBEL.balanceAmount = Convert.ToDecimal(lblTotalPayment.Text) - Convert.ToDecimal(txtRecivedPayment.Value);
                objBEL.paymentMode = "cash";
                objBEL.deliveryBoyID = Convert.ToInt32(Request.Cookies["AdminID"].Value);

                if (objBALL.addPayment(objBEL))
                {
                    //MessageBox("Delivery record insert successfully.");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect", "alert('Payment record insert successfully.'); window.location='" + Request.ApplicationPath + "cpanel/GetPaymentRechord.aspx';", true);
                }
                else
                {
                    //pnlAlert.Attributes.Add("class", "alert alert-danger");
                    //pnlAlert.Visible = true;
                    //lblalert.Text = "ERROR !!! Please try again.";
                    MessageBox("ERROR !!! Please try again.");
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
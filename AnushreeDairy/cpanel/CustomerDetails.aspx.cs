using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnushreeDairy.cpanel
{
    public partial class CustomerDetails : System.Web.UI.Page
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

                if (Request.QueryString["ID"] != null)
                {
                    fillrepeater(Convert.ToInt32(Request.QueryString["ID"]), Convert.ToInt32(ddlMonth.SelectedItem.Value), Convert.ToInt32(ddlYear.SelectedItem.Value));
                }
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
            fillrepeater(Convert.ToInt32(Request.QueryString["ID"]), Convert.ToInt32(ddlMonth.SelectedItem.Value), Convert.ToInt32(ddlYear.SelectedItem.Value));
        }
        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            fillrepeater(Convert.ToInt32(Request.QueryString["ID"]), Convert.ToInt32(ddlMonth.SelectedItem.Value), Convert.ToInt32(ddlYear.SelectedItem.Value));
        }

        private void fillrepeater(int ID, int M, int Y)
        
{
            WIHO.DHO objDAL = new WIHO.DHO();
            DataSet DS = new DataSet();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Customer_FetchCustomerDetails";

                objDAL.SetParameters("@customerID", "integer", ID, 4);
                objDAL.SetParameters("@month", "integer", M, 4);
                objDAL.SetParameters("@year", "integer", Y, 4);

                DS = objDAL.FetchDatainDS();

                lblMonthYear.Text = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt32(ddlMonth.SelectedItem.Value)) + " " + ddlYear.SelectedItem.Value;

                if (DS.Tables[0].Rows.Count > 0)
                {
                    rptrCustomer.DataSource = DS.Tables[0];
                    rptrCustomer.DataBind();                    
                    //Finding the FooterTemplate and access its controls
                    Control FooterTemplate = rptrCustomer.Controls[rptrCustomer.Controls.Count - 1].Controls[0];
                    Label lblTQuantity = FooterTemplate.FindControl("lblTotalQuantity") as Label;
                    Label lblTAmount = FooterTemplate.FindControl("lblTotalAmount") as Label; 
                    Label lblAveRate = FooterTemplate.FindControl("lblAvrageRart") as Label;
                    Label lblBalance = FooterTemplate.FindControl("lblBalanceAmount") as Label;
                    lblTQuantity.Text = DS.Tables[1].Rows[0]["tQuantity"].ToString() == "Null" ? "0.00" : DS.Tables[1].Rows[0]["tQuantity"].ToString();
                    lblTAmount.Text = DS.Tables[1].Rows[0]["tAmount"].ToString() == "Null" ? "0.00" : DS.Tables[1].Rows[0]["tAmount"].ToString();
                    lblAveRate.Text = String.Format("{0:0.00}", (Convert.ToDecimal(lblTAmount.Text) / Convert.ToDecimal(lblTQuantity.Text)));
                    lblBalance.Text = DS.Tables[1].Rows[0]["balanceAmount"].ToString() == "Null" ? "0.00" : DS.Tables[1].Rows[0]["balanceAmount"].ToString();
                }
                else
                {
                    rptrCustomer.DataSource = null;
                    rptrCustomer.DataBind();
                }

                if (DS.Tables[2].Rows.Count > 0)
                {
                    lblID.Text = ID.ToString();
                    lblUserName.Text = DS.Tables[2].Rows[0]["customerUserName"].ToString();
                    lblCustomerName.Text = DS.Tables[2].Rows[0]["customerName"].ToString();
                    lblMobile.Text = DS.Tables[2].Rows[0]["customerMobile"].ToString();
                    lblEmail.Text = DS.Tables[2].Rows[0]["customerEmail"].ToString();
                    lblRDate.Text = String.Format("{0:dd-MM-yyyy}", DS.Tables[2].Rows[0]["dateOfRegister"]);
                    lblStatus.Text = DS.Tables[2].Rows[0]["isActive"].ToString() == "True" ? "Active" : "InActive";
                    lblAddress.Text = DS.Tables[2].Rows[0]["flatNo"].ToString() + ", " + DS.Tables[2].Rows[0]["buildingName"].ToString() + ", " + DS.Tables[2].Rows[0]["street"].ToString() + ", " + DS.Tables[2].Rows[0]["area"].ToString() + ", " + DS.Tables[2].Rows[0]["city"].ToString() + ", " + DS.Tables[2].Rows[0]["pincode"].ToString();
                }
            }
            catch (Exception ex)
            {
                string x = ex.Message;
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        private Boolean fillPDFrepeater(int ID, int M, int Y)
        {
            Boolean _retVal = true;
            WIHO.DHO objDAL = new WIHO.DHO();
            DataSet DS = new DataSet();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Customer_FetchCustomerDetails";

                objDAL.SetParameters("@customerID", "integer", ID, 4);
                objDAL.SetParameters("@month", "integer",M, 4);
                objDAL.SetParameters("@year", "integer", Y, 4);

                DS = objDAL.FetchDatainDS();
                if (DS.Tables[0].Rows.Count > 0)
                {
                    rptrPDF.DataSource = DS.Tables[0];
                    rptrPDF.DataBind();

                    //Finding the FooterTemplate and access its controls
                    Control FooterTemplate = rptrPDF.Controls[rptrCustomer.Controls.Count - 1].Controls[0];
                    Label lblTQuantity = FooterTemplate.FindControl("lblTotalQuantity") as Label;
                    Label lblTAmount = FooterTemplate.FindControl("lblTotalAmount") as Label;
                    Label lblAveRate = FooterTemplate.FindControl("lblAvrageRart") as Label;
                    Label lblBalance = FooterTemplate.FindControl("lblBalanceAmount") as Label;
                    lblTQuantity.Text = DS.Tables[1].Rows[0]["tQuantity"].ToString() == "Null" ? "0.00" : DS.Tables[1].Rows[0]["tQuantity"].ToString();
                    lblTAmount.Text = DS.Tables[1].Rows[0]["tAmount"].ToString() == "Null" ? "0.00" : DS.Tables[1].Rows[0]["tAmount"].ToString();
                    lblAveRate.Text = String.Format("{0:0.00}", (Convert.ToDecimal(lblTAmount.Text) / Convert.ToDecimal(lblTQuantity.Text)));
                    lblBalance.Text = DS.Tables[1].Rows[0]["balanceAmount"].ToString() == "Null" ? "0.00" : DS.Tables[1].Rows[0]["balanceAmount"].ToString();
                }
                else
                {
                    rptrCustomer.DataSource = null;
                    rptrCustomer.DataBind();
                    return false;
                }

                if (DS.Tables[2].Rows.Count > 0)
                {
                    Control HeaderTemplate = rptrPDF.Controls[0].Controls[0];
                    Label id = HeaderTemplate.FindControl("lblID1") as Label;
                    Label userName = HeaderTemplate.FindControl("lblUserName1") as Label;
                    Label customerName = HeaderTemplate.FindControl("lblCustomerName1") as Label;
                    Label mobile = HeaderTemplate.FindControl("lblMobile1") as Label;
                    Label email = HeaderTemplate.FindControl("lblEmail1") as Label;
                    Label RDate = HeaderTemplate.FindControl("lblRdate1") as Label;
                    Label status = HeaderTemplate.FindControl("lblStatus1") as Label;
                    Label address = HeaderTemplate.FindControl("lblAddress1") as Label;
                    Label monthYear = HeaderTemplate.FindControl("lblMonthYear1") as Label;

                    monthYear.Text = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt32(ddlMonth.SelectedItem.Value)) + " " + ddlYear.SelectedItem.Value;
                    customerName.Text = DS.Tables[2].Rows[0]["customerName"].ToString();
                    id.Text = ID.ToString();
                    userName.Text = DS.Tables[2].Rows[0]["customerUserName"].ToString();
                    mobile.Text = DS.Tables[2].Rows[0]["customerMobile"].ToString();
                    email.Text = DS.Tables[2].Rows[0]["customerEmail"].ToString();
                    RDate.Text = String.Format("{0:dd-MM-yyyy}", DS.Tables[2].Rows[0]["dateOfRegister"]);
                    status.Text = DS.Tables[2].Rows[0]["isActive"].ToString() == "True" ? "Active" : "InActive";
                    address.Text = DS.Tables[2].Rows[0]["flatNo"].ToString() + ", " + DS.Tables[2].Rows[0]["buildingName"].ToString() + ", " + DS.Tables[2].Rows[0]["street"].ToString() + ", " + DS.Tables[2].Rows[0]["area"].ToString() + ", " + DS.Tables[2].Rows[0]["city"].ToString() + ", " + DS.Tables[2].Rows[0]["pincode"].ToString();
                }
            }
            catch (Exception ex)
            {
                string x = ex.Message;
                MessageBox("ERROR !!! Please try after some time");
                return false;
            }
            return _retVal;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            pnlPDF.Visible = true;
            if (fillPDFrepeater(Convert.ToInt32(Request.QueryString["ID"]), Convert.ToInt32(ddlMonth.SelectedItem.Value), Convert.ToInt32(ddlYear.SelectedItem.Value)))
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=" + lblCustomerName.Text + "_" + Convert.ToInt32(ddlMonth.SelectedItem.Value) + "-" + DateTime.Now.ToString("yyyy") + ".pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                StringWriter sw = new StringWriter();
                HtmlTextWriter hw = new HtmlTextWriter(sw);
                pnlPDF.RenderControl(hw);
                StringReader sr = new StringReader(sw.ToString());
                Document pdfDoc = new Document(PageSize.A4, 30f, 30f, 35f, 35f);
                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                pdfDoc.Open();
                htmlparser.Parse(sr);
                pdfDoc.Close();
                Response.Write(pdfDoc);
                Response.End();
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
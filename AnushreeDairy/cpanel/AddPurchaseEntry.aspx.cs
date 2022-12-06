using AnushreeDairy.cpanel.BAL;
using AnushreeDairy.cpanel.BEL;
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
    public partial class AddPurchaseEntry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
         {
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("LoginPage.aspx");
            }

            if (!Page.IsPostBack)
            {
                if (Request.Cookies["AdminRole"].Value != "admin")
                {
                    Response.Redirect("Logout.aspx");
                }

                fillddl();
                if (Request.QueryString["ID"] != null)
                {
                    fetchPurchase();
                }
            }
        }

        //fill ddl
        private void fillddl()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            ListItem lstItem = new ListItem();
            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Product_FetchActiveProductInRepeater";

                DT = objDAL.FetchDatainDT();

                lstItem = new ListItem();
                lstItem.Text = "--- Select Product ---";
                lstItem.Value = "0";
                ddlProduct.Items.Add(lstItem);

                if (DT != null)
                {
                    if (DT.Rows.Count > 0)
                    {
                        for (int i = 0; i < DT.Rows.Count; i++)
                        {
                            lstItem = new ListItem();
                            lstItem.Text = DT.Rows[i]["productName"].ToString();
                            lstItem.Value = DT.Rows[i]["productID"].ToString();
                            ddlProduct.Items.Add(lstItem);
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
                MessageBox("ERROR !!! Please try after some time");
            }
            finally
            {
                objDAL.Dispose();
            }
        }

        protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Purchase_FetchOldStock";

                objDAL.SetParameters("@productID", "integer", Convert.ToInt32(ddlProduct.SelectedItem.Value), 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    decimal yesterdaysPurchaseQty = Convert.ToDecimal(DT.Rows[0]["yesterdaysPurchaseQty"].ToString() == "" ? "0" : DT.Rows[0]["yesterdaysPurchaseQty"]);
                    decimal yesterdaysOldStock = Convert.ToDecimal(DT.Rows[0]["yesterdaysOldStock"].ToString() == "" ? "0" : DT.Rows[0]["yesterdaysOldStock"]);
                    decimal yesterdaysSale = Convert.ToDecimal(DT.Rows[0]["yesterdaysSale"].ToString() == "" ? "0" : DT.Rows[0]["yesterdaysSale"]);

                    txtOldStock.Value = string.Format("{0:0.00}", ((yesterdaysPurchaseQty + yesterdaysOldStock) - yesterdaysSale));
                }
                else
                {
                    MessageBox("No Record Found ...");
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
            finally
            {
                objDAL.Dispose();
            }
        }

        //fetch price details in form
        private void fetchPurchase()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Purchase_FetchInForm";

                objDAL.SetParameters("@purchaseID", "integer", Convert.ToInt32(Request.QueryString["ID"]), 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    ddlProduct.Items.FindByValue(DT.Rows[0]["productID"].ToString()).Selected = true;
                    txtOldStock.Value = DT.Rows[0]["oldStock"].ToString();
                    txtQuantity.Value = DT.Rows[0]["quantity"].ToString();
                    txtRate.Value = DT.Rows[0]["rate"].ToString();
                }
                else
                {
                    MessageBox("No Record Found ...");
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
            finally
            {
                objDAL.Dispose();
            }
        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            if (Request.QueryString["ID"] != null)
            {
                if (updatePurchase(Convert.ToInt32(Request.QueryString["ID"])))
                {
                    Response.Redirect("ManagePurchase.aspx?action=update");
                    return;
                }
                else
                {
                    MessageBox("Record could not be Updated... Please try again !!!");
                    return;
                }
            }
            else
            {
                if (insertPurchase())
                {
                    ClearForm();
                    Response.Redirect("ManagePurchase.aspx?action=insert");
                    return;
                }
                else
                {
                    Response.Redirect("Record could not be Added... Please try again !!!");
                    return;
                }
            }
        }

        private bool insertPurchase()
        {
            bool functionReturnValue = false;

            BEL_Purchase objBEL = new BEL_Purchase();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Purchase objBALL = new BAL_Purchase();

            try
            {
                objBEL.productID = Convert.ToInt32(ddlProduct.SelectedItem.Value);
                objBEL.quantity = Convert.ToDecimal(txtQuantity.Value);
                objBEL.oldStock = Convert.ToDecimal(txtOldStock.Value);            
                objBEL.rate = Convert.ToDecimal(txtRate.Value);

                if (objBALL.addPurchase(objBEL))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
            return functionReturnValue;
        }

        private bool updatePurchase(int PurchaseID)
        {
            bool functionReturnValue = false;

            BEL_Purchase objBEL = new BEL_Purchase();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Purchase objBALL = new BAL_Purchase();

            try
            {
                objBEL.purchaseID = PurchaseID;
                objBEL.productID = Convert.ToInt32(ddlProduct.SelectedItem.Value);
                objBEL.quantity = Convert.ToDecimal(txtQuantity.Value);
                objBEL.rate = Convert.ToDecimal(txtRate.Value);

                if (objBALL.updatePurchase(objBEL))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
            return functionReturnValue;
        }

        protected void btnCancel_Click(object sender, System.EventArgs e)
        {
            ClearForm();
            Response.Redirect("ManagePurchase.aspx");
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
                        Response.Redirect("Logout.aspx", false);
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

        private void ClearForm()
        {
            txtQuantity.Value = "";
            txtOldStock.Value = "";
            ddlProduct.SelectedItem.Value = "0";
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
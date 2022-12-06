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
    public partial class AddDeliveryEntry : System.Web.UI.Page
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
                //if (Request.QueryString["action"] == "insert")
                //{
                //    pnlAlert.Attributes.Add("class", "alert alert-success");
                //    pnlAlert.Visible = true;
                //    lblalert.Text = "Delivery record insert successfully.";
                //}
                                
                fillDDL();
                fillddlProduct();
                if (Request.QueryString["ID"] != null)
                {                    
                    fetchcustomerDetails(Convert.ToInt32(Request.QueryString["ID"]));
                    ddlID.ClearSelection();
                    ddlName.ClearSelection();
                    ddlID.Items.FindByValue(Request.QueryString["ID"].ToString()).Selected = true;
                    ddlName.Items.FindByValue(Request.QueryString["ID"].ToString()).Selected = true;
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
                objDAL.QueryName = "proc_AnushreeDairy_Saler_FetchDailyDeliveryListInRepeater";

                objDAL.SetParameters("@deliveryBoyID", "integer", Convert.ToInt32(Request.Cookies["AdminID"].Value), 4);

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
                            if(DT.Rows[i]["deliveryID"].ToString() != "")
                            {
                                lstItem.Attributes.Add("style", "background-color:#dddddd");
                            }                            
                            ddlName.Items.Add(lstItem);

                            lstItemID = new ListItem();
                            lstItemID.Text = DT.Rows[i]["customerID"].ToString();
                            lstItemID.Value = DT.Rows[i]["customerID"].ToString();
                            if (DT.Rows[i]["deliveryID"].ToString() != "")
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

        private void fillddlProduct()
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
                lstItem.Text = "-- Products --";
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

        protected void ddlID_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlName.ClearSelection();
            ddlName.Items.FindByValue(ddlID.SelectedItem.Value).Selected = true;
            fetchcustomerDetails(Convert.ToInt32(ddlID.SelectedItem.Value));
        }
        protected void ddlName_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlID.ClearSelection();
            ddlID.Items.FindByValue(ddlName.SelectedItem.Value).Selected = true;
            fetchcustomerDetails(Convert.ToInt32(ddlName.SelectedItem.Value));
        }

        private void fetchcustomerDetails(int ID)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Saler_FetcCustomerDetailsInForm";

                objDAL.SetParameters("@customerID", "integer", ID, 4);

                DT = objDAL.FetchDatainDT();

                if (DT != null)
                {
                    if (DT.Rows.Count > 0)
                    {
                        ddlProduct.ClearSelection();
                        ddlProduct.Items.FindByValue(DT.Rows[0]["productID"].ToString()).Selected = true;
                        txtQuantity.Value = DT.Rows[0]["milkQuatity"].ToString();
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

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            BEL_Delivery objBEL = new BEL_Delivery();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Delivery objBALL = new BAL_Delivery();

            try
            {
                string date = Request.Form["txtDate"];

                objBEL.customerID = Convert.ToInt32(ddlID.SelectedItem.Value);
                objBEL.deliveryDate = txtDate.Value == "" ? DateTime.Now.Date :  Convert.ToDateTime(txtDate.Value);
                objBEL.batch = DateTime.Now.ToString("tt");
                objBEL.milkQuatity = Convert.ToDecimal(txtQuantity.Value);
                objBEL.productID = Convert.ToInt32(ddlProduct.SelectedItem.Value);
                objBEL.deliveryBoyID = Convert.ToInt32(Request.Cookies["AdminID"].Value);

                if (objBALL.addDelivery(objBEL))
                {
                    //MessageBox("Delivery record insert successfully.");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect", "alert('Delivery record insert successfully.'); window.location='" + Request.ApplicationPath + "cpanel/AddDeliveryEntry.aspx';", true);                    
                }
                else
                {
                    //pnlAlert.Attributes.Add("class", "alert alert-danger");
                    //pnlAlert.Visible = true;
                    //lblalert.Text = "ERROR !!! Please try again.";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect", "alert('ERROR !!! Please try again.'); window.location='" + Request.ApplicationPath + "cpanel/AddDeliveryEntry.aspx';", true);
                }

                if (Request.Cookies["date"] != null)
                {
                    Response.Cookies["date"].Expires = DateTime.Now.AddDays(-1);
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
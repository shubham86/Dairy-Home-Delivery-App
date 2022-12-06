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
    public partial class AddProductPriceaspx : System.Web.UI.Page
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

                fetchAdminDetails();
                fillddl();
                if (Request.QueryString["ID"] != null)
                {
                    lblOld.Visible = true;
                    ClearForm();
                    fetchProductPriceDetails();
                }
                else
                {
                    lblNew.Visible = true;
                    
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

        //fetch price details in form
        private void fetchProductPriceDetails()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_ProductRate_FetchInForm";

                objDAL.SetParameters("@productRateID", "integer", Convert.ToInt32(Request.QueryString["ID"]), 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    ddlProduct.Items.FindByValue(DT.Rows[0]["productID"].ToString()).Selected = true;
                    txtPrice.Value = DT.Rows[0]["productRate"].ToString();
                    txtDate.Value = DT.Rows[0]["dateOfDeclare"].ToString();
                    //chbxIsActive.Checked = Convert.ToBoolean(DT.Rows[0]["isActive"]);
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
            WIHO.BHO objBAL = new WIHO.BHO();

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
            objBAL.QueryType = "procedure";


            //if (Request.QueryString["ID"] != null)
            //{

            //    objBAL.QueryName = "proc_AnushreeDairy_ProductRate_UpdateValidation";

            //    if (objBAL.IsDuplicateRecord("@productRate", txtPrice.Value.ToString(), 10, "@productRateID", Convert.ToInt32(Request.QueryString["ID"])) == false)
            //    {
            //        if (updateProductPrice(Convert.ToInt32(Request.QueryString["ID"])))
            //        {
            //            Response.Redirect("ManageProductPrice.aspx?action=update");
            //            return;
            //        }
            //        else
            //        {
            //            MessageBox("Record could not be Updated... Please try again !!!");
            //            return;
            //        }
            //    }
            //    else
            //    {
            //        MessageBox("This Price already exist !");
            //    }
            //}
            //else
            //{
                objBAL.QueryName = "proc_AnushreeDairy_ProductRate_AddValidation";

                if (objBAL.IsDuplicateRecord("@rate", txtPrice.Value.ToString(), 10, "@productID", Convert.ToInt32(ddlProduct.SelectedItem.Value)) == false)
                {
                    if (insertProductPrice())
                    {
                        ClearForm();
                        Response.Redirect("ManageProductPrice.aspx?action=insert");
                        return;
                    }
                    else
                    {
                        Response.Redirect("Record could not be Added... Please try again !!!");
                        return;
                    }
                }
                else
                {
                    MessageBox("This Price already exist !");
                }
            //}
        }

        private bool insertProductPrice()
        {
            bool functionReturnValue = false;

            BEL_Product objBEL = new BEL_Product();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Product objBALL = new BAL_Product();

            try
            {
                objBEL.productID = Convert.ToInt32(ddlProduct.SelectedItem.Value);
                objBEL.productRate = Convert.ToDecimal(txtPrice.Value);
                objBEL.dateOfDeclare = Convert.ToDateTime(txtDate.Value);
                //objBEL.isActive = chbxIsActive.Checked;

                if (objBALL.addProductPrice(objBEL))
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
         
        private bool updateProductPrice(int productPriceID)
        {
            bool functionReturnValue = false;

            BEL_Product objBEL = new BEL_Product();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Product objBALL = new BAL_Product();

            try
            {
                objBEL.productRateID = productPriceID;
                objBEL.productRate = Convert.ToDecimal(txtPrice.Value);
                objBEL.dateOfDeclare = Convert.ToDateTime(txtDate.Value);
                //objBEL.isActive = chbxIsActive.Checked;

                if (objBALL.updateProductPrice(objBEL))
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
            Response.Redirect("ManageProductPrice.aspx");
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
            txtDate.Value = "";
            txtPrice.Value = "";
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
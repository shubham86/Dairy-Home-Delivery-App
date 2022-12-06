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
    public partial class AddProduct : System.Web.UI.Page
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

                if (Request.QueryString["ID"] != null)
                {
                    lblOld.Visible = true;
                    ClearForm();
                    fetchProductDetails();
                }
                else
                {
                    lblNew.Visible = true;
                    chbxIsActive.Checked = true;
                }
            }
        }

        //fetch product details in form
        private void fetchProductDetails()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Product_FetchInForm";

                objDAL.SetParameters("@productID", "integer", Convert.ToInt32(Request.QueryString["ID"]), 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    txtProductName.Value = DT.Rows[0]["productName"].ToString();
                    txtProductDesc.Value = DT.Rows[0]["productDesc"].ToString();
                    chbxIsActive.Checked = Convert.ToBoolean(DT.Rows[0]["isActive"]);
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


            if (Request.QueryString["ID"] != null)
            {

                objBAL.QueryName = "proc_AnushreeDairy_Product_UpdateValidation";

                if (objBAL.IsDuplicateRecord("@productName", txtProductName.Value.ToString(), 100, "@productID", Convert.ToInt32(Request.QueryString["ID"])) == false)
                {
                    if (updateProduct(Convert.ToInt32(Request.QueryString["ID"])))
                    {
                        Response.Redirect("ManageProduct.aspx?action=update");
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
                    MessageBox("This product already exist !");
                }
            }
            else
            {
                objBAL.QueryName = "proc_AnushreeDairy_Product_AddValidation";

                if (objBAL.IsDuplicateRecord("@productName", txtProductName.Value.ToString(), 100) == false)
                {
                    if (insertProduct())
                    {
                        ClearForm();
                        Response.Redirect("ManageProduct.aspx?action=insert");
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
                    MessageBox("This product already exist !");
                }
            }
        }

        private bool insertProduct()
        {
            bool functionReturnValue = false;

            BEL_Product objBEL = new BEL_Product();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Product objBALL = new BAL_Product();

            try
            {
                objBEL.productName = txtProductName.Value.ToString();
                objBEL.productDesc = txtProductDesc.Value.ToString();

                if (objBALL.addProduct(objBEL))
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

        private bool updateProduct(int productID)
        {
            bool functionReturnValue = false;

            BEL_Product objBEL = new BEL_Product();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Product objBALL = new BAL_Product();

            try
            {
                objBEL.productID = productID;
                objBEL.productName = txtProductName.Value.ToString();
                objBEL.productDesc = txtProductDesc.Value.ToString();
                objBEL.isActive = Convert.ToBoolean(chbxIsActive.Checked);

                if (objBALL.updateProduct(objBEL))
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
            Response.Redirect("ManageProduct.aspx", false);
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
            txtProductDesc.Value = "";
            txtProductName.Value = "";
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
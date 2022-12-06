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
    public partial class AddDeliveryBoy : System.Web.UI.Page
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
                    fetchAdminInForm();
                }
                else
                {
                    lblNew.Visible = true;
                }
            }
        }

        //fetch ADMIN details in form
        private void fetchAdminInForm()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Admin_FetchInForm";

                objDAL.SetParameters("@adminID", "integer", Convert.ToInt32(Request.QueryString["ID"]), 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    string[] str = DT.Rows[0]["adminName"].ToString().Split(' ', '\t');
                    int a = str.Length;
                    txtFirstName.Value = str[0].ToString();
                    txtLastName.Value = a < 2 ? "" : str[1].ToString();
                    txtMobile.Value = DT.Rows[0]["mobile"].ToString();
                    txtEmail.Value = DT.Rows[0]["email"].ToString();
                    txtMobile.Value = DT.Rows[0]["mobile"].ToString();
                    ddlRole.Items.FindByValue(DT.Rows[0]["role"].ToString()).Selected = true;
                    txtUserName.Value = DT.Rows[0]["adminUserName"].ToString();
                    txtPassword.Value = DT.Rows[0]["password"].ToString();

                    if(!Convert.ToBoolean(DT.Rows[0]["isActive"]))
                    {
                        btnSave.Enabled = false;
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
            WIHO.BHO objBAL = new WIHO.BHO();

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
            objBAL.QueryType = "procedure";


            if (Request.QueryString["ID"] != null)
            {

                objBAL.QueryName = "proc_AnushreeDairy_Admin_UpdateValidation";

                if (objBAL.IsDuplicateRecord("@adminUserName", txtUserName.Value.ToString(), 100, "@adminID", Convert.ToInt32(Request.QueryString["ID"])) == false)
                {
                    if (updateAdmin(Convert.ToInt32(Request.QueryString["ID"])))
                    {
                        Response.Redirect("ManageDeliveryBoy.aspx?action=update");
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
                    MessageBox("This Username already exist !");
                }
            }
            else
            {
                objBAL.QueryName = "proc_AnushreeDairy_Admin_AddValidation";

                if (objBAL.IsDuplicateRecord("@userName", txtUserName.Value.ToString(), 50) == false)
                {
                    InsertAdmin();
                }
                else
                {
                    MessageBox("This Username already exist !");
                }
            }
        }

        private void InsertAdmin()
        {
            BEL_Admin objBEL = new BEL_Admin();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Admin objBALL = new BAL_Admin();

            try
            {
                string fName = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFirstName.Value.ToString().ToLower());
                string lName = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtLastName.Value.ToString().ToLower());

                objBEL.adminName = fName + " " + lName;
                objBEL.adminUserName = txtUserName.Value.ToString();
                objBEL.password = txtConfirmPass.Value.ToString();
                objBEL.role = (ddlRole.SelectedItem.Value).ToString();
                objBEL.adminEmail = txtEmail.Value.ToString();
                objBEL.adminMobile = txtMobile.Value.ToString();

                if (objBALL.addValidation(objBEL))
                {
                    if (objBALL.addAdmin(objBEL))
                    {
                        ClearForm();
                        Response.Redirect("ManageDeliveryBoy.aspx?action=insert");
                        return;
                    }
                    else
                    {
                        MessageBox("Record could not be Added... Please try again !!!");
                        return;
                    }
                }
                else
                {
                    MessageBox("You already have an account!");
                    return;
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        private bool updateAdmin(int adminID)
        {
            bool functionReturnValue = false;

            BEL_Admin objBEL = new BEL_Admin();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Admin objBALL = new BAL_Admin();

            try
            {
                string fName = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFirstName.Value.ToString().ToLower());
                string lName = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtLastName.Value.ToString().ToLower());
                                
                objBEL.adminID = adminID;
                objBEL.adminName = fName + " " + lName;
                objBEL.adminUserName = txtUserName.Value.ToString();
                objBEL.password = txtConfirmPass.Value.ToString();
                objBEL.role = (ddlRole.SelectedItem.Value).ToString();
                objBEL.adminEmail = txtEmail.Value.ToString();
                objBEL.adminMobile = txtMobile.Value.ToString();

                if (objBALL.updateAdmin(objBEL))
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
            Response.Redirect("ManageDeliveryBoy.aspx", false);
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
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        private void ClearForm()
        {
            txtConfirmPass.Value = "";
            txtEmail.Value = "";
            txtFirstName.Value = "";
            txtLastName.Value = "";
            txtMobile.Value = "";
            txtPassword.Value = "";
            txtUserName.Value = "";
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
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
    public partial class AddArea : System.Web.UI.Page
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
                    fetchAreaDetails();
                }
                else
                {
                    lblNew.Visible = true;
                    chbxIsActive.Checked = true;
                }
            }
        }

        //fetch area details in form
        private void fetchAreaDetails()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Area_FetchInForm";

                objDAL.SetParameters("@areaID", "integer", Convert.ToInt32(Request.QueryString["ID"]), 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    txtAreName.Value = DT.Rows[0]["area"].ToString();
                    txtCity.Value = DT.Rows[0]["city"].ToString();
                    txtPincode.Value = DT.Rows[0]["pincode"].ToString();
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

                objBAL.QueryName = "proc_AnushreeDairy_Area_UpdateValidation";

                if (objBAL.IsDuplicateRecord("@area", txtAreName.Value.ToString(), 100, "@areaID", Convert.ToInt32(Request.QueryString["ID"])) == false)
                {
                    if (updateArea(Convert.ToInt32(Request.QueryString["ID"])))
                    {
                        Response.Redirect("ManageArea.aspx?action=update");
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
                    MessageBox("This area already exist !");
                }
            }
            else
            {
                objBAL.QueryName = "proc_AnushreeDairy_Area_AddValidation";

                if (objBAL.IsDuplicateRecord("@area", txtAreName.Value.ToString(), 100) == false)
                {
                    if (insertArea())
                    {
                        ClearForm();
                        Response.Redirect("ManageArea.aspx?action=insert");
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
                    MessageBox("This area already exist !");
                }
            }
        }

        private bool insertArea()
        {
            bool functionReturnValue = false;

            BEL_Area objBEL = new BEL_Area();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Area objBALL = new BAL_Area();

            try
            {
                objBEL.area = txtAreName.Value.ToString();
                objBEL.city = txtCity.Value.ToString();
                objBEL.pincode = txtPincode.Value.ToString();
                objBEL.isActive = chbxIsActive.Checked;

                if (objBALL.addArea(objBEL))
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

        private bool updateArea(int areaID)
        {
            bool functionReturnValue = false;

            BEL_Area objBEL = new BEL_Area();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Area objBALL = new BAL_Area();

            try
            {
                objBEL.areaID = areaID;
                objBEL.area = txtAreName.Value.ToString();
                objBEL.city = txtCity.Value.ToString();
                objBEL.pincode = txtPincode.Value.ToString();
                objBEL.isActive = chbxIsActive.Checked;

                if (objBALL.updateArea(objBEL))
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
            Response.Redirect("ManageArea.aspx", false);
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
            txtAreName.Value = "";
            txtCity.Value = "";
            txtPincode.Value = "";
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
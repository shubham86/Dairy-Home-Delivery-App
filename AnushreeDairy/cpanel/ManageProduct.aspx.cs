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
    public partial class ManageProduct : System.Web.UI.Page
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
                if (Request.Cookies["AdminRole"].Value != "admin")
                {
                    Response.Redirect("Logout.aspx");
                }

                if (Request.QueryString["action"] == "insert")
                {
                    MessageBox("Record Inserted successfully !!!");
                }
                else if (Request.QueryString["action"] == "update")
                {
                    MessageBox("Record Updated successfully !!!");
                }
                else if (Request.QueryString["action"] == "delete")
                {
                    MessageBox("Record Deleted successfully !!!");
                }

                fillrepeaterActive();
            }
        }

        protected void ddlRecord_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRecord.SelectedItem.Value == "1")
            {
                fillrepeaterActive();
            }
            else
            {
                fillrepeaterAll();
            }
        }

        public void fillrepeaterActive()
        {

            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Product_FetchActiveProductInRepeater";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    rptrProduct.DataSource = DT;
                    rptrProduct.DataBind();
                }
                else
                {
                    rptrProduct.DataSource = null;
                    rptrProduct.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        public void fillrepeaterAll()
        {

            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Product_FetchProductInRepeater";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    rptrProduct.DataSource = DT;
                    rptrProduct.DataBind();
                }
                else
                {
                    rptrProduct.DataSource = null;
                    rptrProduct.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        public string getImageURL(string img)
        {
            if (Convert.ToBoolean(img))
            {
                return "images/tickIcon.png";
            }
            else
            {
                return "images/crossIcon.png";
            }
        }

        public string getAlternateText(string img)
        {
            if (Convert.ToBoolean(img))
            {
                return "Active";
            }
            else
            {
                return "Inactive";
            }
        }

        protected void rptrProduct_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            WIHO.BHO objBAL = new WIHO.BHO();

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
            objBAL.QueryType = "procedure";

            if (e.CommandName == "edit")
            {
                Response.Redirect("AddProduct.aspx?ID=" + e.CommandArgument, false);
                return;
            }

            else if (e.CommandName == "delete")
            {
                try
                {
                    objBAL.QueryName = "proc_AnushreeDairy_Product_delete";
                    if (objBAL.DeleteRecord("@productID", Convert.ToInt32(e.CommandArgument)))
                    {
                        Response.Redirect("ManageProduct.aspx?action=delete");
                        return;

                    }
                    else
                    {
                        MessageBox("Unable to Delete Record...Please try again !!");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    MessageBox("repeater Row Command Delete Record Error - " + ex.Message);
                }
            }
            else if (e.CommandName == "status")
            {
                try
                {
                    objBAL.QueryName = "proc_AnushreeDairy_Product_ChangeStatus";
                    if (objBAL.ChangeRecordStatus("@productID", Convert.ToInt32(e.CommandArgument)))
                    {
                        fillrepeaterActive();
                        MessageBox("Status Changed Successfully");
                        return;
                    }
                    else
                    {
                        MessageBox("Unable to Change Status...Please try again !!");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    MessageBox("ERROR !!! Please try after some time");
                }
            }
        }

        protected void imgbtnadd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("AddProduct.aspx", false);
            return;
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
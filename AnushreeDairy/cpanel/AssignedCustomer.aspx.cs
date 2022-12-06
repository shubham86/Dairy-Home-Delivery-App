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
    public partial class AssignedCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("Logout.aspx");
                return;
            }
            if (!Page.IsPostBack)
            {
                if (Request.Cookies["AdminRole"].Value != "admin")
                {
                    Response.Redirect("Logout.aspx");
                }

                fillrepeater();
                if (Request.QueryString["action"] == "assigned")
                {
                    MessageBox("Selected customers Assigned to " + lblDBoyName.Text + " successfully !!!");
                }
            }
        }

        public void fillrepeater()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataSet DS = new DataSet();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Delivery_FetchAssignedCustomersInRepeater";

                objDAL.SetParameters("@deliveryBoyID", "integer", Convert.ToInt32(Request.QueryString["ID"]), 4);

                DS = objDAL.FetchDatainDS();
                if (DS.Tables[0].Rows.Count > 0)
                {                    
                    rptrCustomer.DataSource = DS.Tables[0];
                    rptrCustomer.DataBind();
                }
                else
                {
                    rptrCustomer.DataSource = null;
                    rptrCustomer.DataBind();
                    btnUnAssign.Enabled = false;
                }

                if (DS.Tables[1].Rows.Count > 0)
                {
                    lblDBoyName.Text = DS.Tables[1].Rows[0]["deliveryBoyName"].ToString();
                    lblDBoyName1.Text = DS.Tables[1].Rows[0]["deliveryBoyName"].ToString();
                }
                else
                {
                    lblDBoyName.Text = "Delivery Boy";
                    lblDBoyName1.Text = "Delivery Boy";
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        protected void btnUnAssign_Click(object sender, System.EventArgs e)
        {
            foreach (RepeaterItem ri in rptrCustomer.Items)
            {
                CheckBox item_check = (CheckBox)ri.FindControl("chkRowData");
                Label txt_id = (Label)ri.FindControl("lblCustomerID");
                if (item_check.Checked)
                {
                    WIHO.DHO objDAL = new WIHO.DHO();
                    try
                    {
                        objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                        objDAL.QueryType = "procedure";
                        objDAL.QueryName = "proc_AnushreeDairy_Delivery_UnassignCustomer";

                        objDAL.SetParameters("@customerID", "integer", Convert.ToInt32(txt_id.Text), 4);
                        objDAL.IUDData();
                    }
                    catch (Exception ex)
                    {
                        string x = ex.Message;
                        MessageBox("ERROR !!! Please try after some time");
                    }
                }
            }
            fillrepeater();
            MessageBox("Selected customers un-assigned from " + lblDBoyName.Text + " successfully !!!");
        }

        protected void imgbtnadd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("UnassignedCustomer.aspx?ID=" + Request.QueryString["ID"].ToString(), false);
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
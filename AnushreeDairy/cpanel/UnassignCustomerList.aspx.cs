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
    public partial class UnassignCustomerList : System.Web.UI.Page
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
                if (Request.QueryString["action"] == "assigned")
                {
                    MessageBox("Selected customers Assigned to " + Request.QueryString["Name"].ToString() + " successfully !!!");
                }

                fetchActiveCustomer();
                fillDeliveryBoyrepeater();
            }
        }

        public void fetchActiveCustomer()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Customer_FetchUnassignActiveCustomerInRepeater";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    rptrCustomer.DataSource = DT;
                    rptrCustomer.DataBind();
                }
                else
                {
                    rptrCustomer.DataSource = null;
                    rptrCustomer.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        public void fetchAllCustomer()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Customer_FetchUnassignAllCustomerInRepeater";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    rptrCustomer.DataSource = DT;
                    rptrCustomer.DataBind();
                }
                else
                {
                    rptrCustomer.DataSource = null;
                    rptrCustomer.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        public string getImageURL(string ID)
        {
            if (Convert.ToBoolean(ID))
            {
                return "images/tickIcon.png";
            }
            else
            {
                return "images/crossIcon.png";
            }
        }

        public string getAlternateText(string ID)
        {
            if (Convert.ToBoolean(ID))
            {
                return "Active";
            }
            else
            {
                return "InActive";
            }
        }

        protected void ddl_SelectedIndexChange(object sender, System.EventArgs e)
        {
            if (ddlAll.SelectedItem.Value == "2")
            {
                fetchAllCustomer();
            }
            else
            {
                fetchActiveCustomer();
            }
        }

        protected void rptrCustomer_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                Response.Redirect("CustomerDetails.aspx?ID=" + e.CommandArgument, false);
            }
        }

        public void fillDeliveryBoyrepeater()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Delivery_FetchDeliveryBoyInRepeater";

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    rptrDeliveryBoy.DataSource = DT;
                    rptrDeliveryBoy.DataBind();
                }
                else
                {
                    rptrDeliveryBoy.DataSource = null;
                    rptrDeliveryBoy.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        public string getAreas(int ID)
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            string area = "";

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Delivery_FetchAreasOfDeliveryBoy";

                objDAL.SetParameters("@adminID", "integer", ID, 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    for (int c = 0; c < DT.Rows.Count; c++)
                    {
                        if (c > 0)
                        {
                            area += ", " + DT.Rows[c]["area"].ToString();
                        }
                        else
                        {
                            area = DT.Rows[c]["area"].ToString();
                        }
                    }
                }
                else
                {
                    area = "-";
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
            return area;
        }

        protected void rptrDeliveryBoy_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
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
                        objDAL.QueryName = "proc_AnushreeDairy_Delivery_AssignCustomer";

                        objDAL.SetParameters("@customerID", "integer", Convert.ToInt32(txt_id.Text), 4);
                        objDAL.SetParameters("@deliveryBoyID", "integer", Convert.ToInt32(e.CommandArgument), 4);
                        objDAL.IUDData();
                    }
                    catch (Exception ex)
                    {
                        string x = ex.Message;
                        MessageBox("ERROR !!! Please try after some time");
                    }
                }
            }
            Response.Redirect("UnassignCustomerList.aspx?Name=" + e.CommandName + "&action=assigned", false);
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
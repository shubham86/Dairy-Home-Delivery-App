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
    public partial class ManagePurchase : System.Web.UI.Page
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

                fillYearDDL();
                ddlMonth.Items.FindByValue(string.Format("{0:00}", DateTime.Now.ToString("MM"))).Selected = true;
                ddlYear.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
                fillrepeater();
            }
        }

        private void fillYearDDL()
        {
            var years = Enumerable.Range(DateTime.Now.Year - 2, 3).OrderByDescending(x => x);

            ddlYear.Items.Clear();

            foreach (var year in years)
            {
                ddlYear.Items.Add(year.ToString());
            }
        }

        public void fillrepeater()
        {

            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();

            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Purchase_FetchEntryInRepeater";

                objDAL.SetParameters("@month", "integer", Convert.ToInt32(ddlMonth.SelectedItem.Value), 4);
                objDAL.SetParameters("@year", "integer", Convert.ToInt32(ddlYear.SelectedItem.Value), 4);

                DT = objDAL.FetchDatainDT();
                if (DT.Rows.Count > 0)
                {
                    rptrPurchase.DataSource = DT;
                    rptrPurchase.DataBind();
                }
                else
                {
                    rptrPurchase.DataSource = null;
                    rptrPurchase.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }
        
        protected void rptrPurchase_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            WIHO.BHO objBAL = new WIHO.BHO();

            objBAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
            objBAL.QueryType = "procedure";

            if (e.CommandName == "edit")
            {
                Response.Redirect("AddPurchaseEntry.aspx?ID=" + e.CommandArgument, false);
                return;
            }

            else if (e.CommandName == "delete")
            {
                try
                {
                    objBAL.QueryName = "proc_AnushreeDairy_Purchase_delete";
                    if (objBAL.DeleteRecord("@purchaseID", Convert.ToInt32(e.CommandArgument)))
                    {
                        MessageBox("Record Deleted Successfully !!!");
                        fillrepeater();
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
        }

        protected void imgbtnadd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("AddPurchaseEntry.aspx", false);
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

        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            fillrepeater();
        }
        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            fillrepeater();
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
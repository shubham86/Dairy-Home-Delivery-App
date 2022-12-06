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
    public partial class ManageDelivery : System.Web.UI.Page
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

                fillrepeater();
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
                    for(int c=0; c < DT.Rows.Count; c++)
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

        if (e.CommandName == "view")
        {
            Response.Redirect("AssignedCustomer.aspx?ID=" + e.CommandArgument, false);
            return;
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
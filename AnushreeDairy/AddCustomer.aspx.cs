using AnushreeDairy.BAL;
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

namespace AnushreeDairy
{
    public partial class AddCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {                
                fillAreaddl();
            }
        }

        //Add Area
        private bool addArea()
        {
            bool functionReturnValue = false;
            BEL_Customer objBEL = new BEL_Customer();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Customer objBALL = new BAL_Customer();

            try
            {
                string fName = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFirstName.Value.ToString().ToLower());
                string lName = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtLastName.Value.ToString().ToLower());

                objBEL.customerName = fName + " " + lName;
                objBEL.customerUserName = txtUserName.Value;
                objBEL.customerPassword = txtConfirmPassword.Value;
                objBEL.customerMobile = txtMobile.Value;
                objBEL.customerEmail = txtEmail.Value;
                objBEL.dateOfRegister = Convert.ToDateTime(DateTime.Now);
                objBEL.flatNo = txtFlat.Value;
                objBEL.buildingName = txtBuilding.Value;
                objBEL.street = txtStreet.Value;
                objBEL.areaID = Convert.ToInt32(ddlArea.SelectedItem.Value);
                objBEL.Latitude = lat.Value;
                objBEL.Longitude = lng.Value;

                if (objBALL.addCustomer(objBEL))
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
                
            }
            return functionReturnValue;
        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            if (addArea())
            {
                MessageBox("Customer add successfully");
            }
            else
            {
                MessageBox("ERROR !!! Please try after some time");
            }
            
        }

        //fill ddl
        private void fillAreaddl()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            ListItem lstItem = new ListItem();
            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Area_FetchAreaInRepeater";

                DT = objDAL.FetchDatainDT();

                lstItem = new ListItem();
                lstItem.Text = "Select Area..";
                lstItem.Value = "0";
                ddlArea.Items.Add(lstItem);

                if (DT != null)
                {
                    if (DT.Rows.Count > 0)
                    {
                        for (int i = 0; i < DT.Rows.Count; i++)
                        {
                            lstItem = new ListItem();
                            lstItem.Text = DT.Rows[i]["area"].ToString();
                            lstItem.Value = DT.Rows[i]["areaID"].ToString();
                            ddlArea.Items.Add(lstItem);
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

        protected void ddlArea_SelectedIndexChanged(object sender, EventArgs e)
        {
            fetchPincode();
        }

        private void fetchPincode()
        {
            WIHO.DHO objDAL = new WIHO.DHO();
            DataTable DT = new DataTable();
            ListItem lstItem = new ListItem();
            try
            {
                objDAL.SQLConnectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ToString();
                objDAL.QueryType = "procedure";
                objDAL.QueryName = "proc_AnushreeDairy_Area_FetchAreaPincode";

                objDAL.SetParameters("@areaID", "varchar", ddlArea.SelectedItem.Value, 4);

                DT = objDAL.FetchDatainDT();

                if (DT.Rows.Count > 0)
                {
                    txtPin.Value = DT.Rows[0]["pincode"].ToString();
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
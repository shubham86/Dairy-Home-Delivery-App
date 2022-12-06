using AnushreeDairy.cpanel.BAL;
using AnushreeDairy.cpanel.BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnushreeDairy.cpanel
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //getBackup();
            }
            
            if (Request.Cookies["AdminID"] != null && Request.Cookies["AdminName"] != null && Request.Cookies["AdminRole"] != null)
            {                
                if (Request.Cookies["AdminRole"].Value != "admin")
                {
                    Response.Redirect("Dashboard2.aspx");
                }
                else
                {
                    Response.Redirect("Dashboard.aspx");
                }
            }
        }

        protected void btnSubmitUP_Click(object sender, System.EventArgs e)
        {
            //InsertAdmin();
        }

        private void InsertAdmin()
        {
            BEL_Admin objBEL = new BEL_Admin();
            WIHO.BHO objBAL = new WIHO.BHO();
            BAL_Admin objBALL = new BAL_Admin();

            try
            {
                //objBEL.adminName = txtFirstName.Text + " " + txtLastName.Text;
                //objBEL.adminUserName = txtUserNameUP.Text;
                //objBEL.password = txtPasswordUP.Text;
                //objBEL.role = (ddlRole.SelectedItem.Value).ToString();
                //objBEL.adminEmail = txtEmail.Text;
                //objBEL.adminMobile = txtMobile.Text;

                if (objBALL.addValidation(objBEL))
                {
                    if (objBALL.addAdmin(objBEL))
                    {
                        //pnlAlert.Attributes.Add("class", "alert alert-success");
                        //pnlAlert.Visible = true;
                        //lblalert.Text = "Registration successful. Please check your email.";

                        MessageBox("Registration successful. Please check your email.");
                    }
                    else
                    {
                        MessageBox("ERROR !!! Please try after some time");
                    }
                }
                else
                {
                    MessageBox("You already have an account!");
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            VerifyLoginUser(txtUserName.Value.ToString(), txtPAssword.Value.ToString());
        }

        //verify login
        private void VerifyLoginUser(string Uname,string Password)
        {
            DataTable dt = new DataTable();

            BEL_Admin objBEL = new BEL_Admin();
            BAL_Admin objBAL = new BAL_Admin();

            objBEL.adminUserName = Uname;
            objBEL.password = Password;
            try
            {
                dt = objBAL.VerifyAdmin(objBEL);
                if (dt.Rows.Count > 0)
                {
                    //Request.Cookies["AdminID"].Value = dt.Rows[0]["adminID"].ToString();
                    //Session["v_session_str_AdminName"] = dt.Rows[0]["adminName"].ToString();

                    if (chbxRemember.Checked)
                    {
                        HttpCookie Cookie = new HttpCookie("AdminID");
                        Cookie.Value = dt.Rows[0]["adminID"].ToString() == "" ? "0" : dt.Rows[0]["adminID"].ToString();
                        Cookie.Expires = DateTime.Now.AddDays(15);
                        Response.Cookies.Add(Cookie);

                        HttpCookie Cookie1 = new HttpCookie("AdminName");
                        Cookie1.Value = dt.Rows[0]["adminName"].ToString() == "" ? "" : dt.Rows[0]["adminName"].ToString();
                        Cookie1.Expires = DateTime.Now.AddDays(15);
                        Response.Cookies.Add(Cookie1);

                        HttpCookie Cookie2 = new HttpCookie("AdminRole");
                        Cookie2.Value = dt.Rows[0]["role"].ToString() == "" ? "" : dt.Rows[0]["role"].ToString();
                        Cookie2.Expires = DateTime.Now.AddDays(15);
                        Response.Cookies.Add(Cookie2);
                    }
                    else
                    {
                        HttpCookie Cookie = new HttpCookie("AdminID");
                        Cookie.Value = dt.Rows[0]["adminID"].ToString() == "" ? "0" : dt.Rows[0]["adminID"].ToString();
                        Cookie.Expires = DateTime.Now.AddMinutes(360);
                        Response.Cookies.Add(Cookie);

                        HttpCookie Cookie1 = new HttpCookie("AdminName");
                        Cookie1.Value = dt.Rows[0]["adminName"].ToString();
                        Cookie1.Expires = DateTime.Now.AddMinutes(360);
                        Response.Cookies.Add(Cookie1);

                        HttpCookie Cookie2 = new HttpCookie("AdminRole");
                        Cookie2.Value = dt.Rows[0]["role"].ToString() == "" ? "" : dt.Rows[0]["role"].ToString();
                        Cookie2.Expires = DateTime.Now.AddMinutes(360);
                        Response.Cookies.Add(Cookie2);
                    }

                    if (dt.Rows[0]["role"].ToString() != "admin")
                    {
                        Response.Redirect("Dashboard2.aspx",false);
                    }
                    else
                    {
                        Response.Redirect("Dashboard.aspx",false);
                    }
                }
                else
                {
                    MessageBox("User Name or Password is Incorrect, Please try again !!!");
                }
            }
            catch (Exception ex)
            {
                MessageBox("ERROR !!! Please try after some time");
            }
        }

        private void getBackup()
        {
            // read connectionstring from config file
            var connectionString = ConfigurationManager.ConnectionStrings["CONST_AnushreeDairy_DBCONN"].ConnectionString;

            // read backup folder from config file ("C:/temp/")
            var backupFolder = Server.MapPath("../cpanel/DBbackup/");

            var sqlConStrBuilder = new SqlConnectionStringBuilder(connectionString);

            // set backupfilename (you will get something like: "C:/temp/MyDatabase-2013-12-07.bak")
            var backupFileName = String.Format("{0}{1}-{2}.bak", backupFolder, sqlConStrBuilder.InitialCatalog, DateTime.Now.ToString("yyyy-MM-dd"));

            var yesterdayFileName = String.Format("{0}{1}-{2}.bak", backupFolder, sqlConStrBuilder.InitialCatalog, DateTime.Today.AddDays(-1).ToString("yyyy-MM-dd"));

            using (var connection = new SqlConnection(sqlConStrBuilder.ConnectionString))
            {
                var query = String.Format("BACKUP DATABASE {0} TO DISK='{1}'",
                    sqlConStrBuilder.InitialCatalog, backupFileName);

                using (var command = new SqlCommand(query, connection))
                {
                    Boolean _retVal = false;
                    FileInfo file = new FileInfo(backupFileName);
                    if (! file.Exists)
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        _retVal = true;
                    }

                    //delete recent database
                    if(_retVal)
                    {
                        //FileInfo fileOld = new FileInfo(yesterdayFileName);
                        //if (fileOld.Exists)
                        //{
                        //    fileOld.Delete();
                        //}
                        string[] filePaths = Directory.GetFiles(backupFolder);
                        foreach (string filePath in filePaths)
                        {
                            var name = new FileInfo(filePath).Name;
                            string currentFile = sqlConStrBuilder.InitialCatalog + "-" + DateTime.Now.ToString("yyyy-MM-dd") + ".bak";
                            if (name != currentFile)
                            {
                                File.Delete(filePath);
                            }
                        }
                    }                    
                }
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
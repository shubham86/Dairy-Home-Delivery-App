<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="AnushreeDairy.cpanel.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Log-In</title> 
     <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png"/>
    <!-- Bootstrap Core CSS -->
    <link href="css/lib/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <!-- Custom CSS -->
    <link href="css/helper.css" rel="stylesheet"/>
    <link href="css/style.css" rel="stylesheet"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:** -->
    <!--[if lt IE 9]>
    <script src="https:**oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https:**oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    <style>
        .login-form label {
            color: #455a64;
            text-transform: capitalize;
        }

        .error {
            color: #ef5350;
            font-size: 12px;
            display: none;
            margin-bottom: 0;
        }

        @media only screen and (min-width : 1024px) {
                .login-content {
                margin: 65px 0;
            }
        }

        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            .login-content {
                margin: 30px 0;
            }
        }
    </style>

    <script>
         function validateForm() {
            if (document.getElementById('<%=txtUserName.ClientID%>').value == "") {
                document.getElementById("lblUserName").style.display = "block";
                document.getElementById('<%=txtUserName.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtUserName.ClientID%>').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=txtPAssword.ClientID%>').value == "") {
                document.getElementById("lblPassword").style.display = "block";
                document.getElementById('<%=txtPAssword.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtPAssword.ClientID%>').style.borderColor = "red";
                return false;
            }
        }

        function hideArealbl()
        {
            document.getElementById("lblUserName").style.display = "none"
            document.getElementById('<%=txtUserName.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtUserName.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideCitylbl()
        {
            document.getElementById("lblPassword").style.display = "none"
            document.getElementById('<%=txtPAssword.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtPAssword.ClientID%>').style.borderColor = "#e7e7e7";
        }
    </script>
</head>
<body class="fix-header fix-sidebar">
    <!-- Preloader - style you can find in spinners.css -->
    <div class="preloader">
        <svg class="circular" viewBox="25 25 50 50">
            <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10" />
        </svg>
    </div>
    <!-- Main wrapper  -->
    <div id="main-wrapper">
        <div class="unix-login">
            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="col-lg-4">
                        <div class="login-content card">
                            <div class="login-form">
                                <h4>LOGIN</h4>
                                <form runat="server">
                                    <div class="form-group">
                                        <label>User Name</label>
                                        <input id="txtUserName" runat="server" type="text" class="form-control" onclick="hideArealbl()" placeholder="User Name"/>
                                        <label id="lblUserName" class="error" style="color:#ef5350">Please enter user name</label>
                                    </div>
                                    <div class="form-group">
                                        <label>Password</label>
                                        <input id="txtPAssword" runat="server" type="password" class="form-control" placeholder="Password" onclick="hideCitylbl()"/>
                                        <label id="lblPassword" class="error" style="color:#ef5350">Please enter password</label>
                                    </div>
                                    <div class="checkbox" style="display:none">
                                        <label>
                                            <input id="chbxRemember" type="checkbox" runat="server"/>
                                            Remember Me
                                        </label> 
                                    </div>
                                    <asp:Button ID="btnLogin" runat="server" Text="Sign in" class="btn btn-primary btn-flat m-b-30 m-t-30" OnClick="btnLogin_Click" OnClientClick="return validateForm()"/>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!-- End Wrapper -->
    <!-- All Jquery -->
    <script src="js/lib/jquery/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="js/lib/bootstrap/js/popper.min.js"></script>
    <script src="js/lib/bootstrap/js/bootstrap.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="js/jquery.slimscroll.js"></script>
    <!--Menu sidebar -->
    <script src="js/sidebarmenu.js"></script>
    <!--stickey kit -->
    <script src="js/lib/sticky-kit-master/dist/sticky-kit.min.js"></script>
    <!--Custom JavaScript -->
    <script src="js/custom.min.js"></script>
</body>
</html>

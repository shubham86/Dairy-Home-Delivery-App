<%@ Page Title="" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="AddDeliveryBoy.aspx.cs" Inherits="AnushreeDairy.cpanel.AddDeliveryBoy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .error {
            color: #ef5350;
            font-size: 12px;
            display: none;
            margin-bottom: 0;
        }

        .hideError {
            display: none;
        }
    </style>

    <script>        
        function validateForm() {
            if (document.getElementById('<%=txtFirstName.ClientID%>').value == "") {
                document.getElementById("lblFirstName").style.display = "block";
                document.getElementById('<%=txtFirstName.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtFirstName.ClientID%>').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=txtMobile.ClientID%>').value == "") {
                document.getElementById("lblMobile").style.display = "block";
                document.getElementById('<%=txtMobile.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtMobile.ClientID%>').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=txtMobile.ClientID%>').value.length < 10) {
                document.getElementById("lblMobile1").style.display = "block";
                document.getElementById('<%=txtMobile.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtMobile.ClientID%>').style.borderColor = "red";
                return false;
            }

            if (document.getElementById('<%=txtEmail.ClientID%>').value != "") {
                var email = document.getElementById('<%=txtEmail.ClientID%>');
                var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

                if (!filter.test(email.value)) {
                    (document.getElementById("lblEmail1").style.display = "block")
                    document.getElementById('<%=txtEmail.ClientID%>').style.marginBottom = "10px";
                    document.getElementById('<%=txtEmail.ClientID%>').style.borderColor = "red";
                    return false;
                }
            }
            else {
                 document.getElementById("lblEmail").style.display = "block";
                document.getElementById('<%=txtEmail.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtEmail.ClientID%>').style.borderColor = "red";
                return false;
            }
            
             if (document.getElementById('<%=ddlRole.ClientID%>').value == "0") {
                document.getElementById("lblRole").style.display = "block";
                document.getElementById('<%=ddlRole.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=ddlRole.ClientID%>').style.borderColor = "red";
                return false;
            }
             if (document.getElementById('<%=txtUserName.ClientID%>').value == "") {
                document.getElementById("lblUserName").style.display = "block";
                document.getElementById('<%=txtUserName.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtUserName.ClientID%>').style.borderColor = "red";
                return false;
            }
             if (document.getElementById('<%=txtPassword.ClientID%>').value == "") {
                document.getElementById("lblPassword").style.display = "block";
                document.getElementById('<%=txtPassword.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtPassword.ClientID%>').style.borderColor = "red";
                return false;
            }
             if (document.getElementById('<%=txtConfirmPass.ClientID%>').value == "") {
                document.getElementById("lblConfirmPass").style.display = "block";
                document.getElementById('<%=txtConfirmPass.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtConfirmPass.ClientID%>').style.borderColor = "red";
                return false;
            }
             if (document.getElementById('<%=txtPassword.ClientID%>').value != document.getElementById('<%=txtConfirmPass.ClientID%>').value) {
                document.getElementById("lblPassTryAgain").style.display = "block";
                document.getElementById('<%=txtConfirmPass.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtConfirmPass.ClientID%>').style.borderColor = "red";
                return false;
            }
        }

        function hideFirstNamelbl()
        {
            document.getElementById("lblFirstName").style.display = "none"
            document.getElementById('<%=txtFirstName.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtFirstName.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideEmaillbl()
        {
            document.getElementById("lblEmail").style.display = "none"
            document.getElementById("lblEmail1").style.display = "none"
            document.getElementById('<%=txtEmail.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtEmail.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideMobilelbl()
        {
            document.getElementById("lblMobile").style.display = "none"
            document.getElementById("lblMobile1").style.display = "none"
            document.getElementById('<%=txtMobile.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtMobile.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideRolelbl()
        {
            document.getElementById("lblRole").style.display = "none"
            document.getElementById('<%=ddlRole.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=ddlRole.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideUserNamelbl()
        {
            document.getElementById("lblUserName").style.display = "none"
            document.getElementById('<%=txtUserName.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtUserName.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hidePasswordlbl()
        {
            document.getElementById("lblPassword").style.display = "none"
            document.getElementById("lblPassTryAgain").style.display = "none"
            document.getElementById('<%=txtPassword.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtPassword.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideConfirmPasslbl()
        {
            document.getElementById("lblConfirmPass").style.display = "none"            
            document.getElementById("lblPassTryAgain").style.display = "none"
            document.getElementById('<%=txtConfirmPass.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtConfirmPass.ClientID%>').style.borderColor = "#e7e7e7";
        }
        

        function isDecimalNumber(evt, c) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            var dot1 = c.value.indexOf('.');
            var dot2 = c.value.lastIndexOf('.');

            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else if (charCode == 46 && (dot1 == dot2) && dot1 != -1 && dot2 != -1)
                return false;

            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bread crumb -->
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">
                <asp:Label ID="lblNew" runat="server" Text="Add New Delivery-Boy" Visible="false"></asp:Label>
                <asp:Label ID="lblOld" runat="server" Text="Edit Delivery-Boy" Visible="false"></asp:Label>
            </h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item"><a href="ManageDeliveryBoy.aspx">Manage Delivery-Boy</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">Add Delivery-Boy</a></li>
            </ol>
        </div>
    </div>
    <!-- End Bread crumb -->
    <!-- Container fluid  -->
    <div class="container-fluid">
        <!-- Start Page Content -->
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-body">
                        <div class="form-validation">                           
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtFirstName">First Name<span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" id="txtFirstName" type="text" name="txtFirstName" class="form-control" onclick="hideFirstNamelbl()">
                                    <label id="lblFirstName" class="error">Please enter your First Name</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtLastName">Last Name<span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtLastName" class="form-control" name="txtLastName">
                                    <label id="lblLastName" class="error">Please enter your Last Name</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtMobile">Mobile Number <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtMobile" class="form-control" name="txtMobile" onclick="hideMobilelbl()" onkeypress='javascript:return isDecimalNumber(event,this);' maxlength="10">
                                    <label id="lblMobile" class="error">Please enter your Mobile Number</label>
                                    <label id="lblMobile1" class="error">Please enter a valid mobile number</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtEmail">Email Address </label>
                                <div class="col-lg-6">
                                    <input runat="server" type="email" id="txtEmail" class="form-control" name="txtEmail">
                                    <label id="lblEmail1" class="error">Please provide a valid email address</label>
                                </div>
                            </div>
                            <div class="form-group row" style="margin-bottom: 20px">
                                <label class="col-lg-4 col-form-label" for="ddlRole">Role <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <asp:DropDownList ID="ddlRole" runat="server" class="form-control" ForeColor="#888888" onclick="hideRolelbl();">
                                        <asp:ListItem Text="--- Select Role ---" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Administrator" Value="admin"></asp:ListItem>
                                        <asp:ListItem Text="delivery Person" Value="saler"></asp:ListItem>
                                    </asp:DropDownList>
                                    <label id="lblRole" class="error">Please select your Role</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtUserName">User Name <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtUserName" class="form-control" name="txtUserName" onclick="hideUserNamelbl()">
                                    <label id="lblUserName" class="error">Please enter your User Name</label>
                                </div>
                            </div>      
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtPassword">Password <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtPassword" class="form-control" name="txtPassword" onclick="hidePasswordlbl()">
                                    <label id="lblPassword" class="error">Please enter your User Name</label>
                                </div>
                            </div>     
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtConfirmPass">Confirm Password <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtConfirmPass" class="form-control" name="txtConfirmPass" onclick="hideConfirmPasslbl()">
                                    <label id="lblConfirmPass" class="error">Please Confirm your Password</label>
                                    <label id="lblPassTryAgain" class="error">Password and Confirm Password do not match, Please try again.</label>
                                </div>
                            </div>     
                            <div class="form-group row">
                                <div class="col-lg-8 ml-auto">
                                    <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return validateForm()" Width="17%"/>
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn  btn-secondary" OnClick="btnCancel_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End PAge Content -->
    </div>
    <!-- End Container fluid  -->
</asp:Content>

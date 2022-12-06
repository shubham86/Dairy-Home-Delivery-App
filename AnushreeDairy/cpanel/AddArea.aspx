<%@ Page Title="" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="AddArea.aspx.cs" Inherits="AnushreeDairy.cpanel.AddArea" %>
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
            if (document.getElementById('<%=txtAreName.ClientID%>').value == "") {
                document.getElementById("lblArea").style.display = "block";
                document.getElementById('<%=txtAreName.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtAreName.ClientID%>').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=txtCity.ClientID%>').value == "") {
                document.getElementById("lblCity").style.display = "block";
                document.getElementById('<%=txtCity.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtCity.ClientID%>').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=txtPincode.ClientID%>').value == "") {
                document.getElementById("lblPincode").style.display = "block";
                document.getElementById('<%=txtPincode.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtPincode.ClientID%>').style.borderColor = "red";
                return false;
            }
        }

        function hideArealbl()
        {
            document.getElementById("lblArea").style.display = "none"
            document.getElementById('<%=txtAreName.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtAreName.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideCitylbl()
        {
            document.getElementById("lblCity").style.display = "none"
            document.getElementById('<%=txtCity.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtCity.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hidePincodelbl()
        {
            document.getElementById("lblPincode").style.display = "none"
            document.getElementById('<%=txtPincode.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtPincode.ClientID%>').style.borderColor = "#e7e7e7";
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
                <asp:Label ID="lblNew" runat="server" Text="Add New Area" Visible="false"></asp:Label>
                <asp:Label ID="lblOld" runat="server" Text="Edit Area" Visible="false"></asp:Label>
            </h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item"><a href="ManageArea.aspx">Manage Area</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">Add Area</a></li>
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
                                <label class="col-lg-4 col-form-label" for="txtAreName">Area Name<span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" id="txtAreName" type="text" name="txtAreName" class="form-control" onclick="hideArealbl()" placeholder="e.g. - Nanded city">
                                    <label id="lblArea" class="error">Please enter area name</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtCity">Name of City <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtCity" class="form-control" name="txtCity" onclick="hideCitylbl()" placeholder="e.g - Pune">
                                    <label id="lblCity" class="error">Please enter city name</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtPincode">Pincode <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtPincode" class="form-control" name="txtPincode" onclick="hidePincodelbl()" placeholder="e.g - 400 100" maxlength="6"  onkeypress='javascript:return isDecimalNumber(event,this);'>
                                    <label id="lblPincode" class="error">Please enter pincode</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label">Is Active</label>
                                <div class="col-lg-8">
                                    <label class="css-control css-control-primary css-checkbox" for="chbxIsActive">
                                        <input runat="server" id="chbxIsActive" type="checkbox" class="css-control-input" name="chbxIsActive" value="1">
                                    </label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-lg-8 ml-auto">
                                    <asp:Button ID="Button1" runat="server" Text="Save" class="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return validateForm()"/>
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

<%@ Page Title="" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="AddProductPrice.aspx.cs" Inherits="AnushreeDairy.cpanel.AddProductPriceaspx" %>
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
            if (document.getElementById('<%=ddlProduct.ClientID%>').value == "0") {
                document.getElementById("lblProduct").style.display = "block";
                document.getElementById('<%=ddlProduct.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=ddlProduct.ClientID%>').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=txtPrice.ClientID%>').value == "") {
                document.getElementById("lblPrice").style.display = "block";
                document.getElementById('<%=txtPrice.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtPrice.ClientID%>').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=txtDate.ClientID%>').value == "") {
                document.getElementById("lblDate").style.display = "block";
                document.getElementById('<%=txtDate.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtDate.ClientID%>').style.borderColor = "red";
                return false;
            }
        }

        function hideProductlbl()
        {
            document.getElementById("lblProduct").style.display = "none"
            document.getElementById('<%=ddlProduct.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=ddlProduct.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hidePricelbl()
        {
            document.getElementById("lblPrice").style.display = "none"
            document.getElementById('<%=txtPrice.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtPrice.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hidePincodelbl()
        {
            document.getElementById("lblDate").style.display = "none"
            document.getElementById('<%=txtDate.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtDate.ClientID%>').style.borderColor = "#e7e7e7";
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
                <asp:Label ID="lblNew" runat="server" Text="Add New Product Price" Visible="false"></asp:Label>
                <asp:Label ID="lblOld" runat="server" Text="Edit Product Price" Visible="false"></asp:Label>
            </h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item"><a href="ManageProductPrice.aspx">Manage Product Price</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">Add Product Price</a></li>
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
                            <div class="form-group row" style="margin-bottom: 20px">
                                <label class="col-lg-4 col-form-label" for="ddlProduct">Role <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <asp:DropDownList ID="ddlProduct" runat="server" class="form-control" ForeColor="#888888" onclick="hideProductlbl();"></asp:DropDownList>
                                    <label id="lblProduct" class="error">Please select Product</label>
                                </div>
                            </div>                            
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtPrice">Product Price <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input id="txtPrice" runat="server" name="txtPrice" class="form-control" onclick="hidePricelbl()" placeholder="Rs."  onkeypress='javascript:return isDecimalNumber(event,this);'/>
                                    <label id="lblPrice" class="error">Please enter product price</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtDate">Date of Declare<sub> (mm/dd/yyyy)</sub> <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" type="date" id="txtDate" class="form-control" name="txtDate" onclick="hideDatelbl()">
                                    <label id="lblDate" class="error">Please select date of rate declaration</label>
                                </div>
                            </div>
                            <%--<div class="form-group row">
                                <label class="col-lg-4 col-form-label">Is Active</label>
                                <div class="col-lg-8">
                                    <label class="css-control css-control-primary css-checkbox" for="chbxIsActive">
                                        <input runat="server" id="chbxIsActive" type="checkbox" class="css-control-input" name="chbxIsActive" value="1">
                                    </label>
                                </div>
                            </div>--%>
                            <div class="form-group row">
                                <div class="col-lg-8 ml-auto">
                                    <asp:Button ID="Button1" runat="server" Text="Save" class="btn btn-primary" OnClientClick="return validateForm()" OnClick="btnSave_Click"/>
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


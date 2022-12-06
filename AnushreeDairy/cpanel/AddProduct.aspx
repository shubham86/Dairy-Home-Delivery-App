<%@ Page Title="Add Product" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="AnushreeDairy.cpanel.AddProduct" %>
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
            if (document.getElementById('<%=txtProductName.ClientID%>').value == "") {
                document.getElementById("lblProductName").style.display = "block";
                document.getElementById('<%=txtProductName.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtProductName.ClientID%>').style.borderColor = "red";
                return false;
            }
        }

        function hideNamebl()
        {
            document.getElementById("lblProductName").style.display = "none"
            document.getElementById('<%=txtProductName.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtProductName.ClientID%>').style.borderColor = "#e7e7e7";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bread crumb -->
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">
                <asp:Label ID="lblNew" runat="server" Text="Add New Product" Visible="false"></asp:Label>
                <asp:Label ID="lblOld" runat="server" Text="Edit Product" Visible="false"></asp:Label>
            </h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item"><a href="ManageProduct.aspx">Manage Product</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">Add Product</a></li>
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
                                <label class="col-lg-4 col-form-label" for="txtProductName">Product Name<span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input id="txtProductName" runat="server" type="text" name="txtProductName" class="form-control" onclick="hideNamelbl()"/>
                                    <label id="lblProductName" class="error">Please enter product name</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtProductDesc">Product Description</label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtProductDesc" class="form-control" name="txtProductDesc">
                                    <label id="lblProductDesc" class="error">Please enter product description</label>
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
                                    <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return validateForm()"/>
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

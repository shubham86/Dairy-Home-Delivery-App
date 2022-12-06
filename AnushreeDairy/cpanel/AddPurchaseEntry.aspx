<%@ Page Title="Add Purchase Entry" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="AddPurchaseEntry.aspx.cs" Inherits="AnushreeDairy.cpanel.AddPurchaseEntry" %>
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
            if (document.getElementById('<%=txtQuantity.ClientID%>').value == "") {
                document.getElementById("lblQuantity").style.display = "block";
                document.getElementById('<%=txtQuantity.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtQuantity.ClientID%>').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=txtRate.ClientID%>').value == "") {
                document.getElementById("lblRate").style.display = "block";
                document.getElementById('<%=txtRate.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtRate.ClientID%>').style.borderColor = "red";
                return false;
            }
        }

        function hideProductlbl()
        {
            document.getElementById("lblProduct").style.display = "none"
            document.getElementById('<%=ddlProduct.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=ddlProduct.ClientID%>').style.borderColor = "#e7e7e7";
        }

        function isDecimalNumber(evt, c) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            var dot1 = c.value.indexOf('.');
            var dot2 = c.value.lastIndexOf('.');

            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else if (charCode == 46 && (dot1 == dot2) && dot1 != -1 && dot2 != -1)
                return false;

            document.getElementById("lblQuantity").style.display = "none"
            document.getElementById('<%=txtQuantity.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtQuantity.ClientID%>').style.borderColor = "#e7e7e7";

            document.getElementById("lblRate").style.display = "none"
            document.getElementById('<%=txtRate.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtRate.ClientID%>').style.borderColor = "#e7e7e7";

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
                <li class="breadcrumb-item"><a href="ManagePurchase.aspx">Manage Stock</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">Add Purchase Entry</a></li>
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
                                <label class="col-lg-4 col-form-label" for="ddlRole">Product<span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <asp:DropDownList ID="ddlProduct" runat="server" class="form-control" ForeColor="#888888" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged" AutoPostBack="true" onclick="hideProductlbl();">                                        
                                    </asp:DropDownList>
                                    <label id="lblProduct" class="error">Please select product</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtPincode">Old Stock</label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtOldStock" class="form-control" name="txtOldStock" readonly="readonly">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtQuantity">Quantity <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtQuantity" class="form-control" name="txtQuantity" placeholder="in Liters" onkeypress='javascript:return isDecimalNumber(event,this);'>
                                    <label id="lblQuantity" class="error">Please enter Quantity</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="txtRate">Rate per Liter <span class="text-danger">*</span></label>
                                <div class="col-lg-6">
                                    <input runat="server" type="text" id="txtRate" class="form-control" name="txtRate" placeholder="Rs. per Liter" onkeypress='javascript:return isDecimalNumber(event,this);'>
                                    <label id="lblRate" class="error">Please enter rate per liter</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-lg-8 ml-auto">
                                    <asp:Button ID="Button1" runat="server" Text="Save" class="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return validateForm()" Width="15%"/>
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn  btn-secondary" OnClick="btnCancel_Click"/>
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

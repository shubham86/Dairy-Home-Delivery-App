<%@ Page Title="Delivery Entry" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="AddDeliveryEntry.aspx.cs" Inherits="AnushreeDairy.cpanel.AddDeliveryEntry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"> 
    <link rel="stylesheet" href="css/ddlSearch.css"/>
    <style>
        .error {
            color: #ef5350;
            font-size: 12px;
            display: none;
            margin-bottom: 0;
        }

        select {
            text-align: center;
            text-align-last: center;
        }

        .ddl-center {
            text-align: center;
        }

        @media only screen and (max-width: 400px) {
            .btn-center {
                margin-left: 33%;
            }
        }

        @media only screen and (min-width: 700px) {
            .btn-center {
                margin-left: 7%;
            }

            .card-body {
                padding: 0 100px;
            }
        }

        .input-container {
            position: relative;
        }

            .input-container input {
                width: 100%;
            }

            .input-container .unit {
                position: absolute;
                display: block;
                top: 11px;
                right: 7px;
                color: #888888;
                padding-left: 5px;
                width: 45px;
            }


        /*search ddl*/
        .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
            width: 100%;
        }

        .bootstrap-select.btn-group .btn .filter-option {
            display: inline-block;
            overflow: hidden;
            width: 100%;
            text-align: center;
        }

        .btn-group > .btn:first-child {
            margin-left: 0;
            color: #888888;
            height: 38px;
            border-radius: 0px;
        }

        .caret {
            display: none;
        }

        .bs-searchbox input.form-control {
            margin-bottom: 0;
            width: 100%;
            height: 30px;
            font-size:12px
        }

        .dropdown-menu li {
            font-size: 14px;
            padding: 0;
        }
    </style>
    
    <script>
        function getDate() {
            var cookieDate = getCookie("date");
            if (cookieDate != "") {
                document.getElementById("Date").value = cookieDate;
                document.getElementById('<%=txtDate.ClientID%>').value = cookieDate;
            }
            else {
                var today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth() + 1; //January is 0!
                var yyyy = today.getFullYear();

                if (dd < 10) {
                    dd = '0' + dd
                }

                if (mm < 10) {
                    mm = '0' + mm
                }

                today = yyyy + '-' + mm + '-' + dd;
                console.log(today);
                document.getElementById("Date").value = today;
                document.getElementById('<%=txtDate.ClientID%>').value = today;
            }
        }

        window.onload = function () {
            getDate();
        };

        function changeDate(e) {

            var d = new Date();
            d = new Date(d.getTime() + 1000 * 60);
            document.cookie = 'date' + '=' + e.target.value + '; expires=' + d.toGMTString() + '; path=/';

            document.getElementById('<%=txtDate.ClientID%>').value = e.target.value;
        }

        function getCookie(cname) {
            var name = cname + "=",
                ca = document.cookie.split(';'),
                i,
                c,
                ca_length = ca.length;
            for (i = 0; i < ca_length; i += 1) {
                c = ca[i];
                while (c.charAt(0) === ' ') {
                    c = c.substring(1);
                }
                if (c.indexOf(name) !== -1) {
                    return c.substring(name.length, c.length);
                }
            }
            return "";
        }

        function validateForm() {
            if (document.getElementById('Date').value == "") {
                document.getElementById("lblDate").style.display = "block";
                document.getElementById('Date').style.marginBottom = "10px";
                document.getElementById('Date').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=ddlID.ClientID%>').value == "0" && document.getElementById('<%=ddlName.ClientID%>').value == "0") {
                document.getElementById("lblName").style.display = "block";
                document.getElementById('<%=ddlName.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=ddlName.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=ddlID.ClientID%>').style.borderColor = "red";
                return false;
            }
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
        }

        function hideNamelbl() {
            document.getElementById("lblName").style.display = "none"
            document.getElementById('<%=ddlID.ClientID%>').style.borderColor = "#e7e7e7";

            document.getElementById('<%=ddlName.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=ddlName.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideProductlbl() {
            document.getElementById("lblProduct").style.display = "none"
            document.getElementById('<%=ddlProduct.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=ddlProduct.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideQuantitylbl() {
            document.getElementById("lblQuantity").style.display = "none"
            document.getElementById('<%=txtQuantity.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtQuantity.ClientID%>').style.borderColor = "#e7e7e7";
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

        window.setTimeout(function () {
            $(".alert").fadeTo(500, 0).slideUp(500, function () {
                $(this).remove();
            });
        }, 6000);

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">  
    <!-- Bread crumb -->
    <div class="row page-titles" style="margin:0">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">Delivery Entry</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard2.aspx">Home</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">Delivery Entry</a></li>
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
                    <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Visible="false">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <asp:Label ID="lblalert" runat="server" Text="" Font-Bold="true"></asp:Label>
                    </asp:Panel>
                    <div class="card-body">
                        <div class="form-validation" style="margin-top: 20px">
                            <div class="form-group row ddl">
                                <div class="col-lg-12">
                                    <input type="date" id="Date" class="form-control" style="color: #888888; text-align: center" onchange="changeDate(event)" />
                                    <label id="lblDate" class="error">Please select date</label>
                                </div>
                            </div>
                            <div class="form-group row ddl">
                                <div class="col-lg-12">
                                    <asp:DropDownList ID="ddlID" runat="server" class="selectpicker" data-show-subtext="true" data-live-search="true" onclick="hideNamelbl();" OnSelectedIndexChanged="ddlID_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-lg-12">
                                    <asp:DropDownList ID="ddlName" runat="server" class="selectpicker" data-show-subtext="true" data-live-search="true" onclick="hideNamelbl();" OnSelectedIndexChanged="ddlName_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <label id="lblName" class="error" style="margin-left: auto; margin-right: auto; margin-top: 10px">Please enter eithe customer ID or Name</label>
                            </div>
                            <div class="form-group row">
                                <div class="col-lg-12">
                                    <table class="col-lg-12">
                                        <tr>
                                            <td width="50%">
                                                <asp:DropDownList ID="ddlProduct" runat="server" class="form-control" ForeColor="#888888" onclick="hideProductlbl();" Height="42" Font-Size="14px"></asp:DropDownList>
                                            </td>
                                            <td style="width: 10%"></td>
                                            <td width="40%" class="input-container">
                                                <input runat="server" type="tel" id="txtQuantity" class="form-control" name="txtQuantity" onclick="hideQuantitylbl()" maxlength="5" onkeypress='javascript:return isDecimalNumber(event,this);'>
                                                <span class="unit" style="font-size: 14px">Liters</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="text-align: center">
                                                <label id="lblProduct" class="error">Please select product</label>
                                                <label id="lblQuantity" class="error">Please enter quantity</label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-lg-8 ml-auto">
                                    <asp:Button ID="btnSave" runat="server" Text="Deliver" class="btn btn-primary btn-center" OnClientClick="return validateForm()" OnClick="btnSave_Click" Width="35%" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<asp:Label ID="txtDate" runat="server" Text="" ForeColor="red" Font-Size="15px"></asp:Label>--%>
        <input type="text" id="txtDate" runat="server" readonly="readonly" style="border:0px;background-color:transparent;font-size:1px;height:1px;color:transparent" /> 
        <!-- End PAge Content -->
    </div>
    <!-- End Container fluid  -->    
  <script src="js/bootstrap.min.js"></script>
  <script src="js/ddlsearch_jquery.min.js"></script>
  <script src="js/bootstrap-select.min.js"></script>
</asp:Content>

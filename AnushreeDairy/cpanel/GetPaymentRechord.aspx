<%@ Page Title="Payment Entry" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="GetPaymentRechord.aspx.cs" Inherits="AnushreeDairy.cpanel.GetPaymentRechord" %>
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
                margin-left: 30%
            }
        }

        @media only screen and (min-width: 700px) {
            .btn-center {
                margin-left: 40%
            }

            .card-body {
                padding: 0 100px;
            }
        }

        /*search ddl*/
        .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
            width: 100%;
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

        .bootstrap-select.btn-group .btn .filter-option {
            display: inline-block;
            overflow: hidden;
            width: 100%;
            text-align: center;
        }
    </style>
    <script>
         window.onload = function () {
            if (getCookie("date") != "") {
                document.cookie = 'date' + '=;expires=Thu, 01 Jan 1970 00:00:01 GMT;path=/';
            }
        };
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
            if (document.getElementById('<%=ddlID.ClientID%>').value == "0" && document.getElementById('<%=ddlName.ClientID%>').value == "0") {
                document.getElementById("lblName").style.display = "block";
                document.getElementById('<%=ddlName.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=ddlName.ClientID%>').style.borderColor = "red";
                document.getElementById('<%=ddlID.ClientID%>').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=ddlMonth.ClientID%>').value == "0") {
                document.getElementById("lblMonth").style.display = "block";
                document.getElementById('<%=ddlMonth.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=ddlMonth.ClientID%>').style.borderColor = "red";
                return false;
            }
            if (document.getElementById('<%=ddlYear.ClientID%>').value == "--Year--") {
                document.getElementById("lblYear").style.display = "block";
                document.getElementById('<%=ddlYear.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=ddlYear.ClientID%>').style.borderColor = "red";
                return false;
            }
        }

        function hideNamelbl() {
            document.getElementById("lblName").style.display = "none"
            document.getElementById('<%=ddlID.ClientID%>').style.borderColor = "#e7e7e7";

            document.getElementById('<%=ddlName.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=ddlName.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideMonthlbl() {
            document.getElementById("lblMonth").style.display = "none"
            document.getElementById('<%=ddlMonth.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=ddlMonth.ClientID%>').style.borderColor = "#e7e7e7";
        }
        function hideYearlbl() {
            document.getElementById("lblYear").style.display = "none"
            document.getElementById('<%=ddlYear.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=ddlYear.ClientID%>').style.borderColor = "#e7e7e7";
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
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">Payment Entry</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard2.aspx">Home</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">Get Payment Rechord</a></li>
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
                        <div class="form-validation" style="margin-top:20px">
                            <div class="form-group row ddl">                                
                                <div class="col-lg-12">
                                    <asp:DropDownList ID="ddlID" runat="server" class="selectpicker" data-show-subtext="true" data-live-search="true" onclick="hideNamelbl();" OnSelectedIndexChanged="ddlID_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>                                    
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-lg-12">
                                    <asp:DropDownList ID="ddlName" runat="server" class="selectpicker" data-show-subtext="true" data-live-search="true" onclick="hideNamelbl();" OnSelectedIndexChanged="ddlName_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <label id="lblName" class="error">Please enter eithe customer ID or Name</label>
                            </div>
                            <div class="form-group row">                                  
                                <div class="col-lg-12">
                                    <table class="col-lg-12">
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlMonth" runat="server" class="form-control ddl-center" ForeColor="#888888" Font-Size="14px" onclick="hideMonthlbl();">
                                                    <asp:ListItem Value="0" Text="---Month---"></asp:ListItem>
                                                    <asp:ListItem Value="01" Text="january"></asp:ListItem>
                                                    <asp:ListItem Value="02" Text="February"></asp:ListItem>
                                                    <asp:ListItem Value="03" Text="March"></asp:ListItem>
                                                    <asp:ListItem Value="04" Text="April"></asp:ListItem>
                                                    <asp:ListItem Value="05" Text="May"></asp:ListItem>
                                                    <asp:ListItem Value="06" Text="June"></asp:ListItem>
                                                    <asp:ListItem Value="07" Text="July"></asp:ListItem>
                                                    <asp:ListItem Value="08" Text="August"></asp:ListItem>
                                                    <asp:ListItem Value="09" Text="September"></asp:ListItem>
                                                    <asp:ListItem Value="10" Text="October"></asp:ListItem>
                                                    <asp:ListItem Value="11" Text="November"></asp:ListItem>
                                                    <asp:ListItem Value="12" Text="December"></asp:ListItem>
                                                </asp:DropDownList>                                                
                                            </td>
                                            <td style="width:10%"></td>
                                            <td>
                                                <asp:DropDownList ID="ddlYear" runat="server" class="form-control" Font-Size="14px" ForeColor="#888888" onclick="hideYearlbl();"></asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="text-align:center">
                                                <label id="lblMonth" class="error">Please select Month</label>
                                                <label id="lblYear" class="error">Please select Year</label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-lg-8 btn-center">
                                    <asp:Button ID="btnSave" runat="server" Text="Get Rechord" class="btn btn-primary" OnClientClick="return validateForm()" OnClick="btnSave_Click"/>
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
    
  <script src="js/bootstrap.min.js"></script>
  <script src="js/ddlsearch_jquery.min.js"></script>
  <script src="js/bootstrap-select.min.js"></script>
</asp:Content>


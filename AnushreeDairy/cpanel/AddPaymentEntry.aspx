<%@ Page Title="Monthly Delivery List" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="AddPaymentEntry.aspx.cs" Inherits="AnushreeDairy.cpanel.AddPaymentEntry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">   
    <style>
        .error {
            color: #ef5350;
            font-size: 12px;
            display: none;
            margin-bottom: 0;
        }

        tbody tr td {
            color: #777777;
        }

        @media only screen and (max-width: 400px) {
            .page-titles {
                display: none;
            }
            table {
                font-size:14px;
            }
        }

        #myTable > thead > tr > th {
            line-height: 22px;
            vertical-align: central;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            line-height: 22px;
            vertical-align: middle;
        }

        .dataTables_filter {
            float: right;
            margin-top: 0;
            width: 50%;
        }

        .dataTables_length {
            margin-top: 0;
            width: 50%;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button {
            padding: 0.2em 1em;
        }
                
        .table {
            margin-bottom: 10px;
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
                top: 4px;
                right: -7px;
                color: #888888;
                padding-left: 5px;
                width: 45px;
            }

        .btn {
            padding: 5px;
        }
    </style>  
    <script>
        function validateForm() {   
            if (document.getElementById('<%=txtRecivedPayment.ClientID%>').value == "") {                   
                
                document.getElementById("lblPayment").style.display = "block";
                document.getElementById('<%=txtRecivedPayment.ClientID%>').style.marginBottom = "10px";
                document.getElementById('<%=txtRecivedPayment.ClientID%>').style.borderColor = "red";
                return false;
            }
        }
       
        function hideQuantitylbl() {
            document.getElementById("lblPayment").style.display = "none"
            document.getElementById('<%=txtRecivedPayment.ClientID%>').style.marginBottom = "0px";
            document.getElementById('<%=txtRecivedPayment.ClientID%>').style.borderColor = "#e7e7e7";
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
            <h3 class="text-primary">Monthly Delivery List</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard2.aspx">Home</a></li>
                <li class="breadcrumb-item"><a href="GetPaymentRechord.aspx">Get Payment Rechord</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0)">Add Payment</a></li>
            </ol>
        </div>
    </div>
    <!-- End Bread crumb -->
    <!-- Container fluid  -->
    <div class="container-fluid">
        <!-- Start Page Content -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title"><asp:Label ID="lblCustomerName" runat="server"></asp:Label></h4>
                        <h6 class="card-subtitle"><asp:Label ID="lblMonthYear" runat="server"></asp:Label></h6>
                    </div>

                    <table width="100%" style="line-height: 30px;" align="center">
                        <tr>
                            <td width="55%">Balance Payment</td>
                            <td width="5%">=</td>
                            <td width="40%">
                                <asp:Label ID="lblBalancePayment" runat="server" Text="0.00"></asp:Label>&nbsp Rs.
                            </td>
                        </tr>
                        <tr>
                            <td style="border-bottom:solid 1px #dddddd">Current Payment</td>
                            <td style="border-bottom:solid 1px #dddddd">=</td>
                            <td style="border-bottom:solid 1px #dddddd">
                                <asp:Label ID="lblCurrentPayment" runat="server" Text="0.00"></asp:Label>&nbsp Rs.
                            </td>
                        </tr>
                        <tr>
                            <td>Total Payment</td>
                            <td>=</td>
                            <td>
                                <asp:Label ID="lblTotalPayment" runat="server" Font-Bold="true" Text="0.00"></asp:Label>&nbsp Rs.
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 15px"></td>
                        </tr>
                        <tr>
                            <td  class="input-container">
                                <input runat="server" type="tel" id="txtRecivedPayment" class="form-control" name="txtRecivedPayment" onclick="hidePaymentlbl()" maxlength="7" onkeypress='javascript:return isDecimalNumber(event,this);' style="height: 30px">
                                <span class="unit">Rs.</span>
                                <label id="lblPayment" class="error">Please enter paid amount</label>
                            </td>
                            <td></td>
                            <td>
                                <asp:Button ID="btnSave" runat="server" Text="Paid" class="btn btn-primary btn-center" OnClientClick="return validateForm()" OnClick="btnSave_Click" Width="80%" /></td>
                        </tr>
                    </table>
                    <hr />
                    <div class="panel-heading">
                        <h6 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Monthly Delivery Details</a>
                        </h6>
                    </div>
                    <div id="collapse1" class="panel-collapse collapse">
                        <div class="table-responsive m-t-0">
                            <asp:Repeater ID="rptrCustomer" runat="server">
                                <HeaderTemplate>
                                    <table id="tblCustomer" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th style="text-align: center;color:#004c82">Sr.No</th>
                                                <th style="text-align: center;">Date</th>
                                                <th style="text-align: center;">Quantity</th>
                                                <th style="text-align: center;">Amount</th>
                                                <%--<th style="text-align: center;vertical-align:middle">Delivery Boy</th>--%>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td style="text-align: center; line-height: 22px;color:#004c82">
                                            <asp:Label ID="lblno" runat="server" Text='<%#Container.ItemIndex+1 %>'></asp:Label>
                                        </td>
                                        <td style="text-align: center; line-height: 22px">
                                            <asp:Label ID="lblDate" runat="server" Text='<%#Eval("deliveryDate") %>'></asp:Label>
                                        </td>
                                        <td style="text-align: center; line-height: 22px">
                                            <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("milkQuatity") %>'></asp:Label>
                                        </td>
                                        <td style="text-align: center; line-height: 22px">
                                            <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("amount") %>'></asp:Label>
                                        </td>
                                        <%--<td style="text-align: center;">
                                        <asp:Label ID="lblArea" runat="server" Text='<%#Eval("deliveryBoy") %>'></asp:Label>
                                    </td>--%>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th colspan="2" style="text-align:center">Total</th>
                                            <th style="text-align:center">
                                                <asp:Label ID="lblTotalQuantity" runat="server"></asp:Label>
                                            </th>
                                            <th style="text-align:center">
                                                <asp:Label ID="lblTotalAmount" runat="server"></asp:Label>
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

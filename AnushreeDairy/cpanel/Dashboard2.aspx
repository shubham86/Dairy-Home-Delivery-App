<%@ Page Title="Dashboard" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="Dashboard2.aspx.cs" Inherits="AnushreeDairy.cpanel.Dashboard2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .widget-ten p {
            color: #000000 !important;
            opacity: 10;
        }

        .btn-dark {
            color: #000;
            background-color: #343a4033;
            border-color: #343a40;
            font-weight:bold;
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bread crumb -->
    <div class="row page-titles" style="margin-bottom: 25px">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">Dashboard</h3>
        </div>
        <%--<div class="col-md-7 align-self-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                        <li class="breadcrumb-item active">Dashboard</li>
                    </ol>
                </div>--%>
    </div>
    <!-- End Bread crumb -->
    <!-- Container fluid  -->
    <div class="container-fluid" style="margin-bottom: 25px">
        <!-- Start Page Content -->
        <div class="row">
            <div class="col-md-6">
                <div class="card" style="margin: 0 0 25px 0; background-color: #ffffff8c">
                    <div class="media widget-ten">
                        <div class="media-left meida media-middle">
                            <span>
                                <img src="images/deliverd.png" width="80" height="70" /></span>
                        </div>
                        <div class="media-body media-text-right">
                            <h2 class="color-dark font-weight-bold p-r-3">
                                <asp:Label ID="lblDeliverd" runat="server" Text="0" Font-Size="30px" Font-Bold="true" ForeColor="#545a64"></asp:Label></h2>
                            <p class="m-b-0" style="font-size: 18px">Complete Delivery</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card" style="margin: 0 0 25px 0; background-color: #ffffff8c">
                    <div class="media widget-ten">
                        <div class="media-left meida media-middle">
                            <span>
                                <img src="images/pending.png" width="80" height="70" /></span>
                        </div>
                        <div class="media-body media-text-right">
                            <h2 class="color-dark font-weight-bold p-r-3">
                                <asp:Label ID="lblPending" runat="server" Text="0" Font-Size="30px" Font-Bold="true" ForeColor="#545a64"></asp:Label></h2>
                            <p class="m-b-0" style="font-size: 18px">Pending Delivery</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 m-b-10">
                <table align="center" width="100%">
                    <tr>
                        <td width="48%"><a href="DailyDeliveryList.aspx" class="btn btn-dark" style="width: 100%">Delivery List</a></td>
                        <td style="width: 4%"></td>
                        <td width="48%"><a href="AddDeliveryEntry.aspx" class="btn btn-dark" style="width: 100%">Delivery Entry</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table align="center" width="100%">
                    <tr>
                        <td width="48%"><a href="PaymentList.aspx" class="btn btn-dark" style="width: 100%">Payment List</a></td>
                        <td style="width: 4%"></td>
                        <td width="48%"><a href="GetPaymentRechord.aspx" class="btn btn-dark" style="width: 100%">Payment Entry</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- End PAge Content -->

        <!-- column -->
        <div class="row">
            <div class="col-lg-2"></div>
            <div class="col-lg-4">
                <div class="card" style="margin: 25px 0 25px 0; background-color: #ffffff8c">
                    <div class="card-body browser">
                        <h2 style="text-align: center">
                            <i class="fa fa-inr p-r-10" style="font-size: 18px; color: #213c02"></i>
                            <asp:Label ID="lblCollection" runat="server" Text="0.00" Font-Size="24px" Font-Bold="true" ForeColor="#545a64"></asp:Label>
                        </h2>
                        <p class="f-w-600" style="color:#79909b">
                            Total Payment Collection 
                            <span class="pull-right">
                                <asp:Label ID="lblCollectionPercentage" runat="server" Text="0"></asp:Label>&nbsp%
                            </span>
                        </p>
                        <div class="progress ">
                            <div id="progressBar1" runat="server" role="progressbar" style="width: 0%; height: 8px; background-color:#213c02;" class="progress-bar wow animated progress-animated"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card"  style="margin: 25px 0 25px 0; background-color: #ffffff8c">
                    <div class="card-body browser">
                        <h2 style="text-align: center">
                            <i class="fa fa-inr p-r-10" style="font-size: 18px; color: #660000"></i>
                            <asp:Label ID="lblBalance" runat="server" Text="0.00" Font-Size="24px" Font-Bold="true" ForeColor="#545a64"></asp:Label>
                        </h2>
                        <p class="f-w-600" style="color:#79909b">
                            Balance Payment Collection 
                            <span class="pull-right">
                                <asp:Label ID="lblBalancePercentage" runat="server" Text="0"></asp:Label>&nbsp%
                            </span>
                        </p>
                        <div class="progress ">
                            <div id="progressBar2" runat="server" role="progressbar" style="width: 0%; height: 8px;background-color:#660000" class="progress-bar wow animated progress-animated"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-2"></div>
        </div>
        <!-- column -->
    </div>
    <!-- End Container fluid  -->
</asp:Content>

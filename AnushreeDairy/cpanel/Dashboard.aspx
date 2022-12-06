<%@ Page Title="Dashboard" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="AnushreeDairy.cpanel.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bread crumb -->
    <div class="row page-titles" style="margin: 0px 0 17px">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">Dashboard</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
            </ol>
        </div>
    </div>
    <!-- End Bread crumb -->
    <div class="container-fluid" style="padding: 0 30px 0px;">
        <div class="row">
            <span style="font-size: 12px;">Note : Below details are of previous month</span>
        </div>
    </div>
    <!-- Container fluid  -->
    <div class="container-fluid">
        <!-- Start Page Content -->
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="card p-30">
                    <div class="media">
                        <div class="media-left meida media-middle">
                            <span><i class="fa fa-inr f-s-40 color-primary"></i></span>
                        </div>
                        <div class="media-body media-text-right">
                            <h2>
                                <asp:Label ID="lblRevenue" runat="server" Text="0.00" Font-Size="22px" Font-Bold="true" ForeColor="#545a64"></asp:Label></h2>
                            <p class="m-b-0">Total Revenue</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card p-30">
                    <div class="media">
                        <div class="media-left meida media-middle">
                            <span><i class="fa fa-shopping-cart f-s-40 color-success"></i></span>
                        </div>
                        <div class="media-body media-text-right">
                            <h2>
                                <asp:Label ID="lblSale" runat="server" Text="0.00" Font-Size="22px" Font-Bold="true" ForeColor="#545a64"></asp:Label>
                                <span style="font-size: 20px; font-style: italic; font-family: -webkit-body; font-weight: bold; color: #99abb4;"> l</span>
                            </h2>
                            <p class="m-b-0">Total Sales</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card p-30">
                    <div class="media">
                        <div class="media-left meida media-middle">
                            <span><i class="fa f-s-40 color-warning">
                                <img src="images/deliveryBoy_icon.png" width="52" height="50" /></i></span>
                        </div>
                        <div class="media-body media-text-right">
                            <h2>
                                <asp:Label ID="lblDeliveryBoy" runat="server" Text="0" Font-Size="22px" Font-Bold="true" ForeColor="#545a64"></asp:Label></h2>
                            <p class="m-b-0">Delivery Person</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card p-30">
                    <div class="media">
                        <div class="media-left meida media-middle">
                            <span><i class="fa fa-users f-s-40 color-danger"></i></span>
                        </div>
                        <div class="media-body media-text-right">
                            <h2>
                                <asp:Label ID="lblCustomer" runat="server" Text="0" Font-Size="22px" Font-Bold="true" ForeColor="#545a64"></asp:Label></h2>
                            <p class="m-b-0">Total Customer</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- column -->
        <div class="row">
            <div class="col-lg-2"></div>
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body browser">                        
                        <h2 style="text-align:center">
                            <i class="fa fa-inr p-r-10" style="font-size:18px;color:#7460ee"></i>
                            <asp:Label ID="lblCollection" runat="server" Text="0.00" Font-Size="24px" Font-Bold="true" ForeColor="#545a64"></asp:Label>
                        </h2>
                        <p>
                            Total Payment Collection 
                            <span class="pull-right">
                                <asp:Label ID="lblCollectionPercentage" runat="server" Text="0" Font-Bold="true"></asp:Label>&nbsp%
                            </span>
                        </p>
                        <div class="progress ">
                            <div id="progressBar1" runat="server" role="progressbar" style="width: 0%; height: 8px;background-color:#7460ee" class="progress-bar wow animated progress-animated"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body browser">                        
                        <h2 style="text-align:center">
                            <i class="fa fa-inr p-r-10" style="font-size:18px;color:#ef5350"></i>
                            <asp:Label ID="lblBalance" runat="server" Text="0.00" Font-Size="24px" Font-Bold="true" ForeColor="#545a64"></asp:Label>
                        </h2>
                        <p>
                            Balance Payment Collection 
                            <span class="pull-right">
                                <asp:Label ID="lblBalancePercentage" runat="server" Text="0" Font-Bold="true"></asp:Label>&nbsp%
                            </span>
                        </p>
                        <div class="progress ">
                            <div id="progressBar2" runat="server" role="progressbar" style="width: 0%; height: 8px;background-color:#ef5350" class="progress-bar wow animated progress-animated"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-2"></div>
        </div>
        <!-- column -->
        <!-- End PAge Content -->
    </div>
    <!-- End Container fluid  -->
</asp:Content>

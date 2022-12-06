<%@ Page Title="Todays Delivery List" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="DailyDeliveryList.aspx.cs" Inherits="AnushreeDairy.cpanel.DailyDeliveryList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        tbody tr td {
            color: #777777;
        }

        @media only screen and (max-width: 400px) {
            #breadcrum {
                display: none;
            }

            .page-titles {
                margin: 0;
            }

            .container-fluid {
                padding: 0 25px;
            }
            .footer {
                margin:0;
            }
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            line-height: 17px;
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

        .card {
            padding: 0 20px 20px 20px;
        }

        .table {
            margin-bottom: 10px;
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
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">Todays Delivery List</h3>
        </div>
        <div id="breadcrum" class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard2.aspx">Home</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0)">Daily Delivery List</a></li>
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
                        <div>
                            <h4 class="card-title" style="float: left"><asp:Label ID="lblDate" runat="server"></asp:Label></h4>                            
                        </div>
                    </div>
                    <%--<h6 class="card-subtitle">Data table example</h6>--%>
                    <div class="table-responsive m-t-0">
                        <asp:Repeater ID="rptrCustomer" runat="server" OnItemCommand="rptrCustomer_RowCommand">
                            <HeaderTemplate>
                                <table id="myTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>                                            
                                            <th style="text-align: center">No</th>
                                            <th style="text-align: center">Status</th>
                                            <th style="text-align: center">Location</th>
                                            <th style="text-align: center">Name</th>
                                            <th style="text-align: center">Address</th>
                                            <th style="text-align: center">Area</th>
                                            <th style="text-align: center">Mobile</th>
                                            <th style="text-align: center">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>       
                                    <td style="text-align: center">
                                        <asp:Label ID="lblno" runat="server" Text='<%#Container.ItemIndex+1 %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%#getDeliveryStatus(Eval("deliveryID").ToString()) %>' AlternateText='<%#getAlternateText(Eval("deliveryID").ToString()) %>' Width="18px" Height="18px"/>
                                    </td>  
                                    <td style="text-align: center">
                                        <a href='<%# "http://www.google.com/maps/place/" + Eval("Latitude") + "," + Eval("Longitude") %>' target="_blank">
                                            <asp:Image ID="Image2" runat="server"  ImageUrl="images/pin.png"  AlternateText="Location" Width="20px" Height="25px"/>
                                        </a>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("customerName") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblAdd" runat="server" Text='<%#Eval("address") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblArea" runat="server" Text='<%#Eval("area") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <a href="tel:"><asp:Label ID="lblMobile" runat="server" Text='<%#Eval("customerMobile") %>'></asp:Label></a>
                                    </td>
                                    <td style="text-align: center">                                        
                                        <asp:ImageButton ID="imgbtn" runat="server" ImageUrl="images/viewDetails.png" AlternateText="View Details" Width="20px" Height="20px" CommandArgument='<%#Eval("customerID") +"," + Eval("deliveryID").ToString() %>' CommandName="view" ToolTip="View Details" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                            </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
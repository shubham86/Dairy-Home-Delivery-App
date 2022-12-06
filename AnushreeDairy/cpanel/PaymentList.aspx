<%@ Page Title="Payment List" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="PaymentList.aspx.cs" Inherits="AnushreeDairy.cpanel.PaymentList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        tbody tr td {
            color: #777777;
        }

        @media only screen and (max-width: 400px) {
           
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
        <table id="titleTbl" width="100%">
            <tr>
                <td width="40%">
                    <div class="col-md-5 align-self-center" style="padding-left:0;padding-right:0">
                        <h3 class="text-primary">Payment List</h3>
                    </div>
                </td>
                <td width="60%">
                    <table>
                        <tr>
                            <td>
                                <asp:DropDownList ID="ddlMonth" runat="server" class="form-control ddl-center" ForeColor="#888888" Width="120px" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged" AutoPostBack="true">
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
                            <td>
                                <asp:DropDownList ID="ddlYear" runat="server" class="form-control" ForeColor="#888888" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
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
                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%#getPaymentStatus(Eval("paymentID").ToString()) %>' AlternateText='<%#getAlternateText(Eval("paymentID").ToString()) %>' Width="18px" Height="18px"/>
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
                                        <asp:ImageButton ID="imgbtn" runat="server" ImageUrl="images/viewDetails.png" AlternateText="View Details" Width="20px" Height="20px" CommandArgument='<%#Eval("customerID") +"," + Eval("paymentID").ToString() %>' CommandName="view" ToolTip="View Details" />
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
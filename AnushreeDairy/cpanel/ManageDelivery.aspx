<%@ Page Title="Delivery Managment" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="ManageDelivery.aspx.cs" Inherits="AnushreeDairy.cpanel.ManageDelivery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        tbody tr td {
            color:#777777;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bread crumb -->
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">Delivery Managment</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item active">Delivery Managment</li>
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
                            <h4 class="card-title" style="float: left">List of Delivery Boy</h4>                            
                        </div>
                    </div>
                    <%--<h6 class="card-subtitle">Data table example</h6>--%>
                    <div class="table-responsive m-t-0">
                        <asp:Repeater ID="rptrDeliveryBoy" runat="server" OnItemCommand="rptrDeliveryBoy_RowCommand">
                            <HeaderTemplate>
                                <table id="myTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center">Sr. No.</th>
                                            <th style="text-align: center">Delivery Boy</th>
                                            <th style="text-align: center">Customers</th>
                                            <th style="text-align: center">Areas</th>
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
                                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("deliveryBoy") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblCustomers" runat="server" Text='<%#Eval("totalCustomer") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblAreas" runat="server" Text='<%#getAreas(Convert.ToInt32(Eval("adminID")))%>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/viewDetails.png" AlternateText="Edit Record" Width="20px" Height="20px" CommandArgument='<%#Eval("adminID") %>' CommandName="view" ToolTip="View Details" />
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


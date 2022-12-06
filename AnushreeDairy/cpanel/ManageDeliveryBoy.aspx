<%@ Page Title="Delivery Boy" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="ManageDeliveryBoy.aspx.cs" Inherits="AnushreeDairy.ManageDeliveryBoy" %>
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
            <h3 class="text-primary">Delivery Boy</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item active">Manage Delivery Boy</li>
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
                            <h4 class="card-title" style="float: left">Manage Delivery Boy</h4>
                            <div style="float: right">
                                <asp:ImageButton ID="imgbtnAdd" ImageUrl="~/cpanel/images/add_record.png" runat="server" Width="25px" Height="25px" OnClick="imgbtnadd_Click" ToolTip="Add New Record" />
                            </div>
                        </div>
                    </div>
                    <%--<h6 class="card-subtitle">Data table example</h6>--%>
                    <div class="table-responsive m-t-0">
                        <asp:Repeater ID="rpterDBoy" runat="server" OnItemCommand="rptrDBoy_RowCommand">
                            <HeaderTemplate>
                                <table id="myTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center">Sr.No.</th>
                                            <th style="text-align: center">Name</th>
                                            <th style="text-align: center">User Name</th>
                                            <th style="text-align: center">Password</th>
                                            <th style="text-align: center">Mobile Number</th>
                                            <th style="text-align: center">Role</th> 
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
                                        <asp:Label ID="lblArea" runat="server" Text='<%#Eval("adminName") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblCity" runat="server" Text='<%#Eval("adminUserName") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblPincode" runat="server" Text='<%#Eval("password") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblMobile" runat="server" Text='<%#Eval("mobile") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblRole" runat="server" Text='<%#Eval("role") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/edit.png" AlternateText="Edit Record" Width="20px" Height="20px" CommandArgument='<%#Eval("adminID") %>' CommandName="edit" ToolTip="Edit Record" />
                                        <asp:ImageButton ID="imgbtnDetails" runat="server" ImageUrl="images/delete.png" AlternateText="Delete Record" Width="20px" Height="20px" CommandArgument='<%#Eval("adminID") + "," + Eval("role")%>' CommandName="delete" ToolTip="Delete Record"  OnClientClick="return confirm('Are You Sure You Want To Delete it..?')"/>
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

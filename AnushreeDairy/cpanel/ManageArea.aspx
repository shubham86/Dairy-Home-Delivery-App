<%@ Page Title="Manage Area" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="ManageArea.aspx.cs" Inherits="AnushreeDairy.cpanel.ManageArea" %>
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
            <h3 class="text-primary">Area</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item active">Manage Area</li>
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
                            <h4 class="card-title" style="float: left">Manage Area</h4>
                            <div style="float: right">
                                <asp:ImageButton ID="imgbtnAdd" ImageUrl="../cpanel/images/add_record.png" runat="server" Width="25px" Height="25px" OnClick="imgbtnadd_Click" ToolTip="Add New Record" />
                            </div>
                        </div>
                    </div>
                    <%--<h6 class="card-subtitle">Data table example</h6>--%>
                    <div class="table-responsive m-t-0">
                        <asp:Repeater ID="rptrArea" runat="server" OnItemCommand="rptrArea_RowCommand">
                            <HeaderTemplate>
                                <table id="myTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center">Sr. No.</th>
                                            <th style="text-align: center">Are Name</th>
                                            <th style="text-align: center">City</th>
                                            <th style="text-align: center">Pincode</th>
                                            <th style="text-align: center">Status</th>
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
                                        <asp:Label ID="lblArea" runat="server" Text='<%#Eval("area") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblCity" runat="server" Text='<%#Eval("city") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblPincode" runat="server" Text='<%#Eval("pincode") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:ImageButton ID="imgbtnStatus" runat="server" ImageUrl='<%#getImageURL(Eval("isActive").ToString())%>' AlternateText='<%#getAlternateText(Eval("isActive").ToString()) %>' Width="15px" Height="15px" CommandArgument='<%#Eval("areaID") %>' CommandName="status" ToolTip="Change Status" />
                                    </td>
                                    <td style="text-align: center">
                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/edit.png" AlternateText="Edit Record" Width="20px" Height="20px" CommandArgument='<%#Eval("areaID") %>' CommandName="edit" ToolTip="Edit Record" />
                                        <asp:ImageButton ID="imgbtnDetails" runat="server" ImageUrl="images/delete.png" AlternateText="Delete Record" Width="20px" Height="20px" CommandArgument='<%#Eval("areaID") %>' CommandName="delete" ToolTip="Delete Record"  OnClientClick="return confirm('Are You Sure You Want To Delete it..?')"/>
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

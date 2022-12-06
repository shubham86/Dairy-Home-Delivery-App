<%@ Page Title="Products" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="ManageProduct.aspx.cs" Inherits="AnushreeDairy.cpanel.ManageProduct" %>
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
            <h3 class="text-primary">Product</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item active">Manage Product</li>
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
                            <h4 class="card-title" style="float: left">Manage Product</h4>
                            <div style="float: right;margin-left:20px">                                
                                <asp:ImageButton ID="imgbtnAdd" ImageUrl="~/cpanel/images/add_record.png" runat="server" Width="25px" Height="25px" OnClick="imgbtnadd_Click" ToolTip="Add New Record" />
                            </div>
                            <div style="float:right">
                                <asp:DropDownList ID="ddlRecord" runat="server" class="form-control" ForeColor="#888888" OnSelectedIndexChanged="ddlRecord_OnSelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Text="Active Record" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="All Record" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>                            
                        </div>
                    </div>
                    <%--<h6 class="card-subtitle">Data table example</h6>--%>
                    <div class="table-responsive m-t-0">                        
                        <asp:Repeater ID="rptrProduct" runat="server" OnItemCommand="rptrProduct_RowCommand">
                            <HeaderTemplate>
                                <table id="myTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center">Sr. No.</th>
                                            <th style="text-align: center">Product Name</th>
                                            <th style="text-align: center">Product Description</th>
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
                                        <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("productName") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblProductDesc" runat="server" Text='<%#Eval("productDesc").ToString() == "" ? "-" : Eval("productDesc") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:ImageButton ID="imgbtnStatus" runat="server" ImageUrl='<%#getImageURL(Eval("isActive").ToString())%>' AlternateText='<%#getAlternateText(Eval("isActive").ToString()) %>' Width="15px" Height="15px" CommandArgument='<%#Eval("productID") %>' CommandName="status" ToolTip="Change Status" />
                                    </td>
                                    <td style="text-align: center">
                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/edit.png" AlternateText="Edit Record" Width="20px" Height="20px" CommandArgument='<%#Eval("productID") %>' CommandName="edit" ToolTip="Edit Record" />
                                        <asp:ImageButton ID="imgbtnDetails" runat="server" ImageUrl="images/delete.png" AlternateText="Delete Record" Width="20px" Height="20px" CommandArgument='<%#Eval("productID") %>' CommandName="delete" ToolTip="Delete Record" OnClientClick="return confirm('Are You Sure You Want To Delete it..?')" />
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

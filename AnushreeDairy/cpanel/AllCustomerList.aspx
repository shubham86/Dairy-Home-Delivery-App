<%@ Page Title="" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="AllCustomerList.aspx.cs" Inherits="AnushreeDairy.cpanel.AllCustomerList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        tbody tr td {
            color:#777777;
        }
        .right {
            float:right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bread crumb -->
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">List of Customers</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">List of Customer</a></li>
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
                            <h4 class="card-title" style="float: left">List of Customers</h4>
                        </div>
                    </div>
                    <div>
                        <asp:DropDownList ID="ddlAll" runat="server" class="form-control right" ForeColor="#888888" OnSelectedIndexChanged="ddl_SelectedIndexChange" AutoPostBack="true" Width="150px">
                            <asp:ListItem Text="Active Customer" Value="1"></asp:ListItem>
                            <asp:ListItem Text="All Customer" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="table-responsive m-t-0">
                        <asp:Repeater ID="rptrCustomer" runat="server" OnItemCommand="rptrCustomer_RowCommand">
                            <HeaderTemplate>
                                <table id="myTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center">Sr.No.</th>
                                            <th style="text-align: center">Customer ID</th>
                                            <th style="text-align: center">Customer Name</th>
                                            <th style="text-align: center">Mobile Number</th>
                                            <th style="text-align: center">Area</th>
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
                                        <asp:Label ID="lblID" runat="server" Text='<%#Eval("customerID") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("customerName") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <a href="tel"><asp:Label ID="lblMobile" runat="server" Text='<%#Eval("customerMobile") %>'></asp:Label></a>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblArea" runat="server" Text='<%#Eval("area") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Image ID="imgStatus" runat="server" ImageUrl='<%#getImageURL(Eval("isActive").ToString())%>' AlternateText='<%#getAlternateText(Eval("isActive").ToString()) %>' Width="18px" Height="18px"/>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:ImageButton ID="imgbtn" runat="server" ImageUrl="images/viewDetails.png" AlternateText="View Details" Width="20px" Height="20px" CommandArgument='<%#Eval("customerID")%>' CommandName="view" ToolTip="View Details" />
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
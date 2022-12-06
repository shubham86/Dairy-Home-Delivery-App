<%@ Page Title="Purchase Entries" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="ManagePurchase.aspx.cs" Inherits="AnushreeDairy.cpanel.ManagePurchase" %>
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
            <h3 class="text-primary">Purchase Entries</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item active">Manage Purchase Entry</li>
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
                            <h4 class="card-title" style="float: left">Manage Purchase Entry</h4>
                            <table align="right">
                            <tr>
                                <td width="50%" align="right">
                                    <asp:DropDownList ID="ddlMonth" runat="server" class="form-control right" ForeColor="#888888" Width="130px" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Value="01" Text="January"></asp:ListItem>
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
                                <td width="30%">
                                    <asp:DropDownList ID="ddlYear" runat="server" class="form-control right" ForeColor="#888888" Width="90px" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </td>
                                <td width="20%">
                                    <asp:ImageButton ID="imgbtnAdd" ImageUrl="../cpanel/images/add_record.png" runat="server" Width="25px" Height="25px" OnClick="imgbtnadd_Click" ToolTip="Add New Record" />
                                </td>
                            </tr>
                        </table>
                        </div>
                    </div>
                    <%--<h6 class="card-subtitle">Data table example</h6>--%>
                    <div class="table-responsive m-t-0">                        
                        <asp:Repeater ID="rptrPurchase" runat="server" OnItemCommand="rptrPurchase_RowCommand">
                            <HeaderTemplate>
                                <table id="myTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center">Sr. No.</th>
                                            <th style="text-align: center">Purchase Date</th>
                                            <th style="text-align: center">Product Name</th>
                                            <th style="text-align: center">Quantity</th>
                                            <th style="text-align: center">Rate per Liter</th>
                                            <th style="text-align: center">Total Price</th>
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
                                        <asp:Label ID="lblDate" runat="server" Text='<%#Eval("purchaseDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("productName") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("quantity").ToString() == "" ? "0.00" : Eval("quantity") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblRate" runat="server" Text='<%#Eval("rate").ToString() == "" ? "0.00" : Eval("rate") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblTotal" runat="server" Text='<%#string.Format("{0:0.00}", (Convert.ToDecimal(Eval("rate")) * Convert.ToDecimal(Eval("quantity")))) %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/edit.png" AlternateText="Edit Record" Width="20px" Height="20px" CommandArgument='<%#Eval("purchaseID") %>' CommandName="edit" ToolTip="Edit Record" />
                                        <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="images/delete.png" AlternateText="Delete Record" Width="20px" Height="20px" CommandArgument='<%#Eval("purchaseID") %>' CommandName="delete" ToolTip="Delete Record" OnClientClick="return confirm('Are You Sure You Want To Delete it..?')" />
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

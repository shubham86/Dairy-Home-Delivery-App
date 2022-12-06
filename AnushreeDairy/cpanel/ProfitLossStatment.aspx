<%@ Page Title="" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="ProfitLossStatment.aspx.cs" Inherits="AnushreeDairy.cpanel.ProfitLossStatment" %>
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
            <h3 class="text-primary">Monthly Report</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">Monthly Report</a></li>
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
                    <div class="row card-body">
                        <div>
                            <h4 class="card-title" style="margin-left: 10px">Monthly Report</h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-9 col-sm-12"></div>
                        <table class="col-md-3 col-sm-12">
                            <tr>                                
                                <td width="60%" align="right">
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
                                <td width="40%">
                                    <asp:DropDownList ID="ddlYear" runat="server" class="form-control right" ForeColor="#888888" Width="90px" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="table-responsive m-t-0">
                        <table class="table table-bordered table-striped" style="width:60%;margin:60px auto">
                            <thead>
                                <tr>
                                    <td></td>
                                    <td style="text-align:center"><b>Quantity in Liters</b></td>
                                    <td style="text-align:center"><b>Total Amount</b></td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align:center"><b>Sold</b></td>
                                    <td style="text-align:center"><asp:Label ID="lblSoldQty" runat="server" Text="0.00"></asp:Label></td>
                                    <td style="text-align:center"><asp:Label ID="lblSoldAmount" runat="server" Text="0.00"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td style="text-align:center"><b>Purchased</b></td>
                                    <td style="text-align:center"><asp:Label ID="lblPurchasedQty" runat="server" Text="0.00"></asp:Label></td>
                                    <td style="text-align:center"><asp:Label ID="lblPurchasedAmt" runat="server" Text="0.00"></asp:Label></td>
                                </tr>                                
                                <tr>
                                    <td style="text-align:center"><b>Profit</b></td>
                                    <td colspan="2" style="text-align:center"><span>₹</span>&nbsp&nbsp<asp:Label ID="lblProfit" runat="server" Text="0.00"></asp:Label></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

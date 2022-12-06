<%@ Page Title="Payment Details" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="PaymentDetails.aspx.cs" Inherits="AnushreeDairy.cpanel.PaymentDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bread crumb -->
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">Payment Details</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">Payment Details</a></li>
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
                            <h4 class="card-title" style="margin-left: 10px">Payment Details</h4>
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
                        <asp:Repeater ID="rptrPayment" runat="server">
                            <HeaderTemplate>
                                <table id="myTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center;width:9%">SrNo </th>
                                            <th style="text-align: center;width:19%">Customer Name</th>
                                            <th style="text-align: center;width:15%">Payment Date</th>
                                            <th style="text-align: center;width:12%">Payment of Month</th>
                                            <th style="text-align: center;width:10%">Payment Amount</th>
                                            <th style="text-align: center;width:10%">Paid Amount</th>
                                            <th style="text-align: center;width:10%">Balance Amount</th>
                                            <th style="text-align: center;width:15%">Payment Reciver</th>
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
                                        <asp:Label ID="lblID" runat="server" Text='<%#Eval("customerName") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("paymentDate", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <a href="tel"><asp:Label ID="lblMobile" runat="server" Text='<%#Eval("monthYear") %>'></asp:Label></a>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblArea" runat="server" Text='<%#Eval("paymentAmount") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("paidAmount") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="Label2" runat="server" Text='<%#Eval("balanceAmount") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("paymentReciver") %>'></asp:Label>
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

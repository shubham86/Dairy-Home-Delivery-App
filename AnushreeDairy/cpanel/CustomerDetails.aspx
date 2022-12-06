<%@ Page Title="Customer Details" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="CustomerDetails.aspx.cs" Inherits="AnushreeDairy.cpanel.CustomerDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #Details table {
            line-height: 27px;
            font-size: 15px;
        }

        #pnlPDF table td {
            font-size: 12px;
        }

        @media only screen and (min-width : 1024px) {
            #title {
                float: left;
            }

            #btns {
                float: right;
            }
        }

        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            #title {
                float: left;
            }

            #btns {
                float: none;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bread crumb -->
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">Customer Details</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard2.aspx">Home</a></li>
                <li class="breadcrumb-item"><a href="AllCustomerList.aspx">List of Customer</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0)">Customer Details</a></li>
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
                        <div id="title">
                            <h4 class="card-title">
                                <asp:Label ID="lblCustomerName" runat="server"></asp:Label></h4>
                            <h6>
                                <asp:Label ID="lblMonthYear" runat="server"></asp:Label></h6>
                        </div>
                        <div id="btns">
                            <table>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="ddlMonth" runat="server" class="form-control ddl-center" ForeColor="#888888" Height="35px" Width="120px" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged" AutoPostBack="true">
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
                                        <asp:DropDownList ID="ddlYear" runat="server" class="form-control" ForeColor="#888888" Height="35px" Width="90px" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnPrint" runat="server" Text="PDF" CssClass="btn btn-secondary" ToolTip="Download PDF Report" OnClick="btnExport_Click" Font-Size="12px" />
                                    </td>
                                </tr>
                            </table>                            
                        </div>
                    </div>
                        <div id="Details">
                            <div class="row">
                                <div class="col-lg-5">
                                    <table width="100%" align="center">
                                        <tr>
                                            <td width="40%" style="color: #999999">ID</td>
                                            <td width="10%">:</td>
                                            <td width="50%" style="text-align: left">
                                                <asp:Label ID="lblID" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-lg-2"></div>
                                <div class="col-lg-5">
                                    <table width="100%" align="center">
                                        <tr>
                                            <td width="40%" style="color: #999999">User Name</td>
                                            <td width="10%">:</td>
                                            <td width="50%" style="text-align: left">
                                                <asp:Label ID="lblUserName" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-5">
                                    <table width="100%" align="center">
                                        <tr>
                                            <td width="40%" style="color: #999999">Mobile No.</td>
                                            <td width="10%">:</td>
                                            <td width="50%" style="text-align: left">
                                                <asp:Label ID="lblMobile" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-lg-2"></div>
                                <div class="col-lg-5">
                                    <table width="100%" align="center">
                                        <tr>
                                            <td width="40%" style="color: #999999">Email ID</td>
                                            <td width="10%">:</td>
                                            <td width="50%" style="text-align: left">
                                                <asp:Label ID="lblEmail" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-5">
                                    <table width="100%" align="center">
                                        <tr>
                                            <td width="40%" style="color: #999999">Date Of Register</td>
                                            <td width="10%">:</td>
                                            <td width="50%" style="text-align: left">
                                                <asp:Label ID="lblRDate" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-lg-2"></div>
                                <div class="col-lg-5">
                                    <table width="100%" align="center">
                                        <tr>
                                            <td width="40%" style="color: #999999">Status</td>
                                            <td width="10%">:</td>
                                            <td width="50%" style="text-align: left">
                                                <asp:Label ID="lblStatus" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-7">
                                    <table width="100%" align="center">
                                        <tr>
                                            <td width="28%" style="color: #999999">Address</td>
                                            <td width="7%">:</td>
                                            <td width="65%" style="text-align: left">
                                                <asp:Label ID="lblAddress" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    <hr />
                    <div class="table-responsive m-t-0">
                        <asp:Repeater ID="rptrCustomer" runat="server">
                            <HeaderTemplate>
                                <table id="tblCustomer" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center;">Sr.No</th>
                                            <th style="text-align: center;">Date</th>
                                            <th style="text-align: center;">Quantity</th>
                                            <th style="text-align: center;">Rate</th>
                                            <th style="text-align: center;">Amount</th>
                                            <th style="text-align: center; vertical-align: middle">Delivery Boy</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td style="text-align: center; line-height: 18px;vertical-align:middle">
                                        <asp:Label ID="lblno" runat="server" Text='<%#Container.ItemIndex+1 %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center; line-height: 18px;vertical-align:middle">
                                        <asp:Label ID="lblDate" runat="server" Text='<%#Eval("deliveryDate","{0:dd}").ToString() %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center; line-height: 18px;vertical-align:middle">
                                        <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("milkQuatity") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center; line-height: 18px;vertical-align:middle">
                                        <asp:Label ID="lblRate" runat="server" Text='<%#Eval("rate") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center; line-height: 18px;vertical-align:middle">
                                        <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("amount") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center;;vertical-align:middle">
                                        <asp:Label ID="lblArea" runat="server" Text='<%#Eval("deliveryBoy") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                    <tfoot>
                                        <tr>
                                            <th colspan="2" style="text-align: center; vertical-align:middle">Total</th>
                                            <th style="text-align: center; vertical-align:middle">
                                                <asp:Label ID="lblTotalQuantity" runat="server"></asp:Label>&nbsp <span style="font-size:12px">Ltr.</span>
                                            </th>
                                            <th style="text-align: center; vertical-align:middle">
                                                <span style="font-size:12px">Rs.</span>&nbsp<asp:Label ID="lblAvrageRart" runat="server"></asp:Label>
                                            </th>
                                            <th style="text-align: center; vertical-align:middle">
                                                <span style="font-size:12px; vertical-align:middle">Rs.</span>&nbsp<asp:Label ID="lblTotalAmount" runat="server"></asp:Label>
                                            </th>
                                            <th style="text-align: center; vertical-align:middle">Balance Amount :&nbsp 
                                                <span style="font-size:12px">Rs.</span>&nbsp<asp:Label ID="lblBalanceAmount" runat="server"></asp:Label>
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <asp:Panel ID="pnlPDF" runat="server" CssClass="pdf" Visible="false">
        <asp:Repeater ID="rptrPDF" runat="server">
            <HeaderTemplate>
                <table id="tblCustomer" width="100%" border="1" style="line-height: 14px;font-size:10px">
                    <thead>
                        <tr>
                            <td colspan="5">
                                <table align="left" width="100%" border="0" style="line-height:11px">
                                    <tr>
                                        <td style="text-align: left; font-size: 16px;line-height:13px">
                                            <asp:Label ID="lblCustomerName1" runat="server" Text="Name"></asp:Label>
                                        </td>
                                        <td style="text-align: right; font-size: 10px;">
                                            <asp:Label ID="lblMonthYear1" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="50%" style="text-align: left">
                                            <table width="100%" align="center">
                                                <tr>
                                                    <td width="40%">ID</td>
                                                    <td width="10%">:</td>
                                                    <td width="50%" style="text-align: left;color: #777777">
                                                        <asp:Label ID="lblID1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="text-align: left">
                                            <table width="100%" align="center">
                                                <tr>
                                                    <td width="40%">User Name</td>
                                                    <td width="10%">:</td>
                                                    <td width="50%" style="text-align: left;color: #777777">
                                                        <asp:Label ID="lblUserName1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="50%" style="text-align: left">
                                            <table width="100%" align="center">
                                                <tr>
                                                    <td width="40%">Mobile No.</td>
                                                    <td width="10%">:</td>
                                                    <td width="50%" style="text-align: left;color: #777777">
                                                        <asp:Label ID="lblMobile1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="text-align: left">
                                            <table width="100%" align="center">
                                                <tr>
                                                    <td width="40%">Email ID</td>
                                                    <td width="10%">:</td>
                                                    <td width="50%" style="text-align: left;color: #777777">
                                                        <asp:Label ID="lblEmail1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="50%" style="text-align: left">
                                            <table width="100%" align="center">
                                                <tr>
                                                    <td width="40%">Date Of Register</td>
                                                    <td width="10%">:</td>
                                                    <td width="50%" style="text-align: left;color: #777777">
                                                        <asp:Label ID="lblRdate1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="text-align: left">
                                            <table width="100%" align="center">
                                                <tr>
                                                    <td width="40%">Status</td>
                                                    <td width="10%">:</td>
                                                    <td width="50%" style="text-align: left;color: #777777">
                                                        <asp:Label ID="lblStatus1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" width="50%" style="text-align: left">
                                            <table width="100%" align="center">
                                                <tr>
                                                    <td width="20%">Address</td>
                                                    <td width="5%">:</td>
                                                    <td width="75%" style="text-align: left;color: #777777">
                                                        <asp:Label ID="lblAddress1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <th style="text-align: center">Sr.No</th>
                            <th style="text-align: center">Date</th>
                            <th style="text-align: center">Quantity</th>
                            <th style="text-align: center">Rate</th>
                            <th style="text-align: center">Amount</th>
<%--                            <th style="text-align: center; vertical-align: middle">Delivery Boy</th>--%>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td width="20%" style="text-align: center;color: #777777;vertical-align:middle">
                        <asp:Label ID="lblno" runat="server" Text='<%#Container.ItemIndex+1 %>'></asp:Label>
                    </td>
                    <td width="20%" style="text-align: center;color: #777777;vertical-align:middle">
                        <asp:Label ID="lblDate" runat="server" Text='<%#Eval("deliveryDate","{0:dd/MM/yyyy}").ToString() %>'></asp:Label>
                    </td>
                    <td width="20%" style="text-align: center;color: #777777;vertical-align:middle">
                        <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("milkQuatity") %>'></asp:Label>
                    </td>
                    <td width="20%" style="text-align: center;color: #777777;vertical-align:middle">
                        <asp:Label ID="lblRate" runat="server" Text='<%#Eval("rate") %>'></asp:Label>
                    </td>
                    <td width="20%" style="text-align: center;color: #777777;vertical-align:middle">
                        <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("amount") %>'></asp:Label>
                    </td>
<%--                    <td width="25%" style="text-align: center;">
                        <asp:Label ID="lblArea" runat="server" Text='<%#Eval("deliveryBoy") %>'></asp:Label>
                    </td>--%>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
                    <tfoot style="line-height:20px">
                        <tr>
                            <th style="text-align: center">Total</th>
                            <th style="text-align: center">Balance :
                                <asp:Label ID="lblBalanceAmount" runat="server" ></asp:Label>
                            </th>
                            <th style="text-align: center">
                                <asp:Label ID="lblTotalQuantity" runat="server" ></asp:Label> <span style="font-size:8px">Ltr.</span>
                            </th>
                            <th style="text-align: center">
                                <span style="font-size:8px">Rs.</span> <asp:Label ID="lblAvrageRart" runat="server" ></asp:Label>
                            </th>
                            <th style="text-align: center">
                                <span style="font-size:8px">Rs.</span> <asp:Label ID="lblTotalAmount" runat="server" ></asp:Label>
                            </th>
                            
                        </tr>
                    </tfoot>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </asp:Panel>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="UnassignCustomerList.aspx.cs" Inherits="AnushreeDairy.cpanel.UnassignCustomerList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        tbody tr td {
            color:#777777;
        }
        .right {
            float:right;
        }
    </style>
    <style>
        .modalDialog {
            position: fixed;
            font-family: Arial, Helvetica, sans-serif;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background: rgba(0, 0, 0, 0.8);
            z-index: 99999;
            opacity: 0;
            -webkit-transition: opacity 400ms ease-in;
            -moz-transition: opacity 400ms ease-in;
            transition: opacity 400ms ease-in;
            pointer-events: none;
            padding:20px;
        }

            .modalDialog:target {
                opacity: 1;
                pointer-events: auto;
            }

            .modalDialog > div {
                width: 800px;
                position: relative;
                margin: 10% auto;
                padding: 20px 20px 20px 20px;
                border-radius: 10px;
                background: #fff;
                font-size:13px;
            }

        .close {
            background: #0083c5;
            color: #FFFFFF;
            line-height: 25px;
            position: absolute;
            right: -12px;
            text-align: center;
            top: -10px;
            width: 24px;
            text-decoration: none;
            font-weight: bold;
            -webkit-border-radius: 12px;
            -moz-border-radius: 12px;
            border-radius: 12px;
            -moz-box-shadow: 1px 1px 3px #000;
            -webkit-box-shadow: 1px 1px 3px #000;
            box-shadow: 1px 1px 3px #000;
            font-size: 1em;
            text-shadow: 0 0px 0 #fff;
            opacity: 1;
        }

            .close:hover {
                background: #ef5350;
                opacity: 1;
                color: #FFFFFF;
            }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
    <script>
    $(document).ready(function () {
        // CHECK-UNCHECK ALL CHECKBOXES IN THE REPEATER 
            // WHEN USER CLICKS THE HEADER CHECKBOX.
        $('table [id*=chkAll]').click(function () {
            if ($(this).is(':checked'))
                $('table [id*=chkRowData]').prop('checked', true)
            else
                $('table [id*=chkRowData]').prop('checked', false)
        });

        // NOW CHECK THE HEADER CHECKBOX, IF ALL THE ROW CHECKBOXES ARE CHECKED.
        $('table [id*=chkRowData]').click(function () {
            var total_rows = $('table [id*=chkRowData]').length;
            var checked_Rows = $('table [id*=chkRowData]:checked').length;
            if (checked_Rows == total_rows)                
                $('table [id*=chkAll]').prop('checked', true);
            else
                $('table [id*=chkAll]').prop('checked', false);
        });

        // CHECK THE AllCHECKBOXES ARE CHECKED.
        $('[id*=ModelLink]').click(function () {
            var checked_Rows = $('table [id*=chkRowData]:checked').length;
            if (checked_Rows == 0) {
                document.getElementById("ModelLink").href = "javascript:void(0)";
                alert("Please select atleast one customer");
            }
            else {
                document.getElementById("ModelLink").href = "#openModal";
            }
        });
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bread crumb -->
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">Unassign Customers</h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item active"><a href="javascript: void(0);">Unassign Customers</a></li>
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
                            <h4 class="card-title" style="float: left">Unassign Customers</h4>
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
                                            <th style="text-align: center">Subscription Date</th>
                                            <th style="text-align: center">Customer ID</th>
                                            <th style="text-align: center">Customer Name</th>
                                            <th style="text-align: center">Mobile Number</th>
                                            <th style="text-align: center">Status</th>
                                            <th style="text-align: center">Area</th>
                                            <th style="text-align: center"><asp:CheckBox ID="chkAll" runat="server" /></th>
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
                                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("dateOfRegister") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblID" runat="server" Text='<%#Eval("customerID") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("customerName") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <a href="tel"><asp:Label ID="lblMobile" runat="server" Text='<%#Eval("customerMobile") %>'></asp:Label></a>
                                        <asp:Label ID="lblCustomerID" runat="server" Text='<%#Eval("customerID") %>' Font-Size="1px" ForeColor="White"></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblArea" runat="server" Text='<%#Eval("area") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Image ID="imgStatus" runat="server" ImageUrl='<%#getImageURL(Eval("isActive").ToString())%>' AlternateText='<%#getAlternateText(Eval("isActive").ToString()) %>' Width="18px" Height="18px"/>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:CheckBox ID="chkRowData" runat="server"/>                                        
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                            </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="row">
                        <div class="col-lg-4"></div>
                        <div class="col-lg-4" style="text-align:center">
                            <a id="ModelLink" href="#openModal"><input id="btnAssign" type="button" class="btn btn-primary" value="Assign to Delivery-boy" style="margin:20px 0"/></a>
                        </div>
                        <div class="col-lg-4"></div>
                    </div>

                    <div id="openModal" class="modalDialog">
                        <div>
                            <a href="#close" title="Close" class="close">X</a>
                            <h4 class="card-title">Select Delivery-boy</h4>

                            <asp:Repeater ID="rptrDeliveryBoy" runat="server" OnItemCommand="rptrDeliveryBoy_RowCommand">
                                <HeaderTemplate>
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th style="text-align: center" width="10%">Sr.No.</th>
                                                <th style="text-align: center" width="30%">Delivery Boy</th>
                                                <th style="text-align: center" width="20%">Customers</th>
                                                <th style="text-align: center" width="30%">Areas</th>
                                                <th style="text-align: center" width="10%">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td style="text-align: center;vertical-align:middle">
                                            <asp:Label ID="lblno" runat="server" Text='<%#Container.ItemIndex+1 %>'></asp:Label>
                                        </td>
                                        <td style="text-align: center;vertical-align:middle">
                                            <asp:Label ID="lblName" runat="server" Text='<%#Eval("deliveryBoy") %>'></asp:Label>
                                        </td>
                                        <td style="text-align: center;vertical-align:middle">
                                            <asp:Label ID="lblCustomers" runat="server" Text='<%#Eval("totalCustomer") %>'></asp:Label>
                                        </td>
                                        <td style="text-align: center;vertical-align:middle">
                                            <asp:Label ID="lblAreas" runat="server" Text='<%#getAreas(Convert.ToInt32(Eval("adminID")))%>'></asp:Label>
                                        </td>
                                        <td style="text-align: center;vertical-align:middle">
                                            <asp:Button ID="btnAssign" runat="server" Text="Assign"  class="btn btn-success" CommandArgument='<%#Eval("adminID") %>' CommandName='<%#Eval("deliveryBoy") %>' style="height: 25px;padding: 0 5px;font-size:12px"/>
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
    </div>
</asp:Content>
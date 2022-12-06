<%@ Page Title="Assigned Customer to Delivery Person" Language="C#" MasterPageFile="../cpanel/Master.Master" AutoEventWireup="true" CodeBehind="AssignedCustomer.aspx.cs" Inherits="AnushreeDairy.cpanel.AssignedCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        tbody tr td {
            color:#777777;
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
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bread crumb -->
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h3 class="text-primary">Assigned Customer To <asp:Label ID="lblDBoyName1" runat="server"></asp:Label></h3>
        </div>
        <div class="col-md-7 align-self-center">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                <li class="breadcrumb-item"><a href="ManageDelivery.aspx">Delivery Managment</a></li>
                <li class="breadcrumb-item active">Assigned Customer</li>
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
                            <span style="float:left;">Select customer to Un-Assign from &nbsp</span><h4 class="card-title" style="float: left"><asp:Label ID="lblDBoyName" runat="server"></asp:Label></h4>
                            <div style="float: right">
                                <asp:ImageButton ID="imgbtnAdd" ImageUrl="~/cpanel/images/add_record.png" runat="server" Width="25px" Height="25px" OnClick="imgbtnadd_Click" ToolTip="Assigned New Customer" />
                            </div>
                        </div>
                    </div>
                    <%--<h6 class="card-subtitle">Data table example</h6>--%>
                    <div class="table-responsive m-t-0">
                        <asp:Repeater ID="rptrCustomer" runat="server">
                            <HeaderTemplate>
                                <table id="myTable" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center">Sr. No.</th>
                                            <th style="text-align: center">Customer Name</th>
                                            <th style="text-align: center">Mobile Number</th>
                                            <th style="text-align: center">Street</th>
                                            <th style="text-align: center">Area</th>
                                            <th style="text-align: center"><asp:CheckBox ID="chkAll" runat="server" OnClick="checkAll(this)"/></th>
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
                                        <asp:Label ID="lblArea" runat="server" Text='<%#Eval("customerName") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblCity" runat="server" Text='<%#Eval("customerMobile") %>'></asp:Label>
                                        <asp:Label ID="lblCustomerID" runat="server" Text='<%#Eval("customerID") %>' Font-Size="1px" ForeColor="White"></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="lblPincode" runat="server" Text='<%#Eval("street") %>'></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("area") %>'></asp:Label>
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
                        <div class="col-lg-12 mt-4" style="padding-left:45%">
                            <asp:Button ID="btnUnAssign" runat="server" Text="Un-Assign" class="btn btn-danger" OnClick="btnUnAssign_Click"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="AnushreeDairy.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="txtTo" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtMsg" runat="server"></asp:TextBox>
            <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="btn_send_Click"/>
        </div>
    </form>
</body>
</html>

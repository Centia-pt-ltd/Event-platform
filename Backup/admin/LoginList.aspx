<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginList.aspx.cs" Inherits="admin_LoginList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Qstudy:LoginList</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblmsg" runat="server"></asp:Label>
    <div>
        
        <h3>Login List:  
            
            <asp:Button ID="btnLogOut" runat="server" Text="LogOut" OnClick="btnLogOut_Click" style="float:right; margin-left:10px; cursor:pointer; font-weight:bold" />
            <asp:Button ID="btnWelcome" runat="server" Text="" style="float:right; margin-left:10px; font-weight:bold" />
            <asp:Button ID="btnDownload" runat="server" Text="Download in Excel" style="float:right; cursor:pointer; font-weight:bold" OnClick="btnDownload_Click" />
            <asp:Button ID="btnRegList" runat="server" Text="Go To Registration List" OnClick="btnRegList_Click" style="float:right; margin-right:10px; cursor:pointer; font-weight:bold" />

        </h3>
    <asp:GridView ID="grdList" runat="server" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" AllowPaging="True" OnPageIndexChanging="OnPageIndexChanging" Width="100%">
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <RowStyle ForeColor="#330099" BackColor="White" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <SortedAscendingCellStyle BackColor="#FEFCEB" />
        <SortedAscendingHeaderStyle BackColor="#AF0101" />
        <SortedDescendingCellStyle BackColor="#F6F0C0" />
        <SortedDescendingHeaderStyle BackColor="#7E0000" />
        </asp:GridView>
    </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DriveLoader.aspx.cs" Inherits="Week2Module1.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <%--<asp:Panel ID="CurrentNav" runat="server" Width="100%">
        <asp:ImageButton ID="Home" runat="server" CssClass="left" 
            ImageUrl="~/Images/home.png" />
        <asp:Label ID="Label1" runat="server" CssClass="left" Font-Bold="True" 
            Text="&amp;rtrif;"></asp:Label>
    </asp:Panel>--%>
    <asp:Panel ID="Drive" runat="server">

    </asp:Panel>
    <asp:Panel ID="DriveContent" runat="server" BackColor="White">
    </asp:Panel>
</body>
</html>

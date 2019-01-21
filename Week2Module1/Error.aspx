<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="Week2Module1.Error" %>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="PageContent" runat="server">
    </asp:Panel>
    <asp:Button ID="Back" runat="server" Text="Back" BackColor="#CCFF66" 
        BorderColor="#CCFF66" BorderStyle="Solid" BorderWidth="5px" 
        CssClass="buttons" onclick="backButton_Click" UseSubmitBehavior="False" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="Home" runat="server" Text="Home" BackColor="#FFFF99" 
        BorderColor="#FFFF99" BorderStyle="Solid" BorderWidth="5px" 
        CssClass="buttons" onclick="homeButton_Click" UseSubmitBehavior="False"
         />
</asp:Content>

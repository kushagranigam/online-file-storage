<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Week2Module1._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="PageContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:TextBox ID="search" runat="server" TabIndex="1"></asp:TextBox>
    <asp:ImageButton ID="searchButton" runat="server" AlternateText="Search" 
        TabIndex="2" />
</asp:Content>

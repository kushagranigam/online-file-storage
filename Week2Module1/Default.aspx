<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Week2Module1._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="PageContent" runat="server" ContentPlaceHolderID="MainContent">
    <div id="formContainer" style="margin-top: 180px">
        <div id="form">
            <asp:TextBox ID="search" runat="server" TabIndex="1" Height="30px" 
                Width="250px"></asp:TextBox>
            <asp:ImageButton ID="searchButton" runat="server" AlternateText="Search" 
                TabIndex="2" Height="20px" Width="20px" ImageUrl="~/Images/search.png" 
                onclick="searchButton_Click" />
            <div id="formMast">
                <p>
                    Search people, files and more.
                </p>
                <p>
                </p>
                <asp:Panel ID="Panel1" runat="server">
                </asp:Panel>
            </div>
        </div>
    </div>
    
    </asp:Content>

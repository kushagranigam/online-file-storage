<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="Week2Module1.Account.Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div id="formContainer">
        <div id="form">
            <asp:Image ID="nameImage" runat="server" />
            <asp:TextBox ID="name" runat="server" ontextchanged="TextBox1_TextChanged"></asp:TextBox>
            <br />
            <br />
            <asp:Image ID="dobImage" runat="server" />
            <asp:TextBox ID="dateOfBirth" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Image ID="Image8" runat="server" />
            <asp:RadioButtonList ID="gender" runat="server" CellPadding="5" CellSpacing="5" 
                RepeatDirection="Horizontal" RepeatLayout="Flow">
                <asp:ListItem Value="M">Him</asp:ListItem>
                <asp:ListItem Value="F">Her</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            <br />
            <asp:Image ID="userImage" runat="server" />
            <asp:TextBox ID="userName" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Image ID="emailImage" runat="server" />
            <asp:TextBox ID="emailID" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Image ID="passImage" runat="server" />
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Image ID="cpassImage" runat="server" />
            <asp:TextBox ID="confirmPassword" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="registerButton" runat="server" Text="Register" />
        </div>
    </div>
</asp:Content>

<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="Week2Module1.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
<script type="text/javascript">
    function rememberMe(){
        var rm = Document.getElementById("rememberMe");
        if(rm.Checked == "checked")
            rm.Checked="checked";  
        else
            rm.Checked = "";
    }
</script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div id="formContainer">
        <div id="form">

            <asp:Image ID="userImage" runat="server" Height="20px" 
                ImageUrl="~/Images/userNotFilled.png" Width="20px" />

            <asp:TextBox ID="userName" runat="server" 
                placeholder="Enter username or emailID" Height="27px" Width="209px"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="userName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />

            <asp:Image ID="passwordImage" runat="server" Height="20px" 
                ImageUrl="~/Images/passNotFilled.png" Width="20px" />

            <asp:TextBox ID="password" runat="server" placeholder="Enter password" 
                TextMode="Password" Height="27px" ViewStateMode="Enabled" Width="206px"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="password" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />

            <asp:Literal ID="errorText" runat="server"></asp:Literal>
            <br />

            <asp:Button ID="loginButton" runat="server" Text="Log In" 
                onclick="loginButton_Click" OnClientClick="session_create()" />

        </div>
        <div id="formOptions">

            <asp:ImageButton ID="rmImage" runat="server" ImageUrl="~/Images/rmChecked.png" 
                onclick="rmImage_Click" AlternateText="Remember Me" Height="20px" 
                Width="20px" CausesValidation="False" OnClientClick="rememberMe()" />

            <asp:Label ID="rmLabel" runat="server" AssociatedControlID="rmImage" 
                ForeColor="#00CCFF" Text="Remember Me"></asp:Label>

            <input id="rememberMe" type="checkbox" name="rememberMe" style="display: none" checked="checked"/>

        </div>
    </div>
</asp:Content>

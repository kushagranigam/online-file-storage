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

    <div id="formContainer" 
    style="overflow: auto; display: block; width: 425px; margin: auto; height: 200">
        <div id="form" 
            style="padding: 4px; overflow: auto; float: left; border-right-style: solid; border-right-width: medium; border-right-color: #66CCFF;">

            <asp:Image ID="userImage" runat="server" Height="16px" 
                ImageUrl="~/Images/userNotFilled.png" Width="20px" />

            <asp:TextBox ID="userName" runat="server" 
                placeholder="Enter username or emailID" Height="25px" Width="250px" 
                CausesValidation="True"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="userName" ErrorMessage="*" ForeColor="Red" Height="25px"></asp:RequiredFieldValidator>
            <br />
            <br />

            <asp:Image ID="passwordImage" runat="server" Height="20px" 
                ImageUrl="~/Images/passNotFilled.png" Width="20px" />

            <asp:TextBox ID="password" runat="server" placeholder="Enter password" 
                TextMode="Password" Height="25px" ViewStateMode="Enabled" Width="250px" 
                CausesValidation="True"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="password" ErrorMessage="*" ForeColor="Red" Height="25px"></asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="errorText" runat="server" ForeColor="Red"></asp:Label>
            <br />

            <asp:Button ID="loginButton" runat="server" Text="Log In" 
                onclick="loginButton_Click" BackColor="#CCFF66" BorderColor="#CCFF99" 
                BorderStyle="Solid" BorderWidth="5px" CssClass="buttons right" />

        </div>
        <div id="formOptions" style="float: right; overflow: auto; height: 135px;">

            <br />
            <br />
            <br />

            <asp:ImageButton ID="rmImage" runat="server" ImageUrl="~/Images/rmChecked.png" 
                onclick="rmImage_Click" AlternateText="Remember Me" Height="15px" 
                Width="15px" CausesValidation="False" OnClientClick="rememberMe()" />

            &nbsp;

            <asp:Label ID="rmLabel" runat="server" AssociatedControlID="rmImage" 
                ForeColor="#00CCFF" Text="Remember Me" Font-Size="Small"></asp:Label>

            <input id="rememberMe" type="checkbox" name="rememberMe" style="display: none" checked="checked"/>

        </div>
    </div>
</asp:Content>

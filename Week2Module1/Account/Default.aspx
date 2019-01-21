<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Week2Module1.Account.Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        function hideError() {
            document.getElementById("<%= errorText.ClientID %>").innerHTML = "";
        }

        function rememberMe() {
            var chk = document.getElementById("<%= rememberMe.ClientID %>");
            var img = document.getElementById("<%= rmImage.ClientID %>");
            var txt = document.getElementById("rmText");
            if (chk.checked == true) {
                chk.checked = false;
                txt.style.color = "#000";
                img.src = "/Images/rmUnchecked.png";
            }
            else {
                chk.checked = true;
                txt.style.color = "#27B9DF";
                img.src = "/Images/rmChecked.png";
            }
        }
</script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div id="formContainer" 
    
        style="overflow: auto; display: block; width: 450px; margin: auto; height: 200px;">
        <div id="form" 
            style="padding: 4px; overflow: auto; float: left; border-right-style: solid; border-right-width: medium; border-right-color: #66CCFF; border-radius: 7px;">

            <asp:Image ID="userImage" runat="server" Height="16px" 
                ImageUrl="~/Images/userNotFilled.png" Width="20px" />

            <asp:TextBox ID="userName" runat="server" 
                placeholder="Enter username or emailID" Height="25px" Width="250px" 
                EnableViewState="False" MaxLength="60" 
                onkeypress="hideError()" ValidationGroup="loginValidation" ></asp:TextBox>

            <br />

            <asp:RequiredFieldValidator ID="usernameValidator" runat="server" 
                ControlToValidate="userName" ErrorMessage="Name Required" ForeColor="Red" 
                Height="10px" ValidationGroup="loginValidation" Width="300px"></asp:RequiredFieldValidator>
            <br />
            <br />

            <asp:Image ID="passwordImage" runat="server" Height="20px" 
                ImageUrl="~/Images/passNotFilled.png" Width="20px" />

            <asp:TextBox ID="password" runat="server" placeholder="Enter password" 
                TextMode="Password" Height="25px" ViewStateMode="Enabled" Width="250px" 
                EnableViewState="False" MaxLength="40" onkeypress="hideError()" 
                ValidationGroup="loginValidation"></asp:TextBox>

            <br />

            <asp:RequiredFieldValidator ID="passwordValidator" runat="server" 
                ControlToValidate="password" ErrorMessage="Password Required" ForeColor="Red" 
                Height="10px" ValidationGroup="loginValidation" Width="300px"></asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="errorText" runat="server" ForeColor="Red"></asp:Label>
            <br />

            <asp:Button ID="loginButton" runat="server" Text="Log In" 
                onclick="loginButton_Click" BackColor="#CCFF66" BorderColor="#CCFF99" 
                BorderStyle="Solid" BorderWidth="5px" CssClass="buttons right" 
                ValidationGroup="loginValidation" />

        </div>
        <div id="formOptions" style="float: right; overflow: auto; height: 135px;">

            <br />
            <br />
            <br />

            <asp:Image ID="rmImage" runat="server" Height="15" onclick="rememberMe()"
                Width="15" ImageUrl="~/Images/rmChecked.png" AlternateText="Remember Me" />

            &nbsp;
            <a href="javascript:void(0)" onclick="rememberMe()" id="rmText" style="color: #27B9DF;">Remember Me</a>

            <input id="rememberMe" type="checkbox" runat="server" name="rmChk" value="checked" checked style="display:none;"/>
        </div>
    </div>
</asp:Content>

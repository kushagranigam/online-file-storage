<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="Week2Module1.Account.Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .hide
        {}
    </style>
    <script type="text/javascript">
        function nameError() { document.getElementById("<%= nameError.ClientID %>").innerHTML = ""; }
        function dobError() { document.getElementById("<%= dobError.ClientID %>").innerHTML = ""; }
        function usernameError() { document.getElementById("<%= usernameError.ClientID %>").innerHTML = ""; }
        function emailError() { document.getElementById("<%= emailError.ClientID %>").innerHTML = ""; }
        function passwordError() { document.getElementById("<%= passwordError.ClientID %>").innerHTML = ""; }
        function confirmpasswordError() { document.getElementById("<%= confirmpasswordValidator.ClientID %>").innerHTML = ""; }
        function captchaError() { document.getElementById("<%= captchaValidator.ClientID %>").innerHTML = ""; }
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div id="formContainer">
        <div id="form">
            <asp:MultiView ID="registerForm" runat="server" ActiveViewIndex="0">
                <asp:View ID="registerView" runat="server">
                    <asp:Image ID="nameImage" runat="server" Height="25px" Width="25px" 
                            ImageUrl="~/Images/name.png" />

                        &nbsp;<asp:TextBox ID="name" runat="server" placeholder="Name" Height="25px" 
                            Width="300px" CausesValidation="True" MaxLength="40" TabIndex="1" 
                        ToolTip="Name" AutoCompleteType="Disabled" onkeypress="nameError()"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="nameValidator" runat="server" 
                            ErrorMessage="*" ForeColor="Red" Height="25px" 
                        ControlToValidate="name"></asp:RequiredFieldValidator>
                        <br />
                        <asp:Label ID="nameError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="dobImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/dateOfBirth.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="dateOfBirth" runat="server" Height="25px" placeholder="Date of Birth" 
                        TabIndex="2" Width="300px" ToolTip="Date of Birth" 
                        AutoCompleteType="Disabled" MaxLength="10" onkeypress="dobError()"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="dateofbirthValidator" runat="server" 
                        ControlToValidate="dateOfBirth" ErrorMessage="*" ForeColor="Red" 
                        Height="25px"></asp:RequiredFieldValidator>
                    <div style="position: absolute; display: inline; text-align: left;">
                        <asp:ImageButton ID="calendarButton" runat="server" Height="25px" 
                            ImageUrl="~/Images/calendar.png" onclick="calendarButton_Click" TabIndex="10" 
                            Width="25px" ValidationGroup="validateRegister" />
                        <asp:Calendar ID="calendar" runat="server" BackColor="#FFFFCC" BorderColor="#FFCC66" 
                            CssClass="hide calendar" DayNameFormat="Shortest" Font-Names="Verdana" 
                            Font-Size="8pt" ForeColor="#663399" Height="200px" 
                            onselectionchanged="calendar_SelectionChanged" Visible="False" 
                            BorderWidth="1px" Width="220px">
                            <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="1px" />
                            <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                            <OtherMonthDayStyle ForeColor="#CC9966" />
                            <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                            <SelectorStyle BackColor="#FFCC66" />
                            <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" 
                                ForeColor="#FFFFCC" />
                            <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                        </asp:Calendar>
                    </div>
                    <br />
                    <asp:Label ID="dobError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="genderImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/gender.png" Width="25px" />
                    &nbsp;<asp:RadioButtonList ID="gender" runat="server" CellPadding="5" 
                        CellSpacing="5" Height="25px" RepeatDirection="Horizontal" RepeatLayout="Flow" 
                        TabIndex="3" Width="300px" ToolTip="Sex">
                        <asp:ListItem Value="M">Him</asp:ListItem>
                        <asp:ListItem Value="F">Her</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="genderValidator" runat="server" 
                        ControlToValidate="gender" ErrorMessage="*" ForeColor="Red" Height="25px"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:Image ID="userImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/userNotFilled.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="userName" runat="server" Height="25px" 
                        placeholder="UserName" TabIndex="4" 
                        Width="300px" ToolTip="Choose a unique username." 
                        AutoCompleteType="Disabled" MaxLength="30" onkeypress="usernameError()"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="usernameValidator" runat="server" 
                        ControlToValidate="userName" ErrorMessage="*" ForeColor="Red" 
                        Height="25px"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="usernameError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="emailImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/emailId.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="emailID" runat="server" Height="25px" MaxLength="60" 
                        placeholder="Email ID" TabIndex="5" 
                        Width="300px" ToolTip="e-mail ID" AutoCompleteType="Disabled" onkeypress="emailError"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="emailValidator" runat="server" 
                        ControlToValidate="emailID" ErrorMessage="*" ForeColor="Red" Height="25px"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="emailError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="passImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/passNotFilled.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="password" runat="server" Height="25px" MaxLength="40" 
                        placeholder="Password" style="margin-bottom: 0px" TabIndex="6" 
                        TextMode="Password" Width="300px" ToolTip="Create password." 
                        AutoCompleteType="Disabled" onkeypress="passwordError()"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="passwordValidator" runat="server" 
                        ControlToValidate="password" ErrorMessage="*" ForeColor="Red" 
                        Height="25px"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="passwordError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                        <br />

                        <asp:Image ID="cpassImage" runat="server" Height="25px" Width="25px" 
                            ImageUrl="~/Images/passNotFilled.png" />

                        &nbsp;<asp:TextBox ID="confirmPassword" runat="server" 
                            placeholder="Confirm Password" Height="25px" Width="305px" 
                            TextMode="Password" MaxLength="40" TabIndex="7" 
                        ToolTip="Confirm Password." AutoCompleteType="Disabled" onfocus="confirmpasswordError()"></asp:TextBox>
                        <br />
                    <asp:CompareValidator ID="confirmpasswordValidator" runat="server" 
                        ControlToCompare="password" ControlToValidate="confirmPassword" 
                        ErrorMessage="Password does not match." ForeColor="Red" Height="25px" 
                        ValidationGroup="validateContent"></asp:CompareValidator>
                    <br />
                    <asp:Image ID="captchaImage" runat="server" />
                    <br />
                    <asp:TextBox ID="captcha" runat="server" Height="25px" 
                        placeholder="Enter text shown in the image above." 
                        ToolTip="Enter captcha text." Width="246px" onkeypress="captchaError()"></asp:TextBox>
                    <br />
                    <asp:CustomValidator ID="captchaValidator" runat="server" 
                        ControlToValidate="captcha" ErrorMessage="Invalid Captcha entered." 
                        ForeColor="Red"></asp:CustomValidator>
                    <br />
                    <br />

                        <asp:Button ID="Back" runat="server" Text="Back" BackColor="#FF6262" BorderColor="#FF6262" 
                            BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" TabIndex="9" 
                        UseSubmitBehavior="False" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="registerButton" runat="server" BackColor="#CCFF66" 
                        BorderColor="#CCFF66" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                        onclick="registerButton_Click" TabIndex="8" Text="Register" />
                        <br />
                        <br />
                </asp:View>
                <asp:View ID="successView" runat="server">
                    
                    <br />
                    
                    You are Successfully Registered. Click &#39;Login&#39; to proceed.<br />
                    <br />
                    <asp:Button ID="Home" runat="server" BackColor="#FFFF99" BorderColor="#FFFF99" 
                        BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                        onclick="homeButton_Click" Text="Login" UseSubmitBehavior="False" />
                    
                </asp:View>
            </asp:MultiView>
            
        </div>
    </div>
</asp:Content>

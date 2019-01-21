<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="Week2Module1.Account.Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .hide
        {}
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div id="formContainer">
        <div id="form">
            <asp:MultiView ID="registerForm" runat="server" ActiveViewIndex="0">
                <asp:View ID="registerView" runat="server">
                    <asp:Image ID="nameImage" runat="server" Height="25px" Width="25px" 
                            ImageUrl="~/Images/name.png" />

                        &nbsp;<asp:TextBox ID="name" runat="server" placeholder="Name" Height="25px" 
                            Width="300px" CausesValidation="True" MaxLength="40" 
                        ontextchanged="name_TextChanged" TabIndex="1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ErrorMessage="*" ForeColor="Red" Height="25px" ControlToValidate="name" 
                            ValidationGroup="validateContent"></asp:RequiredFieldValidator>
                        <br />
                        <asp:Label ID="nameError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="dobImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/dateOfBirth.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="dateOfBirth" runat="server" Height="25px" 
                        ontextchanged="dateOfBirth_TextChanged" placeholder="Date of Birth" 
                        TabIndex="2" Width="300px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="dateOfBirth" ErrorMessage="*" ForeColor="Red" Height="25px" 
                        ValidationGroup="validateContent"></asp:RequiredFieldValidator>
                    <div style="position: absolute; display: inline; text-align: left;">
                        <asp:ImageButton ID="calendarButton" runat="server" Height="25px" 
                            ImageUrl="~/Images/calendar.png" onclick="calendarButton_Click" TabIndex="2" 
                            Width="25px" />
                        <asp:Calendar ID="calendar" runat="server" BackColor="White" BorderColor="Gray" 
                            CssClass="hide calendar" DayNameFormat="Shortest" Font-Names="Century Gothic" 
                            Font-Size="10pt" ForeColor="Black" Height="152px" NextPrevFormat="ShortMonth" 
                            onselectionchanged="calendar_SelectionChanged" Visible="False">
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" 
                                ForeColor="#333333" Height="10pt" />
                            <DayStyle Width="14%" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" ForeColor="#333333" Width="1%" />
                            <TitleStyle BackColor="#999999" Font-Bold="True" Font-Size="13pt" 
                                ForeColor="White" Height="14pt" />
                            <TodayDayStyle BackColor="#CCCC99" />
                        </asp:Calendar>
                    </div>
                    <br />
                    <asp:Label ID="dobError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="Image8" runat="server" Height="25px" 
                        ImageUrl="~/Images/gender.png" Width="25px" />
                    &nbsp;<asp:RadioButtonList ID="gender" runat="server" CellPadding="5" 
                        CellSpacing="5" Height="25px" RepeatDirection="Horizontal" RepeatLayout="Flow" 
                        TabIndex="3" Width="300px">
                        <asp:ListItem Value="M">Him</asp:ListItem>
                        <asp:ListItem Value="F">Her</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="gender" ErrorMessage="*" ForeColor="Red" Height="25px" 
                        ValidationGroup="validateContent"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:Image ID="userImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/userNotFilled.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="userName" runat="server" Height="25px" 
                        ontextchanged="userName_TextChanged" placeholder="UserName" TabIndex="4" 
                        Width="300px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="userName" ErrorMessage="*" ForeColor="Red" Height="25px" 
                        ValidationGroup="validateContent"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="usernameError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="emailImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/emailId.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="emailID" runat="server" Height="25px" MaxLength="60" 
                        ontextchanged="emailID_TextChanged" placeholder="Email ID" TabIndex="5" 
                        Width="300px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="emailID" ErrorMessage="*" ForeColor="Red" Height="25px" 
                        ValidationGroup="validateContent"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="emailError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="passImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/passNotFilled.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="password" runat="server" Height="25px" MaxLength="40" 
                        placeholder="Password" style="margin-bottom: 0px" TabIndex="6" 
                        TextMode="Password" Width="300px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="password" ErrorMessage="*" ForeColor="Red" Height="25px" 
                        ValidationGroup="validateContent"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="passwordError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                        <br />

                        <asp:Image ID="cpassImage" runat="server" Height="25px" Width="25px" 
                            ImageUrl="~/Images/passNotFilled.png" />

                        &nbsp;<asp:TextBox ID="confirmPassword" runat="server" 
                            placeholder="Confirm Password" Height="25px" Width="300px" 
                            TextMode="Password" MaxLength="40" TabIndex="7"></asp:TextBox>
                        <br />
                        <asp:CompareValidator ID="CompareValidator1" runat="server" 
                            ControlToCompare="password" ControlToValidate="confirmPassword" 
                            ErrorMessage="Password does not match." ForeColor="Red" Height="25px" 
                            ValidationGroup="validateContent"></asp:CompareValidator>
                        <br />

                        <asp:Button ID="Back" runat="server" BackColor="#FF6262" BorderColor="#FF6262" 
                            BorderStyle="Solid" BorderWidth="5px" CssClass="buttons"
                            Text="Back" UseSubmitBehavior="False" TabIndex="9" />

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <asp:Button ID="registerButton" runat="server" Text="Register" 
                            onclick="registerButton_Click" BackColor="#CCFF66" BorderColor="#CCFF66" 
                            BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                            ValidationGroup="validateContent" TabIndex="8" />
                        <br />
                </asp:View>
                <asp:View ID="successView" runat="server">
                    
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

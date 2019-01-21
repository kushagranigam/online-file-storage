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
            <asp:Image ID="nameImage" runat="server" Height="25px" Width="25px" 
                ImageUrl="~/Images/name.png" />

            &nbsp;<asp:TextBox ID="name" runat="server" placeholder="Name" Height="25px" 
                Width="250px" CausesValidation="True"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ErrorMessage="*" ForeColor="Red" Height="25px" ControlToValidate="name" 
                ValidationGroup="validateContent"></asp:RequiredFieldValidator>
            <br />
            <br />

            <asp:Image ID="dobImage" runat="server" Height="25px" Width="25px" 
                ImageUrl="~/Images/dateOfBirth.png" />

            &nbsp;<asp:TextBox ID="dateOfBirth" runat="server" placeholder="Date of Birth" 
                Height="25px" Width="250px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ErrorMessage="*" ForeColor="Red" Height="25px" 
                ControlToValidate="dateOfBirth" ValidationGroup="validateContent"></asp:RequiredFieldValidator>

            <div style="position: absolute; display: inline; text-align: left;">

            <asp:ImageButton ID="calendarButton" runat="server" 
                ImageUrl="~/Images/calendar.png" onclick="calendarButton_Click" Height="25px"
                    Width="25px" />

                <asp:Calendar ID="calendar" runat="server" BackColor="White" 
                    BorderColor="Gray" DayNameFormat="Shortest" 
                    Font-Names="Century Gothic" Font-Size="10pt" ForeColor="Black" 
                    onselectionchanged="calendar_SelectionChanged" CssClass="hide calendar" 
                    Visible="False" Height="152px" NextPrevFormat="ShortMonth">
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
            <br />

            <asp:Image ID="Image8" runat="server" Height="25px" Width="25px" 
                ImageUrl="~/Images/gender.png" />

            &nbsp;<asp:RadioButtonList ID="gender" runat="server" CellPadding="5" CellSpacing="5" 
                RepeatDirection="Horizontal" RepeatLayout="Flow" Height="25px" 
                Width="250px">
                <asp:ListItem Value="M">Him</asp:ListItem>
                <asp:ListItem Value="F">Her</asp:ListItem>
            </asp:RadioButtonList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ErrorMessage="*" ForeColor="Red" Height="25px" ControlToValidate="gender" 
                ValidationGroup="validateContent"></asp:RequiredFieldValidator>

            <br />
            <br />

            <asp:Image ID="userImage" runat="server" Height="25px" Width="25px" 
                ImageUrl="~/Images/userNotFilled.png" />

            &nbsp;<asp:TextBox ID="userName" runat="server" placeholder="UserName" 
                Height="25px" Width="250px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ErrorMessage="*" ForeColor="Red" Height="25px" 
                ControlToValidate="userName" ValidationGroup="validateContent"></asp:RequiredFieldValidator>

            <br />
            <br />

            <asp:Image ID="emailImage" runat="server" Height="25px" Width="25px" 
                ImageUrl="~/Images/emailId.png" />

            &nbsp;<asp:TextBox ID="emailID" runat="server" placeholder="Email ID" 
                Height="25px" Width="250px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                ErrorMessage="*" ForeColor="Red" Height="25px" ControlToValidate="emailID" 
                ValidationGroup="validateContent"></asp:RequiredFieldValidator>

            <br />
            <br />

            <asp:Image ID="passImage" runat="server" Height="25px" Width="25px" 
                ImageUrl="~/Images/passNotFilled.png" />

            &nbsp;<asp:TextBox ID="password" runat="server" placeholder="Password" 
                Height="25px" Width="250px" style="margin-bottom: 0px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                ErrorMessage="*" ForeColor="Red" Height="25px" 
                ControlToValidate="password" ValidationGroup="validateContent"></asp:RequiredFieldValidator>
            <br />
            <br />

            <asp:Image ID="cpassImage" runat="server" Height="25px" Width="25px" 
                ImageUrl="~/Images/passNotFilled.png" />

            &nbsp;<asp:TextBox ID="confirmPassword" runat="server" 
                placeholder="Confirm Password" Height="25px" Width="250px"></asp:TextBox>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToCompare="password" ControlToValidate="confirmPassword" 
                ErrorMessage="*" ForeColor="Red" Height="25px" 
                ValidationGroup="validateContent"></asp:CompareValidator>
            <br />
            <br />

            <asp:Button ID="Back" runat="server" BackColor="#FF6262" BorderColor="#FF6262" 
                BorderStyle="Solid" BorderWidth="5px" CssClass="buttons"
                Text="Back" UseSubmitBehavior="False" />

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <asp:Button ID="registerButton" runat="server" Text="Register" 
                onclick="registerButton_Click" BackColor="#CCFF66" BorderColor="#CCFF66" 
                BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                ValidationGroup="validateContent" />
            <br />
        </div>
    </div>
</asp:Content>

<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="Week2Module1.Account.Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div id="formContainer">
        <div id="form">
            <asp:Image ID="nameImage" runat="server" Height="20px" Width="20px" />

            <asp:TextBox ID="name" runat="server" placeholder="Name"></asp:TextBox>
            <br />
            <br />

            <asp:Image ID="dobImage" runat="server" Height="20px" Width="20px" />

            <asp:TextBox ID="dateOfBirth" runat="server" placeholder="Date of Birth"></asp:TextBox>

            <div style="position: absolute; display: inline;">

            <asp:ImageButton ID="ImageButton1" runat="server" 
                ImageUrl="~/Images/Calendar.jpg" onclick="ImageButton1_Click"/>

                <asp:Calendar ID="calendar" runat="server" BackColor="White" 
                    BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" 
                    Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" 
                    onselectionchanged="calendar_SelectionChanged" CssClass="hide" 
                    Visible="False">
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                    <NextPrevStyle VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#808080" />
                    <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" />
                    <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                    <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <WeekendDayStyle BackColor="#FFFFCC" />
                </asp:Calendar>
            </div>
            <br />
            <br />

            <asp:Image ID="Image8" runat="server" Height="20px" Width="20px" />

            <asp:RadioButtonList ID="gender" runat="server" CellPadding="5" CellSpacing="5" 
                RepeatDirection="Horizontal" RepeatLayout="Flow">
                <asp:ListItem Value="M">Him</asp:ListItem>
                <asp:ListItem Value="F">Her</asp:ListItem>
            </asp:RadioButtonList>

            <br />
            <br />

            <asp:Image ID="userImage" runat="server" Height="20px" Width="20px" />

            <asp:TextBox ID="userName" runat="server" placeholder="UserName"></asp:TextBox>
            <br />
            <br />

            <asp:Image ID="emailImage" runat="server" Height="20px" Width="20px" />

            <asp:TextBox ID="emailID" runat="server" placeholder="Email ID"></asp:TextBox>
            <br />
            <br />

            <asp:Image ID="passImage" runat="server" Height="20px" Width="20px" />

            <asp:TextBox ID="password" runat="server" placeholder="Password"></asp:TextBox>
            <br />
            <br />

            <asp:Image ID="cpassImage" runat="server" Height="20px" Width="20px" />

            <asp:TextBox ID="confirmPassword" runat="server" placeholder="Confirm Password"></asp:TextBox>
            <br />
            <br />

            <asp:Button ID="registerButton" runat="server" Text="Register" 
                onclick="registerButton_Click" />
        </div>
    </div>
</asp:Content>

<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="ChangePassword.aspx.cs" Inherits="Week2Module1.Account.ChangePassword" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div id="formContainer" 
    style="display: block; width: 425px; margin: auto; ">
        <div id="form" 
            
            style="padding: 4px; float: left; width: 413px; ">

            <asp:Panel ID="Panel1" runat="server" GroupingText="Change Password">
                <asp:Image ID="passwordImage" runat="server" Height="20px" 
                ImageUrl="~/Images/passNotFilled.png" Width="20px" />
                <asp:TextBox ID="oldPass" runat="server" Height="25px" 
    Width="300px" placeholder="Old Password" MaxLength="40" 
    TextMode="Password" ValidationGroup="passwordChanger"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ErrorMessage="*" ForeColor="Red" ControlToValidate="oldPass" 
                    ValidationGroup="passwordChanger"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Image ID="passwordImage0" runat="server" Height="20px" 
                ImageUrl="~/Images/passNotFilled.png" Width="20px" />
                &nbsp;<asp:TextBox ID="newPass" runat="server" Height="25px" 
    Width="300px" placeholder="New Password" MaxLength="40" 
    TextMode="Password" ValidationGroup="passwordChanger"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ErrorMessage="*" ForeColor="Red" ControlToValidate="newPass" 
                    ValidationGroup="passwordChanger"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Image ID="passwordImage1" runat="server" Height="20px" 
                ImageUrl="~/Images/passNotFilled.png" Width="20px" />
                &nbsp;<asp:TextBox ID="confPass" runat="server" Height="25px" 
    Width="300px" placeholder="Confirm New Password" 
    MaxLength="40" TextMode="Password" ValidationGroup="passwordChanger"></asp:TextBox>
                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToCompare="confPass" ControlToValidate="newPass" ErrorMessage="*" 
                ForeColor="Red" 
    ValidationGroup="passwordChanger"></asp:CompareValidator>
                <br />
                <br />
                <asp:Label ID="errorText" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <br />
                <asp:Button ID="Back" runat="server" BackColor="#FF6262" 
                        BorderColor="#FF6262" BorderStyle="Solid" 
    BorderWidth="5px" CssClass="buttons" 
                        Text="Back" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="ChangePassButton" runat="server" Text="Change Password" 
                onclick="ChangePassButton_Click" BackColor="#CCFF66" BorderColor="#CCFF99" 
                BorderStyle="Solid" BorderWidth="5px" CssClass="buttons " 
                    ValidationGroup="passwordChanger" />
            </asp:Panel>

            <br />
        </div>
    </div>
</asp:Content>

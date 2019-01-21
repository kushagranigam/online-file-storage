<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyDrive.aspx.cs" Inherits="Week2Module1.MyDrive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="navigationPanel" runat="server">
    </asp:Panel>
    <asp:Panel ID="viewPanel" runat="server">
        <asp:Panel ID="Drive" runat="server" ScrollBars="Vertical">
        </asp:Panel>
        <asp:Panel ID="DriveOptions" runat="server">
            <asp:ImageButton ID="uploadButton" runat="server" Width="30px" Height="30px" 
                AlternateText="Upload" ImageUrl="~/Images/upload.png" ToolTip="Upload" />
            <asp:ImageButton ID="newFolderButton" runat="server" Width="30px" Height="30px" 
                AlternateText="New Folder" ImageUrl="~/Images/newFolder.png" 
                ToolTip="New Folder" />
            <asp:ImageButton ID="renameButton" runat="server" Width="30px" Height="30px" 
                AlternateText="Rename" ImageUrl="~/Images/rename.png" ToolTip="Rename" />
            <asp:ImageButton ID="selectButton" runat="server" AlternateText="Select" 
                Height="30px" ImageUrl="~/Images/select.png" ToolTip="Select" Width="30px" />
            <asp:ImageButton ID="deleteButton" runat="server" Width="30px" Height="30px" 
                AlternateText="Delete" ImageUrl="~/Images/delete.png" ToolTip="Delete" />
            <asp:ImageButton ID="ImageButton5" runat="server" AlternateText="Information" 
               Height="30px" ImageUrl="~/Images/info.png" ToolTip="Info" Width="30px" />
        </asp:Panel>
    </asp:Panel>
    <asp:Panel ID="optionsExtended" runat="server" Visible="False">

    </asp:Panel>
    <asp:Panel ID="infoPanel" runat="server">
    </asp:Panel>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyDrive.aspx.cs" Inherits="Week2Module1.MyDrive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- Navigation Panel -->

    <asp:Panel ID="navigationPanel" runat="server" CssClass="left" Width="19%" 
        BackColor="#D8D8D8">
        <asp:Button ID="hideNavigation" runat="server" Text="&lt;" />
        <asp:TreeView ID="DirectoryTree" runat="server" ImageSet="Arrows">
            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
            <NodeStyle Font-Names="Tahoma" Font-Size="10pt" ForeColor="Black" 
                HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
            <ParentNodeStyle Font-Bold="False" />
            <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" 
                HorizontalPadding="0px" VerticalPadding="0px" />
        </asp:TreeView>
    </asp:Panel>

    <!-- Drive View-->

    <asp:Panel ID="viewPanel" runat="server" CssClass="left" Width="60%" 
    Height="500px">
        
        <!-- Drive Contents -->

        <asp:Panel ID="Drive" runat="server" ScrollBars="Auto" Height="470px">
            <asp:TextBox ID="AddressBar" runat="server" Width="98%" Height="20px"></asp:TextBox>
        </asp:Panel>

        <!-- Option Action Bar -->

        <asp:Panel ID="optionsExtended" runat="server" Visible="False">
        <asp:FileUpload ID="uploadFile" runat="server" BackColor="White" 
            BorderColor="White" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
            Height="30px" Width="300px" />
        <br />
        <br />
        <asp:Button ID="cancelUploadButton" runat="server" BackColor="#FF6262" 
            BorderColor="#FF6262" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
            Text="Cancel" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="uploadFileButton" runat="server" BackColor="#CCFF66" 
            BorderColor="#CCFF66" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
            Text="Upload" />
        </asp:Panel>

        <!-- Actions -->

        <asp:Panel ID="DriveOptions" runat="server" CssClass="bottom" Height="30px">
            <asp:ImageButton ID="uploadButton" runat="server" Width="30px" Height="30px" 
                AlternateText="Upload" ImageUrl="~/Images/upload.png" ToolTip="Upload" 
                CommandName="upload" oncommand="driveButton_Command" />
            <asp:ImageButton ID="newFolderButton" runat="server" Width="30px" Height="30px" 
                AlternateText="New Folder" ImageUrl="~/Images/newFolder.png" 
                ToolTip="New Folder" CommandName="newFolder" 
                oncommand="driveButton_Command" />
            <asp:ImageButton ID="renameButton" runat="server" Width="30px" Height="30px" 
                AlternateText="Rename" ImageUrl="~/Images/rename.png" ToolTip="Rename" 
                CommandName="rename" oncommand="driveButton_Command" />
            <asp:ImageButton ID="selectButton" runat="server" AlternateText="Select" 
                Height="30px" ImageUrl="~/Images/select.png" ToolTip="Select" Width="30px" 
                CommandName="select" oncommand="driveButton_Command" />
            <asp:ImageButton ID="deleteButton" runat="server" Width="30px" Height="30px" 
                AlternateText="Delete" ImageUrl="~/Images/delete.png" ToolTip="Delete" 
                CommandName="delete" oncommand="driveButton_Command" />
            <asp:ImageButton ID="ImageButton5" runat="server" AlternateText="Information" 
               Height="30px" ImageUrl="~/Images/info.png" ToolTip="Info" Width="30px" 
                CommandName="info" oncommand="driveButton_Command" />
        </asp:Panel>

    </asp:Panel>

    <!-- Information Panel -->

    <asp:Panel ID="infoPanel" runat="server" CssClass="left" Width="19%" 
        BackColor="#A4E1FF">
        <asp:Image ID="selectedItem" runat="server" />
        <asp:Panel ID="infoDescription" runat="server">
        </asp:Panel>
    </asp:Panel>

</asp:Content>

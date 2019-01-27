﻿<%@ Page Title="Drive" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Week2Module1.MyDrive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="../Scripts/jquery-3.2.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%= DriveContent.ClientID %>").load("DriveLoader.aspx");
            $(document).on("click", "img.folder", function () {
                $("#<%= selectedItem.ClientID %>").attr("src", $(this).attr("src"));
                $("#<%= itemType.ClientID %>").val("Folder");
                var alt = $(this).attr("alt");
                $("#<%= itemName.ClientID %>").val(alt);
            });
            $(document).on("click", "img.file", function () {
                $("#<%= selectedItem.ClientID %>").attr("src", $(this).attr("src"));
                $("#<%= itemType.ClientID %>").val("File");
                var alt = $(this).attr("alt");
                $("#<%= itemName.ClientID %>").val(alt);
            });
           $(document).on("dblclick", "img.folder", function () {
                var alt = $(this).attr("alt");
                $("#<%= DriveContent.ClientID %>").load(
                    "DriveLoader.aspx",
                    {
                        action: 'open',
                        argument: alt
                    },
                    function () {
                    }
                );
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="driveBox">

        <!-- New Content: 28/06/2017 -->
        <div class="driveOptions">
            <div class="options right" id="more">
                <img src="../Images/essentials/more-1.png" height="20px" width="20px" alt="More.."/>
            </div>
            <div class="options right" id="delete">
                <img src="../Images/delete.png" height="20px" width="20px" alt="More.."/>
            </div>
            <div class="options right" id="rename">
                <img src="../Images/rename.png" height="20px" width="20px" alt="More.."/>
            </div>
            <div class="options right" id="newFolder">
                <img src="../Images/newFolder.png" height="20px" width="20px" alt="More.."/>
            </div>
            <div class="options right" id="upload">
                <img src="../Images/upload.png" height="20px" width="20px" alt="More.."/>
            </div>
        </div>

        <!-- End:: New Content: 28/06/2017 -->
        <div class="panelContainer left" style="width: 19%;">
            <asp:Panel ID="navigationPanel" runat="server"
                Height="500px" ScrollBars="Auto">
                <br />
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/home.png" 
                    oncommand="home_Command" style="height: 16px" CssClass="left" />
                &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" oncommand="home_Command" 
                    CssClass="left">Home</asp:LinkButton>
                <asp:TreeView ID="DirectoryTree" runat="server" 
                    onselectednodechanged="DirectoryTree_SelectedNodeChanged" CssClass="clear" 
                    ExpandDepth="0">
                    <LeafNodeStyle ImageUrl="~/Images/navFile.png" />
                    <NodeStyle ImageUrl="~/Images/navfolder.png" />
                </asp:TreeView>
            </asp:Panel>
        </div>

        <!-- Drive View-->
        <div class="panelContainer left" 
            style="width: 60%; border-left: 1px solid black;">
            <asp:Panel ID="viewPanel" runat="server">
        
                <!-- Drive Contents -->
                <%--<asp:Panel ID="CurrentNav" runat="server">
                    <asp:ImageButton ID="Home" runat="server" CssClass="left" 
                        ImageUrl="~/Images/home.png" oncommand="home_Command" />
                    <asp:Label ID="Label1" runat="server" CssClass="left" Font-Bold="True" 
                        Text="&amp;rtrif;"></asp:Label>
                </asp:Panel>--%>
                <asp:Panel ID="Drive" runat="server" ScrollBars="Auto" Height="470px">
                    <asp:Panel ID="DriveContent" runat="server" BackImageUrl="~/Images/source.gif">
                
                    </asp:Panel>
                </asp:Panel>

                <!-- Option Action Bar -->

                <%--<asp:Panel ID="optionsExtended" runat="server" Height="0px" BackColor="#E4E4E4">
                    <asp:MultiView ID="OptionViews" runat="server">
                        <asp:View ID="UploadView" runat="server">
                            <asp:FileUpload ID="uploadFilename" runat="server" BorderStyle="Solid" 
                                BorderWidth="1px" CssClass="buttons" 
                                Height="30px" Width="300px" />
                                &nbsp;
                            <br />
                            <br />
                            <asp:Button ID="cancelUploadButton" runat="server" BackColor="#FF6262" 
                                BorderColor="#FF6262" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                                Text="Cancel" oncommand="cancel_Command" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="uploadFileButton" runat="server" BackColor="#CCFF66" 
                                BorderColor="#CCFF66" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                                Text="Upload" CommandName="upload" oncommand="option_Command" />
                        </asp:View>
                        <asp:View ID="NewFolderView" runat="server">
                            <asp:TextBox ID="folderName" runat="server" Height="30px" Width="300px" placeholder="Folder Name"></asp:TextBox>
                            &nbsp;
                            <br />
                            <br />
                             <asp:Button ID="cancelFolderButton" runat="server" BackColor="#FF6262" 
                                BorderColor="#FF6262" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                                Text="Cancel" oncommand="cancel_Command" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="createFolderButton" runat="server" BackColor="#CCFF66" 
                                BorderColor="#CCFF66" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                                Text="Create" CommandName="newFolder" oncommand="option_Command" />
                        </asp:View>
                        <asp:View ID="renameView" runat="server">
                            <asp:TextBox ID="NewName" runat="server" Height="30px" placeholder="New Name" 
                                Width="300px"></asp:TextBox>
                            <br />
                            <br />
                            <asp:Button ID="cancelRenameButton" runat="server" BackColor="#FF6262" 
                                BorderColor="#FF6262" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                                Text="Cancel" oncommand="cancel_Command" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="renameItemButton" runat="server" BackColor="#CCFF66" 
                                BorderColor="#CCFF66" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                                Text="Rename" CommandName="rename" oncommand="option_Command" />
                        </asp:View>
                        <asp:View ID="deleteView" runat="server">
                            <asp:Literal ID="deleteMessage" runat="server" Text="Are you sure you want to delete this"></asp:Literal>
                            <br />
                            <br />
                            <asp:Button ID="cancelDelete" runat="server" BackColor="#FF6262" 
                                BorderColor="#FF6262" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                                Text="No" oncommand="cancel_Command" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="deleteItemButton" runat="server" BackColor="#CCFF66" 
                                BorderColor="#CCFF66" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                                Text="Yes" CommandName="delete" oncommand="option_Command" />
                        </asp:View>
                    </asp:MultiView>
                </asp:Panel>--%>

                <!-- Actions -->

                <%--<asp:Panel ID="DriveOptions" runat="server" CssClass="bottom" Height="30px">
                    <asp:ImageButton ID="uploadButton" runat="server" Width="30px" Height="30px" 
                        AlternateText="Upload" ImageUrl="~/Images/upload.png" ToolTip="Upload" 
                        CommandName="upload" oncommand="driveButton_Command" />
                    <asp:ImageButton ID="newFolderButton" runat="server" Width="30px" Height="30px" 
                        AlternateText="New Folder" ImageUrl="~/Images/newFolder.png" 
                        ToolTip="New Folder" CommandName="newFolder" 
                        oncommand="driveButton_Command" />
                </asp:Panel>--%>

            </asp:Panel>
        </div>
    

        <!-- Information Panel -->
        <div class="panelContainer left" style="width: 19%;">
            <asp:Panel ID="infoPanel" runat="server" Height="500px">
                <asp:Image ID="selectedItem" runat="server" Height="100px" Width="100px" 
                    ImageUrl="~/Images/drive.png" />
                <br />
                <asp:TextBox ID="itemName" runat="server" BorderStyle="None" 
                    CssClass="itemDetails" Enabled="False" Font-Bold="True" Text="Home"></asp:TextBox>
                <br />
                <asp:TextBox ID="itemType" runat="server" BorderStyle="None" 
                    CssClass="itemDetails" Enabled="False" Text="Drive"></asp:TextBox>
                <br />
                <asp:Panel ID="infoDescription" runat="server">
                </asp:Panel>
                <asp:Panel ID="itemActions" runat="server" GroupingText="Item Actions">
                    <%--<asp:ImageButton ID="renameButton" runat="server" Width="30px" Height="30px" 
                        AlternateText="Rename" ImageUrl="~/Images/rename.png" ToolTip="Rename" 
                        CommandName="rename" oncommand="driveButton_Command" />
                    <asp:ImageButton ID="deleteButton" runat="server" Width="30px" Height="30px" 
                        AlternateText="Delete" ImageUrl="~/Images/delete.png" ToolTip="Delete" 
                        CommandName="delete" oncommand="driveButton_Command" />--%>
                </asp:Panel>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
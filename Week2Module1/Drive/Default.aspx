<%@ Page Title="Drive" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Week2Module1.MyDrive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="../Scripts/jquery-3.2.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $name = "Home";
            $type = "Drive";
            $src = "../Images/drive.png";
            $label_value = "";

            //initial drive loading
            $("#<%= DriveContent.ClientID %>").load("DriveLoader.aspx");

            //Setting Information Panel Content
            $("#<%= selectedItem.ClientID %>").attr("src", "../Images/drive.png");
            $("#<%= selectedItem.ClientID %>").attr("alt", $name);
            $("#<%= itemType.ClientID %>").val($type);
            $("#<%= itemName.ClientID %>").val($name);

            //event for folder click
            $(document).on("click", "div.folder", function () {
                $("#<%= selectedItem.ClientID %>").attr("src", $(this).find("img").attr("src"));
                $("#<%= selectedItem.ClientID %>").attr("alt", $(this).find("input").val());
                $("#<%= itemType.ClientID %>").val("Folder");
                $("#<%= itemName.ClientID %>").val($(this).find("input").val());
            });

            //event for file click
            $(document).on("click", "div.file", function () {
                $("#<%= selectedItem.ClientID %>").attr("src", $(this).find("img").attr("src"));
                $("#<%= selectedItem.ClientID %>").attr("alt", $(this).find("input").val());
                $("#<%= itemType.ClientID %>").val("File");
                $("#<%= itemName.ClientID %>").val($(this).find("input").val());
            });

            //event for folder double-click
            $(document).on("dblclick", "div.folder", function () {
                $name = $(this).find("input").val();
                $src = $(this).attr("src");

                if ($(this).hasClass("folder"))
                    $type = "Folder"
                else if ($(this).hasClass("file"))
                    $type = "File";
                else
                    $type = "Drive";

                $("#<%= DriveContent.ClientID %>").load(
                    "DriveLoader.aspx",
                    {
                        action: 'open',
                        argument: $(this).find("input").val()
                    },
                    function () { }
                );
                return false;
            });

            //event for file double-click
            $(document).on("dblclick", "div.file", function () {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', "DriveLoader.aspx", true);
                xhr.responseType = 'arraybuffer';
                xhr.onload = function () {
                    if (this.status === 200) {
                        var filename = "";
                        var disposition = xhr.getResponseHeader('Content-Disposition');
                        if (disposition && disposition.indexOf('attachment') !== -1) {
                            var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                            var matches = filenameRegex.exec(disposition);
                            if (matches != null && matches[1]) filename = matches[1].replace(/['"]/g, '');
                        }
                        var type = xhr.getResponseHeader('Content-Type');

                        var blob = new Blob([this.response], { type: type });
                        if (typeof window.navigator.msSaveBlob !== 'undefined') {

                            window.navigator.msSaveBlob(blob, filename);
                        } else {
                            var URL = window.URL || window.webkitURL;
                            var downloadUrl = URL.createObjectURL(blob);

                            if (filename) {

                                var a = document.createElement("a");

                                if (typeof a.download === 'undefined') {
                                    window.location = downloadUrl;
                                } else {
                                    a.href = downloadUrl;
                                    a.download = filename;
                                    document.body.appendChild(a);
                                    a.click();
                                }
                            } else {
                                window.location = downloadUrl;
                            }

                            setTimeout(function () { URL.revokeObjectURL(downloadUrl); }, 100);
                        }
                    }
                };
                xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                xhr.send("action=download&argument=" + $(this).find("img").attr("alt"));
                return false;
            });

            //event for drive click
            $("#<%= DriveContent.ClientID %>").click(function () {
                $("#<%= selectedItem.ClientID %>").attr("src", $src);
                $("#<%= selectedItem.ClientID %>").attr("alt", $name);
                $("#<%= itemType.ClientID %>").val($type);
                $("#<%= itemName.ClientID %>").val($name);

            });

            $("#rename").click(renameItem);

            $(document).on("keypress", "input.focus", function (e) {
                if (e.which == 13) {
                    $(this).attr("disabled", "disabled").removeClass("focus").addClass("label");
                    $image = $(this).attr("id") + "-img";
                    
                    $("#<%= DriveContent.ClientID %>").load(
                        "DriveLoader.aspx",
                        {
                            action: 'rename',
                            argument: $("#"+$image).attr("alt"),
                            argument_2: $(this).val()
                        },
                        function () { }
                    );
                    return false;
                }
            });
        });
        function renameItem() {
            var temp = $("#<%= itemType.ClientID %>").val();
            if (temp != "Drive") {
                var id_temp = $("#<%= itemName.ClientID %>").val().replace(/\./g, '-').replace(/( )/g, '-');
                id_temp = "input#" + id_temp + ".label";
                $label_value = $(id_temp).val();
                $(id_temp).removeAttr("disabled").removeClass("label").addClass("focus").focus().val("").val($label_value);
            }
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="driveBox">

        <%-- New Content: 28/06/2017 --%>

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

        <%-- End:: New Content: 28/06/2017 --%>


        <div class="panelContainer left" style="width: 19%;">
            <asp:Panel ID="navigationPanel" runat="server"
                Height="500px" ScrollBars="Auto">
                <br />
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/home.png" 
                    oncommand="home_Command" style="height: 16px" CssClass="left" />
                &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" oncommand="home_Command" 
                    CssClass="left">Home</asp:LinkButton>
                <asp:TreeView ID="DirectoryTree" runat="server" CssClass="clear" 
                    ExpandDepth="0">
                    <LeafNodeStyle ImageUrl="~/Images/navFile.png" />
                    <NodeStyle ImageUrl="~/Images/navfolder.png" />
                </asp:TreeView>
            </asp:Panel>
        </div>


        <%-- Drive View--%>
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

                <%-- Option Action Bar --%>

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

                <%-- Actions --%>

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
    

        <%-- Information Panel --%>
        <div class="panelContainer left" style="width: 19%;">
            <asp:Panel ID="infoPanel" runat="server" Height="500px">
                <div class="infoimage">
                     <asp:Image ID="selectedItem" runat="server" Height="100px" Width="100px" 
                    ImageUrl="~/Images/drive.png" />
                </div>
                <br />
                <br />
                <asp:TextBox ID="itemName" runat="server" BorderStyle="None" 
                    CssClass="itemDetails" Enabled="False" Font-Bold="True" Text="Home" 
                    Height="16px" Width="121px"></asp:TextBox>
                <br />
                <asp:TextBox ID="itemType" runat="server" BorderStyle="None" 
                    CssClass="itemDetails" Enabled="False" Text="Drive"></asp:TextBox>
                <br />
                <br />
                <asp:Panel ID="infoDescription" runat="server">
                </asp:Panel>
                <%--<asp:Panel ID="itemActions" runat="server" GroupingText="Item Actions">
                    <asp:ImageButton ID="renameButton" runat="server" Width="30px" Height="30px" 
                        AlternateText="Rename" ImageUrl="~/Images/rename.png" ToolTip="Rename" 
                        CommandName="rename" oncommand="driveButton_Command" />
                    <asp:ImageButton ID="deleteButton" runat="server" Width="30px" Height="30px" 
                        AlternateText="Delete" ImageUrl="~/Images/delete.png" ToolTip="Delete" 
                        CommandName="delete" oncommand="driveButton_Command" />
                </asp:Panel>--%>
            </asp:Panel>
        </div>
    </div>
</asp:Content>

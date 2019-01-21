using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Week2Module1
{
    public static class PathStore
    {
        static String path;
        static String action;
        public static String currentPath
        {
            get
            {
                return path;
            }
            set
            {
                path = value;
            }
        }
        public static String actionPath
        {
            get
            {
                return action;
            }
            set
            {
                action = value;
            }
        }
    }

    public partial class MyDrive : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
            String FolderName = String.Empty;

            if(Session["handle"] != null)
                FolderName = Session["handle"].ToString().Replace(' ', '_');
            String path = FolderName + @"\";
            if (!Page.IsPostBack)
            {
                PathStore.currentPath = String.Copy(Server.MapPath("~").ToString() + @"Directories\" + FolderName);
                createNavPan(PathStore.currentPath, null, 'n');
            }
            addDirectory();
            AddressBar.Text = path;
        }
        protected void driveButton_Command(object sender, CommandEventArgs e)
        {
            switch(e.CommandName)
            {
                case "upload":
                    Drive.Height = 380;
                    optionsExtended.Height = 90;
                    OptionViews.ActiveViewIndex = 0;
                    break;
                case "newFolder":
                    Drive.Height = 380;
                    optionsExtended.Height = 90;
                    OptionViews.ActiveViewIndex = 1;
                    break;
                case "rename":
                    Drive.Height = 380;
                    optionsExtended.Height = 90;
                    OptionViews.ActiveViewIndex = 2;
                    break;
                case "delete":
                    Drive.Height = 380;
                    optionsExtended.Height = 90;
                    OptionViews.ActiveViewIndex = 3;
                    deleteMessage.Text = deleteMessage.Text + itemType.Text + "?";
                    break;
                default:
                    Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(e.CommandName));
                    break;
            }
        }

        void addDirectory()
        {
            DriveContent.Controls.Clear();

            int i = 1;
            DirectoryInfo MyDirectory = new DirectoryInfo(PathStore.currentPath);
            try
            {
                DirectoryInfo[] MySub = MyDirectory.GetDirectories();
                FileInfo[] MyFiles = MyDirectory.GetFiles();

                Panel FoldersList = new Panel();
                FoldersList.ID = "folders";
                Panel FilesList = new Panel();
                FilesList.ID = "files";
                foreach (DirectoryInfo subD in MySub)
                {
                    Panel directoryContainer = new Panel();
                    directoryContainer.ID = "FolderContainer" + i;
                    ImageButton directory = new ImageButton();
                    directory.ID = "Folder" + (i++);
                    directory.CssClass = "folder";
                    directory.Height = 80;
                    directory.Width = 100;
                    directory.AlternateText = subD.Name;
                    directory.ImageUrl = "Images/folder.png";
                    directory.Command += itemImageClick_Command;
                    directory.CommandArgument = "Folder";
                    directory.CommandName = subD.Name;

                    directoryContainer.Controls.Add(directory);
                    LinkButton name = new LinkButton();
                    name.Text = subD.Name;
                    name.Command += itemClick_Command;
                    name.CommandArgument = "Folder";
                    name.CommandName = subD.Name;
                    name.Width = 80;
                    directoryContainer.Controls.Add(new LiteralControl("<br/>"));
                    directoryContainer.Controls.Add(name);
                    directoryContainer.CssClass = "left container";
                    FoldersList.GroupingText = "Folders";
                    FoldersList.Controls.Add(directoryContainer);
                }
                i = 1;
                foreach (FileInfo files in MyFiles)
                {
                    Panel fileContainer = new Panel();
                    fileContainer.ID = "FileContainer" + i;
                    ImageButton file = new ImageButton();
                    file.ID = "File" + (i++);
                    file.CssClass = "file";
                    file.Height = 100;
                    file.Width = 80;
                    file.AlternateText = files.Name;
                    file.Command += itemImageClick_Command;
                    file.CommandArgument = "File";
                    file.CommandName = files.Name;
                    try
                    {
                        String url = @"Images/Files/" + files.Extension.ToString().Replace(".", "") + ".png";
                        if (!File.Exists(Server.MapPath("~") + url))
                            throw (new Exception());
                        file.ImageUrl = url;
                    }
                    catch (Exception err)
                    {
                        file.ImageUrl = @"Images/file.png";
                    }
                    
                    fileContainer.Controls.Add(file);
                    LinkButton name = new LinkButton();
                    name.Text = files.Name;
                    name.Command += itemClick_Command;
                    name.CommandArgument = "File";
                    name.CommandName = files.Name;
                    name.Width = 80;
                    fileContainer.Controls.Add(new LiteralControl("<br/>"));
                    fileContainer.Controls.Add(name);
                    fileContainer.CssClass = "left container";
                    FilesList.GroupingText = "Files";
                    FilesList.Controls.Add(fileContainer);
                }
                DriveContent.Controls.Add(FoldersList);
                DriveContent.Controls.Add(FilesList);
                Drive.Controls.Add(DriveContent);
            }
            catch (Exception err)
            {
                Response.Write(err.ToString());
            }
        }
        void createNavPan(String root, String node, char isNode)
        {
            DirectoryInfo MyDirectory = new DirectoryInfo(root);
            try
            {
                DirectoryInfo[] MySub = MyDirectory.GetDirectories();
                FileInfo[] MyFiles = MyDirectory.GetFiles();

                foreach(DirectoryInfo folder in MySub)
                {
                    TreeNode newDirectory = new TreeNode();
                    newDirectory.Text = folder.Name.ToString().Replace("_"," ");
                    newDirectory.SelectAction = TreeNodeSelectAction.SelectExpand;
                    newDirectory.ImageUrl = "Images/navfolder.png";
                    if(isNode != 'y')
                        DirectoryTree.Nodes.Add(newDirectory);
                    else
                        DirectoryTree.FindNode(node).ChildNodes.Add(newDirectory);
                    createNavPan(root+"/"+folder.Name, newDirectory.ValuePath.ToString(), 'y');
                }

                foreach(FileInfo file in MyFiles)
                {
                    TreeNode newFile = new TreeNode();
                    newFile.Text = file.Name;
                    newFile.SelectAction = TreeNodeSelectAction.Select;
                    newFile.ImageUrl = "Images/navfile.png";
                    if(isNode != 'y')
                            DirectoryTree.Nodes.Add(newFile);
                    else
                        DirectoryTree.FindNode(node).ChildNodes.Add(newFile);
                }
            }
            catch (Exception err)
            {
                Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
            }
        }

        protected void cancel_Command(object sender, CommandEventArgs e)
        {
            Drive.Height = 470;
            optionsExtended.Height = 0;
            OptionViews.ActiveViewIndex = -1;
        }

        int uploadFile()
        {
            if (uploadFilename.HasFile)
            {
                try
                {
                    uploadFilename.SaveAs(PathStore.currentPath + uploadFilename.FileName);
                    return 0;
                }
                catch (Exception err)
                {
                    Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
                    return 1;
                }
            }
            return -1;
        }

        int createFolder()
        {
            if (folderName.Text != null)
            {
                try
                {
                    DirectoryInfo currentDirectory = new DirectoryInfo(PathStore.currentPath);
                    currentDirectory.CreateSubdirectory(folderName.Text);
                }
                catch (Exception err)
                {
                    Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
                    return 1;
                }
            }
            return -1;
        }

        int renameItem()
        {
            if (selectedItem.AlternateText != null)
            {

                Directory.Move(PathStore.currentPath + @"\" + selectedItem.AlternateText.ToString(), PathStore.currentPath + @"\" + selectedItem.AlternateText.ToString() + "_temp");
                Directory.Move(PathStore.currentPath + @"\" + selectedItem.AlternateText.ToString() + "_temp", PathStore.currentPath + @"\" + NewName.Text);
                return 0;
            }
            else
            {
                return -1;
            }
        }

        int deleteItem()
        {
            if (selectedItem.AlternateText != null)
            {
                if (String.Compare(itemType.Text, "File") == 0)
                {
                    FileInfo deleteFile = new FileInfo(PathStore.currentPath + @"\" + selectedItem.AlternateText);
                    if (deleteFile.Exists)
                        deleteFile.Delete();
                }
                else
                {
                    DirectoryInfo deleteFolder = new DirectoryInfo(PathStore.currentPath + @"\" + selectedItem.AlternateText);
                    if (deleteFolder.Exists)
                        deleteFolder.Delete();
                }
                return 0;
            }
            else
            {
                return -1;
            }
        }

        protected void option_Command(object sender, CommandEventArgs e)
        {
            int responseCode;
            switch (e.CommandName)
            {
                case "upload":
                    responseCode = uploadFile();
                    if (responseCode == 0)
                        Response.Redirect("~/Error.aspx?error="+Server.UrlEncode("Unable to upload!"));
                    Response.Redirect(Request.UrlReferrer.ToString());
                    break;
                case "newFolder":
                    responseCode = createFolder();
                    if (responseCode == 0)
                        Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode("Unable to create folder!"));
                    Response.Redirect(Request.UrlReferrer.ToString());
                    break;
                case "rename":
                    responseCode = renameItem();
                    if (responseCode != 0)
                        Response.Redirect("~/Error.aspx?error="+Server.UrlEncode("Unable to rename!"));
                    Response.Redirect(Request.UrlReferrer.ToString());
                    break;
                case "delete":
                    responseCode = deleteItem();
                    if(responseCode != 0)
                        Response.Redirect("~/Error.aspx?error="+Server.UrlEncode("Unable to delete!"));
                    Response.Redirect(Request.UrlReferrer.ToString());
                    break;
                default:
                    break;
            }
        }



        protected void itemClick_Command(object sender, CommandEventArgs e)
        {
            switch (e.CommandArgument.ToString())
            {
                case "Folder":
                    PathStore.currentPath = PathStore.currentPath + @"\" + e.CommandName.ToString();
                    addDirectory();
                    break;
                case "File":
                    Response.AddHeader("content-disposition","inline;filename="+e.CommandName.ToString());
                    break;
                default:
                    break;
            }
        }

        protected void itemImageClick_Command(object sender, CommandEventArgs e)
        {
            selectedItem.AlternateText = e.CommandName;
            itemType.Text = e.CommandArgument.ToString();
        }
    }
}
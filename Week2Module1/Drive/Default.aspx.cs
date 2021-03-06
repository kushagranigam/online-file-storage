﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Week2Module1
{
    public partial class MyDrive : System.Web.UI.Page
    {
        
        protected String filter(String val)
        {
            val.Trim();
            val = Server.HtmlEncode(val);
            val.Replace("/", "");
            return val;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //rememberMe();
            if (Session["handle"] != null)
            {
                SessionStore.handle = filter((String)Session["handle"]);
                SessionStore.username = filter((String)Session["username"]);

                //String FolderName = String.Empty;
                //FolderName = Session["handle"].ToString().Replace(' ', '_');
                byte[] folderBytes = Encoding.UTF8.GetBytes(SessionStore.username);
                SHA1 foldercrypter = new SHA1CryptoServiceProvider();
                byte[] cryptedFolderBytes = foldercrypter.ComputeHash(folderBytes);
                String FolderName = BitConverter.ToString(cryptedFolderBytes).Replace("-", "").ToLower();

                PathStore.basePath = PathStore.relativePath = "~/Directories/" + FolderName;
                if (!Page.IsPostBack)
                {
                    PathStore.currentPath = (Server.MapPath("~") + @"\Directories\" + FolderName);
                    DirectoryInfo userFolder = new DirectoryInfo(PathStore.currentPath);
                    if (!userFolder.Exists)
                    {
                        DirectoryInfo create = new DirectoryInfo(Server.MapPath("~").ToString() + @"Directories\");
                        create.CreateSubdirectory(FolderName);
                    }
                    createNavPan(SessionStore.username+"_root", -1, null);
                    //createNavPan(PathStore.currentPath, null, 'n', null, 0);
                }
                //addDirectory();
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        //protected void rememberMe()
        //{
        //    if (Session["rememberMe"] != null && (bool)Session["rememberMe"])
        //    {
        //        Response.Cookies["userName"].Value = (String)Session["userName"];
        //        Response.Cookies["userName"].Expires = DateTime.Now.AddDays(30d);
        //    }
        //}
        //protected void driveButton_Command(object sender, CommandEventArgs e)
        //{
        //    switch(e.CommandName)
        //    {
        //        case "upload":
        //            Drive.Height = 380;
        //            optionsExtended.Height = 90;
        //            OptionViews.ActiveViewIndex = 0;
        //            break;
        //        case "newFolder":
        //            Drive.Height = 380;
        //            optionsExtended.Height = 90;
        //            OptionViews.ActiveViewIndex = 1;
        //            break;
        //        case "rename":
        //            if (selectedItem.AlternateText.Length > 0)
        //            {
        //                Drive.Height = 380;
        //                optionsExtended.Height = 90;
        //                OptionViews.ActiveViewIndex = 2;
        //            }
        //            break;
        //        case "delete":
        //            if (selectedItem.AlternateText.Length > 0)
        //            {
        //                Drive.Height = 380;
        //                optionsExtended.Height = 90;
        //                OptionViews.ActiveViewIndex = 3;
        //                deleteMessage.Text = deleteMessage.Text + itemType.Text + "?";
        //            }
        //            break;
        //        default:
        //            Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(e.CommandName));
        //            break;
        //    }
        //}

        //void addDirectory()
        //{
        //    DriveContent.Controls.Clear();

        //    int i = 1;
        //    DirectoryInfo MyDirectory = new DirectoryInfo(PathStore.currentPath);
        //    try
        //    {
        //        DirectoryInfo[] MySub = MyDirectory.GetDirectories();
        //        FileInfo[] MyFiles = MyDirectory.GetFiles();

        //        Panel FoldersList = new Panel();
        //        FoldersList.ID = "folders";
        //        Panel FilesList = new Panel();
        //        FilesList.ID = "files";
        //        foreach (DirectoryInfo subD in MySub)
        //        {
        //            Panel directoryContainer = new Panel();
        //            directoryContainer.ID = "FolderContainer" + i;
        //            ImageButton directory = new ImageButton();
        //            directory.ID = "Folder" + (i++);
        //            directory.CssClass = "folder";
        //            directory.Height = 80;
        //            directory.Width = 100;
        //            directory.AlternateText = subD.Name;
        //            directory.ImageUrl = "Images/folder.png";
        //            directory.Command += itemImageClick_Command;
        //            directory.CommandArgument = "Folder";
        //            directory.CommandName = subD.Name;

        //            directoryContainer.Controls.Add(directory);
        //            LinkButton name = new LinkButton();
        //            name.Text = subD.Name;
        //            name.Command += itemClick_Command;
        //            name.CommandArgument = "Folder";
        //            name.CommandName = subD.Name;
        //            name.Width = 80;
        //            directoryContainer.Controls.Add(new LiteralControl("<br/>"));
        //            directoryContainer.Controls.Add(name);
        //            directoryContainer.CssClass = "left container";
        //            FoldersList.GroupingText = "Folders";
        //            FoldersList.Controls.Add(directoryContainer);
        //        }
        //        i = 1;
        //        foreach (FileInfo files in MyFiles)
        //        {
        //            Panel fileContainer = new Panel();
        //            fileContainer.ID = "FileContainer" + i;
        //            ImageButton file = new ImageButton();
        //            file.ID = "File" + (i++);
        //            file.CssClass = "file";
        //            file.Height = 100;
        //            file.Width = 80;
        //            file.AlternateText = files.Name;
        //            file.Command += itemImageClick_Command;
        //            file.CommandArgument = "File";
        //            file.CommandName = files.Name;
        //            try
        //            {
        //                String url = @"Images/Files/" + files.Extension.ToString().Replace(".", "") + ".png";
        //                if (!File.Exists(Server.MapPath("~") + url))
        //                    throw (new Exception());
        //                file.ImageUrl = url;
        //            }
        //            catch (Exception err)
        //            {
        //                file.ImageUrl = @"Images/file.png";
        //            }

        //            fileContainer.Controls.Add(file);
        //            HyperLink name = new HyperLink();
        //            name.Text = files.Name;
        //            name.Target = "_blank";
        //            name.NavigateUrl = PathStore.relativePath + "/" + files.Name;
        //            name.Width = 80;
        //            fileContainer.Controls.Add(new LiteralControl("<br/>"));
        //            fileContainer.Controls.Add(name);
        //            fileContainer.CssClass = "left container";
        //            FilesList.GroupingText = "Files";
        //            FilesList.Controls.Add(fileContainer);
        //        }
        //        DriveContent.Controls.Add(FoldersList);
        //        DriveContent.Controls.Add(FilesList);
        //        Drive.Controls.Add(DriveContent);
        //    }
        //    catch (Exception err)
        //    {
        //        Response.Write(err.ToString());
        //    }
        //}

        //void createNavPan(String root, String valuePath, char isNode, String folderName, int chk)
        void createNavPan(String nodename, int parentnode, String valuepath)
        {
            /*      New Code: 29/06/2017        */

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);
            conn.Open();

            try
            {
                SqlCommand getNodes = null;
                if (parentnode == -1)
                    getNodes = new SqlCommand("select duid, isdirectory, nodename, parentNode from directories where nodename = \'" + nodename + "\' and parentNode = " + parentnode, conn);
                else
                    getNodes = new SqlCommand("select duid, isdirectory, nodename, parentNode from directories where parentNode = " + parentnode + " order by isdirectory desc", conn);
                SqlDataReader nodes = null;
                nodes = getNodes.ExecuteReader();

                if (nodes.HasRows)
                {
                    if (parentnode != -1)
                    {
                        while (nodes.Read())
                        {
                            if ((int)nodes[1] == 1)
                            {
                                TreeNode folder = new TreeNode();
                                folder.Text = (String)nodes[2];
                                folder.ImageUrl = "~/Images/navfolder.png";
                                folder.SelectAction = TreeNodeSelectAction.None;
                                folder.Value = (String)nodes[2];
                                if (valuepath != null)
                                    DirectoryTree.FindNode(valuepath).ChildNodes.Add(folder);
                                else
                                    DirectoryTree.Nodes.Add(folder);
                                createNavPan((String)nodes[2], (int)nodes[0], folder.ValuePath);
                            }
                            else
                            {
                                TreeNode file = new TreeNode();
                                file.Text = (String)nodes[2];
                                file.ImageUrl = "~/Images/navfile.png";
                                file.SelectAction = TreeNodeSelectAction.None;
                                file.Value = (String)nodes[2];
                                if (valuepath != null)
                                    DirectoryTree.FindNode(valuepath).ChildNodes.Add(file);
                                else
                                    DirectoryTree.Nodes.Add(file);
                            }
                        }
                    }
                    else
                    {
                        nodes.Read();
                        createNavPan((String)nodes[2], (int)nodes[0], null);
                    }
                }
            }
            catch (Exception err)
            {
                Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
            }
            finally
            {
                conn.Close();
            }

            /*      Old Code        */

            //if (chk == 1)
            //    PathStore.relativePath += ("/" + folderName);
            //DirectoryInfo MyDirectory = new DirectoryInfo(root);
            //try
            //{
            //    DirectoryInfo[] MySub = MyDirectory.GetDirectories();
            //    FileInfo[] MyFiles = MyDirectory.GetFiles();

            //    foreach (DirectoryInfo folder in MySub)
            //    {
            //        TreeNode newDirectory = new TreeNode();
            //        newDirectory.Text = folder.Name.ToString().Replace("_", " ");
            //        newDirectory.SelectAction = TreeNodeSelectAction.SelectExpand;
            //        newDirectory.ImageUrl = "~/Images/navfolder.png";
            //        newDirectory.Value = folder.Name;
            //        if (isNode != 'y')
            //            DirectoryTree.Nodes.Add(newDirectory);
            //        else
            //            DirectoryTree.FindNode(valuePath).ChildNodes.Add(newDirectory);
            //        createNavPan(root + @"\" + folder.Name, newDirectory.ValuePath, 'y', folder.Name, 1);
            //    }

            //    foreach (FileInfo file in MyFiles)
            //    {
            //        TreeNode newFile = new TreeNode();
            //        newFile.Text = file.Name;
            //        newFile.SelectAction = TreeNodeSelectAction.Select;
            //        newFile.ImageUrl = "~/Images/navfile.png";
            //        newFile.Value = "File";
            //        newFile.Target = "_blank";
            //        if (isNode != 'y')
            //        {
            //            newFile.NavigateUrl = PathStore.basePath + "/" + file.Name;
            //            DirectoryTree.Nodes.Add(newFile);
            //        }
            //        else
            //        {
            //            newFile.NavigateUrl = PathStore.relativePath + "/" + file.Name;
            //            DirectoryTree.FindNode(valuePath).ChildNodes.Add(newFile);
            //        }
            //    }
            //    int rm = PathStore.relativePath.LastIndexOf("/" + folderName);
            //    if (rm != -1 && chk == 1)
            //    {
            //        PathStore.relativePath = PathStore.relativePath.Remove(rm, ("/" + folderName).Length);
            //    }
            //}
            //catch (Exception err)
            //{
            //    Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
            //}
        }

        //protected void cancel_Command(object sender, CommandEventArgs e)
        //{
        //    Drive.Height = 470;
        //    optionsExtended.Height = 0;
        //    OptionViews.ActiveViewIndex = -1;
        //}

        //int uploadFile()
        //{
        //    if (uploadFilename.HasFile)
        //    {
        //        try
        //        {
        //            uploadFilename.SaveAs(PathStore.currentPath + @"\" + uploadFilename.FileName);
        //            return 0;
        //        }
        //        catch (Exception err)
        //        {
        //            Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
        //            return 1;
        //        }
        //    }
        //    else
        //    {
        //        return -1;
        //    }
        //}

        //int createFolder()
        //{
        //    if (folderName.Text != null)
        //    {
        //        try
        //        {
        //            DirectoryInfo currentDirectory = new DirectoryInfo(PathStore.currentPath);
        //            currentDirectory.CreateSubdirectory(folderName.Text);
        //        }
        //        catch (Exception err)
        //        {
        //            Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
        //            return 1;
        //        }
        //    }
        //    return -1;
        //}

        //int renameItem()
        //{
        //    if (selectedItem.AlternateText != null)
        //    {

        //        Directory.Move(PathStore.currentPath + @"\" + selectedItem.AlternateText.ToString(), PathStore.currentPath + @"\" + selectedItem.AlternateText.ToString() + "_temp");
        //        Directory.Move(PathStore.currentPath + @"\" + selectedItem.AlternateText.ToString() + "_temp", PathStore.currentPath + @"\" + NewName.Text);
        //        return 0;
        //    }
        //    else
        //    {
        //        return -1;
        //    }
        //}

        //int deleteItem()
        //{
        //    if (selectedItem.AlternateText != null)
        //    {
        //        if (String.Compare(itemType.Text, "File") == 0)
        //        {
        //            FileInfo deleteFile = new FileInfo(PathStore.currentPath + @"\" + selectedItem.AlternateText);
        //            if (deleteFile.Exists)
        //                deleteFile.Delete();
        //        }
        //        else
        //        {
        //            DirectoryInfo deleteFolder = new DirectoryInfo(PathStore.currentPath + @"\" + selectedItem.AlternateText);
        //            if (deleteFolder.Exists)
        //                deleteFolder.Delete(true);
        //        }
        //        return 0;
        //    }
        //    else
        //    {
        //        return -1;
        //    }
        //}

        //protected void option_Command(object sender, CommandEventArgs e)
        //{
        //    int responseCode;
        //    switch (e.CommandName)
        //    {
        //        case "upload":
        //            responseCode = uploadFile();
        //            if (responseCode == -1)
        //                Response.Redirect("~/Error.aspx?error="+Server.UrlEncode("Unable to upload!"));
        //            Response.Redirect(Request.UrlReferrer.ToString());
        //            break;
        //        case "newFolder":
        //            responseCode = createFolder();
        //            if (responseCode == -1)
        //                Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode("Unable to create folder!"));
        //            Response.Redirect(Request.UrlReferrer.ToString());
        //            break;
        //        case "rename":
        //            responseCode = renameItem();
        //            if (responseCode == -1)
        //                Response.Redirect("~/Error.aspx?error="+Server.UrlEncode("Unable to rename!"));
        //            Response.Redirect(Request.UrlReferrer.ToString());
        //            break;
        //        case "delete":
        //            responseCode = deleteItem();
        //            if(responseCode == -1)
        //                Response.Redirect("~/Error.aspx?error="+Server.UrlEncode("Unable to delete!"));
        //            Response.Redirect(Request.UrlReferrer.ToString());
        //            break;
        //        default:
        //            break;
        //    }
        //}



        //protected void itemClick_Command(object sender, CommandEventArgs e)
        //{
        //    switch (e.CommandArgument.ToString())
        //    {
        //        case "Folder":
        //            PathStore.currentPath = PathStore.currentPath + @"\" + e.CommandName.ToString();
        //            Button link = new Button();
        //            link.Text = e.CommandName;
        //            link.BorderStyle = BorderStyle.None;
        //            link.Command += link_Command;
        //            link.CssClass = "left";
        //            link.ID = "CurrentNavFolder" + e.CommandName;
        //            link.CommandArgument = e.CommandName;
        //            CurrentNav.Controls.Add(link);
        //            Label rtrif_ = new Label();
        //            rtrif_.Text = "&rtrif;";
        //            rtrif_.ID = "CurrentNavRTRIF" + e.CommandName;
        //            rtrif_.CssClass = "left";
        //            CurrentNav.Controls.Add(rtrif_);
        //            //addDirectory();
        //            break;
        //        default:
        //            break;
        //    }
        //}

        //protected void itemImageClick_Command(object sender, CommandEventArgs e)
        //{
        //    selectedItem.AlternateText = e.CommandName;
        //    itemType.Text = e.CommandArgument.ToString();
        //    itemName.Text = e.CommandName;
        //    ImageButton i = sender as ImageButton;
        //    selectedItem.ImageUrl = i.ImageUrl;
        //}

        protected void DirectoryTree_SelectedNodeChanged(object sender, EventArgs e)
        {
            int c = 1;
            PathStore.currentPath = Server.MapPath(PathStore.basePath + "/" + DirectoryTree.SelectedNode.ValuePath);
            String[] navs = DirectoryTree.SelectedNode.ValuePath.Split('/');
            String valuePath = "";
            //CurrentNav.Controls.Clear();
            ImageButton home = new ImageButton();
            home.AlternateText = "Home";
            home.ID = "CurrentNavHome";
            home.ImageUrl = "~/Images/home.png";
            //home.Command += home_Command;
            home.CssClass = "left";
            //CurrentNav.Controls.Add(home);
            Label rtrif = new Label();
            rtrif.Text = "&rtrif;";
            rtrif.ID = "CurrentNavRTRIF0";
            rtrif.CssClass = "left";
            //CurrentNav.Controls.Add(rtrif);
            foreach (String i in navs)
            {
                valuePath += "/" + i;
                Button link = new Button();
                link.Text = i;
                link.ToolTip = i;
                link.BorderStyle = BorderStyle.None;
                link.CssClass = "left";
                link.ID = "CurrentNavFolder" + c;
                //link.Command += link_Command;
                link.CommandArgument = valuePath;
                //CurrentNav.Controls.Add(link);
                Label rtrif_ = new Label();
                rtrif_.Text = "&rtrif;";
                rtrif_.ID = "CurrentNavRTRIF" + c;
                rtrif_.CssClass = "left";
                //CurrentNav.Controls.Add(rtrif_);
                c++;
            }
            //addDirectory();
        }

        protected void home_Command(object sender, CommandEventArgs e)
        {
        //    selectedItem.ImageUrl = "~/Images/drive.png";
        //    itemName.Text = "Home";
        //    PathStore.currentPath = Server.MapPath(PathStore.basePath);
        //    //addDirectory();
        }

        //protected void link_Command(object sender, CommandEventArgs e)
        //{
        //    PathStore.currentPath = Server.MapPath(PathStore.basePath + e.CommandArgument);
        //    //addDirectory();
        //}
    }
}
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
    public partial class MyDrive : System.Web.UI.Page
    {
        String currentPath = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            int i = 1;
            PlaceHolder DriveContent = new PlaceHolder();
            String FolderName = String.Empty;

            if(Session["handle"] != null)
                FolderName = Session["handle"].ToString().Replace(' ', '_');
                
            currentPath = Server.MapPath("~").ToString()+@"Directories\" + FolderName + @"\";
            DirectoryInfo MyDirectory = new DirectoryInfo(currentPath);
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

                    directoryContainer.Controls.Add(directory);
                    Label name = new Label();
                    name.Text = subD.Name;
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
                    Label name = new Label();
                    name.Text = files.Name;
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
        protected void driveButton_Command(object sender, CommandEventArgs e)
        {
            //int responseCode;
            switch(e.CommandName)
            {
                case "upload":
                    optionsExtended.Visible = true;
                    break;
                case "newFolder":
                    //responseCode = addNewFolder(e.CommandArgument);
                    //if(responseCode == 1)
                        //print Success.
                    break;
                case "rename":
                    //String arg = e.CommandArgument.ToString();
                    //Regex name = new Regex("^[0-9a-zA-z#\s,_]*$");
                    //Match isMatch = name.Match(e.CommandArgument.ToString());
                    //if(isMatch.Success && )
                    //{
                    //    String[] record = ;
                    //    responseCode = renameFileFolder(e.CommandArgument,);
                    //}
                    //else
                    //{

                    //}
                    break;
                case "select":
                    break;
                case "delete":
                    break;
                case "info":
                    break;
                default:
                    Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(e.CommandName));
                    break;
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
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
                    directory.Height = 100;
                    directory.Width = 100;
                    directory.AlternateText = subD.Name;
                    directory.ImageUrl = "Images/folder.png";

                    directoryContainer.Controls.Add(directory);
                    directoryContainer.Controls.Add(new LiteralControl("<br/>" + subD.Name));
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
                    file.Width = 100;
                    file.AlternateText = files.Name;
                    try
                    {
                        FileInfo imageFile = new FileInfo(@"Images/Files/" + files.Extension.ToString().Replace(".", "") + ".png");
                        file.ImageUrl = @"Images/Files/" + files.Extension.ToString().Replace(".", "") + ".png";
                    }
                    catch (Exception err)
                    {
                        file.ImageUrl = "Images/file.png";
                    }

                    fileContainer.Controls.Add(file);
                    fileContainer.Controls.Add(new LiteralControl("<br/>" + files.Name));
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
            switch(e.CommandName)
            {
                case "upload":

            }
        }
    }
}
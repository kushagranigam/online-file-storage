using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        public static String username;
        public static String handle;
        public static int parentnode = -1;
        public static List<int> duids;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["handle"] != null)
            {
                handle = (String)Session["handle"];
                username = (String)Session["username"];

                String action = String.Empty;
                String argument = String.Empty;
                if(!Page.IsPostBack)
                {
                    parentnode = username + "_root";
                }
                if (Request["action"] != null)
                {
                    action = (String)Request["action"];
                    switch (action)
                    {
                        case "rename":
                            break;
                        case "open":
                            if (Request["argument"] != null)
                            {
                                argument = (String)Request["argument"];
                                parentnode = argument;
                                //PathStore.currentPath = 
                            }
                            break;
                        case "delete":
                            break;
                        case "newFolder":
                            break;
                        case "upload":
                            break;
                    }
                }
            }
            else
            {
                Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode("Error in logging you in."));
            }
        }

        void addDirectory()
        {
            int files, folders;
            files = folders = 0;
            DriveContent.Controls.Clear();

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);

            conn.Open();
            String queryString = "select d.nodename, d.isdirectory, d.duid from users u, directories d where u.userId = d.userId and u.username = \'" + username + "\' and parentnode = \'" + parentnode + "\'";

            SqlCommand getDirectoryContent = new SqlCommand(queryString, conn);
            SqlDataReader directoryContentList = null;
            directoryContentList = getDirectoryContent.ExecuteReader();

            if (directoryContentList.HasRows)
            {

                Panel FolderList = new Panel();
                FolderList.GroupingText = "Folders";
                Panel FileList = new Panel();
                FileList.GroupingText = "File";

                while (directoryContentList.Read())
                {
                    if ((int)directoryContentList[1] == 1)
                    {
                        Panel FolderContainer = new Panel();
                        FolderContainer.ID = (String)directoryContentList[0];
                        FolderContainer.CssClass = "folderContainer left";
                        Image folderImage = new Image();
                        folderImage.AlternateText = (String)directoryContentList[0];
                        folderImage.ImageUrl = "~/Images/folder.png";
                        folderImage.Height = 80;
                        folderImage.Width = 100;
                        folderImage.CssClass = "folder";
                        FolderContainer.Controls.Add(folderImage);
                        FolderContainer.Controls.Add(new LiteralControl("<br/> " + (String)directoryContentList[0]));
                        FolderList.Controls.Add(FolderContainer);
                        folders++;
                    }
                    else
                    {
                        Panel FileContainer = new Panel();
                        FileContainer.ID = (String)directoryContentList[0]; ;
                        FileContainer.CssClass = "fileContainer left";
                        Image fileImage = new Image();
                        int dotpos = directoryContentList[0].ToString().LastIndexOf(".");
                        if ((directoryContentList[0].ToString().Length - dotpos + 1) > 4)
                            fileImage.ImageUrl = "~/Images/file.png";
                        else
                        {
                            try
                            {
                                String url = "~/Images/Files/" + directoryContentList[0].ToString().Substring(dotpos + 1) + ".png";
                                if (!File.Exists(Server.MapPath("~") + url))
                                    throw (new Exception());
                                fileImage.ImageUrl = url;
                            }
                            catch (Exception err)
                            {
                                fileImage.ImageUrl = @"Images/file.png";
                            }
                        }
                        fileImage.CssClass = "file";
                        fileImage.Height = 100;
                        fileImage.Width = 80;
                        FileContainer.Controls.Add(fileImage);
                        FileContainer.Controls.Add(new LiteralControl("<br/> " + (String)directoryContentList[0]));
                        FileList.Controls.Add(FileContainer);
                        files++;
                    }
                }
                
                if(folders > 0)
                    DriveContent.Controls.Add(FolderList);
                if(files > 0)
                    DriveContent.Controls.Add(FileList);
            }
        }
    }
    //String token = cryptedFolderString.Substring(0, 10) + "1" + cryptedFolderString.Substring(11, 20) + "1" + cryptedFolderString.Substring(31, 10);
}
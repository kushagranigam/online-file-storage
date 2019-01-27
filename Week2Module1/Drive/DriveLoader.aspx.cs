using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1
{
    public class DirectoryHandler
    {
        static int parent = -1;
        public static int parentnode
        {
            get
            {
                return parent;
            }
            set
            {
                parent = value;
            }
        }
    }
    public partial class WebForm1 : System.Web.UI.Page
    {
        public static String username;
        public static String handle;
        static List<int> duids;
        static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["handle"] != null)
            {
                handle = filter((String)Session["handle"]);
                username = filter((String)Session["username"]);

                String action = String.Empty;
                String argument = String.Empty;
                if(!Page.IsPostBack)
                {
                    try
                    {
                        conn.Open();

                        SqlCommand rootFinder = new SqlCommand("select duid from directories where nodename = \'" + username + "_root\'", conn);
                        SqlDataReader rootResults = null;
                        rootResults = rootFinder.ExecuteReader();
                        if (rootResults.HasRows)
                        {
                            rootResults.Read();
                            DirectoryHandler.parentnode = (int)rootResults[0];
                            rootResults.Close();

                            SHA1 rootcrypter = new SHA1CryptoServiceProvider();
                            byte[] root = Encoding.UTF8.GetBytes(username + "_root");
                            byte[] cryptedrootBytes = rootcrypter.ComputeHash(root);
                            String folderName = BitConverter.ToString(cryptedrootBytes).Replace("-", "").ToLower();

                            PathStore.currentPath = (Server.MapPath("~") + @"\Directories\" + folderName);
                            PathStore.relativePath = "/";
                            PathStore.basePath = "~/Directories/" + folderName;
                            addDirectory();
                        }
                        else
                        {
                            Response.Write("Couldn't find your files.");
                        }
                    }
                    catch(Exception err)
                    {
                        Response.Write("Error: " + err.ToString());
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
                if (Request["action"] != null)
                {
                    action = filter((String)Request["action"]);
                    switch (action)
                    {
                        case "rename":
                            break;
                        case "open":
                            if (Request["argument"] != null)
                            {
                                try
                                {
                                    conn.Open();
                                    argument = filter((String)Request["argument"]);
                                    SqlCommand directoryDuidFinder = new SqlCommand("select duid from directories where nodename = \'" + argument + "\' and parentnode = \'" + DirectoryHandler.parentnode + "\'", conn);

                                    SqlDataReader resultDuid = null;
                                    resultDuid = directoryDuidFinder.ExecuteReader();

                                    if (resultDuid.HasRows)
                                    {
                                        resultDuid.Read();
                                        DirectoryHandler.parentnode = (int)resultDuid[0];
                                        resultDuid.Close();

                                        SHA1 currentnode = new SHA1CryptoServiceProvider();
                                        byte[] node = Encoding.UTF8.GetBytes(argument);
                                        byte[] resultnode = currentnode.ComputeHash(node);
                                        PathStore.currentPath += (@"\" + BitConverter.ToString(resultnode).Replace("-", "").ToLower());
                                        addDirectory();
                                    }
                                    else
                                    {
                                        Response.Write("Directory seems invalid!");
                                    }
                                }
                                catch (Exception err)
                                {
                                    Response.Write(err.ToString());
                                }
                                finally
                                {
                                    conn.Close();
                                }
                            }
                            else
                            {
                                Response.Write("Couldn't see any directory being requested.");
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
                Response.Write("Error in logging you in.");
            }
        }

        void addDirectory()
        {
            int files, folders;
            files = folders = 0;
            DriveContent.Controls.Clear();

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);

            conn.Open();
            String queryString = "select d.nodename, d.isdirectory, d.duid from login u, directories d where u.userId = d.userId and u.username = \'" + username + "\' and parentnode = \'" + DirectoryHandler.parentnode + "\'";

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
                        FolderContainer.CssClass = "container left folder";
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
                        FileContainer.CssClass = "container left file";
                        Image fileImage = new Image();
                        fileImage.AlternateText = (String)directoryContentList[0];
                        int dotpos = directoryContentList[0].ToString().LastIndexOf(".");
                        int length = directoryContentList[0].ToString().Length;
                        if ((length - dotpos - 1) > 4)
                            fileImage.ImageUrl = "~/Images/file.png";
                        else
                        {
                            try
                            {
                                String url = "~/Images/Files/" + directoryContentList[0].ToString().Substring(dotpos + 1) + ".png";
                                if (!File.Exists(Server.MapPath(url)))
                                    throw (new Exception());
                                fileImage.ImageUrl = url;
                            }
                            catch (Exception err)
                            {
                                fileImage.ImageUrl = "~/Images/file.png";
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

        protected String filter(String val)
        {
            val.Trim();
            val = Server.HtmlEncode(val);
            val.Replace("/", "");
            return val;
        }

    }
    //String token = cryptedFolderString.Substring(0, 10) + "1" + cryptedFolderString.Substring(11, 20) + "1" + cryptedFolderString.Substring(31, 10);
}
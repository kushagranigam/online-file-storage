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
    public partial class WebForm1 : System.Web.UI.Page
    {
        static List<int> duids;
        static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["handle"] != null)
            {
                SessionStore.handle = filter((String)Session["handle"]);
                SessionStore.username = filter((String)Session["username"]);

                String action = String.Empty;
                String argument = String.Empty;
                String argument_2 = String.Empty;

                if (Request["action"] != null)
                {
                    action = filter((String)Request["action"]);
                    switch (action)
                    {
                        case "open":
                            if (Request["argument"] != null)
                            {
                                argument = filter((String)Request["argument"]);
                                openItem(argument);
                            }
                            else
                            {
                                Response.Write("Couldn't see any directory being requested.");
                            }
                            break;

                        case "rename":
                            if (Request["argument"] != null && Request["argument_2"] != null)
                            {
                                argument = filter((String)Request["argument"]);
                                argument_2 = filter((String)Request["argument_2"]);
                                renameItem(argument, argument_2);
                            }
                            else
                            {
                                Response.Write("Couldn't see any directory being requested.");
                            }
                            break;

                        case "download":
                            if(Request["argument"] != null)
                            {
                                argument = filter((String)Request["argument"]);
                                downloadItem(argument);
                            }
                            else
                            {
                                Response.Write("Couldn't see any directory being requested.");
                            }
                            break;

                        case "delete":
                            if (Request["argument"] != null && Request["argument_2"] != null)
                            {
                                argument = filter((String)Request["argument"]);
                                argument_2 = filter((String)Request["argument_2"]);
                                deleteItem(argument, argument_2, DirectoryHandler.parentnode, "");
                            }
                            else
                            {
                                Response.Write("Couldn't see any directory being requested.");
                            }
                            break;

                        case "newFolder":
                            break;

                        case "upload":
                            break;
                    }
                }
                else
                {
                    DirectoryHandler.parentnode = -1;
                    try
                    {
                        conn.Open();

                        SqlCommand rootFinder = new SqlCommand("select duid from directories where nodename = \'" + SessionStore.username + "_root\'", conn);
                        SqlDataReader rootResults = null;
                        rootResults = rootFinder.ExecuteReader();
                        if (rootResults.HasRows)
                        {
                            rootResults.Read();
                            DirectoryHandler.parentnode = (int)rootResults[0];
                            rootResults.Close();

                            SHA1 rootcrypter = new SHA1CryptoServiceProvider();
                            byte[] root = Encoding.UTF8.GetBytes(SessionStore.username + "_root");
                            byte[] cryptedrootBytes = rootcrypter.ComputeHash(root);
                            String folderName = BitConverter.ToString(cryptedrootBytes).Replace("-", "").ToLower();

                            PathStore.currentPath = (Server.MapPath("~") + @"Directories\" + folderName);
                            PathStore.relativePath = "/";
                            PathStore.basePath = "~/Directories/" + folderName;
                            addDirectory();
                        }
                        else
                        {
                            Response.Write("Couldn't find your files.");
                        }
                    }
                    catch (Exception err)
                    {
                        Response.Write("Error: " + err.ToString());
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
                //else
                //{
                //    Response.Write("Error in logging you in.");
                //}
            }
        }


        void addDirectory()
        {
            int files, folders;
            files = folders = 0;
            DriveContent.Controls.Clear();

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);

            conn.Open();
            String queryString = "select d.nodename, d.isdirectory, d.duid from login u, directories d where u.userId = d.userId and u.username = \'" + SessionStore.username + "\' and parentnode = \'" + DirectoryHandler.parentnode + "\'";

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
                        FolderContainer.ID = directoryContentList[0].ToString().Replace(" ","-").Replace(".","-");
                        FolderContainer.CssClass = "container left folder";
                        FolderContainer.Controls.Add(new LiteralControl("<div class=\"folder\">\n"));
                        Image folderImage = new Image();
                        folderImage.AlternateText = directoryContentList[0].ToString();
                        folderImage.ID = directoryContentList[0].ToString().Replace(".", "-").Replace(" ", "-") + "-img";
                        folderImage.ImageUrl = "~/Images/folder.png";
                        folderImage.Height = 60;
                        folderImage.Width = 90;
                        folderImage.CssClass = "folder";
                        FolderContainer.Controls.Add(folderImage);
                        FolderContainer.Controls.Add(new LiteralControl("<br/><input type=\"text\" maxlength=\"40\" class=\"folder label\" id=\"" + directoryContentList[0].ToString().Replace(".","-").Replace(" ","-") + "\" + value=\"" + (String)directoryContentList[0] + "\" disabled />\n</div>"));
                        FolderList.Controls.Add(FolderContainer);
                        folders++;
                    }
                    else
                    {
                        String imgsrc, filename = null;
                        int dotpos = directoryContentList[0].ToString().LastIndexOf(".");
                        int length = directoryContentList[0].ToString().Length;
                        if ((length - dotpos - 1) > 4)
                            imgsrc = "~/Images/file.png";
                        else
                        {
                            try
                            {
                                String url = "~/Images/Files/" + directoryContentList[0].ToString().Substring(dotpos + 1) + ".png";
                                if (!File.Exists(Server.MapPath(url)))
                                    throw (new Exception());
                                filename = directoryContentList[0].ToString().Substring(0, dotpos);
                                imgsrc = url;
                            }
                            catch (Exception err)
                            {
                                filename = directoryContentList[0].ToString();
                                imgsrc = "~/Images/file.png";
                            }
                        }
                        Panel FileContainer = new Panel();
                        FileContainer.ID = filename.Replace(".","-").Replace(" ","-");
                        FileContainer.CssClass = "container left file";
                        FileContainer.Controls.Add(new LiteralControl("<div class=\"file\">\n"));
                        Image fileImage = new Image();
                        fileImage.AlternateText = (String)directoryContentList[0];
                        fileImage.ID = filename.Replace(".", "-").Replace(" ", "-") + "-img";
                        fileImage.CssClass = "file";
                        fileImage.Height = 90;
                        fileImage.Width = 90;
                        fileImage.ImageUrl = imgsrc;
                        FileContainer.Controls.Add(fileImage);
                        FileContainer.Controls.Add(new LiteralControl("<br/><input type=\"text\" maxlength=\"40\" class=\"file label\" id=\"" + filename.Replace(".", "-").Replace(" ", "-") + "\" + value=\"" + filename + "\" disabled />\n</div>"));
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

        //Open Item function
        protected void openItem(String argument)
        {
            try
            {
                conn.Open();

                String query = "select duid from directories where nodename = \'" + argument + "\' and parentnode = \'" + DirectoryHandler.parentnode + "\'";
                SqlCommand directoryDuidFinder = new SqlCommand(query, conn);

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
                    PathStore.relativePath += ("/" + BitConverter.ToString(resultnode).Replace("-", "").ToLower());
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

        //Rename Items
        protected void renameItem(String argument, String argument_2)
        {
            try
            {
                conn.Open();
                byte[] toCrypt = Encoding.UTF8.GetBytes(argument);
                SHA1 crypter = new SHA1CryptoServiceProvider();
                byte[] crypted = crypter.ComputeHash(toCrypt);
                String cryptedArgument = BitConverter.ToString(crypted).Replace("-", "").ToLower();
                String extension = Path.GetExtension(argument);

                toCrypt = Encoding.UTF8.GetBytes(argument_2 + extension);
                crypted = crypter.ComputeHash(toCrypt);
                String cryptedArgument_2 = BitConverter.ToString(crypted).Replace("-", "").ToLower();
                if (!File.Exists(PathStore.currentPath + @"\" + cryptedArgument))
                    Response.Write("Error in Finding File");
                else
                {
                    if (!File.Exists(PathStore.currentPath + @"\" + cryptedArgument_2))
                    {
                        File.Move(PathStore.currentPath + @"\" + cryptedArgument, PathStore.currentPath + @"\" + cryptedArgument_2);

                        SqlCommand checkExisting = new SqlCommand("select duid from directories where nodename = \'" + argument_2 + extension + "\' and parentnode = " + DirectoryHandler.parentnode, conn);

                        SqlDataReader existingSecret = null;
                        existingSecret = checkExisting.ExecuteReader();

                        if (existingSecret.HasRows)
                        {
                            existingSecret.Close();
                            throw (new Exception("There exists another item with same name in the diretory."));
                        }
                        else
                        {
                            existingSecret.Close();
                            SqlCommand updateItem = new SqlCommand("update directories set nodename = \'" + argument_2 + extension + "\', token = \'" + cryptedArgument_2 + "\' where nodename = \'" + argument + "\' and parentnode = " + DirectoryHandler.parentnode, conn);
                            int n = updateItem.ExecuteNonQuery();
                            if (n > 0)
                                addDirectory();
                            else
                                throw (new Exception("Error updating directory."));
                        }
                    }
                    else
                        throw (new Exception("There exists another item with same name in the diretory."));
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

        //Download Item function
        protected void downloadItem(String argument)
        {

            Response.Clear();
            try
            {
                byte[] argumentBytes = Encoding.UTF8.GetBytes(argument);
                SHA1 filenameFinder = new SHA1CryptoServiceProvider();
                byte[] filenameBytes = filenameFinder.ComputeHash(argumentBytes);
                String filename = BitConverter.ToString(filenameBytes).Replace("-", "").ToLower();

                FileStream downloadFileStream = new FileStream(PathStore.currentPath + @"\" + filename, FileMode.Open, FileAccess.Read);
                byte[] filebuffer = new byte[(int)downloadFileStream.Length];

                downloadFileStream.Read(filebuffer, 0, (int)downloadFileStream.Length);
                downloadFileStream.Close();
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("content-disposition", "attachment;filename=\"" + argument + "\"");
                Response.BinaryWrite(filebuffer);
                Response.End();
            }
            catch (Exception err)
            {
                Response.Write(err.ToString());
            }
        }

        //Delete Item function
        protected void deleteItem(String argument, String argument_2, int parent, String path)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);

            try
            {
                conn.Open();
                byte[] toCrypt = Encoding.UTF8.GetBytes(argument);
                SHA1 crypter = new SHA1CryptoServiceProvider();
                byte[] crypted = crypter.ComputeHash(toCrypt);
                String cryptedArgument = BitConverter.ToString(crypted).Replace("-", "").ToLower();

                //Check if item is a file.
                if (String.Compare(argument_2, "File") == 0)
                {

                    FileInfo deleteFile = new FileInfo(PathStore.currentPath + @"\" + path + cryptedArgument);
                    if (deleteFile.Exists)
                    {
                        SqlCommand findFile = new SqlCommand("select nodename from directories where nodename=\'" + argument + "\' and parentnode = " + parent, conn);
                        SqlDataReader checkFile = null;
                        checkFile = findFile.ExecuteReader();

                        if (checkFile.HasRows)
                        {
                            checkFile.Close();
                            deleteFile.Delete();

                            SqlCommand dbUpdate = new SqlCommand("delete from directories where nodename = \'" + argument + "\' and parentnode = " + parent, conn);
                            int n = dbUpdate.ExecuteNonQuery();
                            if (n > 0)
                                addDirectory();
                            else
                                throw (new Exception("File deleted, but failed to update database."));
                        }
                        else
                        {
                            throw (new Exception("Unable to locate file in database."));
                        }
                    }
                    else
                    {
                        throw (new Exception("Unable to locate file."));
                    }
                }

                //Item is a directory.
                else
                {
                    DirectoryInfo deleteDirectory = new DirectoryInfo(PathStore.currentPath + @"\" + path + cryptedArgument);
                    if (deleteDirectory.Exists)
                    {
                        SqlCommand findDirectory = new SqlCommand("select duid, nodename from directories where nodename=\'" + argument + "\' and parentnode = " + parent, conn);
                        SqlDataReader checkDirectory = null;
                        checkDirectory = findDirectory.ExecuteReader();

                        if (checkDirectory.HasRows)
                        {
                            checkDirectory.Read();
                            int duid = (int)checkDirectory[0];
                            checkDirectory.Close();

                            String nodename, nodeType;
                            nodename = nodeType = String.Empty;
                            SqlCommand getChildren = new SqlCommand("select nodename, isdirectory from directories where parentnode = " + duid, conn);
                            SqlDataReader childrenReader = null;
                            childrenReader = getChildren.ExecuteReader();

                            if (childrenReader.HasRows)
                            {
                                while (childrenReader.Read())
                                {
                                    if((int)childrenReader[1] == 0)
                                        nodeType = "File";
                                    else
                                        nodeType = "Folder";

                                    deleteItem((String)childrenReader[0], nodeType, duid, path+cryptedArgument+@"\");
                                }
                            }

                            childrenReader.Close();

                            SqlCommand dbUpdate = new SqlCommand("delete from directories where nodename = \'" + argument + "\' and parentnode = " + parent, conn);
                            int n = dbUpdate.ExecuteNonQuery();
                            if (n > 0)
                            {
                                addDirectory();
                                deleteDirectory.Delete(true);
                            }
                            else
                                throw (new Exception("Directory deleted, but failed to update database."));
                        }
                        else
                        {
                            throw (new Exception("Unable to locate directory in database."));
                        }
                    }
                    else
                    {
                        throw (new Exception("Unable to locate directory."));
                    }
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

        //Input filtering function
        protected String filter(String val)
        {
            val.Trim();
            val = Server.HtmlEncode(val);
            val.Replace("/", "");
            return val;
        }

    }
    
}
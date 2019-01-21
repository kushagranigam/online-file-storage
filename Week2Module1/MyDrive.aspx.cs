using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        String currentPath = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            currentPath = "~/Directories/" + Session["handle"] + "/";
            DirectoryInfo MyDirectory = new DirectoryInfo(currentPath);
            DirectoryInfo[] MySub = MyDirectory.GetDirectories();
            FileInfo[] MyFiles = MyDirectory.GetFiles();

        }
    }
}
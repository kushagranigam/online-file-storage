using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["handle"] != null)
            {
                username.Text = (String)Session["handle"];
                loginBox.ActiveViewIndex = 0;
            }
            else
            {
                loginBox.ActiveViewIndex = 1;
            }
        }

        protected void logoutButton_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Session.Abandon();
            loginBox.ActiveViewIndex = 1;
            Response.Redirect("~/Default.aspx");
        }

        protected void loginBox_ActiveViewChanged(object sender, EventArgs e)
        {

        }

        protected void changePassButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Account/ChangePassword.aspx");
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["error"] != null)
                PageContent.Controls.Add(new LiteralControl(Request.Params["error"].ToString()));
            if(Request.UrlReferrer != null)
                Back.PostBackUrl = Request.UrlReferrer.ToString();
        }

        protected void homeButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx", true);
        }

        protected void backButton_Click(object sender, EventArgs e)
        {
        }
    }
}
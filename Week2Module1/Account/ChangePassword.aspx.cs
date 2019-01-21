using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1.Account
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.UrlReferrer != null)
                Back.PostBackUrl = Request.UrlReferrer.ToString();
        }

        protected void ChangePassButton_Click(object sender, EventArgs e)
        {
            int n;
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);
            try
            {
                conn.Open();

                SqlCommand query = new SqlCommand("update login set pass=\'" + newPass.Text + "\' where username=\'" + (String)Session["username"] + "\'", conn);
                n = query.ExecuteNonQuery();
                if(n > 0)
                    Response.Redirect("~/Account/ChangePasswordSuccess.aspx");
                else
                    errorText.Text = "Something happened.. Please Try again.";
                conn.Close();
            }
            catch(Exception err)
            {
                Response.Redirect("~/Error.aspx?error="+Server.UrlEncode(err.ToString()));
            }
        }
    }
}

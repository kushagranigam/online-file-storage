using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["handle"] != null)
                Response.Redirect("~/MyDrive.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Error.aspx?error=HitBack", true);
        }

        protected void searchButton_Click(object sender, ImageClickEventArgs e)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);
            try
            {
                conn.Open();
                SqlCommand findUserId = new SqlCommand("select userId, name from users where name LIKE \'%" + search.Text + "%\'", conn);
                SqlDataReader userId = null;
                userId = findUserId.ExecuteReader();
                if (userId.HasRows)
                {
                    Panel1.Controls.Add(new LiteralControl("Results:<br/>"));
                    while (userId.Read())
                        Panel1.Controls.Add(new LiteralControl(userId[1].ToString() + "<br/>"));
                }
                else
                {
                    Panel1.Controls.Add(new LiteralControl("No results found.<br/>"));
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
        }
    }
}

using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void rmImage_Click(object sender, ImageClickEventArgs e)
        {
            if (String.Compare(rmImage.ImageUrl,"~/Images/rmChecked.png")==0)
            {
                rmImage.ImageUrl = "~/Images/rmUnChecked.png";
                rmLabel.ForeColor = System.Drawing.Color.Gray;
            }
            else
            {
                rmImage.ImageUrl = "~/Images/rmChecked.png";
                rmLabel.ForeColor = System.Drawing.Color.FromArgb(00,204,255);
            }
        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            MultiView loginBox = (MultiView)Master.FindControl("loginBox");
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);
            try
            {
                conn.Open();

                SqlCommand query = new SqlCommand("select u.name, l.pass from users u, login l where u.userId = l.userId and l.username=\'" + userName.Text + "\' or u.emailId=\'" + userName.Text + "\'", conn);

                SqlDataReader result = null;
                result = query.ExecuteReader();
                if (result.HasRows)
                {
                    while (result.Read())
                    {
                        if (String.Compare(result[1].ToString(), password.Text) == 0)
                        {
                            errorText.Text = "Logging In.. Please Wait";
                            Session["handle"] = result[0].ToString();
                            Session["userName"] = userName.Text;
                            loginBox.ActiveViewIndex = 0;
                            Response.Redirect("~/MyDrive.aspx");
                        }
                        else
                        {
                            errorText.Text = "Password mismatch!";
                        }
                    }
                }
                else
                {
                    errorText.Text = "User doesn't exist!";
                }
            }
            catch (Exception databaseError)
            {
                errorText.Text = databaseError.ToString();
            }
            finally
            {
                conn.Close();
            }
        }
    }
}

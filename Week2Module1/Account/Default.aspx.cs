using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1.Account
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["handle"] != null)
                Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode("You are already logged in!!"));
            //if (Request.Cookies["userName"] != null)
            //    userName.Text = Server.HtmlEncode(Request.Cookies["userName"].Value);
        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            MultiView loginBox = (MultiView)Master.FindControl("loginBox");
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);

            String usernameText = filter(userName.Text);
            String passwordText = filter(password.Text);

            bool usernameValid = isUsernameValid(usernameText);
            bool passwordValid = isPasswordValid(passwordText);

            if (usernameValid && passwordValid)
            {
                try
                {
                    conn.Open();

                    SqlCommand query = new SqlCommand("select u.name, l.pass from users u, login l where u.userId = l.userId and l.username=\'" + usernameText + "\' or u.emailId=\'" + usernameText + "\'", conn);

                    SqlDataReader result = null;
                    result = query.ExecuteReader();
                    if (result.HasRows)
                    {
                        while (result.Read())
                        {
                            if (String.Compare(result[1].ToString(), passwordText) == 0)
                            {
                                errorText.Text = "Logging In.. Please Wait";
                                Session["handle"] = result[0].ToString();
                                Session["userName"] = userName.Text;
                                loginBox.ActiveViewIndex = 0;
                                if (rememberMe.Checked)
                                    Session["rememberMe"] = true;
                                else
                                    Session.Remove("rememberMe");
                                Response.Redirect("~/Drive/");
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

        protected String filter(String val)
        {
            val.Trim();
            val = Server.HtmlEncode(val);
            val.Replace("/", "");
            return val;
        }

        protected bool isUsernameValid(String input)
        {
            Regex nameRE = new Regex(@"^[a-zA-Z0-9\._]+$");
            Regex emailRE = new Regex(@"^([\w\.-]+)@([\w-]+)((\.(\w){2,3})+)$");
            if (!(nameRE.IsMatch(input) || emailRE.IsMatch(input)))
            {
                usernameValidator.IsValid = false;
                usernameValidator.Text = "Username or Email doesn't look right.";
            }
            else
            {
                usernameValidator.Text = "";
                usernameValidator.IsValid = true;
            }
            return usernameValidator.IsValid;
        }

        protected bool isPasswordValid(String input)
        {
            return passwordValidator.IsValid;
        }
    }
}

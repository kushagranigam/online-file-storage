using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1.Account
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        
        protected void calendar_SelectionChanged(object sender, EventArgs e)
        {
            dateOfBirth.Text = calendar.SelectedDate.ToString("dd-MM-yyyy");
            calendar.Visible = false;
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (calendar.Visible == true)
                calendar.Visible = false;
            else
                calendar.Visible = true;
        }

        protected void registerButton_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);

            try
            {
                int n;
                conn.Open();
                SqlCommand userUpdate = new SqlCommand("insert into users(name, dob, gender, emailId) values(\'" + name.Text + "\', \'" + calendar.SelectedDate.ToString("d") + "\', \'" + gender.SelectedValue + "\', \'" + emailID.Text + "\')", conn);
                n = userUpdate.ExecuteNonQuery();
                if (n > 0)
                {
                    SqlCommand findUserId = new SqlCommand("select userId from users where name=\'" + name.Text + "\' and emailId=\'" + emailID.Text + "\' and dob=\'" + calendar.SelectedDate.ToString("d") + "\'", conn);

                    SqlDataReader userId = null;
                    userId = findUserId.ExecuteReader();
                    userId.Read();
                    SqlCommand loginUpdate = new SqlCommand("insert into login values(\'" + (int)userId[0] + "\', \'" + userName.Text + "\', \'" + password.Text + "\')", conn);
                    userId.Close();
                    n = loginUpdate.ExecuteNonQuery();
                    if (n > 0)
                    {
                        DirectoryInfo UserDirectory = new DirectoryInfo(Server.MapPath("~") + @"Directories\");
                        UserDirectory.CreateSubdirectory(name.Text.ToString().Replace(" ", "_"));
                        Response.Redirect("~/Account/Login.aspx");
                    }
                    else
                    {
                        throw (new Exception("Failed to Insert Login data."));
                    }
                }
                else
                {
                    throw (new Exception("Failed to insert User Data."));
                }
            }
            catch (Exception err)
            {
                Response.Write(err);
                //Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
            }
            finally
            {
                conn.Close();
            }
            
        }

    }
}

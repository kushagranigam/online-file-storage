using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1.Account
{
    public static class GrammerHelper
    {
        static int also = 0;
        public static int nalso
        {
            get { return also; }
            set { also = value; }
        }
    }

    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.UrlReferrer != null)
                Back.PostBackUrl = Request.UrlReferrer.ToString();
        }
        
        protected void calendar_SelectionChanged(object sender, EventArgs e)
        {
            dateOfBirth.Text = calendar.SelectedDate.ToString("dd-MM-yyyy");
            calendar.Visible = false;
        }

        protected void calendarButton_Click(object sender, ImageClickEventArgs e)
        {
            if (calendar.Visible == true)
                calendar.Visible = false;
            else
                calendar.Visible = true;
        }

        protected void registerButton_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);

            String nameText = filter(name.Text);
            String dobText = filter(calendar.SelectedDate.ToString("d"));
            String genderSelectedValue = gender.SelectedValue;
            String passText = filter(password.Text);
            String emailText = filter(emailID.Text);
            String userNameText = filter(userName.Text);

            try
            {
                int n;
                conn.Open();
                SqlCommand userUpdate = new SqlCommand("insert into users(name, dob, gender, emailId) values(\'" + nameText + "\', \'" + dobText + "\', \'" + genderSelectedValue + "\', \'" + emailText + "\')", conn);
                n = userUpdate.ExecuteNonQuery();
                if (n > 0)
                {
                    SqlCommand findUserId = new SqlCommand("select userId, name from users where name=\'" + nameText + "\' and emailId=\'" + emailText + "\' and dob=\'" + dobText + "\'", conn);

                    SqlDataReader userId = null;
                    userId = findUserId.ExecuteReader();
                    userId.Read();
                    SqlCommand loginUpdate = new SqlCommand("insert into login values(\'" + (int)userId[0] + "\', \'" + userNameText + "\', \'" + passText + "\')", conn);
                    userId.Close();
                    n = loginUpdate.ExecuteNonQuery();
                    if (n > 0)
                    {
                        DirectoryInfo UserDirectory = new DirectoryInfo(Server.MapPath("~") + @"\Directories\");
                        String Folder = nameText.Replace(" ","_");
                        UserDirectory.CreateSubdirectory(Folder);
                        registerForm.SetActiveView(successView);
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
                Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
            }
            finally
            {
                conn.Close();
            }
        }

        protected String filter(String val)
        {
            val.Trim();
            val = Server.HtmlEncode(val);
            val.Replace("/", "");
            return val;
        }

        protected void homeButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Account/Login.aspx", true);
        }

        protected void dateOfBirth_TextChanged(object sender, EventArgs e)
        {
            Regex dobRE = new Regex("^([0-1])?[0-9]\\-([0-3])?[0-9]\\-([0-2]0)?[0-9][0-9]$");
            if (!dobRE.IsMatch(name.Text))
            {
                dobError.Text = "Date of birth doesn't look right" + ((GrammerHelper.nalso > 0) ? " too." : ".");
                RequiredFieldValidator2.IsValid = false;
                GrammerHelper.nalso++;
            }
            else
            {
                dobError.Text = "";
                RequiredFieldValidator2.IsValid = true;
                GrammerHelper.nalso--;
            }
        }

        protected void name_TextChanged(object sender, EventArgs e)
        {
            Regex nameRE = new Regex("^([a-zA-Z]+( )?)*$");
            if (!nameRE.IsMatch(name.Text))
            {
                RequiredFieldValidator1.IsValid = false;
                nameError.Text = "Name doesn't look right";
                GrammerHelper.nalso++;
            }
            else
            {
                nameError.Text = "";
                RequiredFieldValidator1.IsValid = true;
                GrammerHelper.nalso--;
            }
        }

        protected void userName_TextChanged(object sender, EventArgs e)
        {
            
        }

        protected void emailID_TextChanged(object sender, EventArgs e)
        {
            Regex emailRE = new Regex("/^([\w\\.\\-]+)@([\w\\-]+)((\\.(\w){2,3})+)$/");
            if (!emailRE.IsMatch(name.Text))
            {
                RequiredFieldValidator5.IsValid = false;
                emailError.Text = "emailID doesn't look right" + ((GrammerHelper.nalso > 0) ? " too." : ".");
                GrammerHelper.nalso++;
            }
            else
            {
                emailError.Text = "";
                RequiredFieldValidator5.IsValid = true;
                GrammerHelper.nalso--;
            }
        }
    }
}

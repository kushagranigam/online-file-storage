using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week2Module1.Account
{
    public partial class Register : System.Web.UI.Page
    {
        protected static String captchaMatch;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    DirectoryInfo captchaFolder = new DirectoryInfo(Server.MapPath("~") + @"\Images\captcha");
                    FileInfo[] captchaImages = captchaFolder.GetFiles();
                    Random r = new Random();
                    int i = r.Next(captchaImages.Length);
                    if (i < captchaImages.Length)
                    {
                        captchaImage.ImageUrl = "~/Images/captcha/" + captchaImages[i].Name;
                        captchaMatch = captchaImages[i].Name;
                    }
                }
                catch (Exception err)
                {
                    Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
                }
            }
            else
            {
                bool nameValid = isNameValid(name.Text);
                bool dateofbirthValid = isDateOfBirthValid(dateOfBirth.Text);
                bool usernameValid = isUsernameValid(userName.Text);
                bool emailValid = isEmailValid(emailID.Text);
                bool passwordValid = isPasswordValid(password.Text);
                bool captchaValid = isCaptchaValid(captcha.Text);
            }
            if(Request.UrlReferrer != null)
                Back.PostBackUrl = Request.UrlReferrer.ToString();
        }

        public string convertDate(String inputDate)
        {
            String[] date = inputDate.Split('-');
            inputDate = date[1] + "-" + date[0] + "-" + date[2];
            return inputDate;
        }

        protected void registerButton_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["database"].ConnectionString);

            String nameText = filter(name.Text);
            String dobText = filter(dateOfBirth.Text);
            String genderSelectedValue = gender.SelectedValue;
            String passText = filter(password.Text);
            String emailText = filter(emailID.Text);
            String userNameText = filter(userName.Text);
            String captchaText = filter(captcha.Text);

            bool nameValid = isNameValid(nameText);
            bool dateofbirthValid = isDateOfBirthValid(dobText);
            bool usernameValid = isUsernameValid(userNameText);
            bool emailValid = isEmailValid(emailText);
            bool passwordValid = isPasswordValid(passText);
            bool captchaValid = isCaptchaValid(captchaText);
            if (
                nameValid &&
                dateofbirthValid &&
                usernameValid &&
                emailValid &&
                passwordValid &&
                captchaValid
                )
            {
                try
                {
                    int n;
                    conn.Open();
                    SqlCommand userUpdate = new SqlCommand("insert into users(name, dob, gender, emailId) values(\'" + nameText + "\', \'" + convertDate(dobText) + "\', \'" + genderSelectedValue + "\', \'" + emailText + "\')", conn);
                    n = userUpdate.ExecuteNonQuery();
                    if (n > 0)
                    {
                        SqlCommand findUserId = new SqlCommand("select userId, name from users where name=\'" + nameText + "\' and emailId=\'" + emailText + "\' and dob=\'" + convertDate(dobText) + "\'", conn);

                        SqlDataReader userId = null;
                        userId = findUserId.ExecuteReader();
                        userId.Read();
                        SqlCommand loginUpdate = new SqlCommand("insert into login values(\'" + (int)userId[0] + "\', \'" + userNameText + "\', \'" + passText + "\')", conn);
                        userId.Close();
                        n = loginUpdate.ExecuteNonQuery();
                        if (n > 0)
                        {
                            DirectoryInfo UserDirectory = new DirectoryInfo(Server.MapPath("~") + @"\Directories\");
                            String Folder = nameText.Replace(" ", "_");
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
            else
            {
                registerButton.BorderColor = System.Drawing.Color.Red;
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


       //Input Validations

        //Name Validation
        protected bool isNameValid(String input)
        {
            Regex nameRE = new Regex(@"^(([a-zA-Z]+)( )?)+$");
            if (!nameRE.IsMatch(input))
            {
                nameValidator.IsValid = false;
                nameError.Text = "Name doesn't look right.";
            }
            else
            {
                nameError.Text = "";
                nameValidator.IsValid = true;
            }
            return nameValidator.IsValid;
        }
        
        //Date of Birth Validation
        protected bool isDateOfBirthValid(String input)
        {
            Regex dobRE = new Regex(@"^([0-9]|0[0-9]|1[1-2])-([0-2]?[0-9]|3[0-1])-(1[0-9]|20)\d{2}$");
            if (!dobRE.IsMatch(input))
            {
                dobError.Text = "Date of birth doesn't look right.";
                dateofbirthValidator.IsValid = false;
            }
            else
            {
                dobError.Text = "";
                dateofbirthValidator.IsValid = true;
            }
            return dateofbirthValidator.IsValid;
        }

        //Password Validation
        protected bool isPasswordValid(String input)
        {
            return passwordValidator.IsValid;
        }

        //username Validation
        protected bool isUsernameValid(String input)
        {
            Regex usernameRE = new Regex(@"^[a-zA-Z0-9\._]+$");
            if (!usernameRE.IsMatch(input))
            {
                usernameValidator.IsValid = false;
                usernameError.Text = "Name doesn't look right.";
            }
            else
            {
                usernameError.Text = "";
                usernameValidator.IsValid = true;
            }
            return usernameValidator.IsValid;
        }

        //Email Validation
        protected bool isEmailValid(String input)
        {
            Regex emailRE = new Regex(@"^([\w]+[\.-]?)+@([\w-]+)((\.(\w){2,3})+)$");
            if (!emailRE.IsMatch(input))
            {
                emailValidator.IsValid = false;
                emailError.Text = "Email doesn't look right.";
            }
            else
            {
                emailError.Text = "";
                emailValidator.IsValid = true;
            }
            return emailValidator.IsValid;
        }
        protected bool isCaptchaValid(String input)
        {
            SHA1 sh = new SHA1CryptoServiceProvider();
            byte[] text = Encoding.UTF8.GetBytes(input.ToLower());
            var result = sh.ComputeHash(text);
            if (String.Compare(captchaMatch, BitConverter.ToString(result).Replace("-", "").ToLower() + ".png") == 0)
                captchaValidator.IsValid = true;
            else
                captchaValidator.IsValid = false;
            return false;
        }

        protected void reloadCaptcha_Command(object sender, CommandEventArgs e)
        {
            try
            {
                DirectoryInfo captchaFolder = new DirectoryInfo(Server.MapPath("~") + @"\Images\captcha");
                FileInfo[] captchaImages = captchaFolder.GetFiles();
                Random r = new Random();
                int i = r.Next(captchaImages.Length);
                if (i < captchaImages.Length)
                {
                    captchaImage.ImageUrl = "~/Images/captcha/" + captchaImages[i].Name;
                    captchaMatch = captchaImages[i].Name;
                }
            }
            catch (Exception err)
            {
                Response.Redirect("~/Error.aspx?error=" + Server.UrlEncode(err.ToString()));
            }
        }
    }
}

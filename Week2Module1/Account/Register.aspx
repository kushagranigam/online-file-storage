<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="Week2Module1.Account.Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        /*Calendar Styles*/
        .view1{cursor:pointer; padding:2px; width:20px; height:0px; color: #FFFFFF; font-weight:bold;}
        .monthDate{ border-radius:10px; height:20px; }
        .monthDate:hover{background:#9966FF; }
        .view2,.view3{cursor:pointer; height:40px; width:50px; border-radius: 20px; color: #FFFFFF; font-weight:bold;}
        .view2:hover,.view3:hover{background:#9966FF; }
        .horNav{cursor:pointer; margin:auto; padding:0px; width:20px; border-radius: 4px; }
        .horNav:hover{background:#9966FF; }
        .verNav{cursor:pointer; height:25px; margin:auto; padding:0px; width:150px; border-radius: 4px; }
        .verNav:hover{background:#9966FF; }
        #dateView,#monthView,#yearView{ cursor:pointer; background:#CFBEFC; display: block; height: auto; padding:10px; position:absolute; width: 180px; }
        #monthView,#yearView{visibility: hidden; }
        #today{position:relative; }
        #month, #year{ border-radius: 4px;}
        #month:hover, #year:hover{background: #6699FF;}
        table{font-family:"Century Gothic"; font-size:13px; margin:auto; text-align:center; }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#form").click(hideCalendar).children().click(function () {
                return false;
            });
        });
        function nameError() { document.getElementById("<%= nameError.ClientID %>").innerHTML = ""; }
        function dobError() { document.getElementById("<%= dobError.ClientID %>").innerHTML = ""; }
        function usernameError() { document.getElementById("<%= usernameError.ClientID %>").innerHTML = ""; }
        function emailError() { document.getElementById("<%= emailError.ClientID %>").innerHTML = ""; }
        function passwordError() { document.getElementById("<%= passwordError.ClientID %>").innerHTML = ""; }
        function confirmpasswordError() { document.getElementById("<%= confirmpasswordValidator.ClientID %>").innerHTML = ""; }
        function captchaError() { document.getElementById("<%= captchaValidator.ClientID %>").innerHTML = ""; }
        function toggleCalendar() {
            var cal = document.getElementById("calendar");
            if (cal.style.display == "none") cal.style.display = "block";
            else cal.style.display = "none";
            return calendar();
        }
        function hideCalendar() {
            var cal = document.getElementById("calendar");
            if (cal.style.display == "block")
                cal.style.display = "none";
        }
    </script>
    <!-- Calendar Script -->
    <script type="text/javascript">
        Date.prototype.Month = function () {
            if (this.getMonth() == 0) { this.monthName = "Jan"; this.days = 31; }
            if (this.getMonth() == 1) { this.monthName = "Feb"; this.days = ((this.getFullYear() % 400 == 0) || ((this.getFullYear() % 4 == 0) && (this.getFullYear() % 100 != 0))) ? 29 : 28; }
            if (this.getMonth() == 2) { this.monthName = "Mar"; this.days = 31; }
            if (this.getMonth() == 3) { this.monthName = "Apr"; this.days = 30; }
            if (this.getMonth() == 4) { this.monthName = "May"; this.days = 31; }
            if (this.getMonth() == 5) { this.monthName = "Jun"; this.days = 30; }
            if (this.getMonth() == 6) { this.monthName = "Jul"; this.days = 31; }
            if (this.getMonth() == 7) { this.monthName = "Aug"; this.days = 31; }
            if (this.getMonth() == 8) { this.monthName = "Sep"; this.days = 30; }
            if (this.getMonth() == 9) { this.monthName = "Oct"; this.days = 31; }
            if (this.getMonth() == 10) { this.monthName = "Nov"; this.days = 30; }
            if (this.getMonth() == 11) { this.monthName = "Dec"; this.days = 31; }
        };

        //Global Declarations
        var today = new Date();
        var d = new Date();
        var m = today.getMonth();
        var y = today.getFullYear();
        var v1 = document.getElementsByClassName("view1");
        var v3 = document.getElementsByClassName("view3");
        var dV = document.getElementById("dateView");

        //Calendar Generator
        function calendar() {
            d.setFullYear(y, m, 1);
            d.Month();
            document.getElementById("monthView").style.visibility = document.getElementById("yearView").style.visibility = "hidden";
            var xD = d.getDay();

            document.getElementById("month").innerHTML = d.monthName + ", " + d.getFullYear();
            document.getElementById("year").innerHTML = d.getFullYear();

            for (c = 0, i = 1, t = d.days + xD; c < 42; c++) {

                if ((c >= xD) && (c < t)) {
                    v1[c].innerHTML = i++;
                    v1[c].onclick = function () { selDate(this) };
                    v1[c].classList.add("monthDate");
                }
                else {
                    v1[c].innerHTML = "";
                    if (v1[c].classList.contains("monthDate"))
                        v1[c].classList.remove("monthDate");
                }
            }
            for (c = 0, i = y - 4; c < 12; c++, i++) {
                v3[c].innerHTML = i;
                v3[c].onclick = function () { selYear(this) };
            }
        }


        //Cell Selection Functions
        function selDate(x) { document.getElementById("<%= dateOfBirth.ClientID %>").value = (m + 1) + "-" + x.innerHTML + "-" + y; toggleCalendar();}
        function selMonth(x) { var mV = document.getElementById("monthView"); m = x; mV.style.visibility = "hidden"; calendar(); }
        function selYear(x) { var yV = document.getElementById("yearView"); y = x.innerHTML; yV.style.visibility = "hidden"; calendar(); }

        //Navigation Functions
        function prevMonth() { if (m > 0) m--; else { y--; m = 11; } calendar(); }
        function nextMonth() { if (m < 11) m++; else { y++; m = 0; } calendar(); }
        function prevYear() { y--; calendar(); }
        function nextYear() { y++; calendar(); }
        function prevYearView() { y -= 5; calendar(); }
        function nextYearView() { y += 5; calendar(); }
        function transMonth() { var mV = document.getElementById("monthView"); mV.style.visibility = "visible"; }
        function transYear() { var yV = document.getElementById("yearView"); yV.style.visibility = "visible";
        }
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div id="formContainer">
        <div id="form">
            <asp:MultiView ID="registerForm" runat="server" ActiveViewIndex="0">
                <asp:View ID="registerView" runat="server">
                    <asp:Image ID="nameImage" runat="server" Height="25px" Width="25px" 
                            ImageUrl="~/Images/name.png" />

                        &nbsp;<asp:TextBox ID="name" runat="server" placeholder="Name" Height="25px" 
                            Width="300px" CausesValidation="True" MaxLength="40" TabIndex="1" 
                        ToolTip="Name" onkeypress="nameError()" autocomplete="off"
                        ValidationGroup="registerValidation"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="nameValidator" runat="server" 
                            ErrorMessage="*" ForeColor="Red" Height="25px" 
                        ControlToValidate="name" ValidationGroup="registerValidation"></asp:RequiredFieldValidator>
                        <br />
                        <asp:Label ID="nameError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="dobImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/dateOfBirth.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="dateOfBirth" runat="server" Height="25px" placeholder="Date of Birth" 
                        TabIndex="2" Width="300px" ToolTip="Date of Birth" 
                         autocomplete="off" MaxLength="10" onkeypress="dobError()" 
                        ValidationGroup="registerValidation"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="dateofbirthValidator" runat="server" 
                        ControlToValidate="dateOfBirth" ErrorMessage="*" ForeColor="Red" 
                        Height="25px" ValidationGroup="registerValidation"></asp:RequiredFieldValidator>

                    <div style="position: absolute; display: inline; text-align: left;">
                        <img alt="Show Calendar" onclick="javascript:toggleCalendar(); return false;" src="../Images/calendar.png" style="width: 25px; height: 25px; cursor:pointer;" />
                        <div class="calender" id="calendar" style="display: none;">
                    		<div id="dateView">
			                    <table border="0">
				                    <tr><td class="horNav" onclick="prevYear()">&ltrif;</td><td class="horNav" onclick="prevMonth()">&ltri;</td><th colspan="3" id="month" onclick="transMonth()"></th><td class="horNav" onclick="nextMonth()">&rtri;</td><td class="horNav" onclick="nextYear()">&rtrif;</td></tr>
                                    <tr><td colspan="7"><hr /></td></tr>
				                    <tr><td>Su</td><td>Mo</td><td>Tu</td><td>We</td><td>Th</td><td>Fr</td><td>Sa</td></tr>
				                    <tr><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td></tr>
				                    <tr><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td></tr>
				                    <tr><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td></tr>
				                    <tr><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td></tr>
				                    <tr><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td></tr>
				                    <tr><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td><td class="view1"></td></tr>
			                    </table>
		                    </div>
		                    <div id="monthView">
			                    <table border="0">
				                    <tr><td class="horNav" onclick="prevYear()">&ltri;</td><th colspan="5" id="year" onclick="transYear()"></th><td class="horNav" onclick="nextYear()">&rtri;</td></tr>
				                    <tr><td class="view2" onclick="selMonth(0)" colspan="2">Jan</td><td class="view2" onclick="selMonth(1)" colspan="3">Feb</td><td class="view2" onclick="selMonth(2)" colspan="2">Mar</td></tr>
				                    <tr><td class="view2" onclick="selMonth(3)" colspan="2">Apr</td><td class="view2" onclick="selMonth(4)" colspan="3">May</td><td class="view2" onclick="selMonth(5)" colspan="2">Jun</td></tr>
				                    <tr><td class="view2" onclick="selMonth(6)" colspan="2">Jul</td><td class="view2" onclick="selMonth(7)" colspan="3">Aug</td><td class="view2" onclick="selMonth(8)" colspan="2">Sep</td></tr>
				                    <tr><td class="view2" onclick="selMonth(9)" colspan="2">Oct</td><td class="view2" onclick="selMonth(10)" colspan="3">Nov</td><td class="view2" onclick="selMonth(11)" colspan="2">Dec</td></tr>
			                    </table>
		                    </div>
		                    <div id="yearView">
			                    <table border="0">
				                    <tr><td align="center" class="verNav" colspan="3" onclick="prevYearView()"> &utri; </td></tr>
				                    <tr><td class="view3"></td><td class="view3"></td><td class="view3"></td></tr>
				                    <tr><td class="view3"></td><td class="view3"></td><td class="view3"></td></tr>
				                    <tr><td class="view3"></td><td class="view3"></td><td class="view3"></td></tr>
				                    <tr><td align="center" class="verNav" colspan="3" onclick="nextYearView()"> &dtri; </td></tr>
			                    </table>
		                    </div>
	                    </div>
                    </div>

                    <br />
                    <asp:Label ID="dobError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="genderImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/gender.png" Width="25px" />
                    &nbsp;<asp:RadioButtonList ID="gender" runat="server" CellPadding="0" 
                        CellSpacing="5" Height="25px" RepeatDirection="Horizontal" RepeatLayout="Flow" 
                        TabIndex="3" Width="300px" ToolTip="Sex" 
                        ValidationGroup="registerValidation">
                        <asp:ListItem Value="M">Him</asp:ListItem>
                        <asp:ListItem Value="F">Her</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="genderValidator" runat="server" 
                        ControlToValidate="gender" ErrorMessage="*" ForeColor="Red" Height="25px"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <asp:Image ID="userImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/userNotFilled.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="userName" runat="server" Height="25px" 
                        placeholder="UserName" TabIndex="4" 
                        Width="300px" ToolTip="Choose a unique username." 
                        autocomplete="off" MaxLength="30" onkeypress="usernameError()" 
                        ValidationGroup="registerValidation"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="usernameValidator" runat="server" 
                        ControlToValidate="userName" ErrorMessage="*" ForeColor="Red" 
                        Height="25px" ValidationGroup="registerValidation"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="usernameError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="emailImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/emailId.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="emailID" runat="server" Height="25px" MaxLength="60" 
                        placeholder="Email ID" TabIndex="5" 
                        Width="300px" ToolTip="e-mail ID" autocomplete="off" 
                        onkeypress="emailError()" ValidationGroup="registerValidation"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="emailValidator" runat="server" 
                        ControlToValidate="emailID" ErrorMessage="*" ForeColor="Red" Height="25px" 
                        ValidationGroup="registerValidation"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="emailError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Image ID="passImage" runat="server" Height="25px" 
                        ImageUrl="~/Images/passNotFilled.png" Width="25px" />
                    &nbsp;<asp:TextBox ID="password" runat="server" Height="25px" MaxLength="40" 
                        placeholder="Password" style="margin-bottom: 0px" TabIndex="6" 
                        TextMode="Password" Width="300px" ToolTip="Create password." 
                        autocomplete="off" onkeypress="passwordError()" 
                        ValidationGroup="registerValidation"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="passwordValidator" runat="server" 
                        ControlToValidate="password" ErrorMessage="*" ForeColor="Red" 
                        Height="25px" ValidationGroup="registerValidation"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="passwordError" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                        <br />

                        <asp:Image ID="cpassImage" runat="server" Height="25px" Width="25px" 
                            ImageUrl="~/Images/passNotFilled.png" />

                        &nbsp;<asp:TextBox ID="confirmPassword" runat="server" 
                            placeholder="Confirm Password" Height="25px" Width="305px" 
                            TextMode="Password" MaxLength="40" TabIndex="7" 
                        ToolTip="Confirm Password." autocomplete="off" 
                        ValidationGroup="registerValidation"></asp:TextBox>
                        <br />
                    <asp:CompareValidator ID="confirmpasswordValidator" runat="server" 
                        ControlToCompare="password" ControlToValidate="confirmPassword" 
                        ErrorMessage="Password does not match." ForeColor="Red" Height="25px" 
                        ValidationGroup="validateContent"></asp:CompareValidator>
                    <br />
                    <asp:Image ID="captchaImage" runat="server" />
                    <br />
                    <asp:ImageButton ID="reloadCaptchaImage" runat="server" Height="20px" 
                        ImageUrl="~/Images/reload.png" oncommand="reloadCaptcha_Command" 
                        ValidationGroup="reloadCaptchaGroup" Width="20px" />
                    <asp:Button ID="reloadCaptcha" runat="server" BorderColor="White" 
                        BorderStyle="Solid" Height="20px" oncommand="reloadCaptcha_Command" 
                        Text="Reload Captcha" ValidationGroup="reloadCaptchaGroup" />
                    <br />
                    <br />
                    <asp:TextBox ID="captcha" runat="server" Height="25px" 
                        onkeypress="captchaError()" placeholder="Enter text shown in the image above." 
                        ToolTip="Enter captcha text." ValidationGroup="registerValidation" autocomplete="off" 
                        Width="246px" TabIndex="8"></asp:TextBox>
                    <br />
                    <asp:CustomValidator ID="captchaValidator" runat="server" 
                        ControlToValidate="captcha" ErrorMessage="Invalid Captcha entered." 
                        ForeColor="Red"></asp:CustomValidator>
                    <br />
                    <br />
                    <asp:Button ID="Back" runat="server" BackColor="#FF6262" BorderColor="#FF6262" 
                        BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" TabIndex="10" 
                        Text="Back" UseSubmitBehavior="False" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="registerButton" runat="server" BackColor="#CCFF66" 
                        BorderColor="#CCFF66" BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                        onclick="registerButton_Click" TabIndex="9" Text="Register" 
                        ValidationGroup="registerValidation" />
                        <br />
                        <br />
                </asp:View>
                <asp:View ID="successView" runat="server">
                    
                    <br />
                    
                    You are Successfully Registered. Click on button below to proceed.<br />
                    <br />
                    <asp:Button ID="Home" runat="server" BackColor="#FFFF99" BorderColor="#FFFF99" 
                        BorderStyle="Solid" BorderWidth="5px" CssClass="buttons" 
                        onclick="homeButton_Click" Text="Go to Drive" UseSubmitBehavior="False" />
                    
                </asp:View>
            </asp:MultiView>
            
        </div>
    </div>
</asp:Content>

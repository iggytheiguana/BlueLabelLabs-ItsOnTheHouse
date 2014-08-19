using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DrinkBarVoucherObject;
using DrinkBarVoucher.Helper;
namespace DrinkBarVoucher
{
    public partial class AdminLogin : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblErrorMsg.Text = string.Empty;

            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            Admin_User objAdminUser = new Admin_User();
            objAdminUser.UserValidate(txtEmail.Text.Trim(), txtPassword.Text);
            if (objAdminUser.UserId > 0)
            {
                SessionUtility.UserID = objAdminUser.UserId;
                SessionUtility.Email = objAdminUser.Email;
                SessionUtility.FName = objAdminUser.FName;
                SessionUtility.LName = objAdminUser.LName;
                Response.Redirect("BarList.aspx");
            }
            else
            {
                lblErrorMsg.Text = "Please enter valid Email or Password!";
                ClearPageContents();
            }
        }


        public void ClearPageContents()
        {
            txtEmail.Text = "";
            txtPassword.Text = "";
        }

        protected void lnkForgot_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("ForgotPassword.aspx");
               
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
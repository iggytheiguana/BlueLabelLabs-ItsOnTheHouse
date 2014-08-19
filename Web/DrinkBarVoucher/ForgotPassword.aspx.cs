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
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                lblErrorMsg.Text = string.Empty; 
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean blnMailSendStatus;
                Admin_User objAdminUser = new Admin_User();
                string strIPUrl = System.Configuration.ConfigurationManager.AppSettings["ForgotPasswordUrl"];    

                if (objAdminUser.ExistsEmail(txtEmail.Text))
                {
                    Guid guidTempPWD = Guid.NewGuid();
                    string[] strTempPassword = Convert.ToString(guidTempPWD).Split('-');
                    string strEncryptPWD = EncryptDecrypt.Encodebase64(strTempPassword[0].ToString());

                    blnMailSendStatus = objAdminUser.SendMailTempPWD(Convert.ToString(txtEmail.Text), strEncryptPWD, strIPUrl);
                    if (blnMailSendStatus == true)
                    {
                        objAdminUser.CreateTempPassword(Convert.ToString(txtEmail.Text), strTempPassword[0].ToString());
                    }
                    lblErrorMsg.Text = "Activation link sent to your email. Please check your inbox and click on activation link to reset your password.";
                    txtEmail.Text = string.Empty;
                }
                else
                {
                    lblErrorMsg.Text = "Provided email address is invalid.";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminLogin.aspx");  
        }
    }
}
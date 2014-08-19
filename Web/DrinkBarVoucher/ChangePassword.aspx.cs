using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DrinkBarVoucherObject;
namespace DrinkBarVoucher
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        public string _Email
        {
            get
            {
                if (Request.QueryString["1"] != null)
                {
                    return Convert.ToString(Request.QueryString["1"]);

                }
                else
                {
                    return "";
                }
            }
            set { Request.QueryString["1"] = value; }
        }

        public string _TempPassword
        {
            get
            {
                if (Request.QueryString["2"] != null)
                {
                    return Convert.ToString(Request.QueryString["2"]);

                } 
                else
                {
                    return "";
                }
            }
            set { Request.QueryString["2"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(_TempPassword) &&  ! string.IsNullOrEmpty(_Email))
                {
                    txtEmail.Text = EncryptDecrypt.Decodebase64(_Email);                           
                }
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(_TempPassword)) {
                    string script;
                    Admin_User objAdminUser = new Admin_User();
                    if (objAdminUser.UpdatePassword(Convert.ToString(txtEmail.Text), Convert.ToString(txtPassword.Text)))
                    {
                      script = "Redirect();";
                        
                    }
                    else
                    {
                        script = "AlreadyChanged();";
                    }
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), script, true);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
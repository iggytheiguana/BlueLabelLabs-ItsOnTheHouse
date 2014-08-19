using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DrinkBarVoucherObject;
using DrinkBarVoucher.Helper; 
using System.Data;

namespace DrinkBarVoucher
{
    public partial class AdminUser : System.Web.UI.Page
    {

        #region "Private Variables and Properties"

        /// <summary>
        /// Gets or sets the User Id
        /// </summary>
        private int UserId
        {
            get
            {
                if (Request.QueryString["Id"] != null)
                {
                    return Convert.ToInt32(Request.QueryString["Id"]);
                }
                else
                {
                    return 0;
                }
            }
        }

        /// <summary>
        /// Gets or sets pwd
        /// </summary>
        private String pwd
        {
            get
            {
                return Convert.ToString(ViewState["Password"]);
            }
            set
            {
                ViewState["Password"] = value;
            }
        }

        #endregion

        #region "Page events"


        /// <summary>
        ///Page Load 
        /// </summary>
        /// <returns></returns>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LinkButton lnkVoucher = (LinkButton)Master.FindControl("lnkAdministrator");
                lnkVoucher.CssClass = "active";

                if (UserId == 0)
                {
                    trOldAdmin.Visible = false;
                    lblNewPassword.Visible = false;
                    lblconfirmNewPassword.Visible = false;
                    trNewAdmin.Visible = true;
                    btnDeleteUser.Visible = false;
                }
                else
                {
                    trOldAdmin.Visible = true;
                    lblNewPassword.Visible = true;
                    lblconfirmNewPassword.Visible = true;
                    trNewAdmin.Visible = false;
                    btnDeleteUser.Visible = true;
                    BindData();
                }
            }
        }

        #endregion


        #region "control Events"


        ///<summary>
        ///Handles the click Event of Save button
        ///</summary>
        ///<param name="sender">The source of the event.</param>
        ///<param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void btnSave_Clicked(object sender, EventArgs e)
        {
            string oldpwd = Convert.ToString(txtOldPassword.Text).Trim();
            string newpwd = Convert.ToString(txtNewPassword.Text).Trim();
            string confnewpwd = Convert.ToString(txtConformNewPassword.Text).Trim();
            if (IsValidate())
            {
                Admin_User objAdminUser = new Admin_User();
                objAdminUser.FName = Convert.ToString(txtFirstName.Text);
                objAdminUser.LName = Convert.ToString(txtLastName.Text);
                objAdminUser.Email = Convert.ToString(txtEmail.Text);
                objAdminUser.LC_UserID = SessionUtility.UserID;
                objAdminUser.UserId = UserId;

                if (objAdminUser.CheckDuplicateEmail())
                {
                    lblErrorEmail.Text = "EmailID already exists";
                    
                    txtOldPassword.Attributes.Add("value", oldpwd);
                    txtNewPassword.Attributes.Add("value", newpwd);
                    txtConformNewPassword.Attributes.Add("value", confnewpwd);
                }
                else
                {
                    if (UserId == 0)
                    {
                        
                        objAdminUser.Password = Convert.ToString(txtPassword.Text);
                        
                        objAdminUser.CR_UserID = SessionUtility.UserID;
                        objAdminUser.Insert();
                    }
                    else
                    {
                        if (oldpwd == "")
                        {
                            objAdminUser.Password = pwd;
                        }
                        else
                        {
                            objAdminUser.Password = Convert.ToString(txtNewPassword.Text);
                        }
                        // TO DO NEED TO CHAGNE WITH LOGIN USER ID
                        objAdminUser.Update();
                    }
                    string script = "Redirect();";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), script, true);
                   // Response.Redirect("~/AdminUserList.aspx");
                }

            }
            else
            {
                txtOldPassword.Attributes.Add("value", oldpwd);
                txtNewPassword.Attributes.Add("value", newpwd);
                txtConformNewPassword.Attributes.Add("value", confnewpwd);
              }
           
        }

        ///<summary>
        ///Handles the click Event of Delete User button
        ///</summary>
        ///<param name="sender">The source of the event.</param>
        ///<param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void btnDeleteUser_Clicked(object sender, EventArgs e)
        {
            Admin_User objAdminUser = new Admin_User();
            objAdminUser.UserId = UserId;
            objAdminUser.Delete();
            Response.Redirect("~/AdminUserList.aspx");
        }

        ///<summary>
        ///Handles the click Event of Cancel button
        ///</summary>
        ///<param name="sender">The source of the event.</param>
        ///<param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void btnCancel_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/AdminUserList.aspx");
        }

        #endregion

        #region "Methods"

        /// <summary>
        ///Bind Data
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        public void BindData()
        {
            Admin_User objAdminUser = new Admin_User();
            DataSet ds = objAdminUser.Select(UserId);
            DataTable dt = ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                txtFirstName.Text = Convert.ToString(dt.Rows[0]["FName"]);
                txtLastName.Text = Convert.ToString(dt.Rows[0]["LName"]);
                txtEmail.Text = Convert.ToString(dt.Rows[0]["Email"]);
                pwd = Convert.ToString(dt.Rows[0]["Password"]);
            }
        }


        
        /// <summary>
        ///validate data
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        public Boolean IsValidate()
        {
            //TO DO CHECK FOR DUPLICATE EMAIL
            if (UserId == 0) 
            {
                return true;
            }
            else
            {
                string oldpwd = Convert.ToString(txtOldPassword.Text).Trim();
                string newpwd = Convert.ToString(txtNewPassword.Text).Trim();
                string confnewpwd = Convert.ToString(txtConformNewPassword.Text).Trim();

                if (oldpwd.Length > 0)
                {
                    if(oldpwd == pwd)
                    {
                        if (newpwd.Length > 0 && confnewpwd.Length > 0)
                        {
                            if (newpwd == confnewpwd)
                            {
                                lblerror.Text = "";
                                return true;
                            }
                            lblerror.Text = "Confirm password should match with new password.";
                            return false;
                        }
                        else
                        {
                            if (newpwd.Length == 0)
                            {
                                lblerror.Text = "Please enter new password";
                                return false;
                            }
                            else
                            {
                                lblerror.Text = "Please enter confirm new password";
                                return false;
                            }
                        }
                    }
                    else
                    {
                        lblerror.Text = "Incorrect Old Password";
                        return false;
                    }
                }
                else
                {
                    lblerror.Text = "";
                    return true;
                }
            }
        }


        #endregion

    }
}
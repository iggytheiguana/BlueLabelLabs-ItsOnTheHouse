using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DrinkBarVoucher.Helper; 
namespace DrinkBarVoucher
{
    public partial class mstDrinkVoucher : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (! (SessionUtility.UserID > 0))
            {
                Response.Redirect("AdminLogin.aspx");
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
           
            SessionUtility.UserID = 0;
            SessionUtility.Email = string.Empty;
            Session.Clear();
            Session.Abandon();
            Response.Redirect("AdminLogin.aspx");
        }
    }
}
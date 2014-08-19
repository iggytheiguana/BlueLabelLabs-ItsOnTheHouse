using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DrinkBarVoucher.Helper
{
    public class SessionUtility
    {
        public static int UserID
        {
            get
            {
                if (HttpContext.Current.Session == null || HttpContext.Current.Session["UserID"] == null)
                {
                    return 0;
                }
                else
                {
                    int intUserID = 0;
                    return Convert.ToInt32(((int.TryParse(HttpContext.Current.Session["UserID"].ToString(), out intUserID)) ? intUserID : -1));
                }
            }
            set { HttpContext.Current.Session["UserID"] = value; }
        }


     

        public static string Email
        {
            get
            {
                if (HttpContext.Current.Session["Email"] == null)
                {
                    return "";
                  
                }
                else
                {
                    return System.Convert.ToString(HttpContext.Current.Session["Email"]);
                }
            }
            set { HttpContext.Current.Session["Email"] = value; }
        }


        public static string FName
        {
            get
            {
                if (HttpContext.Current.Session["FName"] == null)
                {
                    return "";

                }
                else
                {
                    return System.Convert.ToString(HttpContext.Current.Session["FName"]);
                }
            }
            set { HttpContext.Current.Session["FName"] = value; }
        }

        public static string LName
        {
            get
            {
                if (HttpContext.Current.Session["LName"] == null)
                {
                    return "";

                }
                else
                {
                    return System.Convert.ToString(HttpContext.Current.Session["LName"]);
                }
            }
            set { HttpContext.Current.Session["LName"] = value; }
        }

    }
}
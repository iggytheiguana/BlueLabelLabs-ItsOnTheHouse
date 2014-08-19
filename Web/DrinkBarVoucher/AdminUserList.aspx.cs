using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using DrinkBarVoucherObject;

namespace DrinkBarVoucher
{
    public partial class AdminUserList : System.Web.UI.Page
    {
        PagedDataSource pds = new PagedDataSource();


        #region "Private Variables and Properties"
        /// <summary>
        /// Gets or sets the SortExpression value.
        /// </summary>
        public virtual string  m_strSortExp
        {
            get {
                    if (ViewState["_SortExp_"] != null)
                    {
                        return ViewState["_SortExp_"].ToString();
                    }                
                    return "";
                }
            set {
                    ViewState["_SortExp_"] = value; 
                }
        }


        /// <summary>
        /// Gets or sets the SortExpression value.
        /// </summary>
        public virtual string m_strSortDirection
        {
            get
            {
                if (ViewState["_SortDir_"] != null)
                {
                    return ViewState["_SortDir_"].ToString();
                }
                return "ASC";
            }
            set
            {
                ViewState["_SortDir_"] = value;
            }
        }


        /// <summary>
        /// Gets or sets the Current Page value.
        /// </summary>
        private int CurrentPage 
        {
            get{
                //Check view state is null if null then return current index value as "0" else return specific page viewstate value
                 if (ViewState["CurrentPage"] == null)
                 {
                 return 0;
                 }
                else
                {
                return ((int)ViewState["CurrentPage"]);
                }
               }
            
            set
            {
                //Set View statevalue when page is changed through Paging DataList
                ViewState["CurrentPage"] = value;
            }
         }

        /// <summary>
        /// Gets or sets the total Page Count value.
        /// </summary>
        public int PageCount
        {
            get
            {                
                if (ViewState["PageCount"] == null)
                {
                    return 0;
                }
                else
                {
                    return ((int)ViewState["PageCount"]);
                }
            }

            set
            {
                //Set View statevalue when page is changed through Paging DataList
                ViewState["PageCount"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the Page Size value
        /// </summary>
        public int PageSize
        {
            get
            {
                if (ViewState["PageSize"] == null)
                {
                    return 25;
                }
                else
                {
                    return ((int)ViewState["PageSize"]);
                }
            }

            set
            {
               ViewState["PageSize"] = value;
            }
        }


        #endregion



        #region PageEvents

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
                BindAdminUserGrid();
            }
        }

        #endregion 

        #region "Methods"

        /// <summary>
        ///Bind gvAdmin_User gridview
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        public void BindAdminUserGrid()
        {
            Admin_User objAdmin_User = new Admin_User();
            DataSet ds = objAdmin_User.SelectAll();            
            DataView dv = new DataView(ds.Tables[0]);
            if (!string.IsNullOrEmpty(m_strSortExp))
            {
                dv.Sort = m_strSortExp + " " + m_strSortDirection;
            }

            pds.DataSource =dv;

            int intTotal=pds.Count;
            pds.PageSize = PageSize;
            pds.AllowPaging = true;
            PageCount = pds.PageCount;
            pds.CurrentPageIndex = CurrentPage;

            lnkPrev.Enabled=!pds.IsFirstPage;
            lnkNext.Enabled = !pds.IsLastPage;
            lblPageInfo.Text = (CurrentPage + 1) + " of " + PageCount;

            if (!(lnkPrev.Enabled))
                lnkPrev.CssClass = "inactive";
            else
                lnkPrev.CssClass = "active";

            if (!(lnkNext.Enabled))
                lnkNext.CssClass = "inactive";
            else
                lnkNext.CssClass = "active";

            if (PageSize == 25)
                lnk25.CssClass = "inactive";
            else if (PageSize == 50)
                lnk50.CssClass = "inactive";
            else if (PageSize == 100)
                lnk100.CssClass = "inactive";

            
            gvAdminUserList.DataSource =pds ;
            gvAdminUserList.DataBind();


        }

        #endregion

        #region "Control Events"

        ///<summary>
        ///Handles the sorting event of the gvAdminUserList control.
        ///</summary>
         ///<param name="sender">The source of the event.</param>
        ///<param name="e">The <see cref="GridViewSortEventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void gvAdminUserList_sorting(object sender, GridViewSortEventArgs e)
        {

            if (m_strSortExp == e.SortExpression)
            {
                if (m_strSortDirection == "ASC")
                {
                    m_strSortDirection = "DESC";
                }
                else
                {
                    m_strSortDirection = "ASC";
                }
            }
            else
            {
                m_strSortExp = e.SortExpression;
                m_strSortDirection = "ASC";
            }
            BindAdminUserGrid();

        }

        ///<summary>
        ///Handles the click Event of lnkPrev link button
        ///</summary>
        ///<param name="sender">The source of the event.</param>
        ///<param name="e"> <see cref="EventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void lnkPrev_Click(object sender, EventArgs e)
        {
            CurrentPage = CurrentPage - 1;
            BindAdminUserGrid();
            
        }

        ///<summary>
        ///Handles the click Event of lnkNext link button
        ///</summary>
        ///<param name="sender">The source of the event.</param>
        ///<param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void lnkNext_Click(object sender, EventArgs e)
        {
            CurrentPage = CurrentPage + 1;
            BindAdminUserGrid();

        }

        ///<summary>
        ///Handles the click Event of lnk20 link button
        ///</summary>
        ///<param name="sender">The source of the event.</param>
        ///<param name="e"> <see cref="EventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void lnk25_Click(object sender, EventArgs e)
        {
            PageSize = 25;
            lnk25.CssClass = "inactive";
            lnk50.CssClass = "active";
            lnk100.CssClass = "active";
            CurrentPage = 0;
            BindAdminUserGrid();

        }


        ///<summary>
        ///Handles the click Event of lnk50 link button
        ///</summary>
        ///<param name="sender">The source of the event.</param>
        ///<param name="e"> <see cref="EventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void lnk50_Click(object sender, EventArgs e)
        {
            PageSize = 50;
            lnk25.CssClass = "active";
            lnk50.CssClass = "inactive";
            lnk100.CssClass = "active";
            CurrentPage = 0;
            BindAdminUserGrid();

        }

        ///<summary>
        ///Handles the click Event of lnk100 link button
        ///</summary>
        ///<param name="sender">The source of the event.</param>
        ///<param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void lnk100_Click(object sender, EventArgs e)
        {
            PageSize = 100;
            lnk25.CssClass = "active";
            lnk50.CssClass = "active";
            lnk100.CssClass = "inactive";
            CurrentPage = 0;
            BindAdminUserGrid();

        }

        ///<summary>
        ///Handles the click Event of add new admin btn
        ///</summary>
        ///<param name="sender">The source of the event.</param>
        ///<param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void btnAddNewAdmin_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/AdminUser.aspx");
        }


        protected void gvAdminUserList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.Header)
            {
                foreach (TableCell tc in e.Row.Cells)
                {


                    if (tc.HasControls() && tc.Controls[0].GetType() != typeof(System.Web.UI.LiteralControl))
                    {
                        LinkButton lnk = (LinkButton)tc.Controls[0];
                        if (lnk != null)
                        {
                            System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
                            if (m_strSortExp == lnk.CommandArgument)
                            {

                                if (m_strSortDirection == "ASC")
                                    img.ImageUrl = "~/Images/up.png";
                                else
                                    img.ImageUrl = "~/Images/sort_down.png";
                            }
                            else
                            {
                                img.ImageUrl = "~/Images/UpArrow.png";
                            }
                            tc.Controls.Add(img);
                        }
                    }

                }
            }

        }
        #endregion
    }
}
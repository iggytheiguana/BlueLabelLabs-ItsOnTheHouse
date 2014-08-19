using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DrinkBarVoucherObject;
using System.Data;
using System.Text;
using System.IO;
namespace DrinkBarVoucher
{
    public partial class BarList : System.Web.UI.Page
    {
        PagedDataSource pdsBar = new PagedDataSource();
        Boolean IsFromPageLoad = false;

        #region Properties and Fields


        public virtual string GridViewSortDirection
        {
            get
            {
                if (ViewState["sortDirection"] != null)
                {
                    return Convert.ToString(ViewState["sortDirection"]);

                }
                return "ASC";
            }
            set { ViewState["sortDirection"] = value; }
        }

        public virtual string SortExpression
        {
            get
            {
                if (ViewState["sortExpression"] != null)
                {
                    return ViewState["sortExpression"].ToString();
                }
                return "";
            }
            set
            {
                ViewState["sortExpression"] = value;
            }
        }
        /// <summary>
        /// Gets or sets the Current Page value.
        /// </summary>
        private int CurrentPage
        {
            get
            {
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

        /// <summary>
        /// Gets or sets the Bar Id
        /// </summary>
        private int BarId
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

        #endregion


        #region PageMethods
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LinkButton lnkBar = (LinkButton)Master.FindControl("lnkBar");
                lnkBar.CssClass = "active";
                if (BarId > 0)
                {
                    IsFromPageLoad = true;
                }
                BindGridBarList();
            }
        }
        #endregion

        #region ControlMethods

        protected void gvBarList_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (SortExpression == e.SortExpression)
            {
                if (GridViewSortDirection == "ASC")
                {
                    GridViewSortDirection = "DESC";
                }
                else
                {
                    GridViewSortDirection = "ASC";
                }
            }
            else
            {
                SortExpression = e.SortExpression;
                GridViewSortDirection = "ASC";
            }
            BindGridBarList();

        }


        protected void btnAddBar_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddEditBar.aspx");
        }


        protected void btnInactive_Click(object sender, EventArgs e)
        {
            DrinkBarVoucherObject.Bar objBar = new DrinkBarVoucherObject.Bar();
            objBar.InActiveBar(Convert.ToString(hdnBarIdChecked.Value));
            BindGridBarList();
            hdnBarIdChecked.Value = string.Empty;
        }

        protected void btnActive_Click(object sender, EventArgs e)
        {
            DrinkBarVoucherObject.Bar objBar = new DrinkBarVoucherObject.Bar();
            objBar.ActiveBar(Convert.ToString(hdnBarIdChecked.Value));
            BindGridBarList();
            hdnBarIdChecked.Value = string.Empty;
        }

        protected void btnDeleteBar_Click(object sender, EventArgs e)
        {
            DrinkBarVoucherObject.Bar objBar = new DrinkBarVoucherObject.Bar();
            objBar.DeleteMultiBar(Convert.ToString(hdnBarIdChecked.Value));
            CurrentPage = 0;
            BindGridBarList();
            hdnBarIdChecked.Value = string.Empty;
        }


        protected void btnExportAll_Click(object sender, EventArgs e)
        {
            ExportToCSV();
            hdnBarIdChecked.Value = string.Empty;
        }



        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            try
            {
                BindGridBarList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void imgEdit_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton btnEdit = (ImageButton)sender;
            if (btnEdit != null)
            {
                string strBarID = Convert.ToString(btnEdit.CommandArgument);
                Response.Redirect("AddEditBar.aspx?BarID=" + strBarID);
            }
        }

        protected void gvBarList_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.Header)
            {
                foreach (TableCell tc in e.Row.Cells)
                {


                    if (tc.HasControls() && tc.Controls[0].GetType() != typeof(System.Web.UI.LiteralControl))
                    {

                        // search for the header link
                        LinkButton lnk = (LinkButton)tc.Controls[0];
                        if (lnk != null)
                        {
                            System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
                            if (SortExpression == lnk.CommandArgument)
                            {

                                if (GridViewSortDirection.Trim() == "ASC")
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
        ///<summary>
        ///Handles the click Event of lnkPrev link button
        ///</summary>
        ///<param name="sender">The source of the event.</param>
        ///<param name="e"> <see cref="EventArgs" /> instance containing the event data.</param>
        ///<remarks></remarks>
        protected void lnkPrev_Click(object sender, EventArgs e)
        {
            CurrentPage = CurrentPage - 1;
            BindGridBarList();

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
            BindGridBarList();

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
            CurrentPage = 0;
            lnk25.CssClass = "inactive";
            lnk50.CssClass = "active";
            lnk100.CssClass = "active";
            BindGridBarList();

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
            CurrentPage = 0;
            lnk25.CssClass = "active";
            lnk50.CssClass = "inactive";
            lnk100.CssClass = "active";
            BindGridBarList();

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
            CurrentPage = 0;
            lnk25.CssClass = "active";
            lnk50.CssClass = "active";
            lnk100.CssClass = "inactive";
            BindGridBarList();

        }
        #endregion

        #region Methods
        /// <summary>
        /// Bind Information about Bars 
        /// </summary>
        public void BindGridBarList()
        {
            try
            {
                DrinkBarVoucherObject.Bar objBar = new DrinkBarVoucherObject.Bar();
                DataTable dtBarDetail = new DataTable();
                if (!string.IsNullOrEmpty(txtSearch.Text) && txtSearch.Text != "search by bar name")
                {
                    dtBarDetail = objBar.SearchBarList(Convert.ToString(txtSearch.Text)).Tables[0];
                }
                else
                {
                    dtBarDetail = objBar.SelectBarList().Tables[0];
                }

                DataView dvBar = new DataView(dtBarDetail);

                if (IsFromPageLoad)
                {
                    dvBar.RowFilter = "BarID=" + BarId;
                    if (dvBar.ToTable().Rows.Count > 0)
                    {
                        txtSearch.Text = Convert.ToString((dvBar.ToTable()).Rows[0]["BarName"]);
                    }


                    IsFromPageLoad = false;
                }
                if (!string.IsNullOrEmpty(SortExpression))
                {
                    dvBar.Sort = SortExpression + " " + GridViewSortDirection;
                }

                pdsBar.DataSource = dvBar;

                int intTotal = pdsBar.Count;
                pdsBar.PageSize = PageSize;
                pdsBar.AllowPaging = true;
                PageCount = pdsBar.PageCount;
                pdsBar.CurrentPageIndex = CurrentPage;

                lnkPrev.Enabled = !pdsBar.IsFirstPage;
                lnkNext.Enabled = !pdsBar.IsLastPage;
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

                gvBarList.DataSource = pdsBar;
                gvBarList.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        /// <summary>
        /// export user log into csv file.
        /// </summary>
        /// <remarks></remarks>
        private void ExportToCSV()
        {
            DataTable dt = null;
            DataTable dttemp = null;
            string strHomeURL = System.Configuration.ConfigurationManager.AppSettings["HomeUrl"].ToString();
            DrinkBarVoucherObject.Bar objBar = new DrinkBarVoucherObject.Bar();
            if (!string.IsNullOrEmpty(hdnBarIdChecked.Value))
            {
                dttemp = objBar.ExportBarSelected(Convert.ToString(hdnBarIdChecked.Value)).Tables[0];
            }
            else if (!string.IsNullOrEmpty(txtSearch.Text) && txtSearch.Text != "search by bar name")
            {
                dttemp = objBar.SearchBarList(Convert.ToString(txtSearch.Text)).Tables[0];
            }
            else
            {
                dttemp = objBar.SelectBarList().Tables[0];
            }

            DataView dvBar = new DataView(dttemp);
           
            if (!string.IsNullOrEmpty(SortExpression))
            {
                dvBar.Sort = SortExpression + " " + GridViewSortDirection;
            }

            dt = dvBar.ToTable();

            StringBuilder str = new StringBuilder();
            str.Append("Name");
            str.Append(",");
            str.Append("Status");
            str.Append(",");
            str.Append("Active Days");
            //str.Append(",");
            //str.Append("Voucher Hours");
            str.Append(",");
            str.Append("Discovery Radius");
            str.Append(",");
            str.Append("Redemption Radius");
            str.Append(",");
            str.Append("Date Created");
            str.Append(",");
            str.Append("Website");
            str.Append(",");
            str.Append("Photo");
            str.Append(",");
            str.Append("Street Address");
            str.Append(",");
            str.Append("City");
            str.Append(",");
            str.Append("State");
            str.Append(",");
            str.Append("Country");
            str.Append(",");
            str.Append("Phone");
            str.Append(",");
            str.Append("Zipcode");
            str.Append(",");
            str.Append("Latitude");
            str.Append(",");
            str.Append("Longitude");
            str.Append("<BR>");
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                str.Append(dt.Rows[i]["BarName"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["Status"].ToString());
                str.Append(",");
                string strActiveDays = dt.Rows[i]["ActiveDays"].ToString().Replace(",", "_");
                str.Append(strActiveDays);
                //str.Append(",");
                //str.Append(dt.Rows[i]["VoucherHours"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["Radius"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["RedemptionRadius"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["DateCreated"].ToString());
                str.Append(",");

                str.Append(dt.Rows[i]["BarWebsite"].ToString());
                str.Append(",");
                str.Append(strHomeURL + dt.Rows[i]["BarImageName"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["BarStreet"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["CityName"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["StateName"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["BarCountry"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["BarPhone"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["BarZipCode"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["BarLatitude"].ToString());
                str.Append(",");
                str.Append(dt.Rows[i]["BarLongitude"].ToString());
                str.Append("<BR>");
            }
            Response.Clear();
            str = str.Replace("<BR>", "\r\n");
            Response.AddHeader("content-disposition", "attachment;filename=BarInformation.csv");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/x-msexcel";
            //Dim stringWrite As New System.IO.StringWriter()
            //Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
            Response.Write(str.ToString());
            Response.Flush();
            Response.End();



        }

        #endregion





    }
}
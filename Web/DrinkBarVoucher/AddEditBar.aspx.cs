using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DrinkBarVoucherObject;
using System.Xml;
using System.IO; 
using DrinkBarVoucher.Helper;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;



namespace DrinkBarVoucher
{
    public partial class Bar : System.Web.UI.Page
    {

        #region PageMethods
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LinkButton lnkBar = (LinkButton)Master.FindControl("lnkBar");
                lnkBar.CssClass = "active";

                BindStateDropDown();
                BindCityDropDown();
                GetZipcode();
                if (Request.QueryString["BarID"] != null && Convert.ToInt32(Request.QueryString["BarID"]) > 0)
                {
                    FillBarEdit(Convert.ToInt32(Request.QueryString["BarID"]));
                }

                
            }
        }
        #endregion

        #region ControlsMethod

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveBarDetail();
            Response.Redirect("BarList.aspx");

        }


        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlState.SelectedIndex > 0)
            {
                BindCityDropDown();
            }
        }

        protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetZipcode();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("BarList.aspx");
        }

        #endregion

        #region Methods
        protected void BindStateDropDown()
        {
            try
            {
                State objState = new State();
                ddlState.DataValueField = "StateID";
                ddlState.DataTextField = "StateName";
                ddlState.DataSource = objState.SelectAll();
                ddlState.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void BindCityDropDown()
        {
            try
            {
                int intDDLStateId = Convert.ToInt32(ddlState.SelectedValue);
                City objCity = new City();
                ddlCity.DataValueField = "CityId";
                ddlCity.DataTextField = "CityName";
                ddlCity.DataSource = objCity.SelectByState(intDDLStateId);
                ddlCity.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        private void GetZipcode()
        {
            City objCity = new City();
            txtZipCode.Text = objCity.SelectZipcode(Convert.ToInt32(ddlCity.SelectedValue));
        }

        //private System.Drawing.Bitmap FixedSize(System.Drawing.Image  imgPhoto ,int  Width,int Height)
        //{
        // //  int   sourceWidth = imgPhoto.Width;
        // // int sourceHeight = imgPhoto.Height;
        // //int sourceX  = 0;
        // //int sourceY = 0;
        // //int destX = 0;
        // //int destY = 0;
        // //float nPercent = 0;
        // //float nPercentW = 0;
        // //float nPercentH = 0;

        // //nPercentW = (Convert.ToSingle(Width) / Convert.ToSingle(sourceWidth));
        // //nPercentH = (Convert.ToSingle(Height) / Convert.ToSingle(sourceHeight));

        // ////if we have to pad the height pad both the top and the bottom
        // ////with the difference between the scaled height and the desired height
        // //if (nPercentH < nPercentW)
        // //{
        // //    nPercent = nPercentH;
        // //    destX = Convert.ToInt32(((Width - (sourceWidth * nPercent)) / 2));
        // //}
        // //else
        // //{
        // //    nPercent = nPercentW;
        // //    destY = Convert.ToInt32(((Height - (sourceHeight * nPercent)) / 2));
        // //}

        // //int destWidth = Convert.ToInt32((sourceWidth * nPercent));
        // //int destHeight = Convert.ToInt32((sourceHeight * nPercent));

        // Bitmap bmPhoto = new Bitmap(Width, Height);
        // //, PixelFormat.Format24bppRgb)
        // bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

        // Graphics grPhoto = Graphics.FromImage(bmPhoto);
         
        //     grPhoto.Clear(Color.Transparent);
        

        // grPhoto.SmoothingMode = SmoothingMode.AntiAlias;
        // grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;
        // grPhoto.PixelOffsetMode = PixelOffsetMode.HighQuality;

        // grPhoto.DrawImage(imgPhoto, new Rectangle(destX, destY, destWidth, destHeight), new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight), GraphicsUnit.Pixel);

        // grPhoto.Dispose();
        // return bmPhoto;

        //}

        private void SaveBarDetail()
        {
            try
            {
                if (Page.IsValid)
                {

                    string website = Convert.ToString(txtWebSite.Text);

                    if (website.Substring(0, 4) != "http")
                    {

                        website = "http://" + website;
                    }

                    DrinkBarVoucherObject.Bar objBar = new DrinkBarVoucherObject.Bar();
                    objBar.BarID = Convert.ToInt32(hdnBarId.Value);
                    objBar.BarName = Convert.ToString(txtName.Text);
                    objBar.BarStreet = Convert.ToString(txtStreet.Text);
                    objBar.BarCityId = Convert.ToInt32(ddlCity.SelectedValue);
                    objBar.BarStateID = Convert.ToInt32(ddlState.SelectedValue);
                    objBar.BarZipCode = Convert.ToString(txtZipCode.Text);
                    objBar.BarCountry = Convert.ToString(txtCountry.Text);
                    objBar.BarLatitude = Convert.ToSingle(txtLatitude.Text);
                    objBar.BarLongitude = Convert.ToSingle(txtLongitude.Text);
                    objBar.BarWebsite = website;
                    objBar.BarHours = Convert.ToString(txtTotalHours.Text);
                    objBar.BarStatus = Convert.ToBoolean(Convert.ToInt32(hdnBarStatus.Value));
                    objBar.BarRadius = Convert.ToInt32(txtDiscoveryRadius.Text);
                    objBar.BarRedemptionRadius = Convert.ToInt32(txtRedemptionRadius.Text);
                    if (!string.IsNullOrEmpty(lnkBarPhoto.Text) && fudPhoto.HasFile == false)
                    {
                        objBar.BarImageName = Convert.ToString(lnkBarPhoto.Text);
                    }
                    else
                    {
                        objBar.BarImageName = fuFileName();
                    }
                    objBar.BarActiveDay1 = Convert.ToBoolean(Convert.ToInt32(hdnBarDay1.Value));
                    objBar.BarActiveDay2 = Convert.ToBoolean(Convert.ToInt32(hdnBarDay2.Value));
                    objBar.BarActiveDay3 = Convert.ToBoolean(Convert.ToInt32(hdnBarDay3.Value));
                    objBar.BarActiveDay4 = Convert.ToBoolean(Convert.ToInt32(hdnBarDay4.Value));
                    objBar.BarActiveDay5 = Convert.ToBoolean(Convert.ToInt32(hdnBarDay5.Value));
                    objBar.BarActiveDay6 = Convert.ToBoolean(Convert.ToInt32(hdnBarDay6.Value));
                    objBar.BarActiveDay7 = Convert.ToBoolean(Convert.ToInt32(hdnBarDay7.Value));
                    objBar.BarHoursFromDay1 = Convert.ToDateTime(ddlFromHrsDay1.SelectedValue);
                    objBar.BarHoursFromDay2 = Convert.ToDateTime(ddlFromHrsDay2.SelectedValue);
                    objBar.BarHoursFromDay3 = Convert.ToDateTime(ddlFromHrsDay3.SelectedValue);
                    objBar.BarHoursFromDay4 = Convert.ToDateTime(ddlFromHrsDay4.SelectedValue);
                    objBar.BarHoursFromDay5 = Convert.ToDateTime(ddlFromHrsDay5.SelectedValue);
                    objBar.BarHoursFromDay6 = Convert.ToDateTime(ddlFromHrsDay6.SelectedValue);
                    objBar.BarHoursFromDay7 = Convert.ToDateTime(ddlFromHrsDay7.SelectedValue);
                    objBar.BarHoursToDay1 = Convert.ToDateTime(ddlToHrsDay1.SelectedValue);
                    objBar.BarHoursToDay2 = Convert.ToDateTime(ddlToHrsDay2.SelectedValue);
                    objBar.BarHoursToDay3 = Convert.ToDateTime(ddlToHrsDay3.SelectedValue);
                    objBar.BarHoursToDay4 = Convert.ToDateTime(ddlToHrsDay4.SelectedValue);
                    objBar.BarHoursToDay5 = Convert.ToDateTime(ddlToHrsDay5.SelectedValue);
                    objBar.BarHoursToDay6 = Convert.ToDateTime(ddlToHrsDay6.SelectedValue);
                    objBar.BarHoursToDay7 = Convert.ToDateTime(ddlToHrsDay7.SelectedValue);
                    objBar.BarVoucherMessage = Convert.ToString(txtMsg.Text);
                    objBar.BarDetails = Convert.ToString(txtBarDetails.Text);
                    objBar.BarPhone = Convert.ToString(txtPhone.Text);
                    objBar.CE_UserID = SessionUtility.UserID;
                    objBar.LC_UserID = SessionUtility.UserID; 
                    objBar.Save();

                    

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void FillBarEdit(int intBarId)
        {
            try
            {
                DrinkBarVoucherObject.Bar objBar = new DrinkBarVoucherObject.Bar(intBarId);
                hdnBarId.Value = Convert.ToString(objBar.BarID);
                txtName.Text = Convert.ToString(objBar.BarName);
                txtStreet.Text = Convert.ToString(objBar.BarStreet);
                ddlState.SelectedValue = Convert.ToString(objBar.BarStateID);
                BindCityDropDown();
                ddlCity.SelectedValue = Convert.ToString(objBar.BarCityId);
                txtZipCode.Text = Convert.ToString(objBar.BarZipCode);
                txtCountry.Text = Convert.ToString(objBar.BarCountry);
                txtLatitude.Text = Convert.ToString(objBar.BarLatitude);
                txtLongitude.Text = Convert.ToString(objBar.BarLongitude);
                txtWebSite.Text = Convert.ToString(objBar.BarWebsite);
                txtTotalHours.Text = Convert.ToString(objBar.BarHours);
                hdnBarStatus.Value = Convert.ToString(Convert.ToInt32(objBar.BarStatus));
                txtDiscoveryRadius.Text = Convert.ToString(objBar.BarRadius);
                txtRedemptionRadius.Text = Convert.ToString(objBar.BarRedemptionRadius);
                hdnBarDay1.Value = Convert.ToString(Convert.ToInt32(objBar.BarActiveDay1));
                hdnBarDay2.Value = Convert.ToString(Convert.ToInt32(objBar.BarActiveDay2));
                hdnBarDay3.Value = Convert.ToString(Convert.ToInt32(objBar.BarActiveDay3));
                hdnBarDay4.Value = Convert.ToString(Convert.ToInt32(objBar.BarActiveDay4));
                hdnBarDay5.Value = Convert.ToString(Convert.ToInt32(objBar.BarActiveDay5));
                hdnBarDay6.Value = Convert.ToString(Convert.ToInt32(objBar.BarActiveDay6));
                hdnBarDay7.Value = Convert.ToString(Convert.ToInt32(objBar.BarActiveDay7));
                ddlFromHrsDay1.SelectedValue = Convert.ToDateTime(objBar.BarHoursFromDay1).ToString("hh:mm tt");
                ddlFromHrsDay2.SelectedValue = Convert.ToDateTime(objBar.BarHoursFromDay2).ToString("hh:mm tt");
                ddlFromHrsDay3.SelectedValue = Convert.ToDateTime(objBar.BarHoursFromDay3).ToString("hh:mm tt");
                ddlFromHrsDay4.SelectedValue = Convert.ToDateTime(objBar.BarHoursFromDay4).ToString("hh:mm tt");
                ddlFromHrsDay5.SelectedValue = Convert.ToDateTime(objBar.BarHoursFromDay5).ToString("hh:mm tt");
                ddlFromHrsDay6.SelectedValue = Convert.ToDateTime(objBar.BarHoursFromDay6).ToString("hh:mm tt");
                ddlFromHrsDay7.SelectedValue = Convert.ToDateTime(objBar.BarHoursFromDay7).ToString("hh:mm tt");
                ddlToHrsDay1.SelectedValue = Convert.ToDateTime(objBar.BarHoursToDay1).ToString("hh:mm tt");
                ddlToHrsDay2.SelectedValue = Convert.ToDateTime(objBar.BarHoursToDay2).ToString("hh:mm tt");
                ddlToHrsDay3.SelectedValue = Convert.ToDateTime(objBar.BarHoursToDay3).ToString("hh:mm tt");
                ddlToHrsDay4.SelectedValue = Convert.ToDateTime(objBar.BarHoursToDay4).ToString("hh:mm tt");
                ddlToHrsDay5.SelectedValue = Convert.ToDateTime(objBar.BarHoursToDay5).ToString("hh:mm tt");
                ddlToHrsDay6.SelectedValue = Convert.ToDateTime(objBar.BarHoursToDay6).ToString("hh:mm tt");
                ddlToHrsDay7.SelectedValue = Convert.ToDateTime(objBar.BarHoursToDay7).ToString("hh:mm tt");
                txtMsg.Text = Convert.ToString(objBar.BarVoucherMessage);
                txtBarDetails.Text = Convert.ToString(objBar.BarDetails);
                txtPhone.Text = Convert.ToString(objBar.BarPhone);
                if (!string.IsNullOrEmpty(objBar.BarImageName))
                {
                    lnkBarPhoto.Text = Convert.ToString(objBar.BarImageName);
                    lnkBarPhoto.NavigateUrl = "../DrinkBarVoucher/ImageStorage/" + Convert.ToString(objBar.BarImageName);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private string fuFileName() {
            try
            {
                string strFileName="";
                if (fudPhoto.HasFile) {
                    strFileName = fudPhoto.FileName;
                    System.Drawing.Image imgOriginal = System.Drawing.Image.FromStream(fudPhoto.PostedFile.InputStream);                   
                    string strFolderPath = Server.MapPath("ImageStorage");
                    if (!Directory.Exists(strFolderPath))
                    {
                        Directory.CreateDirectory(strFolderPath);  
                    }
                    string strFullPath = strFolderPath + "/" + strFileName;

                    if (imgOriginal != null)
                    {
                        System.Drawing.Image NewImage = imgOriginal.GetThumbnailImage(640, 300, null, IntPtr.Zero);
                       
                        NewImage.Save(strFolderPath + "/" + strFileName);
                    }
                }
                return strFileName;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            DrinkBarVoucherObject.Bar objBar = new DrinkBarVoucherObject.Bar();
            objBar.BarID = Convert.ToInt32(hdnBarId.Value);
            objBar.Delete(); 
            Response.Redirect("BarList.aspx");
        }


    }
}
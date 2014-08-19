<%@ Page Title="OntheHouse:Update Bar Details" Language="C#" MasterPageFile="~/mstDrinkVoucher.Master"
    AutoEventWireup="true" CodeBehind="AddEditBar.aspx.cs" Inherits="DrinkBarVoucher.Bar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <link href="Styles/PagesContents.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/js_UI_min.js" type="text/javascript"></script>
    <script src="Scripts/json2.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {

            if (parseInt($("#cpMaster_hdnBarId").val()) > 0) {
                FillDaysEdit();
            }
            else {
                $("#btnInactive").removeClass();
                $("#btnInactive").addClass('btnActive');
                InactiveAllDays();
                $(".btnDay").attr("disabled", "disabled");
                $("[id*='ddlFromHrsDay']").attr("disabled", "disabled");
                $("[id*='ddlToHrsDay']").attr("disabled", "disabled");
            }

            if ($.trim($("#cpMaster_lnkBarPhoto").text()) == "") {
                $("#divImgUploader").show();
                $("#divImgViewer").hide();
            }
            else {
                $("#divImgUploader").hide();
                $("#divImgViewer").show();
            }



            $("#btnActive").click(function () {
                $(this).addClass('btnActive');
                $("#btnInactive").removeClass();
                $("#btnInactive").addClass('btnInactive');
                $("#cpMaster_hdnBarStatus").val(1);
                $(".btnDay").removeAttr("disabled");
                $("[id*='ddlFromHrsDay']").removeAttr("disabled");
                $("[id*='ddlToHrsDay']").removeAttr("disabled");
                ActiveAllDays();
            });

            $("#btnInactive").click(function () {
                $(this).addClass('btnActive');
                $("#btnActive").removeClass();
                $("#btnActive").addClass('btnInactive');
                $("#cpMaster_hdnBarStatus").val(0);
                InactiveAllDays();
                $(".btnDay").attr("disabled", "disabled");
                $("[id*='ddlFromHrsDay']").attr("disabled", "disabled");
                $("[id*='ddlToHrsDay']").attr("disabled", "disabled");
            });

            $("#btnDay1").click(function () {
                if ($(this).attr("class") == "btnDayActive") {
                    $(this).removeClass();
                    $(this).addClass("btnDay");
                    $("#cpMaster_hdnBarDay1").val(0);
                    $("[id*='ddlFromHrsDay1']").attr("disabled", "disabled");
                    $("[id*='ddlToHrsDay1']").attr("disabled", "disabled");
                }
                else if ($(this).attr("class") == "btnDay") {
                    $(this).removeClass();
                    $(this).addClass("btnDayActive");
                    $("#cpMaster_hdnBarDay1").val(1);
                    $("[id*='ddlFromHrsDay1']").removeAttr("disabled");
                    $("[id*='ddlToHrsDay1']").removeAttr("disabled");
                }
            });
            $("#btnDay2").click(function () {
                if ($(this).attr("class") == "btnDayActive") {
                    $(this).removeClass();
                    $(this).addClass("btnDay");
                    $("#cpMaster_hdnBarDay2").val(0);
                    $("[id*='ddlFromHrsDay2']").attr("disabled", "disabled");
                    $("[id*='ddlToHrsDay2']").attr("disabled", "disabled");
                }
                else if ($(this).attr("class") == "btnDay") {
                    $(this).removeClass();
                    $(this).addClass("btnDayActive");
                    $("#cpMaster_hdnBarDay2").val(1);
                    $("[id*='ddlFromHrsDay2']").removeAttr("disabled");
                    $("[id*='ddlToHrsDay2']").removeAttr("disabled");
                }
            });
            $("#btnDay3").click(function () {
                if ($(this).attr("class") == "btnDayActive") {
                    $(this).removeClass();
                    $(this).addClass("btnDay");
                    $("#cpMaster_hdnBarDay3").val(0);
                    $("[id*='ddlFromHrsDay3']").attr("disabled", "disabled");
                    $("[id*='ddlToHrsDay3']").attr("disabled", "disabled");
                }
                else if ($(this).attr("class") == "btnDay") {
                    $(this).removeClass();
                    $(this).addClass("btnDayActive");
                    $("#cpMaster_hdnBarDay3").val(1);
                    $("[id*='ddlFromHrsDay3']").removeAttr("disabled");
                    $("[id*='ddlToHrsDay3']").removeAttr("disabled");
                }
            });

            $("#btnDay4").click(function () {
                if ($(this).attr("class") == "btnDayActive") {
                    $(this).removeClass();
                    $(this).addClass("btnDay");
                    $("#cpMaster_hdnBarDay4").val(0);
                    $("[id*='ddlFromHrsDay4']").attr("disabled", "disabled");
                    $("[id*='ddlToHrsDay4']").attr("disabled", "disabled");
                }
                else if ($(this).attr("class") == "btnDay") {
                    $(this).removeClass();
                    $(this).addClass("btnDayActive");
                    $("#cpMaster_hdnBarDay4").val(1);
                    $("[id*='ddlFromHrsDay4']").removeAttr("disabled");
                    $("[id*='ddlToHrsDay4']").removeAttr("disabled");
                }
            });

            $("#btnDay5").click(function () {
                if ($(this).attr("class") == "btnDayActive") {
                    $(this).removeClass();
                    $(this).addClass("btnDay");
                    $("#cpMaster_hdnBarDay5").val(0);
                    $("[id*='ddlFromHrsDay5']").attr("disabled", "disabled");
                    $("[id*='ddlToHrsDay5']").attr("disabled", "disabled");
                }
                else if ($(this).attr("class") == "btnDay") {
                    $(this).removeClass();
                    $(this).addClass("btnDayActive");
                    $("#cpMaster_hdnBarDay5").val(1);
                    $("[id*='ddlFromHrsDay5']").removeAttr("disabled");
                    $("[id*='ddlToHrsDay5']").removeAttr("disabled");
                }
            });

            $("#btnDay6").click(function () {
                if ($(this).attr("class") == "btnDayActive") {
                    $(this).removeClass();
                    $(this).addClass("btnDay");
                    $("#cpMaster_hdnBarDay6").val(0);
                    $("[id*='ddlFromHrsDay6']").attr("disabled", "disabled");
                    $("[id*='ddlToHrsDay6']").attr("disabled", "disabled");
                }
                else if ($(this).attr("class") == "btnDay") {
                    $(this).removeClass();
                    $(this).addClass("btnDayActive");
                    $("#cpMaster_hdnBarDay6").val(1);
                    $("[id*='ddlFromHrsDay6']").removeAttr("disabled");
                    $("[id*='ddlToHrsDay6']").removeAttr("disabled");
                }
            });

            $("#btnDay7").click(function () {
                if ($(this).attr("class") == "btnDayActive") {
                    $(this).removeClass();
                    $(this).addClass("btnDay");
                    $("#cpMaster_hdnBarDay7").val(0);
                    $("[id*='ddlFromHrsDay7']").attr("disabled", "disabled");
                    $("[id*='ddlToHrsDay7']").attr("disabled", "disabled");
                }
                else if ($(this).attr("class") == "btnDay") {
                    $(this).removeClass();
                    $(this).addClass("btnDayActive");
                    $("#cpMaster_hdnBarDay7").val(1);
                    $("[id*='ddlFromHrsDay7']").removeAttr("disabled");
                    $("[id*='ddlToHrsDay7']").removeAttr("disabled");
                }
            });

            $("#aChangePhoto").click(function () {
                $("#divImgUploader").show();
                $("#divImgViewer").hide();
            });

            $("#cpMaster_btnDelete").click(function () {

                if (parseInt($("#cpMaster_hdnBarId").val()) > 0) {
                    if (confirm("Are you sure want to delete ?")) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }

            });
            function InactiveAllDays() {
                $("#btnDay1").removeClass();
                $("#btnDay1").addClass("btnDay");
                $("#cpMaster_hdnBarDay1").val(0);

                $("#btnDay2").removeClass();
                $("#btnDay2").addClass("btnDay");
                $("#cpMaster_hdnBarDay2").val(0);

                $("#btnDay3").removeClass();
                $("#btnDay3").addClass("btnDay");
                $("#cpMaster_hdnBarDay3").val(0);

                $("#btnDay4").removeClass();
                $("#btnDay4").addClass("btnDay");
                $("#cpMaster_hdnBarDay4").val(0);

                $("#btnDay5").removeClass();
                $("#btnDay5").addClass("btnDay");
                $("#cpMaster_hdnBarDay5").val(0);

                $("#btnDay6").removeClass();
                $("#btnDay6").addClass("btnDay");
                $("#cpMaster_hdnBarDay6").val(0);

                $("#btnDay7").removeClass();
                $("#btnDay7").addClass("btnDay");
                $("#cpMaster_hdnBarDay7").val(0);
            }

            function ActiveAllDays() {
                $("#btnDay1").removeClass();
                $("#btnDay1").addClass("btnDayActive");
                $("#cpMaster_hdnBarDay1").val(1);

                $("#btnDay2").removeClass();
                $("#btnDay2").addClass("btnDayActive");
                $("#cpMaster_hdnBarDay2").val(1);

                $("#btnDay3").removeClass();
                $("#btnDay3").addClass("btnDayActive");
                $("#cpMaster_hdnBarDay3").val(1);

                $("#btnDay4").removeClass();
                $("#btnDay4").addClass("btnDayActive");
                $("#cpMaster_hdnBarDay4").val(1);

                $("#btnDay5").removeClass();
                $("#btnDay5").addClass("btnDayActive");
                $("#cpMaster_hdnBarDay5").val(1);

                $("#btnDay6").removeClass();
                $("#btnDay6").addClass("btnDayActive");
                $("#cpMaster_hdnBarDay6").val(1);

                $("#btnDay7").removeClass();
                $("#btnDay7").addClass("btnDayActive");
                $("#cpMaster_hdnBarDay7").val(1);
            }

            function FillDaysEdit() {
                if ($("#cpMaster_hdnBarStatus").val() == "0") {
                    $("#btnInactive").removeClass();
                    $("#btnInactive").addClass('btnActive');
                    InactiveAllDays();
                    $(".btnDay").attr("disabled", "disabled");
                    $("[id*='ddlFromHrsDay']").attr("disabled", "disabled");
                    $("[id*='ddlToHrsDay']").attr("disabled", "disabled");
                }
                if ($("#cpMaster_hdnBarStatus").val() == "1") {
                    $("#btnActive").removeClass();
                    $("#btnActive").addClass('btnActive');
                    if ($("#cpMaster_hdnBarDay1").val() == "1") {
                        $("#btnDay1").removeClass();
                        $("#btnDay1").addClass("btnDayActive");
                        $("[id*='ddlFromHrsDay1']").removeAttr("disabled");
                        $("[id*='ddlToHrsDay1']").removeAttr("disabled");
                    }
                    else {
                        $("#btnDay1").removeClass();
                        $("#btnDay1").addClass("btnDay");
                        $("[id*='ddlFromHrsDay1']").attr("disabled", "disabled");
                        $("[id*='ddlToHrsDay1']").attr("disabled", "disabled");
                    }

                    if ($("#cpMaster_hdnBarDay2").val() == "1") {
                        $("#btnDay2").removeClass();
                        $("#btnDay2").addClass("btnDayActive");
                        $("[id*='ddlFromHrsDay2']").removeAttr("disabled");
                        $("[id*='ddlToHrsDay2']").removeAttr("disabled");
                    }
                    else {
                        $("#btnDay2").removeClass();
                        $("#btnDay2").addClass("btnDay");
                        $("[id*='ddlFromHrsDay2']").attr("disabled", "disabled");
                        $("[id*='ddlToHrsDay2']").attr("disabled", "disabled");
                    }

                    if ($("#cpMaster_hdnBarDay3").val() == "1") {
                        $("#btnDay3").removeClass();
                        $("#btnDay3").addClass("btnDayActive");
                        $("[id*='ddlFromHrsDay3']").removeAttr("disabled");
                        $("[id*='ddlToHrsDay3']").removeAttr("disabled");
                    }
                    else {
                        $("#btnDay3").removeClass();
                        $("#btnDay3").addClass("btnDay");
                        $("[id*='ddlFromHrsDay3']").attr("disabled", "disabled");
                        $("[id*='ddlToHrsDay3']").attr("disabled", "disabled");
                    }

                    if ($("#cpMaster_hdnBarDay4").val() == "1") {
                        $("#btnDay4").removeClass();
                        $("#btnDay4").addClass("btnDayActive");
                        $("[id*='ddlFromHrsDay4']").removeAttr("disabled");
                        $("[id*='ddlToHrsDay4']").removeAttr("disabled");
                    }
                    else {
                        $("#btnDay4").removeClass();
                        $("#btnDay4").addClass("btnDay");
                        $("[id*='ddlFromHrsDay4']").attr("disabled", "disabled");
                        $("[id*='ddlToHrsDay4']").attr("disabled", "disabled");
                    }
                    if ($("#cpMaster_hdnBarDay5").val() == "1") {
                        $("#btnDay5").removeClass();
                        $("#btnDay5").addClass("btnDayActive");
                        $("[id*='ddlFromHrsDay5']").removeAttr("disabled");
                        $("[id*='ddlToHrsDay5']").removeAttr("disabled");
                        
                    }
                    else {
                        $("#btnDay5").removeClass();
                        $("#btnDay5").addClass("btnDay");
                        $("[id*='ddlFromHrsDay5']").attr("disabled", "disabled");
                        $("[id*='ddlToHrsDay5']").attr("disabled", "disabled");
                    }
                    if ($("#cpMaster_hdnBarDay6").val() == "1") {
                        $("#btnDay6").removeClass();
                        $("#btnDay6").addClass("btnDayActive");
                        $("[id*='ddlFromHrsDay6']").removeAttr("disabled");
                        $("[id*='ddlToHrsDay6']").removeAttr("disabled");
                    }
                    else {
                        $("#btnDay6").removeClass();
                        $("#btnDay6").addClass("btnDay");
                        $("[id*='ddlFromHrsDay6']").attr("disabled", "disabled");
                        $("[id*='ddlToHrsDay6']").attr("disabled", "disabled");
                    }
                    if ($("#cpMaster_hdnBarDay7").val() == "1") {
                        $("#btnDay7").removeClass();
                        $("#btnDay7").addClass("btnDayActive");
                        $("[id*='ddlFromHrsDay7']").removeAttr("disabled");
                        $("[id*='ddlToHrsDay7']").removeAttr("disabled");
                    }
                    else {
                        $("#btnDay7").removeClass();
                        $("#btnDay7").addClass("btnDay");
                        $("[id*='ddlFromHrsDay7']").attr("disabled", "disabled");
                        $("[id*='ddlToHrsDay7']").attr("disabled", "disabled");
                    }
                }
            }

            $("#cpMaster_lnkBarPhoto").click(function () {
                window.open($(this).attr("href"), "Name", 'height=300,width=600,top:100,left:200');
                return false;
            });
        });

        function CheckForTestFile() {

            var file = document.getElementById('<%=fudPhoto.ClientID%>');

            var fileName = file.value;

            //Checking for file browsed or not 
            if ($.trim(fileName) == '') {
                alert("Please select PNG or JPG image for to upload!!!");
                file.focus();
                return false;
            }

            //Setting the extension array for diff. type of text files 
            var extArray = new Array(".png", ".PNG", ".jpg", ".JPG", ".jpeg", ".JPEG");

            //getting the file name
            while (fileName.indexOf("\\") != -1)
                fileName = fileName.slice(fileName.indexOf("\\") + 1);

            //Getting the file extension                     
            var ext = fileName.slice(fileName.indexOf(".")).toLowerCase();

            //matching extension with our given extensions.
            for (var i = 0; i < extArray.length; i++) {
                if (extArray[i] == ext) {

                    return true;
                }
            }
            alert("Please select only :  " + (extArray.join("  ")) + "  file type \n Please select a new image and submit again.");
            file.focus();
            file.value = "";
            return false;
        }


        function checkLength(txtbox, maxlength) {

            var txtboxLength;
            var txtbox_value = $(txtbox).val();
            txtboxLength = txtbox_value.replace(/\n|\r/ig, '  ').length;          
            
            if (txtboxLength >= maxlength) {
              
                return false;
                //var txtbox_value = $(txtbox).val();
                //$(txtbox).val(txtbox.value.slice(0, maxlength));
              
            }


        }


        function checkLengthOnBlur(txtbox, maxlength) {

            var txtboxLength;
            var txtbox_value = $(txtbox).val();
            txtboxLength = txtbox_value.replace(/\n|\r/ig, '  ').length;

            if (txtboxLength >= maxlength) {                
                //var txtbox_value = $(txtbox).val();
                $(txtbox).val(txtbox.value.slice(0, maxlength));
                
            }
        }


        function isNumberKey(ctl, len, evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode

            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                evt.cancelBubble = true;
                return false;
            }

            if (ctl != null) {
                len = len - 1;
                if (ctl.value.length > len && charCode != 8)
                { return false; }
            }

            return true;
        }

    </script>
    <style type="text/css">
        #aChangePhoto:hover
        {
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMaster" runat="server">
    <div id="dvMain">
        <div class="dvHeader" align="right">
            <table style="padding-right: 20px;" cellpadding="5">
                <tr>
                    <td style="padding-top: 2px; font-weight: bold" valign="middle">
                        <input type="button" value="" name="btnDay1" id="Button1" class="btnDayActive" />
                        &nbsp; Active
                    </td>
                    <td style="padding-top: 2px; font-weight: bold" valign="middle">
                        <input type="button" value="" name="btnDay1" id="Button2" class="btnDay" />
                        &nbsp; Inactive
                    </td>
                </tr>
            </table>
        </div>
        <div class="dvAction" style="clear: both;">
            <table cellpadding="3" cellspacing="3" width="100%">
                <tr>
                    <td height="80px" valign="middle" style="font-size: 45px; padding-left: 20px;">
                        Add/Edit Bars
                    </td>
                    <td style="padding-right: 20px;" valign="middle" height="80px" align="right">
                        <asp:Button ID="btnDelete" runat="server" Text="Delete Bar" OnClick="btnDelete_Click"
                            CssClass="btnSubmit" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                            CssClass="btnSubmit" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="vgSave"
                            CssClass="btnSubmit" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="dvAddress" style="width: 45%; float: left; margin-bottom: 50px; margin-top: 20px;">
            <table width="100%" cellpadding="3" cellspacing="3">
                <tr>
                    <td colspan="2" valign="top" class="tdfontBold" align="left">
                        Address
                    </td>
                </tr>
                <tr>
                    <td width="80px" class="tdPadd35" align="left">
                        <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtName" runat="server" CssClass="txtLargest" MaxLength="50">
                        
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqfldName" runat="server" ErrorMessage="*" ControlToValidate="txtName"
                            Display="Dynamic" ForeColor="#800000" ValidationGroup="vgSave"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblStreet" runat="server" Text="Street"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtStreet" runat="server" CssClass="txtLargest" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfStreet" runat="server" ErrorMessage="*" ControlToValidate="txtStreet"
                            Display="Dynamic" ForeColor="#800000" ValidationGroup="vgSave"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblState" runat="server" Text="State"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlState" runat="server" CssClass="ddlWidth" OnSelectedIndexChanged="ddlState_SelectedIndexChanged"
                            AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblCity" runat="server" Text="City"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlCity" runat="server" CssClass="ddlWidth" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblZipCode" runat="server" Text="Zip Code"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtZipCode" runat="server" CssClass="txtLargest" MaxLength="10">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfZipcode" runat="server" ErrorMessage="*" ControlToValidate="txtZipCode"
                            Display="Dynamic" ForeColor="#800000" ValidationGroup="vgSave"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblCountry" runat="server" Text="Country"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtCountry" runat="server" Text="United States" Enabled="false"
                            CssClass="txtLargest"></asp:TextBox>
                    </td>
                </tr>
                <tr> 
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblPhone" runat="server" Text="Phone"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtPhone" runat="server" Text="" CssClass="txtLargest" MaxLength="16"></asp:TextBox>
                        <asp:RequiredFieldValidator ErrorMessage="*" ControlToValidate="txtPhone" runat="server"
                            Display="Dynamic" ForeColor="#800000" ValidationGroup="vgSave" ID="rfvtxtPhone" />
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblLatitude" runat="server" Text="Latitude"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtLatitude" runat="server" CssClass="txtLargest"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfLatitude" runat="server" ErrorMessage="*" ControlToValidate="txtLatitude"
                            Display="Dynamic" ForeColor="#800000" ValidationGroup="vgSave"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="regtxtLatitude" ErrorMessage="Invalid Latitude Value"
                            ControlToValidate="txtLatitude" ValidationGroup="vgSave" ValidationExpression="^[-+]?[0-9]*\.?[0-9]*([eE][-+]?[0-9]+)?$"
                            runat="server" ForeColor="#800000" Display="Dynamic" />
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblLongitude" runat="server" Text="Longitude"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtLongitude" runat="server" CssClass="txtLargest"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfLongitude" runat="server" ErrorMessage="*" ControlToValidate="txtLongitude"
                            Display="Dynamic" ForeColor="#800000" ValidationGroup="vgSave"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegtxtLongitude" ErrorMessage="Invalid Longitude Value"
                            ControlToValidate="txtLongitude" ValidationGroup="vgSave" ValidationExpression="^[-+]?[0-9]*\.?[0-9]*([eE][-+]?[0-9]+)?$"
                            runat="server" ForeColor="#800000" Display="Dynamic" />
                    </td>
                </tr>
            </table>
            <table width="100%" cellpadding="3" cellspacing="3">
                <tr>
                    <td colspan="2" valign="top" class="tdfontBold" align="left">
                        Bar Info
                    </td>
                </tr>
                <tr>
                    <td width="100px" class="tdPadd35" align="left">
                        <asp:Label ID="lblWebsite" runat="server" Text="WebSite"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtWebSite" runat="server" CssClass="txtLargest" MaxLength="100"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfWebsite" runat="server" ErrorMessage="*" ControlToValidate="txtWebSite"
                            Display="Dynamic" ForeColor="#800000" ValidationGroup="vgSave"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rgeWebiste" runat="server" ErrorMessage="Invalid Website"
                            ValidationGroup="vgSave" ControlToValidate="txtWebSite" Enabled="True" ValidationExpression="((http|https)://|)([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?"
                            ForeColor="#800000"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblPhoto" runat="server" Text="Photo"></asp:Label>
                    </td>
                    <td style="padding-left: 5px;" align="left">
                        <div id="divImgUploader" style="height: 35px;">
                            <asp:FileUpload ID="fudPhoto" runat="server" CssClass="txtLargest" OnChange="CheckForTestFile();">
                            </asp:FileUpload><br />
                            <i>
                                <label style="font-size: 8pt; color: Gray;" id="lblImgSizeMsg">
                                    Required image size: 640 × 300 pixels</label></i>
                        </div>
                        <div id="divImgViewer" style="height: 25px; padding-top: 10px;">
                            <asp:HyperLink ID="lnkBarPhoto" runat="server" Target="_blank"></asp:HyperLink>
                            &nbsp; <a id="aChangePhoto">Change Photo</a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblTotalHours" runat="server" Text="Hours"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtTotalHours" runat="server" CssClass="txtLargest" MaxLength="30"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblBarDetails" runat="server" Text="Description"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtBarDetails" runat="server" CssClass="txtLargest" MaxLength="2000" TextMode="MultiLine" OnkeyPress="return checkLength(this,2000);" onblur="checkLengthOnBlur(this,2000);"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div id="dvVoucherSetting" style="width: 54%; float: left; margin-bottom: 50px; margin-top: 20px;">
            
            <table width="100%" cellpadding="3" cellspacing="3" style="margin-top: 15px;">
                <tr>
                    <td colspan="2" valign="top" class="tdfontBold" align="left">
                        Voucher Settings
                    </td>
                </tr>
                <tr>
                    <td width="155px" class="tdPadd35" align="left">
                        <asp:Label ID="lblStatus" runat="server" Text="Status"></asp:Label>
                    </td>
                    <td style="padding-left: 8px;" align="left">
                        <input type="button" value="Active" name="btnActive" id="btnActive" class="btnInactive" />
                        <input type="button" value="Inactive" name="btnInActive" id="btnInactive" class="btnInactive"
                            style="border-collapse: collapse;" />
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left">
                        <asp:Label ID="lblActiveDays" runat="server" Text="Active Days"></asp:Label>
                    </td>
                    <td    align="left" style="padding-left:100px;font-weight: bold;">
                         <asp:Label ID="lblHours" runat="server" Text="Hours"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table border="0" cellpadding="0" cellspacing="0">
                                 <tr>
                                    <td class="tdPadd35" align="left" width="155px">
                                        <input type="button" value="Su" name="btnDay1" id="btnDay1" class="btnDayActive" />
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlFromHrsDay1" runat="server" CssClass="txtSmall" style="margin:0px;" > 
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp; to &nbsp;
                                        <asp:DropDownList ID="ddlToHrsDay1" runat="server" CssClass="txtSmall" style="margin:0px;">
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM"  Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td class="tdPadd35" align="left">
                                        <input type="button" value="Mo" name="btnDay2" id="btnDay2" class="btnDayActive"
                                            style="border-collapse: collapse;" />
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlFromHrsDay2" runat="server" CssClass="txtSmall" style="margin:0px;"> 
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp; to &nbsp;
                                        <asp:DropDownList ID="ddlToHrsDay2" runat="server" CssClass="txtSmall" style="margin:0px;">
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM"  Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td class="tdPadd35" align="left">
                                       <input type="button" value="Tu" name="btnDay3" id="btnDay3" class="btnDayActive"
                                            style="border-collapse: collapse;" />
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlFromHrsDay3" runat="server" CssClass="txtSmall" style="margin:0px;"> 
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp; to &nbsp;
                                        <asp:DropDownList ID="ddlToHrsDay3" runat="server" CssClass="txtSmall" style="margin:0px;">
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM"  Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td class="tdPadd35" align="left">
                                         <input type="button" value="We" name="btnDay4" id="btnDay4" class="btnDayActive"
                                            style="border-collapse: collapse;margin:0px;" />
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlFromHrsDay4" runat="server" CssClass="txtSmall" style="margin:0px;"> 
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp; to &nbsp;
                                        <asp:DropDownList ID="ddlToHrsDay4" runat="server" CssClass="txtSmall" style="margin:0px;">
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM" Selected="True" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td class="tdPadd35" align="left">
                                        <input type="button" value="Th" name="btnDay5" id="btnDay5" class="btnDayActive"
                                            style="border-collapse: collapse;" />
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlFromHrsDay5" runat="server" CssClass="txtSmall" style="margin:0px;"> 
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp; to &nbsp;
                                        <asp:DropDownList ID="ddlToHrsDay5" runat="server" CssClass="txtSmall" style="margin:0px;">
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM"  Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td class="tdPadd35" align="left">
                                        <input type="button" value="Fr" name="btnDay6" id="btnDay6" class="btnDayActive"
                                            style="border-collapse: collapse;" />
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlFromHrsDay6" runat="server" CssClass="txtSmall" style="margin:0px;"> 
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp; to &nbsp;
                                        <asp:DropDownList ID="ddlToHrsDay6" runat="server" CssClass="txtSmall" style="margin:0px;">
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM"  Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td class="tdPadd35" align="left">
                                    <input type="button" value="Sa" name="btnDay7" id="btnDay7" class="btnDayActive"
                                            style="border-collapse: collapse;" />
                       
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlFromHrsDay7" runat="server" CssClass="txtSmall" style="margin:0px;"> 
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" Selected="True" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp; to &nbsp;
                                        <asp:DropDownList ID="ddlToHrsDay7" runat="server" CssClass="txtSmall" style="margin:0px;">
                                            <asp:ListItem Text="12:00 AM" Value="12:00 AM"></asp:ListItem>
                                            <asp:ListItem Text="12:30 AM" Value="12:30 AM"></asp:ListItem>
                                            <asp:ListItem Text="01:00 AM"  Value="01:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 AM"  Value="01:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 AM"  Value="02:00 AM"  Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="02:30 AM"  Value="02:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 AM" Value="03:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 AM" Value="03:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 AM" Value="04:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 AM"  Value="04:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 AM"  Value="05:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 AM"  Value="05:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 AM"  Value="06:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 AM"  Value="06:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 AM"  Value="07:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 AM"  Value="07:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 AM"  Value="08:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 AM"  Value="08:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 AM"  Value="09:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 AM"  Value="09:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 AM"  Value="10:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 AM"  Value="10:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 AM"  Value="11:00 AM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 AM"  Value="11:30 AM" ></asp:ListItem>
                                            <asp:ListItem Text="12:00 PM"  Value="12:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="12:30 PM"  Value="12:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:00 PM" Value="01:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="01:30 PM" Value="01:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:00 PM" Value="02:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="02:30 PM" Value="02:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:00 PM" Value="03:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="03:30 PM" Value="03:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:00 PM" Value="04:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="04:30 PM" Value="04:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:00 PM" Value="05:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="05:30 PM" Value="05:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:00 PM" Value="06:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="06:30 PM" Value="06:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:00 PM" Value="07:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="07:30 PM" Value="07:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:00 PM" Value="08:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="08:30 PM" Value="08:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:00 PM" Value="09:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="09:30 PM" Value="09:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:00 PM" Value="10:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="10:30 PM" Value="10:30 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:00 PM" Value="11:00 PM" ></asp:ListItem>
                                            <asp:ListItem Text="11:30 PM" Value="11:30 PM" ></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                           </table>
                    
                    </td>
                
                </tr>
                <tr>
                    <td class="tdPadd35" align="left" valign="top" style="padding-top:15px;">
                        <asp:Label ID="lblDiscoveryRadius" runat="server" Text="Discovery Radius"></asp:Label>
                    </td>
                    <td align="left" >
                        <asp:TextBox ID="txtDiscoveryRadius" runat="server" CssClass="txtLargest" MaxLength="15" onkeypress="return isNumberKey(this,8,event)"
                            Text="1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfDiscoveryRadius" runat="server" ErrorMessage="*"
                            ControlToValidate="txtDiscoveryRadius" Display="Dynamic" ForeColor="#800000"
                            ValidationGroup="vgSave"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rngValDiscoveryRadius" runat="server" ErrorMessage="Discovery Radius should numeric value greater than 1"
                            ValidationGroup="vgSave" MinimumValue="1" SetFocusOnError="True" MaximumValue="1000000000"
                            Type="Integer" ControlToValidate="txtDiscoveryRadius" ForeColor="#800000"></asp:RangeValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left" valign="top" style="padding-top:15px;">
                        <asp:Label ID="lblRedemptionRadius" runat="server" Text="Redemption Radius"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtRedemptionRadius" runat="server" CssClass="txtLargest" MaxLength="15" onkeypress="return isNumberKey(this,8,event)"
                            Text="1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfRedemptionRadius" runat="server" ErrorMessage="*"
                            ControlToValidate="txtRedemptionRadius" Display="Dynamic" ForeColor="#800000" 
                            ValidationGroup="vgSave"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rngValRedemptionRadius" runat="server" ErrorMessage="Redemption Radius should numeric value greater than 1"
                            ValidationGroup="vgSave" MinimumValue="1" SetFocusOnError="True" MaximumValue="100000000"
                            Type="Integer" ControlToValidate="txtRedemptionRadius" ForeColor="#800000"></asp:RangeValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tdPadd35" align="left" valign="top" style="padding-top:15px;">
                        <asp:Label ID="lblMsg" runat="server" Text="Message"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtMsg" runat="server" CssClass="txtLargest" TextMode="MultiLine"
                            OnkeyPress="return checkLength(this,250);"  onblur="checkLengthOnBlur(this,250);"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfMsg" runat="server" ErrorMessage="*" ControlToValidate="txtMsg"
                            Display="Dynamic" ForeColor="#800000" ValidationGroup="vgSave"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="dvHiddenFields" style="display: none">
        <asp:HiddenField ID="hdnBarId" runat="server" Value="0" />
        <asp:HiddenField ID="hdnBarStatus" runat="server" Value="1" />
        <asp:HiddenField ID="hdnBarDay1" runat="server" Value="1" />
        <asp:HiddenField ID="hdnBarDay2" runat="server" Value="1" />
        <asp:HiddenField ID="hdnBarDay3" runat="server" Value="1" />
        <asp:HiddenField ID="hdnBarDay4" runat="server" Value="1" />
        <asp:HiddenField ID="hdnBarDay5" runat="server" Value="1" />
        <asp:HiddenField ID="hdnBarDay6" runat="server" Value="1" />
        <asp:HiddenField ID="hdnBarDay7" runat="server" Value="1" />
    </div>
</asp:Content>

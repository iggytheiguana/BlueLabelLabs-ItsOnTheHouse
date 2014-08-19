<%@ Page Title="OntheHouse:User Details List" Language="C#" MasterPageFile="~/mstDrinkVoucher.Master"
    AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="DrinkBarVoucher.UserList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/PagesContents.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-min.js" type="text/javascript"></script>
    <script src="Scripts/jsArrayIndexOf.js" type="text/javascript"></script>
    <script src="Scripts/jquery.watermark.js" type="text/javascript"></script>
    <style type="text/css">
        .dvHead
        {
            float: right;
            width: 100%;
            border-bottom: 1px solid #800000;
        }
        
        .searchLabel
        {
            font-family: Arial,Microsoft Sans Serif,Verdana;
            font-size: 12pt;
            font-weight: normal;
        }
        
        .tdHide
        {
            display: none;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {

            onbodyload();



            if ($("input:checkbox[id*='chkUserSelect']:checked").length == 0) {
                $("[id*='btnExportAll']").val("export all (csv)");
            }
            else if ($("input:checkbox[id*='chkUserSelect']:checked").length == $("input:checkbox[id*='chkUserSelect']").length) {
              //  $("[id*='btnExportAll']").val("export all (csv)");
            }
            else {
                $("[id*='btnExportAll']").val("export selected (csv)");
            }

        });

        function checkall(checkselectall) {
            if (checkselectall.checked) {
                $("input:checkbox[id*='chkUserSelect']").prop("checked", "checked");
                $("[id*='btnExportAll']").val("export all (csv)");
            }
            else {
                $("[id*='btnExportAll']").val("export all (csv)");
                $("input:checkbox[id*='chkUserSelect']").removeProp("checked");
            }
        }

        function check(checkselect) {
            if ($("input:checkbox[id*='chkUserSelect']:checked").length == 0) {
                $("input:checkbox[id*='chkUsersSelectAll']").removeProp("checked");
                $("[id*='btnExportAll']").val("export all (csv)");
            }
            else if ($("input:checkbox[id*='chkUserSelect']:checked").length == $("input:checkbox[id*='chkUserSelect']").length) {
                //$("[id*='btnExportAll']").val("export all (csv)");
               // $("input:checkbox[id*='chkUsersSelectAll']").prop("checked", "checked");
            }
            else {
                $("[id*='btnExportAll']").val("export selected (csv)");
                $("input:checkbox[id*='chkUsersSelectAll']").removeProp("checked");
            }
        }


        function checkDeleteUser() {

            var arryUserId = new Array();
            $("input:checkbox[id*='chkUserSelect']").each(function () {
                var txtUserId = $(this).closest('tr').find('td:last').find('input').val();
                if ($.trim($(this).is(":checked")).toLocaleUpperCase() == "TRUE") {
                    arryUserId.push(txtUserId);
                }
            });
            $("#cpMaster_hdnUserIdChecked").val(arryUserId);

            if ($("#cpMaster_hdnUserIdChecked").val() == "") {
                alert("Please select atleast one user");
                return false;
            }
            else {
                if (confirm('Are you sure you want to delete user(s)?')) {
                    return true;
                }
                else {
                    $("#cpMaster_hdnUserIdChecked").val("");
                    return false;
                }
            }
        }

        function checkSelectedUser() {

            var arryUserId = new Array();
            if ($("input:checkbox[id*='chkUsersSelectAll']:checked").length == 0) {


                if ($("input:checkbox[id*='chkUserSelect']:checked").length == 0) {

                    //                $("input:checkbox[id*='chkUserSelect']").each(function () {
                    //                    var txtUserId = $(this).closest('tr').find('td:last').find('input').val();
                    //                    arryUserId.push(txtUserId);

                    //                });
                    $("#cpMaster_hdnUserIdChecked").val("");
                    return true;
                }
                else {

                    $("input:checkbox[id*='chkUserSelect']").each(function () {
                        var txtUserId = $(this).closest('tr').find('td:last').find('input').val();
                        if ($.trim($(this).is(":checked")).toLocaleUpperCase() == "TRUE") {
                            arryUserId.push(txtUserId);

                        }

                    });
                    $("#cpMaster_hdnUserIdChecked").val(arryUserId);
                    return true;
                }
            }
            else {
                $("#cpMaster_hdnUserIdChecked").val("");
                return true;
            
            }

        }

        

        function calDateFrom_SelectionChange() {
            // $("#cpMaster_btnCalFrom").click();            
            __doPostBack('ctl00$cpMaster$btnCalFrom', '');
        }

        function calDateTo_SelectionChange() {

            __doPostBack('ctl00$cpMaster$btnCalTo', '');
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMaster" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div id="dvMain">        
                <div class="dvHead" align="right">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td style="width: 100%; height: 43px;" align="right">
                                <asp:TextBox ID="txtSearch" runat="server" Width="250px" AutoPostBack="true" ToolTip="search by user name"
                                    OnTextChanged="txtSearch_TextChanged" onfocus="txtOnFocus(this,'txt');" onblur="txtOnLeave(this,'txt');"
                                    CssClass="txt" Style="margin: 0px 5px;"></asp:TextBox>
                                <asp:Button runat="server" ID="btnFilter" Text="Filter" Style="margin-right: 20px;
                                    margin-top: 0px;" OnClick="btnFilter_Clicked" CssClass="btnSubmit" AutoPostBack="true" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div align="left" id="searchDiv" runat="server" visible="false" style="padding-bottom: 15px;
                                    background: #F0F0F0; border-top: 1px solid #800000">
                                    <table cellpadding="3" cellspacing="3" width="100%">
                                        <tr>
                                            <td class="tdPadd35" width="100px">
                                                <asp:Label Text="Sex" runat="server" ID="lblSex" CssClass="searchLabel"></asp:Label>
                                            </td>
                                            <td colspan="4">
                                                <asp:RadioButtonList runat="server" ID="rdbSex" RepeatDirection="Horizontal" AutoPostBack="true"
                                                    OnSelectedIndexChanged="rdbSex_OnSelectedIndexChanged" Width="150px" Style="float: left;">
                                                </asp:RadioButtonList>
                                                <asp:Button ID="btnClearRdb" runat="server" OnClick="btnClearRdb_Clicked" AutoPostBack="true"
                                                    Text="X" CssClass="btnClose" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdPadd35">
                                                <asp:Label Text="Age" runat="server" ID="lblAge" CssClass="searchLabel"></asp:Label>
                                            </td>
                                            <td width="140px">
                                                <asp:DropDownList runat="server" ID="ddlAgeFrom" OnSelectedIndexChanged="ddlAgeFrom_OnSelectedIndexChanged"
                                                    AutoPostBack="true" Style="width: 80px; margin-left: 5px;">
                                                </asp:DropDownList>
                                            </td>
                                            <td width="15px">
                                                <asp:Label Text="To" runat="server" ID="lblAgeTo" CssClass="searchLabel"></asp:Label>
                                            </td>
                                            <td width="140px">
                                                <asp:DropDownList runat="server" ID="ddlAgeTo" OnSelectedIndexChanged="ddlAgeTo_OnSelectedIndexChanged"
                                                    AutoPostBack="true" Style="width: 80px; margin-left: 5px;">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnClearDDL" runat="server" OnClick="btnClearDDl_Clicked" AutoPostBack="true"
                                                    CssClass="btnClose" Text="X" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdPadd35">
                                                <asp:Label Text="Date Created" runat="server" ID="lblDateCreated" CssClass="searchLabel"></asp:Label>
                                            </td>
                                            <td>
                                                <div style="position: relative; float: left;">
                                                    <asp:TextBox ID="txtDateFrom" runat="server" ReadOnly="true" Style="padding: 0px 5px;
                                                        width: 80px; float: left;" />
                                                    <img src="Images/calender.jpg" id="imgCalFrom" style="float: left; margin-top: 5px;" />
                                                    <asp:CalendarExtender ID="calDateFrom" runat="server" PopupPosition="BottomLeft"
                                                        PopupButtonID="imgCalFrom" TargetControlID="txtDateFrom" Format="dd/MM/yyyy"
                                                        OnClientDateSelectionChanged="calDateFrom_SelectionChange" EnableViewState="true">
                                                    </asp:CalendarExtender>
                                                    <asp:LinkButton ID="btnCalFrom" runat="server" OnClick="calDateFrom_SelectionChanged"
                                                        Style="display: none;" />
                                                </div>
                                            </td>
                                            <td>
                                                <asp:Label Text="To" runat="server" ID="lblDateTo" CssClass="searchLabel"></asp:Label>
                                            </td>
                                            <td width="140px">
                                                <div style="position: relative; float: left;">
                                                    <asp:TextBox ID="txtDateTo" runat="server" ReadOnly="true" Style="padding: 0px 5px;
                                                        width: 80px; float: left;" />
                                                    <img src="Images/calender.jpg" id="imgCalTo" style="float: left; margin-top: 5px;" />
                                                    <asp:CalendarExtender ID="calDateTo" runat="server" PopupPosition="BottomLeft" PopupButtonID="imgCalTo"
                                                        TargetControlID="txtDateTo" Format="dd/MM/yyyy" OnClientDateSelectionChanged="calDateTo_SelectionChange"
                                                        EnableViewState="true">
                                                    </asp:CalendarExtender>
                                                    <asp:LinkButton ID="btnCalTo" runat="server" OnClick="calDateTo_SelectionChanged"
                                                        Style="display: none;" />
                                                </div>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnClearCalender" runat="server" OnClick="btnClearCalender_Clicked"
                                                    AutoPostBack="true" CssClass="btnClose" Text="X" Style="margin-bottom: 5px;" />
                                                <asp:Label ID="lblCalenderError" runat="server" Style="color: Red;" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="gridDiv" runat="server">
                    <div class="dvAction" style="clear: both;">
                        <table cellpadding="3" cellspacing="3" width="100%">
                            <tr>
                                <td height="80px" valign="middle" style="font-size: 45px; padding-left: 20px;" align="left">
                                    Users
                                </td>
                                <td style="padding-right: 20px;" valign="middle" height="80px" align="right">
                                    <asp:Button ID="btnExportAll" runat="server" Text="export all (csv)" OnClick="btnExportAll_Click"
                                        OnClientClick="return checkSelectedUser()" CssClass="btnSubmit" />
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnDeleteUser" runat="server" Text="- delete user(s)" Width="180px"
                                        OnClick="btnDeleteUser_Clicked" OnClientClick="return checkDeleteUser()" CssClass="btnSubmit" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="dvMainContext" style="clear: both">
                        <asp:GridView ID="gvUsersList" runat="server" CssClass="gvDrinkVoucher" AutoGenerateColumns="false"
                            DataKeyNames="UserID" AllowSorting="true" OnSorting="gvUsersList_sorting" GridLines="None"
                            OnRowDataBound="gvUserList_RowDataBound" EmptyDataText="No results match your search criteria.">
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="20px" HeaderStyle-Width="20px">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkUsersSelectAll" runat="server" onclick="checkall(this);" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkUserSelect" runat="server" onclick="check(this);" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Date Created" DataField="DateCreated" SortExpression="DateCreated"
                                    ItemStyle-Width="200px" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="First Name" SortExpression="FName" DataField="FName"
                                    ItemStyle-Width="180px" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Last Name" SortExpression="LName" DataField="LName" ItemStyle-Width="180px"
                                    HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Email" DataField="Email" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Sex" DataField="Sex" ItemStyle-Width="100px" HeaderStyle-Width="100px"
                                    ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Age" DataField="Age" ItemStyle-Width="100px" HeaderStyle-Width="100px"
                                    ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField ControlStyle-CssClass="tdHide">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnUserId" runat="server" Value='<%# Eval("UserID") %>' />
                                    </ItemTemplate>
                                    <ItemStyle CssClass="tdHide" />
                                    <HeaderStyle CssClass="tdHide" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                          <table cellpadding="3" cellspacing="3" width="99%" class="PagingTable">
                            <tr>
                                <td height="50px" valign="middle" align="center" style="width: 75%">
                                    <asp:LinkButton runat="server" ID="lnkPrev" OnClick="lnkPrev_Click" CssClass="lnkBtn">&lt;Previous</asp:LinkButton>
                                    <asp:Label runat="server" ID="lblPageInfo"></asp:Label>
                                    <asp:LinkButton runat="server" ID="lnkNext" OnClick="lnkNext_Click" CssClass="lnkBtn">Next&gt;</asp:LinkButton>
                                </td>
                                <td style="padding-right: 20px;" valign="middle" height="50px" align="right" id="td1">
                                    <asp:LinkButton runat="server" ID="lnk25" OnClick="lnk25_Click">25</asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="lnk50" OnClick="lnk50_Click">50</asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="lnk100" OnClick="lnk100_Click">100</asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                  
                </div>
                <div style="display: none">
                    <asp:HiddenField ID="hdnUserIdChecked" runat="server" Value="" />
                </div>
            </div>
</asp:Content>

<%@ Page Title="OntheHouse:Voucher Details List" Language="C#" MasterPageFile="~/mstDrinkVoucher.Master" AutoEventWireup="true" CodeBehind="VoucherList.aspx.cs" Inherits="DrinkBarVoucher.VoucherList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/PagesContents.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-min.js" type="text/javascript"></script>
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
                font-weight:normal;
                padding:10px 10px 0px 10px;
                
           }
            .tdHide
            {
                display: none;
            }
           
           .ddl
           {
               width:150px;
           }
           
       
           
    </style>

    <script type="text/javascript">

        $(document).ready(function () {
            if ($("input:checkbox[id*='chkVoucherSelect']:checked").length == 0) {
                $("[id*='btnExportAll']").val("export all (csv)");
            }
            else if ($("input:checkbox[id*='chkVoucherSelect']:checked").length == $("input:checkbox[id*='chkVoucherSelect']").length) {
               // $("[id*='btnExportAll']").val("export all (csv)");
            }
            else {
                $("[id*='btnExportAll']").val("export selected (csv)");
            }
        });

        function checkall(checkselectall) {
         
            if (checkselectall.checked) {
                $("input:checkbox[id*='chkVoucherSelect']").prop("checked", "checked");
                $("[id*='btnExportAll']").val("export all (csv)");
            }
            else {
                $("[id*='btnExportAll']").val("export all (csv)");
                $("input:checkbox[id*='chkVoucherSelect']").removeProp("checked");
            }
        }

        function check(checkselect) {
            if ($("input:checkbox[id*='chkVoucherSelect']:checked").length == 0) {
                $("input:checkbox[id*='chkVouchersSelectAll']").removeProp("checked");
                $("[id*='btnExportAll']").val("export all (csv)");
            }
            else if ($("input:checkbox[id*='chkVoucherSelect']:checked").length == $("input:checkbox[id*='chkVoucherSelect']").length) {
                //$("[id*='btnExportAll']").val("export all (csv)");
                //$("input:checkbox[id*='chkVouchersSelectAll']").prop("checked", "checked");
            }
            else {
                $("[id*='btnExportAll']").val("export selected (csv)");
                $("input:checkbox[id*='chkVouchersSelectAll']").removeProp("checked");
            }
        }


        function checkDeleteUser() {

            var arryVoucherId = new Array();
            $("input:checkbox[id*='chkVoucherSelect']").each(function () {
                var txtVoucherId = $(this).closest('tr').find('td:last').find('input').val();
                if ($.trim($(this).is(":checked")).toLocaleUpperCase() == "TRUE") {
                    arryVoucherId.push(txtVoucherId);                   
                }
            });
            $("#cpMaster_hdnVoucherIdChecked").val(arryVoucherId);

            if ($("#cpMaster_hdnVoucherIdChecked").val() == "") {
                alert("Please Select Atleast one Voucher");
                return false;
            }
            else {
                if (confirm('Are you sure you want to delete Voucher(s)?')) {
                    return true;
                }
                else {
                    $("#cpMaster_hdnVoucherIdChecked").val("");
                    return false;
                }
            }

        }

        function checkSelectedUser() {

            var arryVoucherId = new Array();


            if ($("input:checkbox[id*='chkVouchersSelectAll']:checked").length == 0) {

                if ($("input:checkbox[id*='chkVoucherSelect']:checked").length == 0) {

                    //                $("input:checkbox[id*='chkVoucherSelect']").each(function () {
                    //                    var txtVoucherId = $(this).closest('tr').find('td:last').find('input').val();
                    //                    arryVoucherId.push(txtVoucherId);

                    //                });
                    $("#cpMaster_hdnVoucherIdChecked").val("");
                    return true;
                }
                else {

                    $("input:checkbox[id*='chkVoucherSelect']").each(function () {
                        var txtVoucherId = $(this).closest('tr').find('td:last').find('input').val();
                        if ($.trim($(this).is(":checked")).toLocaleUpperCase() == "TRUE") {
                            arryVoucherId.push(txtVoucherId);

                        }

                    });
                    $("#cpMaster_hdnVoucherIdChecked").val(arryVoucherId);
                    return true;
                }
            }
            else {

                $("#cpMaster_hdnVoucherIdChecked").val("");
                return true;

            }

           

        }

        function calDateFrom_SelectionChange() {
            // $("#cpMaster_btnCalFrom").click();

            if ($("[id*='ddlDateType']").val() == "-1") {
                $("[id*='txtDateFrom']").val("");
                alert("please select date type");
            }
            else {
                __doPostBack('ctl00$cpMaster$btnCalFrom', '');
            }
        }

        function calDateTo_SelectionChange() {

            if ($("[id*='ddlDateType']").val() == "-1") {
                $("[id*='txtDateTo']").val("");
                alert("please select date type");
            }
            else {

                __doPostBack('ctl00$cpMaster$btnCalTo', '');
            }
        }

        function popupcalender() {

            if ($("[id*='ddlDateType']").val() == "-1") {

                alert("please select date type");
                return false;           
            }
            else {
                return true;
            }
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
                <td style="width:100%;height:43px;" align="right">
               <asp:Button  runat="server" id="btnFilter" Text="Filter" style="margin-right:20px;margin-top:0px;"  OnClick="btnFilter_Clicked"  CssClass="btnSubmit" AutoPostBack="true"/>
             </td>
             </tr>
              <tr>
                <td>
                    <div  align="left"  id="searchDiv" runat="server" visible="false" style="overflow:hidden;padding-bottom:15px;background:#F0F0F0;border-top:1px solid #800000">
                    <table  cellpadding="3" cellspacing="3" width="100%">
                        <tr>
                            <td class="tdPadd35" width="40px">
                                <asp:Label Text="Bar" runat="server" id="lblBar" CssClass="searchLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlBarList" AutoPostBack="true" OnSelectedIndexChanged="ddlBarList_OnSelectedIndexChanged" class="ddl"></asp:DropDownList>
                                 <asp:Button id="btnClearDDLBar" runat="server" OnClick="btnClearDDLBar_Clicked" AutoPostBack="true" CssClass="btnClose" Text="X" />
                           
                            </td>
                        </tr>
                        <tr>
                            <td class="tdPadd35">
                                <asp:Label Text="User" runat="server" id="lblUser" CssClass="searchLabel"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlUserList" OnSelectedIndexChanged="ddlUserList_OnSelectedIndexChanged" AutoPostBack="true" class="ddl"> </asp:DropDownList>
                                 <asp:Button id="btnClearDDLUser" runat="server" OnClick="btnClearDDLUser_Clicked" AutoPostBack="true" CssClass="btnClose" Text="X" />
                             </td>
                        </tr>
                        <tr>
                            <td class="tdPadd35">                                
                                <asp:Label Text="Date" runat="server" id="lblDate" CssClass="searchLabel"></asp:Label>                               
                            </td>
                            <td align="left" width="1080px">  
                                <div  style="width:180px;float:left;">
                                <asp:DropDownList runat="server" ID="ddlDateType" class="ddl" OnSelectedIndexChanged="ddlDateType_OnSelectedIndexChanged" AutoPostBack="true"> </asp:DropDownList> 
                                </div>
                                <div id="divCalender" runat="server" style="width:900px;float:left;">
                                 <asp:TextBox   id="txtDateFrom" Runat="server" ReadOnly="true" style="padding:0px 5px;margin-top:10px;float:left;"  CssClass="txtSmall"/>   
                                     <img src="Images/calender.jpg" id="imgCalFrom" onclick="return popupcalender()" style="float:left;margin-top:10px;"  />                                
                                    <asp:CalendarExtender ID="calDateFrom" runat="server" PopupPosition="BottomLeft" PopupButtonID="imgCalFrom"
                                         TargetControlID="txtDateFrom" Format="dd/MM/yyyy" 
                                         OnClientDateSelectionChanged="calDateFrom_SelectionChange"
                                         EnableViewState="true">
                                    </asp:CalendarExtender>                                  
                                    <asp:LinkButton id="btnCalFrom" runat="server"  onclick="calDateFrom_SelectionChanged"  style="display:none;"/>

                                     <asp:Label  Text="To" runat="server" id="lblDateTo" CssClass="searchLabel" style="float:left;" ></asp:Label>

                                    <asp:TextBox   id="txtDateTo" Runat="server" ReadOnly="true" style="padding:0px 5px;margin-top:10px;float:left;" CssClass="txtSmall"/>
                                    <img src="Images/calender.jpg" id="imgCalTo"  onclick="return popupcalender()" style="float:left;margin-top:10px;"/>                                    
                                     <asp:CalendarExtender ID="calDateTo" runat="server" PopupPosition="BottomLeft" PopupButtonID="imgCalTo"
                                         TargetControlID="txtDateTo" Format="dd/MM/yyyy" 
                                         OnClientDateSelectionChanged="calDateTo_SelectionChange"
                                         EnableViewState="true">
                                    </asp:CalendarExtender>
                                    <asp:LinkButton id="btnCalTo" runat="server"  onclick="calDateTo_SelectionChanged"  style="display:none;" /> 
                                    <asp:Button id="btnClearCalender" runat="server" OnClick="btnClearCalender_Clicked" AutoPostBack="true" Text="X" CssClass="btnClose" style="margin-top:8px;float:left;" />
                                    <asp:Label id="lblCalenderError" runat="server" style="color:Red;float:left;padding:10px 0px 0px 5px;" />
                                 </div>
                   
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
                    <td height="80px" valign="middle" style="font-size: 45px; padding-left: 20px;"  align="left">
                        Vouchers
                    </td>
                    <td style="padding-right: 20px;" valign="middle" height="80px" align="right">
                        <asp:Button ID="btnExportAll" runat="server" Text="export all (csv)" OnClick="btnExportAll_Click" OnClientClick="return checkSelectedUser()"  CssClass="btnSubmit" />
                        &nbsp;&nbsp;&nbsp;                        
                        <asp:Button ID="btnDeleteVoucher" runat="server" Text="- delete vouchers(s)" Width="180px" onclick="btnDeleteVoucher_Clicked"  OnClientClick="return checkDeleteUser()"  CssClass="btnSubmit"/>
                              
                    </td>
                </tr>
            </table>
        </div>
             <div class="dvMainContext" style="clear: both">
                <asp:GridView ID="gvVoucherList" runat="server" CssClass="gvDrinkVoucher" AutoGenerateColumns="false"
                DataKeyNames="VoucherID" AllowSorting="true"  OnSorting="gvVoucherList_sorting" GridLines="None"
                 onrowdatabound="gvVoucherList_RowDataBound" EmptyDataText="No results match your search criteria." >
                <Columns>
                    <asp:TemplateField ItemStyle-Width="20px" HeaderStyle-Width="20px" >
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkVouchersSelectAll" runat="server" onclick="checkall(this);" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkVoucherSelect" runat="server"  onclick="check(this);" />
                        </ItemTemplate>
                    </asp:TemplateField>                     
                    <asp:BoundField HeaderText="Date Created" DataField="DateCreated" SortExpression="DateCreated"  ItemStyle-Width="180px" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center"  />
                    <asp:BoundField  HeaderText="Date Seen"  SortExpression="DateSeen" DataField="DateSeen"  ItemStyle-Width="180px" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center" /> 
                     <asp:BoundField  HeaderText="Date Redeemed"  SortExpression="DateRedeemed" DataField="DateRedeemed"  ItemStyle-Width="180px" HeaderStyle-Width="180px" ItemStyle-HorizontalAlign="Center" />                                      
                    <asp:TemplateField HeaderText="Bar" ItemStyle-Width="150px" SortExpression="BarName" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center">
                            <ItemStyle HorizontalAlign="Center"  VerticalAlign="Middle"  />
                            <ItemTemplate >
                                <asp:HyperLink runat="server" ID="linkBarList" NavigateUrl='<%# Eval("BarID", "~/BarList.aspx?Id={0}") %>' Text='<%# Bind("BarName") %>' ToolTip="View Bar"></asp:HyperLink>
                            </ItemTemplate>                        
                    </asp:TemplateField> 
                    <asp:TemplateField HeaderText="User Name" ItemStyle-Width="150px" SortExpression="UserName" HeaderStyle-Width="150px"  ItemStyle-HorizontalAlign="Center" >
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemTemplate >
                                <asp:HyperLink ID="linkUserLISt" runat="server" NavigateUrl='<%# Eval("UserID", "~/UserList.aspx?Id={0}") %>' Text='<%# Bind("UserName") %>' ToolTip="View User"></asp:HyperLink>
                            </ItemTemplate>                        
                    </asp:TemplateField>                 
                    <asp:BoundField HeaderText="User Email" DataField="Email"  ItemStyle-HorizontalAlign="Center" />
                      <asp:TemplateField ControlStyle-CssClass="tdHide" >
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnVoucherId" runat="server" Value='<%# Eval("VoucherID") %>' />
                        </ItemTemplate>
                        <ItemStyle CssClass="tdHide" />
                        <HeaderStyle  CssClass="tdHide" />   
                    </asp:TemplateField>
                </Columns>
           </asp:GridView>

         </div>
             <div>       
            <table cellpadding="3" cellspacing="3" width="99%" class="PagingTable">
                <tr>
                    <td height="50px" valign="middle" align="center" style="width:75%" >
                        <asp:LinkButton  runat="server" ID="lnkPrev"  OnClick="lnkPrev_Click" CssClass="lnkBtn" >&lt;Previous</asp:LinkButton>
                        <asp:Label runat="server" ID="lblPageInfo" ></asp:Label>
                        <asp:LinkButton  runat="server" ID="lnkNext"  OnClick="lnkNext_Click" CssClass="lnkBtn">Next&gt;</asp:LinkButton>
                    </td>
                    <td style="padding-right: 20px;" valign="middle" height="50px" align="right" id="td1">
                         <asp:LinkButton  runat="server" ID="lnk25"  OnClick="lnk25_Click" >25</asp:LinkButton>
                        <asp:LinkButton  runat="server" ID="lnk50"  OnClick="lnk50_Click" >50</asp:LinkButton>
                        <asp:LinkButton  runat="server" ID="lnk100"  OnClick="lnk100_Click" >100</asp:LinkButton>
                    </td>
                </tr>
            </table>
         </div>
         </div>         
         <div style="display:none">
            <asp:HiddenField ID="hdnVoucherIdChecked" runat="server" Value="" />
         </div>
    </div>
</asp:Content>

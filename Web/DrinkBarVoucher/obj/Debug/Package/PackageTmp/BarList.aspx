<%@ Page Title="OntheHouse:Bar Detail List" Language="C#" MasterPageFile="~/mstDrinkVoucher.Master"
    AutoEventWireup="true" EnableEventValidation="false" CodeBehind="BarList.aspx.cs"
    Inherits="DrinkBarVoucher.BarList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/PagesContents.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-min.js" type="text/javascript"></script>
    <script src="Scripts/jsArrayIndexOf.js" type="text/javascript"></script>
    <script src="Scripts/jquery.watermark.js" type="text/javascript"></script>
    <script type="text/javascript"> 

        $(document).ready(function () {
            var arryBarId = new Array();
            onbodyload();

            

            $("a[id*='lnkImage']").click(function () {
                window.open($(this).attr("href"), "Name", 'height=400,width=550,top:100,left:200');
                return false;
            });
        });


        function checkSelectedBar() {

            var arryBarId = new Array();
            if ($("input:checkbox[id*='chkBarHead']:checked").length == 0) {


                if ($("input:checkbox[id*='chkBars']:checked").length == 0) {

                    $("#cpMaster_hdnBarIdChecked").val("");
                    return true;
                }
                else {

                    $("input:checkbox[id*='chkBars']").each(function () {
                        var txtBarId = $(this).closest('tr').find('td:last').find('input').val();
                        if ($.trim($(this).is(":checked")).toLocaleUpperCase() == "TRUE") {
                            arryBarId.push(txtBarId);

                        }

                    });
                    $("#cpMaster_hdnBarIdChecked").val(arryBarId);

                    return true;
                }
            }
            else {
                $("#cpMaster_hdnBarIdChecked").val("");
                return true;
            }

        }


        function checkall(checkselectall) {

            if (checkselectall.checked) {
                $("input:checkbox[id*='chkBars']").prop("checked", "checked");
                $("[id*='btnExportAll']").val("export all (csv)");
            }
            else {
                $("[id*='btnExportAll']").val("export all (csv)");
                $("input:checkbox[id*='chkBars']").removeProp("checked");
            }

        }

        function check(checkselect) {

            if ($("input:checkbox[id*='chkBars']:checked").length == 0) {
                $("input:checkbox[id*='chkBarHead']").removeProp("checked");
                $("[id*='btnExportAll']").val("export all (csv)");
            }
            else if ($("input:checkbox[id*='chkBars']:checked").length == $("input:checkbox[id*='chkBars']").length) {
//                $("[id*='btnExportAll']").val("export all (csv)");
//                $("input:checkbox[id*='chkBarHead']").prop("checked", "checked");
            }
            else {
                $("[id*='btnExportAll']").val("export selected (csv)");
                $("input:checkbox[id*='chkBarHead']").removeProp("checked");
            }
        }

        function checkBar() {

            var arryBarId = new Array();
            $("input:checkbox[id*='chkBars']").each(function () {
                var txtBarId = $(this).closest('tr').find('td:last').find('input').val();
                if ($.trim($(this).is(":checked")).toLocaleUpperCase() == "TRUE") {
                    arryBarId.push(txtBarId);
                }
            });
            $("#cpMaster_hdnBarIdChecked").val(arryBarId);

            if ($("#cpMaster_hdnBarIdChecked").val() == "") {
                alert("Please select atleast one bar");
                return false;
            }
            else {
                return true;
            }
        }


        function checkDeleteBar() {

            if (checkBar()) {
                if (confirm('Are you sure you want to delete bar(s)?')) {
                    return true;
                }
                else {
                    $("#cpMaster_hdnBarIdChecked").val("");
                    return false;
                }
            }

        }

        

    </script>
    <style type="text/css">
        .tdHide
        {
            display: none;
        }
       
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMaster" runat="server">
    <div id="dvMain">
        <div class="dvHeader" align="right">
            <asp:TextBox ID="txtSearch" runat="server" Width="250px" ToolTip="search by bar name"
                CssClass="txt" onfocus="txtOnFocus(this,'txt');" onblur="txtOnLeave(this,'txt');"
                AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
        </div>
        <div class="dvAction" style="clear: both;">
            <table cellpadding="3" cellspacing="2" width="100%">
                <tr>
                    <td height="80px" valign="middle" style="font-size: 45px; padding-left: 20px;">
                        Bars
                    </td>
                    <td style="padding-left: 30px;" valign="middle" height="80px" align="left">
                        <asp:Button ID="btnExportAll" runat="server" Text="export all (csv)" OnClick="btnExportAll_Click"
                            OnClientClick="return checkSelectedBar()" CssClass="btnSubmit" />
                        &nbsp;&nbsp;
                        <asp:Button ID="btnInactive" runat="server" Text="make inactive" OnClick="btnInactive_Click"
                            CssClass="btnSubmit" OnClientClick="return checkBar()" />
                        &nbsp;&nbsp;
                        <asp:Button ID="btnActive" runat="server" Text="make active" OnClick="btnActive_Click"
                            CssClass="btnSubmit" OnClientClick="return checkBar()" />
                        &nbsp;&nbsp;
                        <asp:Button ID="btnDeleteBar" runat="server" Text="- delete" OnClick="btnDeleteBar_Click"
                            CssClass="btnSubmit" OnClientClick="return checkDeleteBar()" />
                        &nbsp;&nbsp;
                        <asp:Button ID="btnAddBar" runat="server" Text="+ add" OnClick="btnAddBar_Click"
                            CssClass="btnSubmit" />
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="dvMainContext" style="padding-bottom: 5px; overflow-X: scroll ; border: 1px solid #C9C9C9;">
            <asp:GridView ID="gvBarList" runat="server" CssClass="gvDrinkVoucher" AutoGenerateColumns="false"
                DataKeyNames="BarID" AllowSorting="true" OnSorting="gvBarList_Sorting" GridLines="None"
                EmptyDataText="No results match your search criteria." OnRowDataBound="gvBarList_RowDataBound">
                <Columns>
                    <asp:TemplateField>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkBarHead" runat="server" onclick="checkall(this);" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkBars" runat="server" onclick="check(this);" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemTemplate>
                            <asp:ImageButton ID="imgEdit" ImageUrl="~/Images/btnEdit.png" runat="server" CommandName="btnEditValidate"
                                CommandArgument='<%# Eval("BarID") %>' OnClick="imgEdit_Click" ToolTip="Edit" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Name" DataField="BarName" SortExpression="BarName" HeaderStyle-Wrap="false" />
                    <asp:BoundField HeaderText="Status" DataField="Status" SortExpression="Status" HeaderStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField HeaderText="Active Days" DataField="ActiveDays" HeaderStyle-Wrap="true"
                        ItemStyle-Wrap="true" ItemStyle-HorizontalAlign="Center" />
                    <%--<asp:BoundField HeaderText="Voucher Hours" DataField="VoucherHours" ItemStyle-HorizontalAlign="Center" />--%>
                    <asp:BoundField HeaderText="Discovery Radius" DataField="Radius" SortExpression="Radius" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField HeaderText="Redemption Radius" DataField="RedemptionRadius" SortExpression="RedemptionRadius" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField HeaderText="Date Created" DataField="DateCreated" SortExpression="DateCreated"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="Website">
                        <ItemTemplate>
                            <a href='<%# Eval("BarWebsite") %>' target="_blank">
                                <%# Eval("BarWebsite") %></a>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Wrap="true" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Photo">
                        <ItemTemplate>
                            <a id="lnkImage" href='<%# "../DrinkBarVoucher/ImageStorage/" + Eval("BarImageName") %>'
                                title="View Image" target="_blank">View</a>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Street Address" DataField="BarStreet" ItemStyle-Wrap="true"
                        SortExpression="BarStreet" />
                    <asp:BoundField HeaderText="City" DataField="CityName" ItemStyle-Wrap="true" SortExpression="CityName" />
                    <asp:BoundField HeaderText="State" DataField="StateName" ItemStyle-Wrap="true" SortExpression="StateName" />
                    <asp:BoundField HeaderText="Country" DataField="BarCountry" ItemStyle-Wrap="true" />
                    <asp:BoundField HeaderText="Phone" DataField="BarPhone" ItemStyle-Wrap="true" SortExpression="BarPhone" />
                    <asp:BoundField HeaderText="Zipcode" DataField="BarZipCode" ItemStyle-Wrap="true"
                        SortExpression="BarZipCode" />
                    <asp:BoundField HeaderText="Latitude" DataField="BarLatitude" ItemStyle-Wrap="true"
                        SortExpression="BarLatitude" />
                    <asp:BoundField HeaderText="Longitude" DataField="BarLongitude" ItemStyle-Wrap="true"
                        SortExpression="BarLongitude" />
                    <asp:TemplateField ControlStyle-CssClass="tdHide" HeaderStyle-CssClass="tdHide">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnBarId" runat="server" Value='<%# Eval("BarID") %>' />
                        </ItemTemplate>
                        <ControlStyle CssClass="tdHide"></ControlStyle>
                        <HeaderStyle CssClass="tdHide"></HeaderStyle>
                        <ItemStyle CssClass="tdHide" />
                    </asp:TemplateField>
                </Columns>
                <EmptyDataRowStyle HorizontalAlign="Center" />
                <SortedAscendingHeaderStyle CssClass="asce" />
                <SortedDescendingHeaderStyle CssClass="desc" />
            </asp:GridView>
            <table cellpadding="3" cellspacing="3" width="100%" class="PagingTable">
                <tr>
                    <td height="50px" valign="middle" align="center" style="width: 75%">
                        <asp:LinkButton runat="server" ID="lnkPrev" OnClick="lnkPrev_Click">&lt; previous</asp:LinkButton>
                        <asp:Label runat="server" ID="lblPageInfo"></asp:Label>
                        <asp:LinkButton runat="server" ID="lnkNext" OnClick="lnkNext_Click">next &gt;</asp:LinkButton>
                    </td>
                    <td style="padding-right: 20px;" valign="middle" height="50px" align="right" id="tdPaging">
                        <asp:LinkButton runat="server" ID="lnk25" OnClick="lnk25_Click">25</asp:LinkButton>
                        <asp:LinkButton runat="server" ID="lnk50" OnClick="lnk50_Click">50</asp:LinkButton>
                        <asp:LinkButton runat="server" ID="lnk100" OnClick="lnk100_Click">100</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>
        <div style="display: none">
            <asp:HiddenField ID="hdnBarIdChecked" runat="server" Value="" />
        </div>
    </div>
</asp:Content>

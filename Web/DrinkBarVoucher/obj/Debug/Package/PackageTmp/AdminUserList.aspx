<%@ Page Title="OntheHouse:Administrator Detail List" Language="C#" MasterPageFile="~/mstDrinkVoucher.Master" AutoEventWireup="true" CodeBehind="AdminUserList.aspx.cs" Inherits="DrinkBarVoucher.AdminUserList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/PagesContents.css" rel="stylesheet" type="text/css" />    
    <script src="Scripts/jquery-min.js" type="text/javascript"></script>  
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMaster" runat="server">
    
    <div id="dvMain">
        <div class="dvHeader" align="right" >           
        </div>

        <div class="dvAction" style="clear: both;">
            <table cellpadding="3" cellspacing="3" width="100%">
                <tr>
                    <td height="80px" valign="middle" style="font-size: 45px; padding-left: 20px;" align="left">
                        Administrators
                    </td>
                    <td style="padding-right: 20px;font-size: 30px;font-weight:bold;" valign="middle" height="80px" align="right" >                        
                        <asp:Button Text="Add New Admin" runat="server" ID="btnAddNewAdmin" OnClick="btnAddNewAdmin_Clicked"  CssClass="btnSubmit"/>
                    </td>
                </tr>
            </table>
        </div>

        <div class="dvMainContext" style="clear: both">

                <asp:GridView id="gvAdminUserList" runat="server"  AutoGenerateColumns="false"  AllowSorting="true" 
                     OnSorting="gvAdminUserList_sorting" DataKeyNames="UserId" CssClass="gvDrinkVoucher" GridLines ="None" 
                     onrowdatabound="gvAdminUserList_RowDataBound">
                    <Columns >
                        <asp:TemplateField HeaderText="" ItemStyle-Width="20px" >
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemTemplate >
                                <asp:HyperLink runat="server" NavigateUrl='<%# Eval("UserId", "~/AdminUser.aspx?Id={0}") %>' ImageUrl="~/Images/btnEdit.png" ToolTip="Edit"  ></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField  HeaderText="First Name"  SortExpression="FName" DataField="FName" ItemStyle-Width="180px"/>
                        <asp:BoundField  HeaderText="Last Name"  SortExpression="LName" DataField="LName" ItemStyle-Width="180px"/>
                        <asp:BoundField  HeaderText="Email"  DataField="Email"/>                      
                        
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
    
</asp:Content>

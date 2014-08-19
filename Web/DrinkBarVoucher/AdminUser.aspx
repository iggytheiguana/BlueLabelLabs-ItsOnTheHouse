<%@ Page Title="OntheHouse:Update Administrator Details" Language="C#" MasterPageFile="~/mstDrinkVoucher.Master" AutoEventWireup="true" CodeBehind="AdminUser.aspx.cs" Inherits="DrinkBarVoucher.AdminUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="Styles/PagesContents.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-min.js" type="text/javascript"></script> 
    
    <script type="text/javascript">

        function removeErrorMessage() {

            $("[id*='lblErrorEmail']").html(" ");
        }
     

        function Redirect() {

            alert("Admin User Saved Successfully");
            window.location.href = "AdminUserList.aspx"
            return false;
        }

    
    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpMaster" runat="server"> 
    <div id="dvMain">
        <div class="dvHeader" align="right" style="padding-right:0px;">
        </div>
        <div class="dvAction" style="clear: both;">
            <table cellpadding="3" cellspacing="3" width="100%">
                <tr>
                    <td height="80px" valign="middle" style="font-size: 45px; padding-left: 20px;" align="left">
                        Add/Edit Administrators
                    </td>
                    <td style="padding-right: 20px;" valign="middle" height="80px" align="right">
                         <asp:Button runat="server" Id="btnDeleteUser" Text="Delete user" OnClick="btnDeleteUser_Clicked" OnClientClick="return confirm('Are you sure you want to delete admin user?');"  CssClass="btnSubmit"  />
                         &nbsp;&nbsp;&nbsp;
                        <asp:Button runat="server" Id="btnCancel" Text="Cancel" OnClick="btnCancel_Clicked"  CssClass="btnSubmit" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button runat="server" Id="btnSave" Text="Save" ValidationGroup="ValidateBtnSave"  OnClick="btnSave_Clicked"  CssClass="btnSubmit"/>
                    </td>
                </tr>
            </table>
        </div>
   
            <div style="width: 100%; float: left;">   
                    <table cellpadding="3" cellspacing="3" width="100%">
        
                            <tr>
                                <td width="120px" class="tdPadd35" align="right">
                                    <asp:label ID="lblFirstName" Text="First Name" runat="server"></asp:label>
                                </td>
                                <td align="left">
                                    <asp:TextBox runat="server" id="txtFirstName"  CssClass="txtLargest" MaxLength="50"></asp:TextBox>
                                    <asp:RequiredFieldValidator id="rfvtxtFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="*" ValidationGroup="ValidateBtnSave" style="color:Red;"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                             <tr>
                                <td class="tdPadd35" align="right">
                                    <asp:label ID="lblLastName" Text="Last Name" runat="server"></asp:label>
                                </td>
                                <td  align="left" >
                                     <asp:TextBox runat="server" id="txtLastName"  CssClass="txtLargest" MaxLength="50"></asp:TextBox>
                                     <asp:RequiredFieldValidator id="rfvtxtLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="*" ValidationGroup="ValidateBtnSave" style="color:Red;"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                             <tr>
                                <td class="tdPadd35" align="right">
                                    <asp:label ID="lblEmail" Text="Email" runat="server"></asp:label>
                                </td>
                                <td  align="left">
                                    <asp:TextBox runat="server" id="txtEmail"  CssClass="txtLargest" MaxLength="50" onfocus="removeErrorMessage();"></asp:TextBox>
                                    <asp:RequiredFieldValidator id="rfvtxtEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="*" ValidationGroup="ValidateBtnSave" style="color:Red;"  Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:label  runat="server" id="lblErrorEmail"  style="color:Red;" CssClass="lblErrorEmail" ></asp:label> 
                                    <asp:RegularExpressionValidator ID="revtxtEmail" ErrorMessage="Invalid EmailId" ControlToValidate="txtEmail"   ValidationExpression="^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+"  Display="Dynamic"
                                        runat="server" ValidationGroup="ValidateBtnSave" style="color:Red;"/>
                                    <asp:label style="padding-right:180px;padding-left:6px;" runat="server" ID="lblNewPassword" >New Password</asp:label><asp:label class="txtLargest" runat="server" ID="lblconfirmNewPassword">Confirm New Password</asp:label>
                                </td>
                            </tr>
                            <tr id="trNewAdmin" runat="server" >
                                <td class="tdPadd35" align="right">
                                    <asp:label ID="lblPassword" Text="Password" runat="server"></asp:label>
                                </td>
                                <td  align="left"> 
                                     <asp:TextBox runat="server" id="txtPassword" TextMode="Password"  CssClass="txtLargest" MaxLength="50"></asp:TextBox>
                                     <asp:RequiredFieldValidator id="rfvtxtPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="*" ValidationGroup="ValidateBtnSave" style="color:Red;"></asp:RequiredFieldValidator>
                                     
                                     <asp:TextBox runat="server" id="txtConformPassword" TextMode="Password" CssClass="txtLargest" MaxLength="50"></asp:TextBox>
                                     <asp:RequiredFieldValidator id="rfvtxtConformPassword" runat="server" ControlToValidate="txtConformPassword" ErrorMessage="*" ValidationGroup="ValidateBtnSave" style="color:Red;" Display="Dynamic"></asp:RequiredFieldValidator>
                                     <asp:CompareValidator  ErrorMessage="Match with password" ControlToValidate="txtConformPassword" ControlToCompare="txtPassword" 
                                        runat="server" Id="cvtxtConformPassword" style="color:Red;" ValidationGroup="ValidateBtnSave"  Display="Dynamic" /> 
                                   
                                </td>
                            </tr>

                             <tr id="trOldAdmin" runat="server">
                                <td class="tdPadd35" align="right">
                                    <asp:label ID="lblPassword1" Text="Password" runat="server"></asp:label>
                                </td>
                                <td  align="left" > 
                                    <asp:TextBox runat="server" id="txtOldPassword" TextMode="Password" CssClass="txtLargest" MaxLength="50"></asp:TextBox>                               
                                    <asp:TextBox runat="server" id="txtNewPassword" TextMode="Password" CssClass="txtLargest" MaxLength="50"></asp:TextBox>  
                                    <asp:TextBox runat="server" id="txtConformNewPassword" TextMode="Password" CssClass="txtLargest" MaxLength="50"></asp:TextBox>              
                                    <asp:label  runat="server" id="lblerror"  style="color:Red;" ></asp:label> 
                                  
                                </td>

                            </tr>
                  </table>
             </div>
    </div>
</asp:Content>

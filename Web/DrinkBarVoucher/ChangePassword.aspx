<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs"
    Inherits="DrinkBarVoucher.ChangePassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OntheHouse:Change Password</title>
    <link href="Styles/PagesContents.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #dvLogin
        {
            position: fixed;
            border: 1px solid #C9C9C9;
            padding: 0px 0px 15px 0px;
            top: 150px;
            width: 600px;
        }
        a
        {
            text-decoration: none;
            color: #515151;
            padding-right: 90px;
        }
        a:hover
        {
            text-decoration: underline;
            color: #800000;
            padding-right: 90px;
        }
        .login_area
        {
            width: 600px;
            margin: 0 auto;
        }
        .txtLogin
        {
            width: 300px;
        }
        .tdPadimg
        {
            padding-right: 35px;
            width: 150px;
        }
       .btnSignin
        {
            padding: 5px;
            height: 35px;
            font-family: Arial,Microsoft Sans Serif,Verdana;
            font-size: 13pt;
            border: 1px solid #C9C9C9;
            color: #800000;
            font-weight: bold;
            background: #C9C9C9;
            width: 200px;
        }
        .btnSignin:hover
        {
           
            border: 1px solid #C9C9C9;
            color: #C9C9C9;
            font-weight: bold;
            background: #800000;
            width: 200px;
        }
        
        .errorLabel
        {
            color: Red;
        }
    </style>
    <script type="text/javascript">

        function Redirect() {
            alert("Password change Successfully.");
            window.location.replace('AdminLogin.aspx');
        }

        function AlreadyChanged() {
            alert("your temporary password is expired.");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="login_area">
            <div id="dvLogin">
                <div id="dvHeader" style="font-family: Verdana; font-size: 32pt; background: #C9C9C9;
                    color: #800000; width: 100%;
                    border-collapse: collapse; vertical-align: middle">
                    <table cellpadding="3" cellspacing="3" align="center">
                        <tr>
                            <td align="center">
                                <img src="Images/logo_new.png" />
                            </td>
                            
                        </tr>
                    </table>
                </div>
                <table cellpadding="2" cellspacing="3" style="padding: 5px;" width="100%">
                    <tr>
                        <td rowspan="11" align="justify" valign="middle" class="tdPadimg">
                            <img src="Images/login_user.png" />
                        </td>
                        <td align="center" style="font-family: Verdana; font-size: 14pt; padding: 5px 50px 5px 10px;
                            color: #800000;">
                            Administrator change password
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px;" colspan="2">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Label ID="lblErrorMsg" runat="server" Text="" ForeColor="#800000"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px; font-family: Verdana,Sans-Serif,Arial; color: #515151">
                            Email*
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox runat="server" ID="txtEmail" CssClass="txtLogin" ReadOnly="true"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px; font-family: Verdana,Sans-Serif,Arial; color: #515151">
                            Create New Password*
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" CssClass="txtLogin"></asp:TextBox>
                            <asp:RequiredFieldValidator ErrorMessage="*" ControlToValidate="txtPassword" CssClass="errorLabel"
                                runat="server" ID="rfvtxtPassword" ValidationGroup="btn_SignIn" />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 10px; font-family: Verdana,Sans-Serif,Arial; color: #515151">
                            Confirm Password*
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox runat="server" ID="txtConfirmPassword" TextMode="Password" CssClass="txtLogin"></asp:TextBox>
                            <asp:RequiredFieldValidator ErrorMessage="*" ControlToValidate="txtConfirmPassword"
                                CssClass="errorLabel" runat="server" ID="rfvtxtConfirmPassword" ValidationGroup="btn_SignIn" />
                            <asp:CompareValidator ErrorMessage="confirm Password mst be match with password"
                                ControlToValidate="txtConfirmPassword" runat="server" ControlToCompare="txtPassword"
                                ID="cpvtxtConfirmPassword" ValidationGroup="btn_SignIn" CssClass="errorLabel" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px;">
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Button ID="btnSignIn" runat="server" Text="Change Password" CssClass="btnSignin"
                                OnClick="btnSignIn_Click" ValidationGroup="btn_SignIn" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    </form>
</body>
</html>

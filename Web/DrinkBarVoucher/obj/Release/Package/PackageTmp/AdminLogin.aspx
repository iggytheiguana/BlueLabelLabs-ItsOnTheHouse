<%@ Page  Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="DrinkBarVoucher.AdminLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OntheHouse:Admin Login</title>
    <link href="Styles/PagesContents.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    
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
            padding-top: 30px;
            padding-right: 30px;
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
            width: 150px;
        }
        .btnSignin:hover
        {
           
            border: 1px solid #C9C9C9;
            color: #C9C9C9;
            font-weight: bold;
            background: #800000;
            width: 150px;
        }
        .errorLabel
        {
            color: Red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="login_area">
        <div id="dvLogin">
            <div id="dvHeader" style="font-family: Verdana; font-size: 32pt; background: #C9C9C9;
                color: #800000; width: 100%;  border-collapse: collapse;
                vertical-align: middle">
                <table cellpadding="3" cellspacing="3" align="center">
                    <tr>
                        <td  align="center">
                            <img src="Images/logo_new.png" />
                        </td>
                       
                    </tr>
                </table>
            </div>
            <table cellpadding="1" cellspacing="1" style="padding: 10px;" width="100%">
                <tr>
                    <td rowspan="10" align="justify" valign="top" class="tdPadimg">
                        <img src="Images/login_user.png" />
                    </td>
                    <td align="center" style="font-family: Verdana; font-size: 14pt; padding: 5px 50px 5px 10px;
                        color: #800000;">
                        Administrator sign in
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
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="txtLogin"></asp:TextBox>
                        <asp:RequiredFieldValidator ErrorMessage="*" ControlToValidate="txtEmail" CssClass="errorLabel"
                            runat="server" ID="rfvtxtEmail" ValidationGroup="btn_SignIn" />
                        <asp:RegularExpressionValidator ID="revtxtEmail" ErrorMessage="Please enter valid EmialID"
                            ControlToValidate="txtEmail" ValidationExpression="^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+"
                            runat="server" ValidationGroup="btn_SignIn" CssClass="errorLabel" Style="padding-left: 15px;" />
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 10px; font-family: Verdana,Sans-Serif,Arial; color: #515151">
                        Password*
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
                    <td align="right">
                        <asp:LinkButton runat="server" ID="lnkForgot" Text="Forgot?" OnClick="lnkForgot_Click"></asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td style="height: 10px;">
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:100px">
                        <asp:Button ID="btnSignIn" runat="server" Text="Sign In" OnClick="btnSignIn_Click"
                            CssClass="btnSignin" ValidationGroup="btn_SignIn" Width="110px" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>

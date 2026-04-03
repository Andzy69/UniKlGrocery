<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ProductPage.Register" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Grocery App - Register</title>
    <link href="AuthStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-card">

            <h2>Create Account</h2>

            <div class="form-group">
                <label>Username</label>
                <asp:TextBox ID="txtRegisterUser" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Password</label>
                <asp:TextBox ID="txtRegPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <asp:TextBox ID="txtConfirmPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Register Now" OnClick="btnRegister_Click" CssClass="btn-success" />

            <br />
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red" style="display:block; margin-top:10px;"></asp:Label>
            
            <a href="Login.aspx" class="link-text">Already have an account? Login.</a>

        </div>
    </form>
</body>
</html>
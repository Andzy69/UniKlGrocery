<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProductPage.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Grocery App - Login</title>
    <link href="AuthStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-card">
            <h2>Welcome To UniKL Grocery Store</h2>

            <div class="form-group">
                <label>Username</label>
                <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" placeholder="Enter username"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Password</label>
                <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
            </div>

            <asp:Button ID="Button1" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn-primary" />

            <br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" style="display:block; margin-top:10px;"></asp:Label>

            <a href="Register.aspx" class="link-text">Don't have an account? Register here.</a>

        </div>
    </form>
</body>
</html>
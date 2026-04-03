<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroceryDetails_Old.aspx.cs" Inherits="ProductPage.GroceryDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Details</title>
    <link href="StyleSheet1.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="header">
            <h2>UniKL Grocery Store</h2>
            <p>Product Details</p>
        </div>

        <div class="details-box">
            
            <div class="details-left">
                <asp:Image ID="imgProduct" runat="server" CssClass="details-img" />
            </div>

            <div class="details-right">
                <asp:Label ID="lblName" runat="server" CssClass="details-name" Text="Product Name"></asp:Label>
                <br />
                <asp:Label ID="lblPrice" runat="server" CssClass="details-price" Text="RM 0.00"></asp:Label>
                
                <hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;" />

                <div class="qty-section">
                    <label>Quantity:</label>
                    <asp:TextBox ID="txtQty" runat="server" TextMode="Number" min="1" max="100" Text="1" CssClass="qty-input"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtQty"
                        ErrorMessage="* Required" ForeColor="Red" Display="Dynamic" />
                </div>

                <div class="btn-group">
                    <asp:Button ID="btnAdd" runat="server" Text="Add to Cart" CssClass="add-btn" OnClick="btnAdd_Click" />
                    
                    <asp:Button ID="btnBack" runat="server" Text="Back to Shop" CssClass="back-btn" PostBackUrl="GroceryList.aspx" CausesValidation="false" />
                </div>

                <br />
                <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Font-Bold="true"></asp:Label>
            </div>

        </div>
    </form>
</body>
</html>
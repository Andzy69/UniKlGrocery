<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="Cart.aspx.cs"
    Inherits="ProductPage.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="max-width: 800px; margin: 50px auto; background: white; padding: 20px;
        border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);">

        <h2 style="text-align:center; color:#2ecc71;">My Shopping Cart</h2>
        <br />

        <asp:GridView ID="gvCart"
            runat="server"
            AutoGenerateColumns="False"
            CssClass="cart-table"
            EmptyDataText="Your cart is empty."
            GridLines="None"
            Width="100%"
            OnRowCommand="gvCart_RowCommand">

            <Columns>

                
                <asp:BoundField DataField="CartId" Visible="false" />

                <asp:BoundField
                    DataField="ProductName"
                    HeaderText="Product" />

                <asp:BoundField
                    DataField="Price"
                    HeaderText="Price (RM)"
                    DataFormatString="{0:0.00}" />

                <asp:BoundField
                    DataField="Quantity"
                    HeaderText="Qty" />

                <asp:BoundField
                    DataField="SubTotal"
                    HeaderText="Total (RM)"
                    DataFormatString="{0:0.00}" />

               
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton
                            ID="btnRemove"
                            runat="server"
                            Text="❌ Remove"
                            CommandName="RemoveItem"
                            CommandArgument='<%# Eval("CartId") %>'
                            ForeColor="Red"
                            Font-Bold="true"
                            OnClientClick="return confirm('Remove this item from cart?');" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

            <HeaderStyle BackColor="#2ecc71" ForeColor="White" Height="40px" />
            <RowStyle Height="35px" />

        </asp:GridView>

        <div style="text-align: right; margin-top: 20px;
            font-size: 24px; font-weight: bold;">
            Total:
            <asp:Label ID="lblGrandTotal" runat="server" Text="RM 0.00"></asp:Label>
        </div>

        <div style="text-align: right; margin-top: 20px;">
            <asp:Button ID="btnContinue"
                runat="server"
                Text="Continue Shopping"
                PostBackUrl="GroceryList.aspx"
                CssClass="back-btn" />

            <asp:Button ID="btnCheckout"
                runat="server"
                Text="Checkout"
                PostBackUrl="Checkout.aspx"
                CssClass="add-btn" />
        </div>

        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>

    </div>

</asp:Content>

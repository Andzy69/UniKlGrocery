<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="GroceryList.aspx.cs"
    Inherits="ProductPage.GroceryList1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="category-menu">
        <asp:SqlDataSource 
            ID="SqlDataSourceCategories"
            runat="server"
            ConnectionString="<%$ ConnectionStrings:GrocerieShop %>"
            SelectCommand="SELECT CatId, CatTitle FROM Categories">
        </asp:SqlDataSource>
        <p>
            Select Category to shop:
            <asp:DropDownList 
                ID="DropDownList1"
                runat="server"
                AutoPostBack="True"
                DataSourceID="SqlDataSourceCategories"
                DataTextField="CatTitle"
                DataValueField="CatId">
            </asp:DropDownList>
        </p>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceItems" runat="server"
        ConnectionString="<%$ ConnectionStrings:GrocerieShop %>"
        SelectCommand="
            SELECT ItemId, ItemTitle, ItemPrice, ItemImage
            FROM Items
            WHERE CatId = @CatId">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="CatId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="products-grid">
        <asp:Repeater 
            ID="Repeater1"
            runat="server"
            DataSourceID="SqlDataSourceItems">
            <ItemTemplate>
                <a href='GroceryDetails.aspx?id=<%# Eval("ItemId") %>'
                   class="product-card-link">
                    <div class="product-card">
                        <img 
                            src='<%# Eval("ItemImage") %>'
                            alt='<%# Eval("ItemTitle") %>'
                            class="product-img" />
                        <div class="product-title">
                            <%# Eval("ItemTitle") %>
                        </div>
                        <div class="product-price">
                            RM <%# Eval("ItemPrice", "{0:F2}") %>
                        </div>
                    </div>
                </a>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>

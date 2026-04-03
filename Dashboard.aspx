<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ProductPage.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Dashboard Overview</h1>
    <p>Welcome back, Admin.</p>
    <br />

    <div class="card-container">
        <div class="card">
            <h3>Total Sales</h3>
            <span>
                <asp:Label ID="lblTotalSales" runat="server" Text="RM 0.00" CssClass="green-text"></asp:Label>
            </span>
        </div>
        <div class="card">
            <h3>Total Orders</h3>
            <span>
                <asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label>
            </span>
        </div>
        <div class="card">
            <h3>Customers</h3>
            <span>
                <asp:Label ID="lblTotalCustomers" runat="server" Text="0"></asp:Label>
            </span>
        </div>
    </div>

    <div style="background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        <h3>Recent Transactions</h3>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GrocerieShop %>" SelectCommand="SELECT * FROM [Sales]"></asp:SqlDataSource>
        <br />
        <asp:GridView ID="gvRecent" runat="server" AutoGenerateColumns="False" Width="100%" 
            GridLines="None" CellPadding="10" CssClass="admin-table" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource1">
            <HeaderStyle BackColor="#2c3e50" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="SalesId" HeaderText="SalesId" SortExpression="SalesId" />
                <asp:BoundField DataField="ItemTitle" HeaderText="ItemTitle" SortExpression="ItemTitle" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                <asp:BoundField DataField="SalesDate" HeaderText="SalesDate" SortExpression="SalesDate" />
                <asp:CheckBoxField DataField="Confirmed" HeaderText="Confirmed" SortExpression="Confirmed" />
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
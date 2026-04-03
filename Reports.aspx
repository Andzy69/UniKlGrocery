<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="ProductPage.Admin.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Sales Report</h1>
    <p>Summary of transactions for today.</p>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GrocerieShop %>" SelectCommand="SELECT [SalesId], [Quantity], [Price], [SalesDate] FROM [Sales]"></asp:SqlDataSource>
    <br />

    <div style="background: white; padding: 20px; border-radius: 8px; border: 1px solid #ddd;">
        
        <h3>Sales Data</h3>
        
        <asp:GridView ID="gvReports" runat="server" AutoGenerateColumns="False" 
            Width="100%" CellPadding="10" GridLines="Horizontal" BorderColor="#EEEEEE" DataSourceID="SqlDataSource1">
            
            <HeaderStyle BackColor="#f8f9fa" Font-Bold="True" HorizontalAlign="Left" />
            <RowStyle Height="40px" BorderColor="#eeeeee" />

            <Columns>
                <asp:BoundField DataField="SalesId" HeaderText="SalesId" SortExpression="SalesId" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                <asp:BoundField DataField="SalesDate" HeaderText="SalesDate" SortExpression="SalesDate" />
            </Columns>

        </asp:GridView>

        <br />
        <div style="text-align:right; font-weight:bold; font-size:18px;">
            <asp:Label ID="lblGrandTotal" runat="server" Text="RM 0.00"></asp:Label>
        </div>

    </div>
</asp:Content>

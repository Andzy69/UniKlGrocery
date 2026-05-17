<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ProductPage.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .filter-bar {
            background: white;
            padding: 20px 25px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 24px;
            display: flex;
            flex-direction: row;
            align-items: flex-end;
            gap: 16px;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;

            flex-direction: column;
            gap: 5px;
        }

        .filter-label {
            font-size: 12px;
            font-weight: 600;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .filter-group select,
        .filter-group input[type="date"] {
            padding: 9px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            color: #333;
            min-width: 170px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: white;
        }

        .filter-group select:focus,
        .filter-group input[type="date"]:focus {
            outline: none;
            border-color: #2c3e50;
        }

        .filter-divider {
            width: 1px;
            height: 38px;
            background: #eee;
            align-self: flex-end;
        }

        .filter-actions {
            display: flex;
            flex-direction: row;
            gap: 8px;
            align-self: flex-end;
        }

        .btn-apply {
            padding: 9px 22px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            transition: background 0.2s;
        }

        .btn-apply:hover { background-color: #1a252f; }

        .btn-reset {
            padding: 9px 22px;
            background-color: #ecf0f1;
            color: #555;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            transition: background 0.2s;
        }

        .btn-reset:hover { background-color: #c8cccf; }

        .green-text { color: #27ae60; }

        .transactions-box {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .transactions-box h3 {
            margin-top: 0;
            color: #2c3e50;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Dashboard Overview</h1>
    <p>Welcome back, Admin.</p>
    <br />

    <%-- ── Filter Bar ── --%>
    <div class="filter-bar">

        <div class="filter-group">
            <span class="filter-label">Category</span>
            <asp:DropDownList ID="ddlCategory" runat="server" />
        </div>

        <div class="filter-divider"></div>

        <div class="filter-group">
            <span class="filter-label">Date From</span>
            <asp:TextBox ID="txtDateFrom" runat="server" TextMode="Date" />
        </div>

        <div class="filter-group">
            <span class="filter-label">Date To</span>
            <asp:TextBox ID="txtDateTo" runat="server" TextMode="Date" />
        </div>

        <div class="filter-actions">
            <asp:Button ID="btnApply" runat="server" Text="Apply Filter"
                CssClass="btn-apply" OnClick="btnApply_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Reset"
                CssClass="btn-reset" OnClick="btnReset_Click" />
        </div>

    </div>

    <%-- ── Stat Cards ── --%>
    <div class="card-container">
        <div class="card">
            <h3>Total Sales</h3>
            <span>
                <asp:Label ID="lblTotalSales" runat="server" Text="RM 0.00" CssClass="green-text" />
            </span>
        </div>
        <div class="card">
            <h3>Total Orders</h3>
            <span>
                <asp:Label ID="lblTotalOrders" runat="server" Text="0" />
            </span>
        </div>
        <div class="card">
            <h3>Customers</h3>
            <span>
                <asp:Label ID="lblTotalCustomers" runat="server" Text="0" />
            </span>
        </div>
    </div>

    <%-- ── Recent Transactions ── --%>
    <div class="transactions-box">
        <h3>Recent Transactions</h3>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:GrocerieShop %>"
            SelectCommand="SELECT s.SalesId, s.ItemTitle, c.CatTitle, s.Quantity, s.Price, s.SalesDate, s.Confirmed FROM Sales s LEFT JOIN Items i ON s.ItemTitle = i.ItemTitle LEFT JOIN Categories c ON i.CatId = c.CatId">
        </asp:SqlDataSource>

        <br />
        <asp:GridView ID="gvRecent" runat="server"
            AutoGenerateColumns="False" Width="100%"
            GridLines="None" CellPadding="10"
            CssClass="admin-table"
            AllowPaging="True" AllowSorting="True"
            DataSourceID="SqlDataSource1">
            <HeaderStyle BackColor="#2c3e50" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="SalesId"      HeaderText="Order ID"   SortExpression="SalesId" />
                <asp:BoundField DataField="ItemTitle"    HeaderText="Item"        SortExpression="ItemTitle" />
                <asp:BoundField DataField="CatTitle"     HeaderText="Category"    SortExpression="CatTitle" />
                <asp:BoundField DataField="Quantity"     HeaderText="Qty"         SortExpression="Quantity" />
                <asp:BoundField DataField="Price"        HeaderText="Price (RM)"  SortExpression="Price"    DataFormatString="{0:0.00}" />
                <asp:BoundField DataField="SalesDate"    HeaderText="Date"        SortExpression="SalesDate" DataFormatString="{0:dd MMM yyyy}" />
                <asp:CheckBoxField DataField="Confirmed" HeaderText="Confirmed"   SortExpression="Confirmed" />
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>

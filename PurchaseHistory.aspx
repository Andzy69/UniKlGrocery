<%@ Page Title="Purchase History" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PurchaseHistory.aspx.cs" Inherits="ProductPage.PurchaseHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .history-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px 40px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .history-header { margin-bottom: 24px; }
        .history-header h2 { color: #2c3e50; font-size: 28px; font-weight: 700; margin: 0 0 6px; }
        .history-header p { color: #7f8c8d; font-size: 15px; margin: 0; }
        .order-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.07);
            margin-bottom: 20px;
            overflow: hidden;
            transition: box-shadow 0.2s ease;
        }
        .order-card:hover { box-shadow: 0 6px 20px rgba(0,0,0,0.12); }
        .order-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 22px;
            background: #f8f9fa;
            border-bottom: 1px solid #eee;
            cursor: pointer;
            user-select: none;
        }
        .order-meta { display: flex; gap: 24px; align-items: center; flex-wrap: wrap; }
        .order-id { font-weight: 700; color: #2c3e50; font-size: 15px; }
        .order-date { color: #7f8c8d; font-size: 13px; }
        .order-total { font-weight: 700; color: #27ae60; font-size: 16px; }
        .badge-confirmed {
            background: #d5f5e3; color: #1e8449;
            padding: 4px 10px; border-radius: 20px;
            font-size: 12px; font-weight: 600;
        }
        .chevron { color: #aaa; font-size: 18px; transition: transform 0.25s ease; }
        .chevron.open { transform: rotate(180deg); }
        .order-body { display: none; padding: 18px 22px; }
        .order-body.open { display: block; }
        .items-table { width: 100%; border-collapse: collapse; font-size: 14px; }
        .items-table th {
            text-align: left; padding: 10px 12px;
            background: #2c3e50; color: white; font-weight: 600;
        }
        .items-table td { padding: 10px 12px; border-bottom: 1px solid #f0f0f0; color: #555; }
        .items-table tr:last-child td { border-bottom: none; }
        .items-table tr:hover td { background: #f9fdf9; }
        .order-actions { display: flex; gap: 10px; margin-top: 14px; justify-content: flex-end; }
        .btn-return {
            background-color: #e74c3c; color: white;
            padding: 9px 18px; font-size: 13px; font-weight: 600;
            border: none; border-radius: 6px; cursor: pointer;
            text-decoration: none; display: inline-block;
            transition: background-color 0.2s ease;
        }
        .btn-return:hover { background-color: #c0392b; }
        .empty-state {
            text-align: center; padding: 60px 20px;
            background: white; border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.07);
        }
        .empty-state .icon { font-size: 56px; margin-bottom: 16px; }
        .empty-state h3 { color: #2c3e50; margin: 0 0 8px; font-size: 20px; }
        .empty-state p { color: #7f8c8d; margin: 0 0 24px; }
        .btn-shop {
            background-color: #27ae60; color: white;
            padding: 12px 28px; font-size: 15px; font-weight: 700;
            border: none; border-radius: 8px; cursor: pointer;
            text-decoration: none; display: inline-block;
            transition: background-color 0.2s ease;
        }
        .btn-shop:hover { background-color: #219150; }
        .summary-bar { display: flex; gap: 20px; margin-bottom: 24px; flex-wrap: wrap; }
        .summary-card {
            background: white; border-radius: 10px;
            padding: 16px 22px; box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            flex: 1; min-width: 140px;
        }
        .summary-card .label {
            font-size: 12px; font-weight: 600; color: #888;
            text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 6px;
        }
        .summary-card .value { font-size: 22px; font-weight: 700; color: #2c3e50; }
        .summary-card .value.green { color: #27ae60; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="history-container">
        <div class="history-header">
            <h2>My Purchase History</h2>
            <p>A summary of all your past orders.</p>
        </div>

        <div class="summary-bar">
            <div class="summary-card">
                <div class="label">Total Orders</div>
                <div class="value"><asp:Label ID="lblTotalOrders" runat="server" Text="0" /></div>
            </div>
            <div class="summary-card">
                <div class="label">Items Purchased</div>
                <div class="value"><asp:Label ID="lblTotalItems" runat="server" Text="0" /></div>
            </div>
            <div class="summary-card">
                <div class="label">Total Spent</div>
                <div class="value green"><asp:Label ID="lblTotalSpent" runat="server" Text="RM 0.00" /></div>
            </div>
        </div>

        <asp:Panel ID="pnlOrders" runat="server" />

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
            <div class="empty-state">
                <div class="icon">🛒</div>
                <h3>No orders yet</h3>
                <p>You haven't placed any orders. Start shopping now!</p>
                <a href="GroceryList.aspx" class="btn-shop">Browse Groceries</a>
            </div>
        </asp:Panel>
    </div>

    <script>
        function toggleOrder(id) {
            var body = document.getElementById('body-' + id);
            var chev = document.getElementById('chev-' + id);
            if (body.classList.contains('open')) {
                body.classList.remove('open');
                chev.classList.remove('open');
            } else {
                body.classList.add('open');
                chev.classList.add('open');
            }
        }
    </script>
</asp:Content>
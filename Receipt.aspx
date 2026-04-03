<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="Receipt.aspx.cs"
    Inherits="ProductPage.Receipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .header {
                text-align: center;
            }
        .receipt-box {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 10px;
            border-top: 5px solid #2ecc71;
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }
        .receipt-details {
            text-align: left;
            margin: 20px 0;
            line-height: 1.8;
        }
        @media print {
            .header, .back-btn, .add-btn {
                display: none;
            }
            .receipt-box {
                box-shadow: none;
                border: 1px solid #ddd;
            }
        }
    </style>
    <div class="header">
        <p>Sales Receipt</p>
    </div>

    <div class="receipt-box">

        <h2 style="color:#2ecc71;">Payment Successful</h2>
        <p>Thank you for shopping with us.</p>

        <hr />

        <div class="receipt-details">
            <p><strong>Receipt ID:</strong>
                <asp:Label ID="lblOrderID" runat="server" />
            </p>

            <p><strong>Date:</strong>
                <asp:Label ID="lblDate" runat="server" />
            </p>

            <p><strong>Customer:</strong>
                <asp:Label ID="lblName" runat="server" />
            </p>

            <p><strong>Info:</strong>
                <asp:Label ID="lblAddress" runat="server" />
            </p>
        </div>

        <hr />

        <h3>Items</h3>

        <asp:GridView
            ID="gvReceipt"
            runat="server"
            AutoGenerateColumns="False"
            GridLines="None"
            Width="100%">
            <Columns>
                <asp:BoundField DataField="ProductName" HeaderText="Item" />
                <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                <asp:BoundField DataField="SubTotal"
                    HeaderText="Total (RM)"
                    DataFormatString="{0:0.00}" />
            </Columns>
            <HeaderStyle Font-Bold="True" />
        </asp:GridView>

        <div style="text-align:right; font-size:20px; font-weight:bold; margin-top:20px;">
            Grand Total:
            <asp:Label ID="lblFinalTotal" runat="server"
                Text="RM 0.00"
                ForeColor="#2ecc71" />
        </div>

        <br />

        <button type="button" class="back-btn" onclick="window.print()">
            Print Receipt
        </button>

        <asp:Button
            ID="btnHome"
            runat="server"
            Text="New Order"
            PostBackUrl="GroceryList.aspx"
            CssClass="add-btn" />

    </div>

</asp:Content>

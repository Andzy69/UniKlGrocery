<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="Checkout.aspx.cs"
    Inherits="ProductPage.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .checkout-container {
            display: flex;
            gap: 30px;
            max-width: 900px;
            margin: 50px auto;
        }
        .box {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .left { flex: 2; }
        .right { flex: 1; text-align: center; }
        label { font-weight: bold; display: block; margin-top: 15px; }
        .form-control {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .btn-green {
            width: 100%;
            background: #2ecc71;
            color: white;
            border: none;
            padding: 15px;
            font-size: 18px;
            border-radius: 6px;
            margin-top: 25px;
            cursor: pointer;
        }
        .btn-back {
            background: #95a5a6;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 6px;
            width: 100%;
            cursor: pointer;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="checkout-container">

      
        <div class="box left">
            <h3>Shipping Details</h3>

            <label>Full Name</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
            <asp:RequiredFieldValidator runat="server"
                ControlToValidate="txtName"
                ErrorMessage="Required"
                ForeColor="Red" />

            <label>Phone Number</label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
            <asp:RequiredFieldValidator runat="server"
                ControlToValidate="txtPhone"
                ErrorMessage="Required"
                ForeColor="Red" />

            <label>Delivery Address</label>
            <asp:TextBox ID="txtAddress" runat="server"
                CssClass="form-control"
                TextMode="MultiLine"
                Rows="3" />
            <asp:RequiredFieldValidator runat="server"
                ControlToValidate="txtAddress"
                ErrorMessage="Required"
                ForeColor="Red" />

            <asp:Button
                ID="btnPlaceOrder"
                runat="server"
                Text="Confirm Order"
                CssClass="btn-green"
                OnClick="btnPlaceOrder_Click" />
        </div>

     
        <div class="box right">
            <h3>Order Summary</h3>
            <h1 style="color:#2ecc71;">
                <asp:Label ID="lblTotal" runat="server" Text="RM 0.00" />
            </h1>
            <p>Total Items:
                <asp:Label ID="lblCount" runat="server" Text="0" />
            </p>

            <asp:Button
                ID="btnBack"
                runat="server"
                Text="Back to Cart"
                CssClass="btn-back"
                PostBackUrl="Cart.aspx"
                CausesValidation="false" />
        </div>

    </div>

</asp:Content>

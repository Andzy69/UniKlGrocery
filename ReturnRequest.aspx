<%@ Page Title="Request Return" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReturnRequest.aspx.cs" Inherits="ProductPage.ReturnRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Request Item Return</h2>
    <p>Please fill out the form below to request a return for your item.</p>

    <div>
        <label>Select Item from Past Order:</label>
        <asp:DropDownList ID="ddlItems" runat="server" CssClass="form-control"></asp:DropDownList>
        
        <br /><br />
        
        <label>Reason for Return:</label>
        <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" Placeholder="e.g., Damaged on arrival, wrong item..."></asp:TextBox>
        
        <br /><br />
        
        <asp:Button ID="btnSubmitReturn" runat="server" Text="Submit Return Request" OnClick="btnSubmitReturn_Click" CssClass="btn-submit" />
        
        <br /><br />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>

    </div>
</asp:Content>
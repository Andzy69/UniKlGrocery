<%@ Page Title="Manage Returns" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminReturns.aspx.cs" Inherits="ProductPage.AdminReturns" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="transactions-box">
        <h1>Manage Return Requests</h1>
        <p>Review customer submitted return requests below:</p>
        <br />
<asp:GridView ID="gvReturns" runat="server" AutoGenerateColumns="False" 
            CssClass="admin-table" OnRowCommand="gvReturns_RowCommand" DataKeyNames="ReturnID" Width="100%" GridLines="None" CellPadding="10">
            <HeaderStyle BackColor="#2c3e50" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="ReturnID" HeaderText="Return ID" />
                <asp:BoundField DataField="SalesID" HeaderText="Order ID" />
                <asp:BoundField DataField="ItemID" HeaderText="Item ID" />
                <asp:BoundField DataField="Reason" HeaderText="Reason for Return" />
                <asp:BoundField DataField="Status" HeaderText="Current Status" />
                <asp:BoundField DataField="RequestDate" HeaderText="Date Requested" DataFormatString="{0:dd MMM yyyy}" />
                
                <asp:TemplateField HeaderText="Proof of Damage">
                    <ItemTemplate>
                        <asp:HyperLink ID="hlImage" runat="server" 
                                       NavigateUrl='<%# Eval("ImagePath") %>' 
                                       Target="_blank"
                                       Visible='<%# Eval("ImagePath") != DBNull.Value && !string.IsNullOrEmpty(Eval("ImagePath").ToString()) %>'>
                            <asp:Image ID="imgProof" runat="server" 
                                       ImageUrl='<%# Eval("ImagePath") %>' 
                                       Width="80px" 
                                       Style="border-radius: 4px; border: 1px solid #ccc;" />
                        </asp:HyperLink>

                        <asp:Label ID="lblNoImage" runat="server" 
                                   Text="No Image" 
                                   ForeColor="Gray" Font-Italic="true" Font-Size="Small"
                                   Visible='<%# Eval("ImagePath") == DBNull.Value || string.IsNullOrEmpty(Eval("ImagePath").ToString()) %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnApprove" runat="server" Text="Approve" CommandName="ApproveReturn" 
                                    CommandArgument='<%# Eval("ReturnID") %>' CssClass="btn-apply" style="background-color: #27ae60;" />
                        &nbsp;
                        <asp:Button ID="btnReject" runat="server" Text="Reject" CommandName="RejectReturn" 
                                    CommandArgument='<%# Eval("ReturnID") %>' CssClass="btn-reset" style="background-color: #c0392b; color: white;" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <br />
        <asp:Label ID="lblAdminMessage" runat="server" ForeColor="#2c3e50" Font-Bold="true"></asp:Label>
    </div>
</asp:Content>
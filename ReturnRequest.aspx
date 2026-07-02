<%@ Page Title="Request Return" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReturnRequest.aspx.cs" Inherits="ProductPage.ReturnRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Card Container */
        .return-container {
            max-width: 550px;
            margin: 50px auto;
            padding: 40px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Header Styling */
        .return-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .return-header h2 {
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 28px;
            font-weight: 700;
        }
        .return-header p {
            color: #7f8c8d;
            font-size: 15px;
            margin: 0;
        }

        /* Form Layout */
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #34495e;
            font-size: 14px;
        }

        /* Input Controls */
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #dcdde1;
            border-radius: 8px;
            font-size: 14px;
            color: #2f3640;
            box-sizing: border-box; /* Ensures padding doesn't break width */
            transition: all 0.3s ease;
            background-color: #fcfcfc;
        }
        .form-control:focus {
            border-color: #27ae60;
            background-color: #ffffff;
            outline: none;
            box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.15);
        }

        /* Submit Button */
        .btn-submit {
            width: 100%;
            background-color: #27ae60; /* Fresh Grocery Green */
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s ease;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background-color: #219150;
        }
        .btn-submit:active {
            transform: scale(0.98);
        }

        /* Success/Error Message */
        .msg-label {
            display: block;
            text-align: center;
            margin-top: 20px;
            font-weight: 600;
            font-size: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="return-container">
        
        <div class="return-header">
            <h2>Request Item Return</h2>
            <p>Not satisfied with your order? Let us know and we'll make it right.</p>
        </div>

        <div class="form-group">
            <label>Select Item from Past Order:</label>
            <asp:DropDownList ID="ddlItems" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>
        
       <div class="form-group">
            <label>Reason for Return:</label>
            <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" Placeholder="e.g., Damaged on arrival, wrong item delivered..."></asp:TextBox>
            
            <asp:RequiredFieldValidator ID="rfvReason" runat="server" 
                ControlToValidate="txtReason" 
                ErrorMessage="Reason for return is required." 
                ForeColor="#c0392b" 
                Display="Dynamic" 
                Font-Size="13px" 
                Font-Bold="true"
                style="display: block; margin-top: 5px;">
            </asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label>Upload Proof of Damage (Optional):</label>
            <asp:FileUpload ID="fuReturnImage" runat="server" CssClass="form-control" accept=".png,.jpg,.jpeg" onchange="previewImage(this);" />
            
            <div id="previewContainer" style="margin-top: 15px; display: none; text-align: center; background: #fcfcfc; padding: 10px; border-radius: 8px; border: 1px dashed #dcdde1;">
                <p style="font-size: 13px; color: #7f8c8d; margin-bottom: 5px; font-weight: 600;">Image Preview:</p>
                <img id="imgPreview" style="max-width: 100%; max-height: 250px; border-radius: 4px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);" />
            </div>
        </div>
        
        <div class="form-group">
            <asp:Button ID="btnSubmitReturn" runat="server" Text="Submit Return Request" OnClick="btnSubmitReturn_Click" CssClass="btn-submit" />
        </div>
        
        <asp:Label ID="lblMessage" runat="server" CssClass="msg-label"></asp:Label>

    </div>

</asp:Content>

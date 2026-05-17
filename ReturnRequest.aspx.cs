using System;
using System.Data.SqlClient;
using System.Configuration;

namespace ProductPage
{
    public partial class ReturnRequest : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["GrocerieShop"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    PopulatePurchasedItems(Convert.ToInt32(Session["UserID"]));
                }
            }
        }

        private void PopulatePurchasedItems(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT SalesId, ItemTitle FROM Sales WHERE UserId = @UserId AND Confirmed = 1";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlItems.DataSource = reader;
                ddlItems.DataTextField = "ItemTitle";  
                ddlItems.DataValueField = "SalesId";    
                ddlItems.DataBind();
            }
        }

        protected void btnSubmitReturn_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlItems.SelectedValue))
            {
                lblMessage.Text = "No purchased items available to return.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string selectedSalesId = ddlItems.SelectedValue;
            string reason = txtReason.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string findIdQuery = "SELECT TOP 1 ItemId FROM Sales WHERE SalesId = @SalesId";
                SqlCommand findIdCmd = new SqlCommand(findIdQuery, conn);
                findIdCmd.Parameters.AddWithValue("@SalesId", selectedSalesId);

                object idResult = findIdCmd.ExecuteScalar();
                int itemId = idResult != DBNull.Value && idResult != null ? Convert.ToInt32(idResult) : 0;

                string insertQuery = @"INSERT INTO ReturnRequests (SalesID, ItemID, Reason, Status, RequestDate) 
                               VALUES (@SalesID, @ItemID, @Reason, 'Pending', @Date)";

                SqlCommand cmd = new SqlCommand(insertQuery, conn);
                cmd.Parameters.AddWithValue("@SalesID", selectedSalesId); 
                cmd.Parameters.AddWithValue("@ItemID", itemId);
                cmd.Parameters.AddWithValue("@Reason", reason);
                cmd.Parameters.AddWithValue("@Date", DateTime.Now);

                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Your return request has been submitted successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
            txtReason.Text = ""; 
        }
    }
}
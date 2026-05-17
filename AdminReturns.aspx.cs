using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace ProductPage
{
    public partial class AdminReturns : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["GrocerieShop"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Optional: Check if the logged-in user is actually an admin
                // if (Session["Role"] == null || Session["Role"].ToString() != "Admin") { Response.Redirect("Login.aspx"); }

                BindPendingReturns();
            }
        }

        private void BindPendingReturns()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Only pull requests that haven't been dealt with yet
                string query = "SELECT * FROM ReturnRequests WHERE Status = 'Pending' ORDER BY RequestDate DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvReturns.DataSource = dt;
                gvReturns.DataBind();
            }
        }

        protected void gvReturns_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int returnId = Convert.ToInt32(e.CommandArgument);
            string newStatus = "";

            if (e.CommandName == "ApproveReturn")
            {
                newStatus = "Approved";
            }
            else if (e.CommandName == "RejectReturn")
            {
                newStatus = "Rejected";
            }

            if (!string.IsNullOrEmpty(newStatus))
            {
                UpdateReturnStatus(returnId, newStatus);
                lblAdminMessage.Text = "Return Request #" + returnId + " has been successfully " + newStatus + "!";
                BindPendingReturns(); // Refresh the grid so the completed item disappears
            }
        }

        private void UpdateReturnStatus(int returnId, string status)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE ReturnRequests SET Status = @Status WHERE ReturnID = @ReturnID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@ReturnID", returnId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
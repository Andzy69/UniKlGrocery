using System;
using System.Configuration;
using System.Data.SqlClient;


namespace ProductPage
{
    public partial class Checkout : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["GrocerieShop"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                LoadSummary();
            }
        }

        void LoadSummary()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*), ISNULL(SUM(ItemPrice * Quantity),0) FROM Cart", con);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblCount.Text = dr[0].ToString();
                    lblTotal.Text = "RM " + Convert.ToDecimal(dr[1]).ToString("0.00");
                }
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            int currentUserId = Session["UserID"] != null ? Convert.ToInt32(Session["UserID"]) : 0;

            string salesId = "SALE-" + DateTime.Now.ToString("yyyyMMddHHmmss");
            Session["SalesId"] = salesId;
            Session["CustomerName"] = txtName.Text;
            Session["Phone"] = txtPhone.Text;
            Session["Address"] = txtAddress.Text;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand insertSales = new SqlCommand(@"
            INSERT INTO Sales (SalesId, ItemTitle, ItemId, Quantity, Price, SalesDate, Confirmed, UserId)
            SELECT 
                @SalesId,
                ItemTitle,
                ItemId,    -- Grabbing ItemId from Cart
                Quantity,
                ItemPrice,
                GETDATE(),
                1,
                @UserId    -- Grabbing the logged-in User's ID
            FROM Cart", con);

                insertSales.Parameters.AddWithValue("@SalesId", salesId);
                insertSales.Parameters.AddWithValue("@UserId", currentUserId);

                insertSales.ExecuteNonQuery();

                new SqlCommand("DELETE FROM Cart", con).ExecuteNonQuery();
            }
            Response.Redirect("Receipt.aspx");
        }
    }
}

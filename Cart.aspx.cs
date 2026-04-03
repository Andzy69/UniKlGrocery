using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace ProductPage
{
    public partial class Cart : System.Web.UI.Page
    {
        string cs = ConfigurationManager
                        .ConnectionStrings["GrocerieShop"]
                        .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(@"
                    SELECT 
                        CartId,
                        ItemTitle AS ProductName,
                        ItemPrice AS Price,
                        Quantity,
                        (ItemPrice * Quantity) AS SubTotal
                    FROM Cart", con);

                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCart.DataSource = dt;
                gvCart.DataBind();
                decimal grandTotal = 0;
                foreach (DataRow row in dt.Rows)
                {
                    grandTotal += Convert.ToDecimal(row["SubTotal"]);
                }

                lblGrandTotal.Text = "RM " + grandTotal.ToString("0.00");
            }
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RemoveItem")
            {
                int cartId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Cart WHERE CartId = @CartId", con);

                    cmd.Parameters.AddWithValue("@CartId", cartId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                LoadCart();
            }
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ProductPage
{
    public partial class Receipt : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["GrocerieShop"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                lblOrderID.Text = Session["SalesId"]?.ToString();
                lblDate.Text = DateTime.Now.ToString("dd MMM yyyy, hh:mm tt");
                lblName.Text = Session["CustomerName"]?.ToString();
                lblAddress.Text = Session["Phone"] + " | " + Session["Address"];

                LoadReceiptItems();
            }
        }

        void LoadReceiptItems()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Load items
                SqlCommand itemCmd = new SqlCommand(@"
            SELECT 
                ItemTitle AS ProductName,
                Quantity,
                (Price * Quantity) AS SubTotal
            FROM Sales
            WHERE SalesId = @SalesId", con);

                itemCmd.Parameters.AddWithValue("@SalesId", Session["SalesId"].ToString());

                gvReceipt.DataSource = itemCmd.ExecuteReader();
                gvReceipt.DataBind();
                con.Close();

                // Load total
                SqlCommand totalCmd = new SqlCommand(@"
            SELECT ISNULL(SUM(Price * Quantity),0)
            FROM Sales
            WHERE SalesId = @SalesId", con);

                totalCmd.Parameters.AddWithValue("@SalesId", Session["SalesId"].ToString());

                con.Open();
                decimal total = Convert.ToDecimal(totalCmd.ExecuteScalar());
                lblFinalTotal.Text = "RM " + total.ToString("0.00");
            }
        }

    }
}

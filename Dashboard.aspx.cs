using System;
using System.Configuration;
using System.Data.SqlClient;

namespace ProductPage.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["GrocerieShop"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardStats();
            }
        }

        void LoadDashboardStats()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        ISNULL(SUM(s.Price * s.Quantity), 0) AS TotalSales,
                        COUNT(DISTINCT s.SalesId) AS TotalOrders,
                        (SELECT COUNT(*) FROM Users WHERE Role = 'User') AS TotalCustomers
                    FROM Sales s
                    WHERE s.Confirmed = 1;
                ";

                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblTotalSales.Text = "RM " +
                        Convert.ToDecimal(dr["TotalSales"]).ToString("0.00");

                    lblTotalOrders.Text = dr["TotalOrders"].ToString();
                    lblTotalCustomers.Text = dr["TotalCustomers"].ToString();
                }
            }
        }
    }
}

using System;
using System.Configuration;
using System.Data.SqlClient;

namespace ProductPage.Admin
{
    public partial class Reports : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["GrocerieShop"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowReport();
                ShowGrandTotalToday();
            }
        }

        private void ShowReport()
        {

        }

        private void ShowGrandTotalToday()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT ISNULL(SUM(Price * Quantity), 0)
                    FROM Sales
                    WHERE 
                        Confirmed = 1
                        AND CAST(SalesDate AS DATE) = CAST(GETDATE() AS DATE)
                ";

                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();

                decimal totalToday = Convert.ToDecimal(cmd.ExecuteScalar());

                lblGrandTotal.Text =
                    $"Grand Total for Today ({DateTime.Now:dd/MM/yyyy}): RM {totalToday:0.00}";
            }
        }
    }
}

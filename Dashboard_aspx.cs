using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ProductPage.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["GroceriecsData"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadDashboardStats(catId: null, dateFrom: null, dateTo: null);
                ApplyGridFilter(catId: null, dateFrom: null, dateTo: null);
            }
        }

        // ── Populate dropdown from Categories (CatId, CatTitle) ───────────────
        void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT CatId, CatTitle FROM Categories ORDER BY CatTitle", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlCategory.Items.Clear();
                ddlCategory.Items.Add(
                    new System.Web.UI.WebControls.ListItem("All Categories", ""));

                foreach (DataRow row in dt.Rows)
                    ddlCategory.Items.Add(
                        new System.Web.UI.WebControls.ListItem(
                            row["CatTitle"].ToString(),
                            row["CatId"].ToString()));
            }
        }

        // ── Stat cards ────────────────────────────────────────────────────────
        // Sales → Items (ItemTitle) → Categories (CatId) to reach category filter
        void LoadDashboardStats(string catId, DateTime? dateFrom, DateTime? dateTo)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        ISNULL(SUM(s.Price * s.Quantity), 0)  AS TotalSales,
                        COUNT(DISTINCT s.SalesId)              AS TotalOrders,
                        (SELECT COUNT(*) FROM Users WHERE Role = 'User') AS TotalCustomers
                    FROM Sales s
                    LEFT JOIN Items i ON s.ItemTitle = i.ItemTitle
                    WHERE s.Confirmed = 1
                      AND (@CatId    IS NULL OR i.CatId = @CatId)
                      AND (@DateFrom IS NULL OR CAST(s.SalesDate AS DATE) >= @DateFrom)
                      AND (@DateTo   IS NULL OR CAST(s.SalesDate AS DATE) <= @DateTo);
                ";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CatId",
                    string.IsNullOrEmpty(catId) ? (object)DBNull.Value : (object)Convert.ToInt32(catId));
                cmd.Parameters.AddWithValue("@DateFrom",
                    dateFrom.HasValue ? (object)dateFrom.Value : DBNull.Value);
                cmd.Parameters.AddWithValue("@DateTo",
                    dateTo.HasValue ? (object)dateTo.Value : DBNull.Value);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblTotalSales.Text     = "RM " + Convert.ToDecimal(dr["TotalSales"]).ToString("0.00");
                    lblTotalOrders.Text    = dr["TotalOrders"].ToString();
                    lblTotalCustomers.Text = dr["TotalCustomers"].ToString();
                }
            }
        }

        // ── GridView filter via SqlDataSource ─────────────────────────────────
        void ApplyGridFilter(string catId, DateTime? dateFrom, DateTime? dateTo)
        {
            SqlDataSource1.SelectParameters.Clear();

            string where = "WHERE 1=1";

            if (!string.IsNullOrEmpty(catId))
            {
                where += " AND i.CatId = @CatId";
                SqlDataSource1.SelectParameters.Add(
                    new System.Web.UI.WebControls.Parameter("CatId", DbType.Int32, catId));
            }

            if (dateFrom.HasValue)
            {
                where += " AND CAST(s.SalesDate AS DATE) >= @DateFrom";
                SqlDataSource1.SelectParameters.Add(
                    new System.Web.UI.WebControls.Parameter("DateFrom", DbType.Date,
                        dateFrom.Value.ToString("yyyy-MM-dd")));
            }

            if (dateTo.HasValue)
            {
                where += " AND CAST(s.SalesDate AS DATE) <= @DateTo";
                SqlDataSource1.SelectParameters.Add(
                    new System.Web.UI.WebControls.Parameter("DateTo", DbType.Date,
                        dateTo.Value.ToString("yyyy-MM-dd")));
            }

            SqlDataSource1.SelectCommand =
                $@"SELECT s.SalesId, s.ItemTitle, c.CatTitle, s.Quantity, s.Price, s.SalesDate, s.Confirmed
                   FROM Sales s
                   LEFT JOIN Items i ON s.ItemTitle = i.ItemTitle
                   LEFT JOIN Categories c ON i.CatId = c.CatId
                   {where}";
        }

        // ── Read filter control values ────────────────────────────────────────
        void ReadFilters(out string catId, out DateTime? dateFrom, out DateTime? dateTo)
        {
            catId    = string.IsNullOrWhiteSpace(ddlCategory.SelectedValue)
                           ? null : ddlCategory.SelectedValue;
            dateFrom = DateTime.TryParse(txtDateFrom.Text, out DateTime df) ? df : (DateTime?)null;
            dateTo   = DateTime.TryParse(txtDateTo.Text,   out DateTime dt) ? dt : (DateTime?)null;
        }

        // ── Button handlers ───────────────────────────────────────────────────
        protected void btnApply_Click(object sender, EventArgs e)
        {
            ReadFilters(out string catId, out DateTime? dateFrom, out DateTime? dateTo);
            LoadDashboardStats(catId, dateFrom, dateTo);
            ApplyGridFilter(catId, dateFrom, dateTo);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlCategory.SelectedIndex = 0;
            txtDateFrom.Text = string.Empty;
            txtDateTo.Text   = string.Empty;

            LoadDashboardStats(null, null, null);
            ApplyGridFilter(null, null, null);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProductPage
{
    public partial class PurchaseHistory : Page
    {
        string cs = ConfigurationManager.ConnectionStrings["GrocerieShop"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
                LoadPurchaseHistory(Convert.ToInt32(Session["UserID"]));
        }

        private void LoadPurchaseHistory(int userId)
        {
            var orderIds = new List<string>();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"SELECT DISTINCT SalesId, MIN(SalesDate) AS OrderDate
                             FROM Sales WHERE UserId = @UserId
                             GROUP BY SalesId ORDER BY MIN(SalesDate) DESC";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read()) orderIds.Add(dr["SalesId"].ToString());
            }

            if (orderIds.Count == 0)
            {
                pnlOrders.Visible = false;
                pnlEmpty.Visible = true;
                return;
            }

            int totalItems = 0;
            decimal totalSpent = 0m;
            StringBuilder html = new StringBuilder();

            foreach (string saleId in orderIds)
            {
                string date = "";
                decimal orderTotal = 0m;
                var rows = new List<(string item, int qty, decimal price, decimal sub)>();

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string q = @"SELECT ItemTitle, Quantity, Price,
                                        (Price * Quantity) AS SubTotal, SalesDate
                                 FROM Sales WHERE SalesId = @SalesId AND UserId = @UserId";
                    SqlCommand cmd = new SqlCommand(q, con);
                    cmd.Parameters.AddWithValue("@SalesId", saleId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        if (string.IsNullOrEmpty(date))
                            date = Convert.ToDateTime(dr["SalesDate"]).ToString("dd MMM yyyy, hh:mm tt");
                        int qty = Convert.ToInt32(dr["Quantity"]);
                        decimal price = Convert.ToDecimal(dr["Price"]);
                        decimal sub = Convert.ToDecimal(dr["SubTotal"]);
                        rows.Add((dr["ItemTitle"].ToString(), qty, price, sub));
                        orderTotal += sub;
                        totalItems += qty;
                    }
                }

                totalSpent += orderTotal;
                string cardId = System.Text.RegularExpressions.Regex.Replace(saleId, @"[^a-zA-Z0-9]", "");

                html.AppendFormat(@"
                <div class='order-card'>
                    <div class='order-card-header' onclick=""toggleOrder('{0}')"">
                        <div class='order-meta'>
                            <span class='order-id'>#{1}</span>
                            <span class='order-date'>📅 {2}</span>
                            <span class='order-total'>RM {3:0.00}</span>
                            <span class='badge-confirmed'>✓ Confirmed</span>
                        </div>
                        <span class='chevron' id='chev-{0}'>▼</span>
                    </div>
                    <div class='order-body' id='body-{0}'>
                        <table class='items-table'>
                            <tr>
                                <th>Item</th><th>Qty</th>
                                <th>Unit Price (RM)</th><th>Subtotal (RM)</th>
                            </tr>",
                    cardId, saleId, date, orderTotal);

                foreach (var r in rows)
                    html.AppendFormat("<tr><td>{0}</td><td>{1}</td><td>{2:0.00}</td><td>{3:0.00}</td></tr>",
                        System.Web.HttpUtility.HtmlEncode(r.item), r.qty, r.price, r.sub);

                html.Append(@"
                        </table>
                        <div class='order-actions'>
                            <a href='ReturnRequest.aspx' class='btn-return'>Request Return</a>
                        </div>
                    </div>
                </div>");
            }

            var lit = new Literal { Text = html.ToString() };
            pnlOrders.Controls.Add(lit);

            lblTotalOrders.Text = orderIds.Count.ToString();
            lblTotalItems.Text = totalItems.ToString();
            lblTotalSpent.Text = "RM " + totalSpent.ToString("0.00");
        }
    }
}
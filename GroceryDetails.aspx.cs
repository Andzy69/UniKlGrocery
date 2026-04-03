using System;
using System.Configuration;
using System.Data.SqlClient;

namespace ProductPage
{
    public partial class GroceryDetails1 : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["GrocerieShop"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProduct();
            }
        }
        void LoadProduct()
        {
            if (Request.QueryString["id"] == null)
                return;
            int itemId = int.Parse(Request.QueryString["id"]);
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT ItemTitle, ItemPrice, ItemImage 
                                 FROM Items 
                                 WHERE ItemId = @ItemId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ItemId", itemId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblName.Text = dr["ItemTitle"].ToString();
                    lblPrice.Text = "RM " + Convert.ToDecimal(dr["ItemPrice"]).ToString("0.00");
                    imgProduct.ImageUrl = dr["ItemImage"].ToString();
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            int itemId = int.Parse(Request.QueryString["id"]);
            int qty = int.Parse(txtQty.Text);
            string title = lblName.Text;
            decimal price = decimal.Parse(lblPrice.Text.Replace("RM", ""));
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO Cart (ItemId, ItemTitle, ItemPrice, Quantity)
                                 VALUES (@ItemId, @Title, @Price, @Qty)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ItemId", itemId);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@Qty", qty);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            Response.Redirect("Cart.aspx");
        }
    }
}

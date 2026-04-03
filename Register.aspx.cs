using System;
using System.Configuration;
using System.Data.SqlClient;

namespace ProductPage
{
    public partial class Register : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["GrocerieShop"].ConnectionString;

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtRegisterUser.Text.Trim();
            string password = txtRegPass.Text.Trim();
            string confirm = txtConfirmPass.Text.Trim();
            if (username == "" || password == "" || confirm == "")
            {
                lblMsg.Text = "All fields are required.";
                return;
            }
            if (password != confirm)
            {
                lblMsg.Text = "Passwords do not match.";
                return;
            }
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                // Check if username already exists
                SqlCommand checkCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Username = @u", con);

                checkCmd.Parameters.AddWithValue("@u", username);

                int exists = (int)checkCmd.ExecuteScalar();
                if (exists > 0)
                {
                    lblMsg.Text = "Username already exists.";
                    return;
                }
                // Insert new user to database
                SqlCommand insertCmd = new SqlCommand(
                    "INSERT INTO Users (Username, Password) VALUES (@u, @p)", con);

                insertCmd.Parameters.AddWithValue("@u", username);
                insertCmd.Parameters.AddWithValue("@p", password);

                insertCmd.ExecuteNonQuery();
            }
            Response.Redirect("Login.aspx");
        }
    }
}

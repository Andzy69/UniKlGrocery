using System;
using System.Web.UI;

namespace ProductPage
{
    public partial class GroceryList1 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}

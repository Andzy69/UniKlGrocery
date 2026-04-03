using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProductPage
{
    public partial class GroceryDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1. Check if ID exists in URL to avoid errors
                if (Request.QueryString["id"] != null)
                {
                    int id;
                    // Try to parse the ID. If successful, load the product.
                    if (int.TryParse(Request.QueryString["id"], out id))
                    {
                        LoadProductData(id);
                    }
                }
                else
                {
                    // Redirect back to shop if no ID is found
                    Response.Redirect("GroceryList.aspx");
                }
            }
        }

        private void LoadProductData(int id)
        {
            switch (id)
            {
                // --- FRUITS (1-10) ---
                case 1: SetInfo("Apple", "3.00", "Images/apple.jpg"); break;
                case 2: SetInfo("Banana", "2.50", "Images/banana.jpg");
                    imgProduct.Attributes.Add("style", "width:400px; height:400px; object-fit:contain;"); break;
                case 3: SetInfo("Orange", "3.20", "Images/orange.jpg"); break;
                case 4: SetInfo("Grape", "4.00", "Images/grape.jpg"); break;
                case 5: SetInfo("Mango", "5.00", "Images/mango.jpg"); break;
                case 6: SetInfo("Pear", "3.80", "Images/pear.jpg"); break;
                case 7: SetInfo("Pineapple", "4.50", "Images/pineapple.jpg"); break;
                case 8: SetInfo("Watermelon", "6.00", "Images/watermelon.jpg"); break;
                case 9: SetInfo("Strawberry", "7.00", "Images/strawberry.jpg"); break;
                case 10: SetInfo("Kiwi", "5.50", "Images/kiwi.jpg"); break;

                // --- VEGETABLES (11-19) ---
                case 11: SetInfo("Carrot", "2.00", "Images/carrot.jpg"); break;
                case 12: SetInfo("Broccoli", "4.50", "Images/broccoli.jpg"); break;
                case 13: SetInfo("Potato", "3.00", "Images/potato.jpg"); break;
                case 14: SetInfo("Spinach", "2.50", "Images/spinach.jpg"); break;
                case 15: SetInfo("Tomato", "3.20", "Images/tomato.jpg"); break;
                case 16: SetInfo("Cucumber", "1.80", "Images/cucumber.jpg"); break;
                case 17: SetInfo("Lettuce", "3.50", "Images/lettuce.jpg"); break;
                case 18: SetInfo("Cabbage", "4.00", "Images/cabbage.jpg"); break;
                case 19: SetInfo("Onion", "2.20", "Images/onion.jpg"); break;

                // --- FROZEN MEAT (20-28) ---
                case 20: SetInfo("Frozen Whole Chicken", "13.90", "Images/frozen_chicken.jpg"); break;
                case 21: SetInfo("Chicken Nuggets (1kg)", "18.50", "Images/nuggets.jpg"); break;
                case 22: SetInfo("Ramly Chicken Burger (10pcs)", "15.20", "Images/ramly_burger.jpg");
                    imgProduct.Attributes.Add("style", "width:400px; height:400px; object-fit:contain;"); break;
                case 23: SetInfo("Chicken Frankfurters", "9.00", "Images/frankfurter.jpg"); break;
                case 24: SetInfo("Minced Beef (400g)", "10.50", "Images/minced_meat.jpg");
                    imgProduct.Attributes.Add("style", "width:400px; height:400px; object-fit:contain;"); break;
                case 25: SetInfo("Beef Meatballs", "16.00", "Images/meatballs.jpg"); break;
                case 26: SetInfo("Popcorn Chicken", "17.90", "Images/popcorn_chicken.jpg"); break;
                case 27: SetInfo("Lamb Slices (Frozen)", "24.00", "Images/lamb_slices.jpg"); break;
                case 28: SetInfo("Frozen Ribeye Shabu Slices", "21.50", "Images/shabu_frozen.jpg"); break;

                // --- SNACKS (29-35) ---
                case 29: SetInfo("Maggi 2-Min Curry (5pk)", "5.50", "Images/maggi_curry.jpg");
                    imgProduct.Attributes.Add("style", "width:400px; height:400px; object-fit:contain;"); break;
                case 30: SetInfo("Mister Potato Crisps", "4.20", "Images/mister_potato.jpg"); break;
                case 31: SetInfo("Hup Seng Cream Crackers", "5.90", "Images/hup_seng.jpg"); break;
                case 32: SetInfo("Chipsmore Original", "3.80", "Images/chipsmore.jpg"); break;
                case 33: SetInfo("Twisties BBQ", "2.50", "Images/twisties.jpg"); break;
                case 34: SetInfo("Mamee Monster (Pack)", "3.50", "Images/mamee_monster.jpg"); break;
                case 35: SetInfo("Super Ring Cheese", "2.80", "Images/super_ring.jpg"); break;

                default:
                    lblName.Text = "Item Not Found";
                    lblPrice.Text = "-";
                    btnAdd.Enabled = false;
                    break;
            }
        }

        // Helper method to keep code clean
        private void SetInfo(string name, string price, string imageUrl)
        {
            lblName.Text = name;
            lblPrice.Text = "RM " + price;
            imgProduct.ImageUrl = imageUrl;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            //  Retrieve the existing cart or create a new one
            List<string> cart = Session["Cart"] as List<string>;
            if (cart == null)
            {
                cart = new List<string>();
            }


            // Adding price details makes it easier to calculate totals later
            string itemDetails = string.Format("{0} ({1}) x {2}", lblName.Text, lblPrice.Text, txtQty.Text);


            // 3. Add to list and save back to Session
            cart.Add(itemDetails);
            Session["Cart"] = cart;

   
            lblMessage.Text = "Successfully added to cart!";
            // txtQty.Text = "1"; // Reset quantity if desired
        }
    }
}
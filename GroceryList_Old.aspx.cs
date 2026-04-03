using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProductPage
{
    public partial class GroceryList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowFruits();
            }
        }

        void HideAll()
        {
            pnlFruits.Visible = false;
            pnlVegetables.Visible = false;
            pnlMeat.Visible = false;
            pnlSnacks.Visible = false;
        }

        void ShowFruits()
        {
            HideAll();
            pnlFruits.Visible = true;
        }

        protected void btnFruits_Click(object sender, EventArgs e)
        {
            ShowFruits();
        }

        protected void btnVegetables_Click(object sender, EventArgs e)
        {
            HideAll();
            pnlVegetables.Visible = true;
        }

        protected void btnMeat_Click(object sender, EventArgs e)
        {
            HideAll();
            pnlMeat.Visible = true;
        }

        protected void btnSnacks_Click(object sender, EventArgs e)
        {
            HideAll();
            pnlSnacks.Visible = true;
        }
    }
}
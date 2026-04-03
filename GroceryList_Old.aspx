<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroceryList_Old.aspx.cs" Inherits="ProductPage.GroceryList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UniKL Grocery Store</title>
    <link href="StyleSheet1.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="header">
            <h1>UniKL Grocery Store</h1>
            <p>Fresh & Daily Groceries</p>
        </div>

        <!-- CATEGORY MENU -->
        <div class="category-menu">
            <asp:Button ID="btnFruits" runat="server" Text="Fruits"
        CssClass="cat-btn" OnClick="btnFruits_Click" />
            <asp:Button ID="btnVegetables" runat="server" Text="Vegetables"
        CssClass="cat-btn" OnClick="btnVegetables_Click" />
            <asp:Button ID="btnMeat" runat="server" Text="Meat"
        CssClass="cat-btn" OnClick="btnMeat_Click" />
            <asp:Button ID="btnSnacks" runat="server" Text="Snacks"
        CssClass="cat-btn" OnClick="btnSnacks_Click" />
    </div>


    <!-- FRUITS SECTION -->

       <div class="product-row">

    <asp:Panel ID="pnlFruits" runat="server" CssClass="products-grid">
        
        <div class="product-item">
            <asp:ImageButton CssClass="product-img" ImageUrl="Images/apple.jpg" 
                PostBackUrl="GroceryDetails.aspx?id=1" runat="server" />
            <div class="product-label">
                <asp:Label Text="Apple - RM3.00" runat="server" />
            </div>
        </div>

        <div class="product-item">
            <asp:ImageButton CssClass="product-img" ImageUrl="Images/banana2.jpg"
                PostBackUrl="GroceryDetails.aspx?id=2" runat="server" />
            <div class="product-label">
                <asp:Label Text="Banana - RM2.50" runat="server" />
            </div>
        </div>

        <div class="product-item">
            <asp:ImageButton CssClass="product-img" ImageUrl="Images/orange.jpg"
                PostBackUrl="GroceryDetails.aspx?id=3" runat="server" />
            <div class="product-label">
                <asp:Label Text="Orange - RM3.20" runat="server" />
            </div>
        </div>

        <div class="product-item">
            <asp:ImageButton CssClass="product-img" ImageUrl="Images/grape.jpg"
                PostBackUrl="GroceryDetails.aspx?id=4" runat="server" />
            <div class="product-label">
                <asp:Label Text="Grape - RM4.00" runat="server" />
            </div>
        </div>

        <div class="product-item">
            <asp:ImageButton CssClass="product-img" ImageUrl="Images/mango.jpg"
                PostBackUrl="GroceryDetails.aspx?id=5" runat="server" />
            <div class="product-label">
                <asp:Label Text="Mango - RM5.00" runat="server" />
            </div>
        </div>

        <div class="product-item">
            <asp:ImageButton CssClass="product-img" ImageUrl="Images/pear.jpg"
                PostBackUrl="GroceryDetails.aspx?id=6" runat="server" />
            <div class="product-label">
                <asp:Label Text="Pear - RM3.80" runat="server" />
            </div>
        </div>

        <div class="product-item">
            <asp:ImageButton CssClass="product-img" ImageUrl="Images/pineapple.jpg"
                PostBackUrl="GroceryDetails.aspx?id=7" runat="server" />
            <div class="product-label">
                <asp:Label Text="Pineapple - RM4.50" runat="server" />
            </div>
        </div>

        <div class="product-item">
            <asp:ImageButton CssClass="product-img" ImageUrl="Images/watermelon.jpg"
                PostBackUrl="GroceryDetails.aspx?id=8" runat="server" />
            <div class="product-label">
                <asp:Label Text="Watermelon - RM6.00" runat="server" />
            </div>
        </div>

        <div class="product-item">
            <asp:ImageButton CssClass="product-img" ImageUrl="Images/strawberry.jpg"
                PostBackUrl="GroceryDetails.aspx?id=9" runat="server" />
            <div class="product-label">
                <asp:Label Text="Strawberry - RM7.00" runat="server" />
            </div>
        </div>

        <div class="product-item">
            <asp:ImageButton CssClass="product-img" ImageUrl="Images/kiwi.jpg"
                PostBackUrl="GroceryDetails.aspx?id=10" runat="server" />
            <div class="product-label">
                <asp:Label Text="Kiwi - RM5.50" runat="server" />
            </div>
        </div>

    </asp:Panel>


    <!-- VEGETABLES SECTION -->

    <asp:Panel ID="pnlVegetables" runat="server" CssClass="products-grid">

    <div class="product-item">
        <asp:ImageButton ID="btnCarrot" runat="server" CssClass="product-img" 
            ImageUrl="Images/carrot.jpg" PostBackUrl="GroceryDetails.aspx?id=11" />
        <div class="product-info">
            <asp:Label ID="lblCarrot" runat="server" Text="Carrot - RM2.00"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnBroccoli" runat="server" CssClass="product-img" 
            ImageUrl="Images/broccoli.jpg" PostBackUrl="GroceryDetails.aspx?id=12" />
        <div class="product-info">
            <asp:Label ID="lblBroccoli" runat="server" Text="Broccoli - RM4.50"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnPotato" runat="server" CssClass="product-img" 
            ImageUrl="Images/potato.jpg" PostBackUrl="GroceryDetails.aspx?id=13" />
        <div class="product-info">
            <asp:Label ID="lblPotato" runat="server" Text="Potato - RM3.00"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnSpinach" runat="server" CssClass="product-img" 
            ImageUrl="Images/spinach.jpg" PostBackUrl="GroceryDetails.aspx?id=14" />
        <div class="product-info">
            <asp:Label ID="lblSpinach" runat="server" Text="Spinach - RM2.50"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnTomato" runat="server" CssClass="product-img" 
            ImageUrl="Images/tomato.jpg" PostBackUrl="GroceryDetails.aspx?id=15" />
        <div class="product-info">
            <asp:Label ID="lblTomato" runat="server" Text="Tomato - RM3.20"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnCucumber" runat="server" CssClass="product-img" 
            ImageUrl="Images/cucumber.jpg" PostBackUrl="GroceryDetails.aspx?id=16" />
        <div class="product-info">
            <asp:Label ID="lblCucumber" runat="server" Text="Cucumber - RM1.80"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnLettuce" runat="server" CssClass="product-img" 
            ImageUrl="Images/lettuce.jpg" PostBackUrl="GroceryDetails.aspx?id=17" />
        <div class="product-info">
            <asp:Label ID="lblLettuce" runat="server" Text="Lettuce - RM3.50"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnCabbage" runat="server" CssClass="product-img" 
            ImageUrl="Images/cabbage.jpg" PostBackUrl="GroceryDetails.aspx?id=18" />
        <div class="product-info">
            <asp:Label ID="lblCabbage" runat="server" Text="Cabbage - RM4.00"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnOnion" runat="server" CssClass="product-img" 
            ImageUrl="Images/onion.jpg" PostBackUrl="GroceryDetails.aspx?id=19" />
        <div class="product-info">
            <asp:Label ID="lblOnion" runat="server" Text="Onion - RM2.20"></asp:Label>
        </div>
    </div>

</asp:Panel>
               


    <!-- MEAT SECTION -->

    <asp:Panel ID="pnlMeat" runat="server" CssClass="products-grid">

    <div class="product-item">
        <asp:ImageButton ID="btnFrozenChicken" runat="server" CssClass="product-img" 
            ImageUrl="Images/frozen_chicken.jpg" PostBackUrl="GroceryDetails.aspx?id=20" />
        <div class="product-info">
            <asp:Label ID="lblFrozenChicken" runat="server" Text="Frozen Whole Chicken - RM13.90"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnNuggets" runat="server" CssClass="product-img" 
            ImageUrl="Images/nuggets.jpg" PostBackUrl="GroceryDetails.aspx?id=21" />
        <div class="product-info">
            <asp:Label ID="lblNuggets" runat="server" Text="Chicken Nuggets (1kg) - RM18.50"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnRamlyBurger" runat="server" CssClass="product-img" 
            ImageUrl="Images/ramly_burger.jpg" PostBackUrl="GroceryDetails.aspx?id=22" />
        <div class="product-info">
            <asp:Label ID="lblRamlyBurger" runat="server" Text="Chicken Burger (10pcs) - RM15.20"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnFrankfurter" runat="server" CssClass="product-img" 
            ImageUrl="Images/frankfurter.jpg" PostBackUrl="GroceryDetails.aspx?id=23" />
        <div class="product-info">
            <asp:Label ID="lblFrankfurter" runat="server" Text="Chicken Frankfurters - RM9.00"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnMincedFrozen" runat="server" CssClass="product-img" 
            ImageUrl="Images/minced_meat.jpg" PostBackUrl="GroceryDetails.aspx?id=24" />
        <div class="product-info">
            <asp:Label ID="lblMincedFrozen" runat="server" Text="Minced Beef (400g) - RM10.50"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnMeatballs" runat="server" CssClass="product-img" 
            ImageUrl="Images/meatballs.jpg" PostBackUrl="GroceryDetails.aspx?id=25" />
        <div class="product-info">
            <asp:Label ID="lblMeatballs" runat="server" Text="Beef Meatballs - RM16.00"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnPopcorn" runat="server" CssClass="product-img" 
            ImageUrl="Images/popcorn_chicken.jpg" PostBackUrl="GroceryDetails.aspx?id=26" />
        <div class="product-info">
            <asp:Label ID="lblPopcorn" runat="server" Text="Popcorn Chicken - RM17.90"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnLambSlices" runat="server" CssClass="product-img" 
            ImageUrl="Images/lamb_slices.jpg" PostBackUrl="GroceryDetails.aspx?id=27" />
        <div class="product-info">
            <asp:Label ID="lblLambSlices" runat="server" Text="Lamb Slices (Frozen) - RM24.00"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnShabu" runat="server" CssClass="product-img" 
            ImageUrl="Images/shabu_frozen.jpg" PostBackUrl="GroceryDetails.aspx?id=28" />
        <div class="product-info">
            <asp:Label ID="lblShabu" runat="server" Text="Frozen Ribeye Shabu Slices - RM21.50"></asp:Label>
        </div>
    </div>

</asp:Panel>



    <!-- SNACKS SECTION -->
    <asp:Panel ID="pnlSnacks" runat="server" CssClass="products-grid">

    <div class="product-item">
        <asp:ImageButton ID="btnMaggi" runat="server" CssClass="product-img" 
            ImageUrl="Images/maggi_curry.jpg" PostBackUrl="GroceryDetails.aspx?id=29" />
        <div class="product-info">
            <asp:Label ID="lblMaggi" runat="server" Text="Maggi 2-Min Curry (5pk) - RM5.50"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnMisterPotato" runat="server" CssClass="product-img" 
            ImageUrl="Images/mister_potato.jpg" PostBackUrl="GroceryDetails.aspx?id=30" />
        <div class="product-info">
            <asp:Label ID="lblMisterPotato" runat="server" Text="Mister Potato Crisps - RM4.20"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnHupSeng" runat="server" CssClass="product-img" 
            ImageUrl="Images/hup_seng.jpg" PostBackUrl="GroceryDetails.aspx?id=31" />
        <div class="product-info">
            <asp:Label ID="lblHupSeng" runat="server" Text="Hup Seng Cream Crackers - RM5.90"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnChipsmore" runat="server" CssClass="product-img" 
            ImageUrl="Images/chipsmore.jpg" PostBackUrl="GroceryDetails.aspx?id=32" />
        <div class="product-info">
            <asp:Label ID="lblChipsmore" runat="server" Text="Chipsmore Original - RM3.80"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnTwisties" runat="server" CssClass="product-img" 
            ImageUrl="Images/twisties.jpg" PostBackUrl="GroceryDetails.aspx?id=33" />
        <div class="product-info">
            <asp:Label ID="lblTwisties" runat="server" Text="Twisties BBQ - RM2.50"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnMamee" runat="server" CssClass="product-img" 
            ImageUrl="Images/mamee_monster.jpg" PostBackUrl="GroceryDetails.aspx?id=34" />
        <div class="product-info">
            <asp:Label ID="lblMamee" runat="server" Text="Mamee Monster (Pack) - RM3.50"></asp:Label>
        </div>
    </div>

    <div class="product-item">
        <asp:ImageButton ID="btnSuperRing" runat="server" CssClass="product-img" 
            ImageUrl="Images/super_ring.jpg" PostBackUrl="GroceryDetails.aspx?id=35" />
        <div class="product-info">
            <asp:Label ID="lblSuperRing" runat="server" Text="Super Ring Cheese - RM2.80"></asp:Label>
        </div>
    </div>

</asp:Panel>


        </div>
    </form>
</body>
</html>

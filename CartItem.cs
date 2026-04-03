using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProductPage
{
    public class CartItem
    {

        // this class acts as a blueprint for a single item in the shopping cart.

        // it groups all product details


        // the product's unique id is used to identify which product was boughh when saving it into the cart / database
        public string ProductId { get; set; }
        public string ProductName { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }

        // This automatically calculates the subtotal (Price x Qty)
        public decimal SubTotal
        {
            get { return Price * Quantity; }
        }

    }
}
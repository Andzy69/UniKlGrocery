using System;

namespace ProductPage
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string page = System.IO.Path.GetFileName(Request.Path).ToLower();

            bool isPublicPage =
                page == "login.aspx" ||
                page == "register.aspx";

            if (!isPublicPage && Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (Session["Username"] != null)
            {
                string username = Session["Username"].ToString();

                lblInitial.Text = username.Substring(0, 1).ToUpper();
                lblUsername.Text = username;
                if (Session["Role"] != null && Session["Role"].ToString() == "Admin")
                {
                    pnlAdminLink.Visible = true;
                }
                else
                {
                    pnlAdminLink.Visible = false;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}

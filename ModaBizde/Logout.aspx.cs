using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UyeID"] != null) { Session["UyeID"] = null; }
            if (Session["KullaniciAdi"] != null) { Session["KullaniciAdi"] = null; }
            Response.Redirect("Default.aspx");
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class AddBlog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UyeID"] != null)
            {
                int uye_id = -1;
                if (Int32.TryParse(Session["UyeID"].ToString(), out uye_id))
                {
                    ModalDataContext data = new ModalDataContext();
                    Uye uye = data.Uyes.FirstOrDefault(u => u.UyeID == uye_id);
                    if (uye != null) { if (!((bool)uye.BlogYazmaDuzenleme)) { Response.Redirect("AdminPanel.aspx"); } }
                    else { Response.Redirect("Login.aspx"); }
                }
                else { Session["UyeID"] = null; Session["KullaniciAdi"] = null; Response.Redirect("Login.aspx"); }
            }
            else { Response.Redirect("Login.aspx"); }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class AdminSablon : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int uyeid = -1;
            if (Session["UyeID"] != null)
            {
                if (Int32.TryParse(Session["UyeID"].ToString(), out uyeid))
                {
                    ModalDataContext data = new ModalDataContext();
                    Uye uye = data.Uyes.FirstOrDefault(u => u.UyeID == uyeid);
                    if (uye != null)
                    {
                        bool yetki = (bool)uye.UrunGirmeDuzenleme || (bool)uye.UrunSilme ||
                            (bool)uye.BlogYazmaDuzenleme || (bool)uye.BlogYonetme || (bool)uye.Yetkilendirme ||
                            (bool)uye.SiteUnsurlari || (bool)uye.FaturaIslemleri;
                        if (yetki)
                        {
                            sKullanici.InnerText = Session["KullaniciAdi"] != null ? Session["KullaniciAdi"].ToString() : "";
                        }
                        else { Response.Redirect("Default.aspx"); }
                    }
                    else { Session["UyeID"] = null; Session["KullaniciAdi"] = null; Response.Redirect("Login.aspx"); }
                }
                else { Response.Redirect("Login.aspx"); }
            }
            else { Response.Redirect("Login.aspx"); }
        }
    }
}
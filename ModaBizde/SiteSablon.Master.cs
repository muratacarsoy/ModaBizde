using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class SiteSablon : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KullaniciAdi"] != null)
            {
                sKullanici.InnerText = Session["KullaniciAdi"].ToString();
                NormalPanel.Visible = false;
                KullaniciPaneli.Visible = true;
            }
            else
            {
                NormalPanel.Visible = true;
                KullaniciPaneli.Visible = false;
            }

            #region Ana Sayfa Sekmesi
            nav.InnerHtml = "<li class=\"current\">" +
                                "<a href=\"Default.aspx\">Ana Sayfa</a>" +
                                "<ul class=\"sub-menu\">" +
                                    "<li><a href=\"#\" class=\"mega-title\">Diğer Sayfalar</a></li>" +
                                    "<li><a href=\"Contact.aspx\">İletişim</a></li>" +
                                    "<li><a href=\"AboutUs.aspx\">Hakkımızda</a></li>" +
                                    "<li><a href=\"Blog.aspx\">Blog</a></li>" +
                                    "<li><a href=\"Account.aspx\">Bilgilerim</a></li>" +
                                    "<li><a href=\"Cart.aspx\">Sepetim</a></li>" +
                                    "<li><a href=\"Checkout.aspx\">Satın Al</a></li>" +
                                    "<li><a href=\"Shop.aspx\">Ürün Ara</a></li>" +
                                    "<li><a href=\"Liked.aspx\">Beğendiklerim</a></li>" +
                                "</ul>" +
                            "</li>";
            #endregion

            ModalDataContext data = new ModalDataContext();
            List<Kategori> kategoriler = data.Kategoris.ToList();
            int i = 0, c = kategoriler.Count;
            string nav_inner_html = "";
            while (i < c)
            {
                Kategori _k = kategoriler[i];
                List<UrunGrubu> gruplar = data.UrunGrubus.Where(ug => ug.KategoriID == _k.KategoriID).ToList();
                int j = 0, d = gruplar.Count; int d2 = d / 2;
                string grup_inner_html = "<span><a href=\"#\" class=\"mega-title\">Ürünler</a>";
                while (j <= d / 2)
                {
                    UrunGrubu ug = gruplar[j];
                    grup_inner_html += "<a href=\"Shop.aspx?ctgr=" + _k.KategoriID + "&grp=" + ug.GrupID + "\">" + ug.GrupAdi + "</a>";
                    j++;
                }
                grup_inner_html += "</span>";
                grup_inner_html += "<span><a href=\"#\" class=\"mega-title\">Ürünler</a>";
                while (j < d)
                {
                    UrunGrubu ug = gruplar[j];
                    grup_inner_html += "<a href=\"Shop.aspx?ctgr=" + _k.KategoriID + "&grp=" + ug.GrupID + "\">" + ug.GrupAdi + "</a>";
                    j++;
                }
                grup_inner_html += "</span>";
                List<UrunGrubu> begenilenGruplar = _k.UrunGrubus.OrderByDescending(ug => ug.Uruns.Sum(u => u.Begeniler)).Take(3).ToList();
                grup_inner_html += "<span><a href=\"#\" class=\"mega-title\">Beğenilenler</a>";
                j = 0; d = begenilenGruplar.Count;
                while (j < d)
                {
                    UrunGrubu ug = begenilenGruplar[j];
                    grup_inner_html += "<a href=\"Shop.aspx?ctgr=" + _k.KategoriID + "&grp=" + ug.GrupID + "\">" + ug.GrupAdi + "</a>";
                    j++;
                }
                grup_inner_html += "</span>";
                List<UrunGrubu> oneCikanGruplar = _k.UrunGrubus.OrderByDescending(ug => ug.Uruns.Sum(u => u.GoruntulenmeSayisi)).Take(3).ToList();
                grup_inner_html += "<span><a href=\"#\" class=\"mega-title\">Öne Çıkanlar</a>";
                j = 0; d = oneCikanGruplar.Count;
                while (j < d)
                {
                    UrunGrubu ug = oneCikanGruplar[j];
                    grup_inner_html += "<a href=\"Shop.aspx?ctgr=" + _k.KategoriID + "&grp=" + ug.GrupID + "\">" + ug.GrupAdi + "</a>";
                    j++;
                }
                grup_inner_html += "</span>";
                nav_inner_html += "<li>" + 
                                      "<a href=\"Shop.aspx?ctgr=" + _k.KategoriID + "\">" + _k.KategoriAdi + "</a>" + 
                                      "<div class=\"megamenu\">" +
                                          "<div class=\"megamenu-list clearfix\">" +
                                          grup_inner_html +
                                      "</div>" +
                                  "</li>";
                i++;
            }
            nav.InnerHtml += nav_inner_html;
        }
    }
}
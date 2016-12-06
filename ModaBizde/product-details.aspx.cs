using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class product_details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                SqlConnection baglanti = new SqlConnection();
                baglanti.ConnectionString = ConfigurationManager.ConnectionStrings["baglantimetni"].ConnectionString;

                #region GoruntulemeArtirma İşlemi Kodları
                SqlCommand GoruntulemeArtirmaSorgu = new SqlCommand();
                GoruntulemeArtirmaSorgu.CommandText = "update Urun set GoruntulenmeSayisi+=1 where UrunID=" +
                    Request.QueryString["UrunID"].ToString();
                GoruntulemeArtirmaSorgu.Connection = baglanti;
                baglanti.Open();
                GoruntulemeArtirmaSorgu.ExecuteNonQuery();
                baglanti.Close();
                #endregion

                #region Ürün Bilgileri

                string selectsorgusu = string.Format("exec sp_UrunDetayBilgileri {0}", Request.QueryString["UrunId"]);
                SqlDataAdapter sorgu = new SqlDataAdapter(selectsorgusu, baglanti);
                DataTable tablo = new DataTable();
                sorgu.Fill(tablo);
                string urun_adi = tablo.Rows[0]["UrunAdi"].ToString();
                zoom1.Src = tablo.Rows[0]["GorselAdres"].ToString();
                zoom1.Attributes["data-zoom-image"] = tablo.Rows[0]["GorselAdres"].ToString();
                UrunBasligi.InnerText = urun_adi;
                GoruntulemeSayisi.InnerText = tablo.Rows[0]["GoruntulenmeSayisi"].ToString();
                BegeniSayisi.InnerText = tablo.Rows[0]["Begeniler"] == null ? "0" : tablo.Rows[0]["Begeniler"].ToString();
                Stokta.InnerText = tablo.Rows[0]["NetMiktar"].ToString()!="0"?"Stokta":"Tükendi";
                eskifiyat.InnerHtml = (double.Parse(tablo.Rows[0]["BirimFiyat"].ToString())*1.3).ToString("0.00") + "&#8378";
                yenifiyat.InnerHtml = double.Parse(tablo.Rows[0]["BirimFiyat"].ToString()).ToString("0.00") + "&#8378";
                aciklama.InnerText = tablo.Rows[0]["Aciklama"].ToString();
                EklenmeTarihi.InnerText = Convert.ToDateTime(tablo.Rows[0]["Tarih"]).ToString("dd.MM.yyyy");

                #endregion

                #region Puanlama ve Yorumlar

                float fiyat_puan = 0f;
                float.TryParse(tablo.Rows[0]["FiyatPuani"].ToString(), out fiyat_puan);
                float urun_puan = 0f;
                float.TryParse(tablo.Rows[0]["DegerPuani"].ToString(), out urun_puan);
                float kalite_puan = 0f;
                float.TryParse(tablo.Rows[0]["KalitePuani"].ToString(), out kalite_puan);
                FiyatStars.InnerHtml = PrepareStars(fiyat_puan);
                FiyatPuani.InnerText = fiyat_puan > 1f ? fiyat_puan.ToString("0.0") : "-";
                UrunStars.InnerHtml = PrepareStars(urun_puan);
                UrunPuani.InnerText = urun_puan > 1f ? urun_puan.ToString("0.0") : "-";
                KaliteStars.InnerHtml = PrepareStars(kalite_puan);
                KalitePuani.InnerText = urun_puan > 1f ? kalite_puan.ToString("0.0") : "-";
                Goruntuluyorsunuz.InnerText = "Şu ürünü görüntülüyorsunuz: " + urun_adi;
                ModalDataContext data = new ModalDataContext();
                bool oturum = Session["UyeID"] != null;
                if (oturum)
                {
                    int uyeID = Convert.ToInt32(Session["UyeID"]), urunID = Convert.ToInt32(Request.QueryString["UrunId"]);
                    txtKullaniciAdi.Text = data.Uyes.FirstOrDefault(u => u.UyeID == uyeID).KullaniciAdi;
                    UrunPuan urunPuan = data.UrunPuans.FirstOrDefault(up => up.UrunID == urunID && up.UyeID == uyeID);
                    if (urunPuan == null)
                    {
                        txtBaslik.Text = "";
                        txtYorum.Text = "";
                        btnGonder.Text = "Gönder";
                    }
                    else
                    {
                        double _fiyatPuan = (double)(urunPuan.FiyatPuani != null ? urunPuan.FiyatPuani : 0.0);
                        if (_fiyatPuan > 0.0)
                        {
                            if (_fiyatPuan == 1.0) { FiyatPuan1.Checked = true; }
                            else if (_fiyatPuan == 2.0) { FiyatPuan2.Checked = true; }
                            else if (_fiyatPuan == 3.0) { FiyatPuan3.Checked = true; }
                            else if (_fiyatPuan == 4.0) { FiyatPuan4.Checked = true; }
                            else if (_fiyatPuan == 5.0) { FiyatPuan5.Checked = true; }
                        }
                        double _urunPuan = (double)(urunPuan.DegerPuani != null ? urunPuan.DegerPuani : 0.0);
                        if (_urunPuan > 0.0)
                        {
                            if (_urunPuan == 1.0) { UrunPuan1.Checked = true; }
                            else if (_urunPuan == 2.0) { UrunPuan2.Checked = true; }
                            else if (_urunPuan == 3.0) { UrunPuan3.Checked = true; }
                            else if (_urunPuan == 4.0) { UrunPuan4.Checked = true; }
                            else if (_urunPuan == 5.0) { UrunPuan5.Checked = true; }
                        }
                        double kalitePuan = (double)(urunPuan.KalitePuani != null ? urunPuan.KalitePuani : 0.0);
                        if (kalitePuan > 0.0)
                        {
                            if (kalitePuan == 1.0) { KalitePuan1.Checked = true; }
                            else if (kalitePuan == 2.0) { KalitePuan2.Checked = true; }
                            else if (kalitePuan == 3.0) { KalitePuan3.Checked = true; }
                            else if (kalitePuan == 4.0) { KalitePuan4.Checked = true; }
                            else if (kalitePuan == 5.0) { KalitePuan5.Checked = true; }
                        }
                        string yorum = urunPuan.Yorum, baslik = urunPuan.Baslik;
                        txtYorum.Text = yorum; txtBaslik.Text = baslik;
                        btnGonder.Text = "Güncelle";
                    }
                }
                int urun_id = Convert.ToInt32(Request.QueryString["UrunId"]);
                List<string[]> yorumlar = (from up in data.UrunPuans
                                           where up.UrunID == urun_id && 
                                           !(up.Yorum == null && up.Baslik == null) &&
                                           !(up.Yorum == "" && up.Baslik == "")
                                           orderby up.Tarih descending
                                           select new string[4] 
                                                   { (from k in data.Uyes
                                                     where k.UyeID == up.UyeID
                                                     select k.KullaniciAdi).FirstOrDefault(), 
                                                     up.Tarih == null ? "-" : up.Tarih.ToString(),
                                                     up.Baslik == null ? "" : up.Baslik,
                                                     up.Yorum == null ? "" : up.Yorum }).Take(8).ToList();
                Yorumlar.InnerHtml = GetComments(yorumlar);

                #endregion

                #region Geçmişte Bakılan Ürünler

                DataTable gecmis = new DataTable();
                gecmis = (DataTable)HttpContext.Current.Session["GecmisteBakilanUrunler"];
                
                if (gecmis == null)
                {
                    gecmis = new DataTable();
                    gecmis.Columns.Add("UrunID");
                    gecmis.Columns.Add("UrunAdi");
                    gecmis.Columns.Add("GorselAdres");
                    gecmis.Columns.Add("BirimFiyat");
                }

                bool varmi = false;
                int i = 0, c = gecmis.Rows.Count, indis = 0;
                while (i < c)
                {
                    varmi = gecmis.Rows[i]["UrunID"].ToString() == tablo.Rows[0]["UrunID"].ToString();
                    if (varmi) { indis = i; break; }
                    i++;
                }
                if (varmi) { gecmis.Rows.RemoveAt(indis); }
                gecmis.Rows.Add(tablo.Rows[0]["UrunID"], tablo.Rows[0]["UrunAdi"], tablo.Rows[0]["GorselAdres"], tablo.Rows[0]["BirimFiyat"]);
                HttpContext.Current.Session["GecmisteBakilanUrunler"] = gecmis;

                #endregion
            }
            catch 
            {
                Response.Redirect("NotFound404.aspx");
            }
        }

        private string GetComments(List<string[]> data)
        {
            string ret = "";
            foreach (string[] sl in data)
            {
                string yorum = "<div class=\"user-comment-form-area\">" +
                    "<div class=\"comment\">" +
                        "<div class=\"comment-author\"><p>" + sl[0] + "</p></div>" +
                        "<div class=\"comment-author-info\"><strong>" + sl[1] + "</strong></div>" +
                        "<div class=\"comment-info\">" +
                            "<div class=\"text-info\">" +
                                "<strong>" + sl[2] + "</strong><br>" +
                                "<p>" + sl[3] + "</p>" +
                            "</div>" +
                        "</div>" +
                    "</div>" +
                "</div>";
                ret += yorum;
            }
            return ret;
        }

        private string PrepareStars(float val)
        {
            string ret = "";
            int i = 1;
            while (i <= 5)
            {
                float _i = (float)i; float dif = val - _i;
                if (dif >= 0f) ret += "<i class=\"fa fa-star\"></i>";
                else if (dif < 0f && dif > -1f) ret += "<i class=\"fa fa-star-half-o\"></i>";
                else if (dif <= -1f) ret += "<i class=\"fa fa-star-o\"></i>";
                i++;
            }
            return ret;
        }

        protected void btnGonder_Click(object sender, EventArgs e)
        {
            ModalDataContext data = new ModalDataContext();
            try
            {
                bool oturum = Session["UyeID"] != null;
                if (oturum)
                {
                    string baslik = txtBaslik.Text, yorum = txtYorum.Text;
                    double _fiyatPuan = -1, _urunPuan = -1, _kalitePuan = -1;
                    if (FiyatPuan5.Checked) { _fiyatPuan = 5.0; }
                    else if (FiyatPuan4.Checked) { _fiyatPuan = 4.0; }
                    else if (FiyatPuan3.Checked) { _fiyatPuan = 3.0; }
                    else if (FiyatPuan2.Checked) { _fiyatPuan = 2.0; }
                    else if (FiyatPuan1.Checked) { _fiyatPuan = 1.0; }
                    if (UrunPuan5.Checked) { _urunPuan = 5.0; }
                    else if (UrunPuan4.Checked) { _urunPuan = 4.0; }
                    else if (UrunPuan3.Checked) { _urunPuan = 3.0; }
                    else if (UrunPuan2.Checked) { _urunPuan = 2.0; }
                    else if (UrunPuan1.Checked) { _urunPuan = 1.0; }
                    if (KalitePuan5.Checked) { _kalitePuan = 5.0; }
                    else if (KalitePuan4.Checked) { _kalitePuan = 4.0; }
                    else if (KalitePuan3.Checked) { _kalitePuan = 3.0; }
                    else if (KalitePuan2.Checked) { _kalitePuan = 2.0; }
                    else if (KalitePuan1.Checked) { _kalitePuan = 1.0; }
                    int urunID = Convert.ToInt32(Request.QueryString["UrunId"]), uyeID = Convert.ToInt32(Session["UyeID"].ToString());
                    UrunPuan urunPuan = data.UrunPuans.FirstOrDefault(up => up.UrunID == urunID && up.UyeID == uyeID);
                    if (urunPuan != null)
                    {
                        urunPuan.Yorum = yorum; urunPuan.Baslik = baslik; urunPuan.Tarih = DateTime.Now;
                        urunPuan.FiyatPuani = _fiyatPuan; urunPuan.DegerPuani = _urunPuan; urunPuan.KalitePuani = _kalitePuan;
                    }
                    else
                    {
                        urunPuan = new UrunPuan();
                        urunPuan.UrunID = urunID; urunPuan.UyeID = uyeID;
                        urunPuan.Yorum = yorum; urunPuan.Baslik = baslik; urunPuan.Tarih = DateTime.Now;
                        urunPuan.FiyatPuani = _fiyatPuan; urunPuan.DegerPuani = _urunPuan; urunPuan.KalitePuani = _kalitePuan;
                        urunPuan.Begeni = false;
                        data.UrunPuans.InsertOnSubmit(urunPuan);
                    }
                    data.SubmitChanges();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
            catch (Exception)
            {
                Response.Redirect("NotFound404.aspx");
            }
        }
    }
}
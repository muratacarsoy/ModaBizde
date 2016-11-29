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
    public partial class CheckOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ModalDataContext data = new ModalDataContext();
            string uye_id = (Session["UyeID"] == null ? null : Session["UyeID"].ToString());
            if (uye_id != null) // Kayıtlı üye olarak
            {
                Uye kayitli_uye = data.Uyes.FirstOrDefault(u => u.UyeID.ToString() == uye_id);
                string ad_soyad = kayitli_uye.AdSoyad;
                string[] ad__soyad = ad_soyad.Split(' ');
                string soyad = ad__soyad[ad__soyad.Length - 1];
                txtLastName.Text = soyad; txtLastName.ReadOnly = true;
                txtFirstName.Text = ad_soyad.Replace(" " + soyad, ""); txtFirstName.ReadOnly = true;
                txtEmailBilling.Text = kayitli_uye.Mail;
                txtTCKimlik.Text = kayitli_uye.TcKimlik; txtTCKimlik.ReadOnly = true;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            SqlConnection baglanti = new SqlConnection();
            baglanti.ConnectionString = ConfigurationManager.ConnectionStrings["baglantimetni"].ConnectionString;
            string selectsorgusu = string.Format("select * from Uye where KullaniciAdi='{0}' and Sifre='{1}'", txtAccountName.Text, txtPassword.Text);
            SqlDataAdapter sorgu = new SqlDataAdapter(selectsorgusu, baglanti);
            DataTable tablo = new DataTable();
            sorgu.Fill(tablo);
            if (tablo.Rows.Count == 0) //Kullanıcının Olup Olmadıgını Kontrol Eder
            {
                Response.Write("<script>Kullanıcı Adı veya Sifre Hatalı!!</script>");
                return;
            }

            Session["KullaniciAdi"] = tablo.Rows[0]["KullaniciAdi"].ToString();
            Session["UyeID"] = tablo.Rows[0]["UyeID"].ToString();
            Session.Timeout = 30;
            Response.Redirect("Checkout.aspx");
        }

        protected void btnFaturaKaydet_Click(object sender, EventArgs e)
        {
            ModalDataContext data = new ModalDataContext();
            try
            {
                string uye_id = (Session["UyeID"] == null ? null : Session["UyeID"].ToString());
                string tc_kimlik = null;
                if (uye_id != null) // Kayıtlı üye olarak
                {
                    Uye kayitli_uye = data.Uyes.FirstOrDefault(u => u.UyeID.ToString() == uye_id);
                    if (kayitli_uye != null)
                    {
                        string ad_soyad = kayitli_uye.AdSoyad;
                        string[] ad__soyad = ad_soyad.Split(' ');
                        string soyad = ad__soyad[ad__soyad.Length - 1];
                        txtLastName.Text = soyad; txtLastName.ReadOnly = true;
                        txtFirstName.Text = ad_soyad.Replace(" " + soyad, ""); txtFirstName.ReadOnly = true;
                        txtEmailBilling.Text = kayitli_uye.Mail;
                        txtTCKimlik.Text = kayitli_uye.TcKimlik; txtTCKimlik.ReadOnly = true;
                        tc_kimlik = kayitli_uye.TcKimlik;
                    }
                    else
                    {
                        Response.Write("<script>Oturumunuzun açık olduğundan emin olun</script>");
                        return;
                    }
                }
                else // Misafir Olarak
                {
                    tc_kimlik = txtTCKimlik.Text;
                    Musteri misafir_musteri = data.Musteris.FirstOrDefault(m => m.TcKimlik == tc_kimlik);
                    if (misafir_musteri != null)
                    {
                        Uye misafir_uye = data.Uyes.FirstOrDefault(u => u.TcKimlik == tc_kimlik);
                        if (misafir_uye == null)
                        {
                            Response.Write("<script>Misafir üye bilgisi bulunamadı</script>"); return;
                        }
                        else
                        {
                            if (!misafir_uye.KullaniciAdi.Contains("_misafir"))
                            {
                                Response.Write("<script>Girilen tc kimlik numarası kayıtlıdır</script>"); return;
                            }
                        }
                    }
                    else
                    {
                        misafir_musteri = new Musteri();
                        misafir_musteri.Adres = txtAddress1.Text + " " + txtAddress2.Text;
                        misafir_musteri.Telefon = txtTelephone.Text;
                        misafir_musteri.TcKimlik = tc_kimlik;
                        misafir_musteri.AdSoyad = txtFirstName.Text + " " + txtLastName.Text;
                        misafir_musteri.Kurum = txtCompany.Text;
                        misafir_musteri.Email = txtEmailBilling.Text;
                        data.Musteris.InsertOnSubmit(misafir_musteri);
                        Uye misafir_uye = new Uye();
                        misafir_uye.TcKimlik = tc_kimlik;
                        misafir_uye.AdSoyad = txtFirstName.Text + " " + txtLastName.Text;
                        misafir_uye.KullaniciAdi = "_misafir" + misafir_musteri.TcKimlik;
                        misafir_uye.Mail = txtEmailBilling.Text;
                        data.Uyes.InsertOnSubmit(misafir_uye);
                    }
                }
                DataTable sepet = new DataTable();
                sepet = (DataTable)HttpContext.Current.Session["sepet"];
                if (sepet != null)
                {
                    Fatura yeniFatura = new Fatura();
                    yeniFatura.TcKimlik = tc_kimlik;
                    yeniFatura.KargoID = int.Parse(ddlKargo.SelectedValue);
                    yeniFatura.Tarih = DateTime.Now;
                    yeniFatura.OdemeSekli = "Kredi Kartı";
                    yeniFatura.KdvOrani = 0.08f;
                    data.Faturas.InsertOnSubmit(yeniFatura);
                    data.SubmitChanges();
                    for (int i = 0; i < sepet.Rows.Count; i++)
                    {
                        FaturaDetay yeniDetay = new FaturaDetay();
                        yeniDetay.FaturaID = yeniFatura.FaturaID;
                        yeniDetay.UrunId = Convert.ToInt32(sepet.Rows[i]["UrunID"]);
                        yeniDetay.Miktar = Convert.ToInt32(sepet.Rows[i]["Miktar"]);
                        data.FaturaDetays.InsertOnSubmit(yeniDetay);
                    }
                    data.SubmitChanges();
                    HttpContext.Current.Session["sepet"] = null;
                }
                else
                {
                    Response.Write("<script>Sepetiniz boş</script>"); return;
                }
            }
            catch
            {
                Response.Write("<script>Bir hata oluştu</script>"); return;
            }
            Response.Redirect("Checkout.aspx");
        }
    }
}
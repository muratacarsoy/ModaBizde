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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtKullaniciAdi_TextChanged(object sender, EventArgs e)
        {
            SqlConnection baglanti = new SqlConnection();
            baglanti.ConnectionString = ConfigurationManager.ConnectionStrings["baglantimetni"].ConnectionString;
            string selectsorgusu = string.Format("select * from Uye where KullaniciAdi='{0}'", txtKullaniciAdi.Text);
            SqlDataAdapter sorgu = new SqlDataAdapter(selectsorgusu, baglanti);
            DataTable tablo = new DataTable();
            sorgu.Fill(tablo);
            lblMesaj.Visible = true;
            if(tablo.Rows.Count==0)
            {
                lblMesaj.Text = "Kullanılabilir";
                lblMesaj.CssClass = "text-success";
            }
            else
            {
                lblMesaj.Text = "Sistemde Kayıtlı";
                lblMesaj.CssClass = "text-danger";
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            SqlConnection baglanti = new SqlConnection();
            SqlCommand UyeOlustur = new SqlCommand();
            SqlCommand MusteriOlustur = new SqlCommand();
            try
            {              
                baglanti.ConnectionString = ConfigurationManager.ConnectionStrings["baglantimetni"].ConnectionString;
                #region MusteriOlusturma
                MusteriOlustur.CommandText = string.Format("insert into Musteri (TcKimlik,AdSoyad,Adres,Telefon) values('{0}','{1}','{2}','{3}')",
                    txtTcKimlik.Text, txtAdSoyad.Text, txtAdres.Text, txtTelefon.Text);
                MusteriOlustur.Connection = baglanti;
                baglanti.Open();
                MusteriOlustur.ExecuteNonQuery();
                baglanti.Close();
                #endregion
                #region Uye Olusturma
                UyeOlustur.CommandText = string.Format("insert into Uye (KullaniciAdi,Sifre,Mail,AdSoyad,TcKimlik) values('{0}','{1}','{2}','{3}','{4}')",
                    txtKullaniciAdi.Text, txtSifre.Text, txtEmail.Text, txtAdSoyad.Text, txtTcKimlik.Text);
                UyeOlustur.Connection = baglanti;
                baglanti.Open();
                UyeOlustur.ExecuteNonQuery();
                baglanti.Close();
                #endregion              
                Response.Write("<script>alert('Kayıt Olustu');</script>");
            }
            catch (Exception)
            {
                Response.Write("<script>alert('Kayıt Olusturma sırasında hata oldu!!');</script>");
                baglanti.Dispose();
                UyeOlustur.Dispose();
            }
            

        }
    }
}
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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UyeID"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnGiris_Click(object sender, EventArgs e)
        {
            //DataTable tablo = new DataTable();
            //DataView veri=(DataView)SqlDataSource1.Select(DataSourceSelectArguments);
            //tablo = veri.ToTable();

            SqlConnection baglanti = new SqlConnection();
            baglanti.ConnectionString = ConfigurationManager.ConnectionStrings["baglantimetni"].ConnectionString;
            string selectsorgusu = string.Format("select * from Uye where KullaniciAdi='{0}' and Sifre='{1}'", txtKullaniciAdi.Text,txtSifre.Text);
            SqlDataAdapter sorgu = new SqlDataAdapter(selectsorgusu, baglanti);
            DataTable tablo = new DataTable();
            sorgu.Fill(tablo);
            if(tablo.Rows.Count==0) //Kullanıcının Olup Olmadıgını Kontrol Eder
            {
                Response.Write("<script>Kullanıcı Adı veya Sifre Hatalı!!</script>");
                return;
            }

            Session["KullaniciAdi"] = tablo.Rows[0]["KullaniciAdi"].ToString();
            Session["UyeID"] = tablo.Rows[0]["UyeID"].ToString();
            Session.Timeout = 10;
            Response.Redirect("Default.aspx");
        }
    }
}
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
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private bool Kontrol(string id)
        {
            bool r = false;
            DataTable dt = new DataTable();
            if (HttpContext.Current.Session["sepet"] != null)
            {
                dt = (DataTable)HttpContext.Current.Session["sepet"];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["UrunID"].ToString() == id)
                    {
                        r = true;
                        break;
                    }
                }
            }
            return r;
        }
 
        private void Artir(string id, int adet, double fiyat)
        {
            try
            {
                DataTable dt = new DataTable();
                dt = (DataTable)HttpContext.Current.Session["Sepet"];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["UrunId"].ToString() == id)
                    {
                        int adet1 = Convert.ToInt32(dt.Rows[i]["Miktar"].ToString());
                        adet1 += adet;
                        dt.Rows[i]["Miktar"] = adet1.ToString();
                        double tutar1 = Convert.ToDouble(dt.Rows[i]["Fiyat"].ToString());
                        tutar1 = (adet * Convert.ToDouble(dt.Rows[i]["Fiyat"])) + tutar1;
                        dt.Rows[i]["Fiyat"] = tutar1.ToString();
                        HttpContext.Current.Session["Sepet"] = dt;
                        break;
                    }
                }
            }
            catch
            {
            }
        }

        protected void Repeater4_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SepeteAt")
            {
                DataTable sepet = new DataTable();
                string UrunID = e.CommandArgument.ToString();
                #region Secilen Ürünün Diger bilgilerini Aldık

                SqlConnection baglanti = new SqlConnection();
                baglanti.ConnectionString = ConfigurationManager.ConnectionStrings["baglantimetni"].ConnectionString;
                string selectsorgusu = string.Format("exec sp_UrunDetayBilgileri {0}", UrunID);
                SqlDataAdapter sorgu = new SqlDataAdapter(selectsorgusu, baglanti);
                DataTable tablo = new DataTable();
                sorgu.Fill(tablo);

                #endregion
                #region Sepetteki Eski Ürünlerin DataTable'a Yuklemesini Yaptık
                if (HttpContext.Current.Session["Sepet"] == null) // Sepette Urun Yoksa
                {
                    sepet.Columns.Add("UrunID");
                    sepet.Columns.Add("UrunAdi");
                    sepet.Columns.Add("Fiyat");
                    sepet.Columns.Add("Miktar");
                    sepet.Columns.Add("Resim");
                }
                else
                    sepet = (DataTable)HttpContext.Current.Session["Sepet"];
                #endregion
                bool varmi = Kontrol(UrunID);
                if (varmi == false)
                {
                    sepet.Rows.Add();
                    sepet.Rows[sepet.Rows.Count-1]["UrunID"]= UrunID;
                    sepet.Rows[sepet.Rows.Count - 1]["UrunAdi"] = tablo.Rows[0]["UrunAdi"].ToString();
                    sepet.Rows[sepet.Rows.Count - 1]["Fiyat"] = tablo.Rows[0]["BirimFiyat"].ToString();
                    sepet.Rows[sepet.Rows.Count - 1]["Miktar"] = "1";
                    sepet.Rows[sepet.Rows.Count - 1]["Resim"] = tablo.Rows[0]["GorselAdres"].ToString();
                    HttpContext.Current.Session["Sepet"] = sepet;
                }
                else
                {
                    Artir(UrunID,1,Convert.ToDouble(tablo.Rows[0]["BirimFiyat"]));
                }
                Session.Timeout = 1;
            }
        }

        [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
        public static void SepeteEkle(string id, string adet)
        {
            DataTable sepet = new DataTable();
            string UrunID = id;
            #region Secilen Ürünün Diger Bilgileri

            SqlConnection baglanti = new SqlConnection();
            baglanti.ConnectionString = ConfigurationManager.ConnectionStrings["baglantimetni"].ConnectionString;
            string selectsorgusu = string.Format("exec sp_UrunDetayBilgileri {0}", UrunID);
            SqlDataAdapter sorgu = new SqlDataAdapter(selectsorgusu, baglanti);
            DataTable tablo = new DataTable();
            sorgu.Fill(tablo);

            #endregion
            #region Sepetteki Eski Ürünlerin DataTable'a Yuklenmesini
            if (HttpContext.Current.Session["Sepet"] == null) // Sepette Urun Yoksa
            {
                sepet.Columns.Add("UrunID");
                sepet.Columns.Add("UrunAdi");
                sepet.Columns.Add("Fiyat");
                sepet.Columns.Add("Miktar");
                sepet.Columns.Add("Resim");
            }
            else
                sepet = (DataTable)HttpContext.Current.Session["Sepet"];
            #endregion
            bool varmi = false;
            int i = 0, c = sepet.Rows.Count, var_index = 0;
            while (i < c)
            {
                varmi = sepet.Rows[i]["UrunID"].ToString() == id;
                if (varmi) { var_index = i; break; }
                i++;
            }
            if (varmi)
            {
                int eski_adet = Convert.ToInt32(sepet.Rows[var_index]["Miktar"]);
                int yeni_adet = eski_adet + Convert.ToInt32(adet);
                sepet.Rows[var_index]["Miktar"] = yeni_adet.ToString();
            }
            else
            {
                sepet.Rows.Add();
                sepet.Rows[sepet.Rows.Count - 1]["UrunID"] = UrunID;
                sepet.Rows[sepet.Rows.Count - 1]["UrunAdi"] = tablo.Rows[0]["UrunAdi"].ToString();
                sepet.Rows[sepet.Rows.Count - 1]["Fiyat"] = tablo.Rows[0]["BirimFiyat"].ToString();
                sepet.Rows[sepet.Rows.Count - 1]["Miktar"] = "1";
                sepet.Rows[sepet.Rows.Count - 1]["Resim"] = tablo.Rows[0]["GorselAdres"].ToString();
                HttpContext.Current.Session["Sepet"] = sepet;
            }
            HttpContext.Current.Session.Timeout = 10;
        }

        public class SepetDataModel
        {
            public string id { get; set; }
            public string ad { get; set; }
            public string fiyat { get; set; }
            public string miktar { get; set; }
            public string resim { get; set; }
            public string toplam { get; set; }
            public string tamtoplam { get; set; }
        }

        [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
        public static List<SepetDataModel> SepetiYukle()
        {
            List<SepetDataModel> sepetDataModelList = new List<SepetDataModel>();
            
            DataTable sepet = new DataTable();
            if (HttpContext.Current.Session["Sepet"] == null) // Sepette Urun Yoksa
            {
                sepet.Columns.Add("UrunID");
                sepet.Columns.Add("UrunAdi");
                sepet.Columns.Add("Fiyat");
                sepet.Columns.Add("Miktar");
                sepet.Columns.Add("Resim");
            }
            else
                sepet = (DataTable)HttpContext.Current.Session["Sepet"];
            double _tamtoplam = 0.0;
            foreach (DataRow row in sepet.Rows)
            {
                SepetDataModel model = new SepetDataModel();
                model.id = row["UrunId"].ToString();
                model.ad = row["UrunAdi"].ToString();
                model.fiyat = Convert.ToDouble(row["Fiyat"]).ToString(".00");
                model.miktar = row["Miktar"].ToString();
                model.resim = row["Resim"].ToString();
                model.toplam = (Convert.ToDouble(row["Fiyat"]) * Convert.ToDouble(row["Miktar"])).ToString("0.00");
                _tamtoplam += (Convert.ToDouble(row["Fiyat"]) * Convert.ToDouble(row["Miktar"]));
                sepetDataModelList.Add(model);
            }
            for (int i = 0; i < sepetDataModelList.Count; i++) sepetDataModelList[i].tamtoplam = _tamtoplam.ToString("0.00");
            return sepetDataModelList;
        }

        [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
        public static void SepetiTemizle()
        {
            HttpContext.Current.Session["Sepet"] = null;
        }

        [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
        public static void SepettenSil(string urunid)
        {
            DataTable sepet = new DataTable();

            #region Sepetteki Eski Ürünlerin DataTable'a Yukle
            if (HttpContext.Current.Session["Sepet"] == null) // Sepette Urun Yoksa
            {
                sepet.Columns.Add("UrunID");
                sepet.Columns.Add("UrunAdi");
                sepet.Columns.Add("Fiyat");
                sepet.Columns.Add("Miktar");
                sepet.Columns.Add("Resim");
            }
            else
                sepet = (DataTable)HttpContext.Current.Session["Sepet"];
            #endregion

            int urun_id = 0;
            if (Int32.TryParse(urunid, out urun_id))
            {
                int i = 0, c = sepet.Rows.Count, indis = -1;
                while (i < c)
                {
                    if (Convert.ToInt32(sepet.Rows[i]["UrunID"]) == urun_id)
                    {
                        indis = i; break;
                    }
                    i++;
                }
                if (indis >= 0 && indis < c) { sepet.Rows.RemoveAt(indis); }
                HttpContext.Current.Session["Sepet"] = sepet;
            }
        }

        [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
        public static void Begen(string urunid, string uyeid)
        {
            ModalDataContext data = new ModalDataContext();
            try
            {
                int urun_id = Int32.Parse(urunid), uye_id = Int32.Parse(uyeid);
                UrunPuan urunPuan = data.UrunPuans.FirstOrDefault(up => up.UyeID == uye_id && up.UrunID == urun_id);
                if (urunPuan != null)
                {
                    urunPuan.Begeni = true;
                    data.SubmitChanges();
                }
                else
                {
                    urunPuan = new UrunPuan();
                    urunPuan.UrunID = urun_id;
                    urunPuan.UyeID = uye_id;
                    urunPuan.Begeni = true;
                    urunPuan.FiyatPuani = -1;
                    urunPuan.DegerPuani = -1;
                    urunPuan.KalitePuani = -1;
                    urunPuan.Yorum = "";
                    urunPuan.Baslik = "";
                    data.UrunPuans.InsertOnSubmit(urunPuan);
                    data.SubmitChanges();
                }
            }
            catch
            {

            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btn_sepeti_temizle.ServerClick += Btn_sepeti_temizle_ServerClick;
            btn_devam.ServerClick += Btn_devam_ServerClick;
            btn_devam_et.ServerClick += Btn_devam_ServerClick;
            btn_sepeti_guncelle.ServerClick += Btn_sepeti_guncelle_ServerClick;
        }

        private void Btn_sepeti_guncelle_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }

        private void Btn_devam_ServerClick(object sender, EventArgs e)
        {
            HttpContext.Current.Session.Timeout = 30;
            Response.Redirect("Checkout.aspx");
        }

        private void Btn_sepeti_temizle_ServerClick(object sender, EventArgs e)
        {
            HttpContext.Current.Session["sepet"] = null;
            Response.Redirect("Default.aspx");
        }

        [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
        public static void MiktarDegistir(string urunid, string miktar)
        {
            DataTable sepet = new DataTable();
            
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

            int urun_id = 0, _miktar = 0;
            if (Int32.TryParse(urunid, out urun_id) && Int32.TryParse(miktar, out _miktar))
            {
                int i = 0, c = sepet.Rows.Count;
                while (i < c)
                {
                    if (Convert.ToInt32(sepet.Rows[i]["UrunID"]) == urun_id)
                    {
                        sepet.Rows[i]["Miktar"] = _miktar; break;
                    }
                    i++;
                }
                HttpContext.Current.Session["Sepet"] = sepet;
            }
        }
    }
}
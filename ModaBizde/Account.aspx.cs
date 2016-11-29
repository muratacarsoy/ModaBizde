using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class Account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UyeID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                int uye_id = -1;
                if (Int32.TryParse(Session["UyeID"].ToString(), out uye_id))
                {
                    ModalDataContext data = new ModalDataContext();
                    Uye uye = data.Uyes.FirstOrDefault(u => u.UyeID == uye_id);
                    Musteri musteri = data.Musteris.FirstOrDefault(m => m.TcKimlik == uye.TcKimlik);
                    List<Fatura> faturalar = data.Faturas.Where(f => f.Musteri.TcKimlik == musteri.TcKimlik).ToList();
                    string faturalar_div_inner_html = "";
                    foreach (Fatura f in faturalar)
                    {
                        faturalar_div_inner_html += f.Tarih != null ? ((DateTime)f.Tarih).ToString() : "";
                        faturalar_div_inner_html += "<br><br><table>";
                        foreach (FaturaDetay fd in f.FaturaDetays)
                        {
                            faturalar_div_inner_html += "<tr><td style=\"min-width:200px;\"><strong>" + fd.Urun.UrunAdi + "</strong></td>";
                            faturalar_div_inner_html += "<td style=\"min-width:80px;\"><span>" + fd.Miktar + " adet </span>";
                            faturalar_div_inner_html += "<td style=\"min-width:80px;\"><span>" + Convert.ToDouble(fd.Urun.BirimFiyat).ToString("0.00") + " &#8378 </span></td>";
                            faturalar_div_inner_html += "<td style=\"min-width:80px;\"><span>" + Convert.ToDouble(fd.Miktar * fd.Urun.BirimFiyat).ToString("0.00") + " &#8378 </span></td>";
                            faturalar_div_inner_html += "</tr>";
                        }
                        faturalar_div_inner_html += "</table><br>Toplam Tutar: ";
                        faturalar_div_inner_html += f.ToplamTutar != null ? Convert.ToDouble(f.ToplamTutar).ToString("0.00") : "";
                        faturalar_div_inner_html += "<br><br><hr>";
                    }
                    faturalar_div.InnerHtml = faturalar_div_inner_html;
                    adres_div_p.InnerText = musteri.Adres;
                }
            }
        }

        [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
        public static void AdresDegistir(string uyeid, string yeniadres)
        {
            ModalDataContext data = new ModalDataContext();
            int uye_id = -1;
            if (Int32.TryParse(uyeid, out uye_id))
            {
                Musteri musteri = data.Musteris.FirstOrDefault(m => m.TcKimlik == data.Uyes.FirstOrDefault(u => u.UyeID == uye_id).TcKimlik);
                musteri.Adres = yeniadres;
                data.SubmitChanges();
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class AddProduct : System.Web.UI.Page
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
                    if (uye != null) { if (!((bool)uye.UrunGirmeDuzenleme)) { Response.Redirect("AdminPanel.aspx"); } }
                    else { Response.Redirect("Login.aspx"); }
                }
                else { Session["UyeID"] = null; Session["KullaniciAdi"] = null; Response.Redirect("Login.aspx"); }
            }
            else { Response.Redirect("Login.aspx"); }
        }

        protected void ddlKategoriler_SelectedIndexChanged(object sender, EventArgs e)
        {
            ModalDataContext data = new ModalDataContext();
            string ktgr_str = ddlKategoriler.SelectedValue;
            int ktgr = Convert.ToInt32(ktgr_str);
            var grp = data.UrunGrubus.Where(ug => ug.KategoriID == ktgr).ToList();
            ddlUrunGrubu.Items.Clear();
            foreach (var g in grp)
            {
                ddlUrunGrubu.Items.Add(new ListItem(g.GrupAdi, g.GrupID.ToString()));
            }
        }

        protected void btnRenkEkle_Click(object sender, EventArgs e)
        {
            bool exist = false;
            foreach (ListItem li in blRenkler.Items)
            {
                exist = li.Value == ddlRenkler.SelectedValue;
                if (exist) break;
            }
            if (!exist) blRenkler.Items.Add(new ListItem(ddlRenkler.SelectedItem.Text, ddlRenkler.SelectedValue));
            btnRenkleriSil.Visible = true;
        }

        protected void btnRenkleriSil_Click(object sender, EventArgs e)
        {
            blRenkler.Items.Clear();
            btnRenkleriSil.Visible = false;
        }

        protected void btnGorselEkle_Click(object sender, EventArgs e)
        {
            if (fuGorselUpload.HasFile)
            {
                System.IO.FileInfo fl = new System.IO.FileInfo(fuGorselUpload.FileName);
                string path_crt = createPicturePath(fl.Extension);
                string path = Server.MapPath("~/img/product/" + path_crt);
                fuGorselUpload.SaveAs(path);
                DataTable dtG = new DataTable();
                if (Session["YuklenenGorseller"] == null)
                {
                    dtG = new DataTable();
                    dtG.Columns.Add("GorselAdres");
                }
                else dtG = (DataTable)Session["YuklenenGorseller"];
                dtG.Rows.Add();
                dtG.Rows[dtG.Rows.Count - 1]["GorselAdres"] = "img/product/" + path_crt;
                Session["YuklenenGorseller"] = dtG;
                btnGorselleriSil.Visible = true;
            }
        }

        protected void btnGorselleriSil_Click(object sender, EventArgs e)
        {
            Session["YuklenenGorseller"] = null;
            btnGorselleriSil.Visible = false;
        }

        private string createPicturePath(string ext)
        {
            string ret = "";
            int i = 1000;
            while (true)
            {
                string _i = i.ToString("X8") + ext;
                System.IO.FileInfo fi = new System.IO.FileInfo(Server.MapPath("~/img/product/" + _i));
                if (fi.Exists) { i++; }
                else { ret = _i; break; }
            }
            return ret;
        }

        protected void btnBedenEkle_Click(object sender, EventArgs e)
        {
            bool exist = false;
            foreach (ListItem li in blBedenler.Items)
            {
                exist = li.Value == ddlBedenler.SelectedValue;
                if (exist) break;
            }
            if (!exist) blBedenler.Items.Add(new ListItem(ddlBedenler.SelectedItem.Text, ddlBedenler.SelectedValue));
            btnBedenleriSil.Visible = true;
        }

        protected void btnBedenleriSil_Click(object sender, EventArgs e)
        {
            blBedenler.Items.Clear();
            btnBedenleriSil.Visible = false;
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            try
            {
                ModalDataContext data = new ModalDataContext();
                Urun yeniUrun = new Urun();
                yeniUrun.UrunAdi = txtUrunAdi.Text;
                yeniUrun.Aciklama = txtAciklama.Text;
                yeniUrun.BirimFiyat = Convert.ToDecimal(txtFiyat.Text);
                yeniUrun.DepoyaGirenMiktar = Convert.ToInt32(txtMiktar.Text);
                yeniUrun.KullanilanMiktar = 0;
                yeniUrun.BitisSuresi = cldBitisTarihi.SelectedDate;
                yeniUrun.Begeniler = 0; yeniUrun.GoruntulenmeSayisi = 0;
                yeniUrun.MarkaID = Convert.ToInt32(ddlMarkalar.SelectedValue);
                yeniUrun.GrupID = Convert.ToInt32(ddlUrunGrubu.SelectedValue);
                yeniUrun.Tarih = DateTime.Now;
                data.Uruns.InsertOnSubmit(yeniUrun);
                data.SubmitChanges();
                List<RenkvsUrun> yeniUrunRenkleri = new List<RenkvsUrun>();
                int i = 0, c = blRenkler.Items.Count;
                while (i < c)
                {
                    RenkvsUrun yeniUrunRenk = new RenkvsUrun();
                    yeniUrunRenk.RenkID = Convert.ToInt32(blRenkler.Items[i].Value);
                    yeniUrunRenk.UrunID = yeniUrun.UrunID;
                    yeniUrunRenkleri.Add(yeniUrunRenk);
                    i++;
                }
                var recUR = (from ur in yeniUrunRenkleri
                             select ur);
                data.RenkvsUruns.InsertAllOnSubmit(yeniUrunRenkleri);
                List<BedenvsUrun> yeniUrunBedenleri = new List<BedenvsUrun>();
                i = 0; c = blBedenler.Items.Count;
                while (i < c)
                {
                    BedenvsUrun yeniUrunBeden = new BedenvsUrun();
                    yeniUrunBeden.BedenID = Convert.ToInt32(blBedenler.Items[i].Value);
                    yeniUrunBeden.UrunID = yeniUrun.UrunID;
                    yeniUrunBedenleri.Add(yeniUrunBeden);
                    i++;
                }
                var recUB = (from ub in yeniUrunBedenleri
                             select ub);
                data.BedenvsUruns.InsertAllOnSubmit(recUB);
                DataTable dtG = new DataTable();
                if (Session["YuklenenGorseller"] == null)
                {
                    dtG = new DataTable();
                    dtG.Columns.Add("GorselAdres");
                }
                else dtG = (DataTable)Session["YuklenenGorseller"];
                List<UrunGorseli> yeniUrunGorselleri = new List<UrunGorseli>();
                i = 0; c = dtG.Rows.Count;
                while (i < c)
                {
                    UrunGorseli yeniUrunGorseli = new UrunGorseli();
                    yeniUrunGorseli.GorselAdres = dtG.Rows[i]["GorselAdres"].ToString();
                    yeniUrunGorseli.UrunID = yeniUrun.UrunID;
                    yeniUrunGorselleri.Add(yeniUrunGorseli);
                    i++;
                }
                var recUG = (from ug in yeniUrunGorselleri
                             select ug);
                data.UrunGorselis.InsertAllOnSubmit(recUG);
                data.SubmitChanges();
                Session["YuklenenGorseller"] = null;
                blBedenler.Items.Clear(); blRenkler.Items.Clear();
                txtAciklama.Text = ""; txtFiyat.Text = ""; txtMiktar.Text = ""; txtUrunAdi.Text = "";
            }
            catch
            {
                lblError.Text = "Bir hata oluştu";
            }
        }
    }
}
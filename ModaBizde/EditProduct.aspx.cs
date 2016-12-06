using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class EditProduct : System.Web.UI.Page
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
                    if (uye != null)
                    {
                        if ((bool)uye.UrunGirmeDuzenleme)
                        {
                            if (Request.QueryString["UrunID"] != null)
                            {
                                string prdct_id_str = Request.QueryString["UrunID"].ToString();
                                int prdct_id;
                                if (Int32.TryParse(prdct_id_str, out prdct_id))
                                {
                                    if (!IsPostBack)
                                    {
                                        if (!urunBilgileri(prdct_id)) Response.Redirect("AdminPanel.aspx");
                                    }
                                }
                                else { Response.Redirect("AdminPanel.aspx"); }
                            }
                        }
                        else { Response.Redirect("AdminPanel.aspx"); }
                    }
                    else { Response.Redirect("Login.aspx"); }
                }
                else { Response.Redirect("Login.aspx"); }
            }
            else { Response.Redirect("Login.aspx"); }
        }

        private bool urunBilgileri(int id)
        {
            ModalDataContext data = new ModalDataContext();
            Urun urun = data.Uruns.FirstOrDefault(u => u.UrunID == id);
            if (urun == null) { return false; }
            txtUrunAdi.Text = urun.UrunAdi; txtAciklama.Text = urun.Aciklama;
            txtFiyat.Text = ((decimal)urun.BirimFiyat).ToString("0.00");
            txtMiktar.Text = urun.DepoyaGirenMiktar.ToString();
            cldBitisTarihi.SelectedDate = (DateTime)urun.BitisSuresi;
            cldBitisTarihi.VisibleDate = (DateTime)urun.BitisSuresi;
            ddlMarkalar.SelectedValue = urun.MarkaID.ToString();
            var ktg = data.Kategoris;
            ddlKategoriler.Items.Clear();
            foreach(var k in ktg)
            {
                ddlKategoriler.Items.Add(new ListItem(k.KategoriAdi, k.KategoriID.ToString()));
            }
            ddlKategoriler.SelectedValue = urun.UrunGrubu.KategoriID.ToString();
            var grp = data.UrunGrubus.Where(ug => ug.KategoriID == urun.UrunGrubu.KategoriID).ToList();
            ddlUrunGrubu.Items.Clear();
            foreach (var g in grp)
            {
                ddlUrunGrubu.Items.Add(new ListItem(g.GrupAdi, g.GrupID.ToString()));
            }
            ddlUrunGrubu.SelectedValue = urun.GrupID.ToString();
            blRenkler.Items.Clear();
            foreach (var r in urun.RenkvsUruns)
            {
                blRenkler.Items.Add(new ListItem(r.Renk.RenkAdi, r.RenkID.ToString()));
            }
            blBedenler.Items.Clear();
            foreach (var b in urun.BedenvsUruns)
            {
                blBedenler.Items.Add(new ListItem(b.Beden.BedenBoyu, b.BedenID.ToString()));
            }
            DataTable dtG = new DataTable();
            if (Session["MevcutGorseller"] == null)
            {
                dtG = new DataTable();
                dtG.Columns.Add("GorselAdres");
            }
            else dtG = (DataTable)Session["MevcutGorseller"];
            dtG.Rows.Clear();
            foreach (var ug in urun.UrunGorselis)
            {
                dtG.Rows.Add();
                dtG.Rows[dtG.Rows.Count - 1]["GorselAdres"] = ug.GorselAdres;
            }
            Session["MevcutGorseller"] = dtG;
            return true;
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
                if (Session["MevcutGorseller"] == null)
                {
                    dtG = new DataTable();
                    dtG.Columns.Add("GorselAdres");
                }
                else dtG = (DataTable)Session["MevcutGorseller"];
                dtG.Rows.Add();
                dtG.Rows[dtG.Rows.Count - 1]["GorselAdres"] = "img/product/" + path_crt;
                Session["MevcutGorseller"] = dtG;
                btnGorselleriSil.Visible = true;
            }
        }

        protected void btnGorselleriSil_Click(object sender, EventArgs e)
        {
            Session["MevcutGorseller"] = null;
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
                string _id = "";
                if (Request.QueryString["UrunID"] != null)
                {
                    _id = Request.QueryString["UrunID"].ToString();
                    int id = -1;
                    if (Int32.TryParse(_id, out id))
                    {
                        ModalDataContext data = new ModalDataContext();
                        Urun yeniUrun = data.Uruns.FirstOrDefault(u => u.UrunID == id);
                        if (yeniUrun != null)
                        {
                            yeniUrun.UrunAdi = txtUrunAdi.Text;
                            yeniUrun.Aciklama = txtAciklama.Text;
                            yeniUrun.BirimFiyat = Convert.ToDecimal(txtFiyat.Text);
                            yeniUrun.DepoyaGirenMiktar = Convert.ToInt32(txtMiktar.Text);
                            yeniUrun.KullanilanMiktar = 0;
                            yeniUrun.BitisSuresi = cldBitisTarihi.SelectedDate;
                            yeniUrun.MarkaID = Convert.ToInt32(ddlMarkalar.SelectedValue);
                            yeniUrun.GrupID = Convert.ToInt32(ddlUrunGrubu.SelectedValue);
                            data.SubmitChanges();
                            data.RenkvsUruns.DeleteAllOnSubmit(data.RenkvsUruns.Where(ru => ru.UrunID == id));
                            List<RenkvsUrun> yeniUrunRenkleri = new List<RenkvsUrun>();
                            int i = 0, c = blRenkler.Items.Count;
                            while (i < c)
                            {
                                RenkvsUrun yeniUrunRenk = new RenkvsUrun();
                                yeniUrunRenk.RenkID = Convert.ToInt32(blRenkler.Items[i].Value);
                                yeniUrunRenk.UrunID = id;
                                yeniUrunRenkleri.Add(yeniUrunRenk);
                                i++;
                            }
                            var recUR = (from ur in yeniUrunRenkleri
                                         select ur);
                            data.RenkvsUruns.InsertAllOnSubmit(yeniUrunRenkleri);
                            data.BedenvsUruns.DeleteAllOnSubmit(data.BedenvsUruns.Where(bu => bu.UrunID == id));
                            List<BedenvsUrun> yeniUrunBedenleri = new List<BedenvsUrun>();
                            i = 0; c = blBedenler.Items.Count;
                            while (i < c)
                            {
                                BedenvsUrun yeniUrunBeden = new BedenvsUrun();
                                yeniUrunBeden.BedenID = Convert.ToInt32(blBedenler.Items[i].Value);
                                yeniUrunBeden.UrunID = id;
                                yeniUrunBedenleri.Add(yeniUrunBeden);
                                i++;
                            }
                            var recUB = (from ub in yeniUrunBedenleri
                                         select ub);
                            data.BedenvsUruns.InsertAllOnSubmit(recUB);
                            DataTable dtG = new DataTable();
                            if (Session["MevcutGorseller"] == null)
                            {
                                dtG = new DataTable();
                                dtG.Columns.Add("GorselAdres");
                            }
                            else dtG = (DataTable)Session["MevcutGorseller"];
                            data.UrunGorselis.DeleteAllOnSubmit(data.UrunGorselis.Where(ug => ug.UrunID == id));
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
                            Response.Redirect(Request.Url.AbsolutePath + "?UrunId=" + id.ToString());
                        }
                    }
                }
            }
            catch
            {
                lblError.Text = "Bir hata oluştu";
            }
        }

        protected void btnIptal_Click(object sender, EventArgs e)
        {
            string _id = "";
            if (Request.QueryString["UrunID"] != null)
            {
                _id = Request.QueryString["UrunID"].ToString();
                int id = -1;
                if (Int32.TryParse(_id, out id))
                {
                    urunBilgileri(id);
                }
                else { Response.Redirect("AdminPanel.aspx"); }
            }
            else { Response.Redirect("AdminPanel.aspx"); }
        }

        protected void btnSil_Click(object sender, EventArgs e)
        {
            string _id = "";
            if (Request.QueryString["UrunID"] != null)
            {
                _id = Request.QueryString["UrunID"].ToString();
                int id = -1;
                if (Int32.TryParse(_id, out id))
                {
                    ModalDataContext data = new ModalDataContext();
                    Urun urun = data.Uruns.FirstOrDefault(u => u.UrunID == id);
                    if (urun != null)
                    {
                        int faturalar = data.FaturaDetays.Where(fd => fd.UrunId == id).Count();
                        if (faturalar == 0)
                        {

                            data.UrunGorselis.DeleteAllOnSubmit(data.UrunGorselis.Where(ug => ug.UrunID == id));
                            data.UrunPuans.DeleteAllOnSubmit(data.UrunPuans.Where(up => up.UrunID == id));
                            data.RenkvsUruns.DeleteAllOnSubmit(data.RenkvsUruns.Where(ru => ru.UrunID == id));
                            data.UrunTags.DeleteAllOnSubmit(data.UrunTags.Where(ut => ut.UrunID == id));
                            data.BedenvsUruns.DeleteAllOnSubmit(data.BedenvsUruns.Where(bu => bu.UrunID == id));
                            data.OneCikanUrunlers.DeleteAllOnSubmit(data.OneCikanUrunlers.Where(ocu => ocu.UrunID == id));
                            data.Uruns.DeleteOnSubmit(urun);
                            data.SubmitChanges();
                        }
                        else
                        {
                            lblError.Text = "Faturalandırılmış bir ürünü silemezsiniz";
                        }
                    }
                }
            }
        }

        protected void btnUrunEditID_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditProduct.aspx?UrunId=" + txtUrunEditID.Text);
        }

        protected void btnUrunEdit_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditProduct.aspx?srch=" + txtUrunEdit.Text);
        }
    }
}
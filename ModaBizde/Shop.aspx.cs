using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class Shop : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            search_text.ServerClick += search_text_ServerClick;
            search_price.ServerClick += search_price_ServerClick;

            ModalDataContext data = new ModalDataContext();

            #region Filtreleme

            UlFilters.InnerHtml = "";
            int[] page_array = new int[9] { 1, 2, 3, 4, 5, 6, 7, 8, 9 }; int _page = 1;
            string[] filters = new string[8] { "ctgr", "grp", "clr", "mrk", "srch", "prc", "sz", "page" };
            int i = 0, c = filters.Length;
            List<Urun> urunler = data.Uruns.ToList();
            while (i < c)
            {
                try
                {
                    string filter = filters[i];
                    if (Request.QueryString[filter] != null)
                    {
                        if (i == 0) // Kategori Sorgulama
                        {
                            int id = 0;
                            if (Int32.TryParse(Request.QueryString[filter], out id))
                            {
                                urunler = urunler.Where(u => data.UrunGrubus.Where(ug => ug.KategoriID == id).Contains(u.UrunGrubu)).ToList();
                                string kategori_adi = data.Kategoris.FirstOrDefault(k => k.KategoriID == id).KategoriAdi;
                                h2KategoriGrup.InnerText = kategori_adi;
                                HtmlGenericControl li = new HtmlGenericControl("li");
                                Button button = new Button();
                                button.CssClass = "btn-link";
                                button.Text = "  Kategori: " + kategori_adi;
                                button.ID = "filter_ctgr";
                                button.Click += button_Click;
                                HtmlGenericControl i_ = new HtmlGenericControl("i");
                                i_.Attributes.Add("class", "fa fa-remove");
                                button.Controls.Add(i_);
                                li.Controls.Add(button);
                                UlFilters.Controls.Add(li);
                            }
                            else { i++; continue; }
                        }
                        else if (i == 1) // UrunGrubu Sorgulama
                        {
                            string _ids = Request.QueryString[filter];
                            string[] ids = _ids.Split('+', ' ');
                            int _i = 0, _c = ids.Length;
                            List<int> idList = new List<int>();
                            int id = 0;
                            while (_i < _c) { if (Int32.TryParse(ids[_i], out id)) { idList.Add(id); } else { _i++; continue; } _i++; }
                            if (idList.Count > 0)
                            {
                                urunler = (from u in urunler
                                           where (idList.Contains((int)u.GrupID))
                                           select u).ToList();
                                HtmlGenericControl li = new HtmlGenericControl("li");
                                Button button = new Button();
                                button.CssClass = "btn-link";
                                button.Text = "  Ürün Grubu: " + string.Join("+", data.UrunGrubus.Where(ug => idList.Contains(ug.GrupID)).Select(ug => ug.GrupAdi).ToArray());
                                button.ID = "filter_grp";
                                button.Click += button_Click;
                                HtmlGenericControl i_ = new HtmlGenericControl("i");
                                i_.Attributes.Add("class", "fa fa-remove");
                                button.Controls.Add(i_);
                                li.Controls.Add(button);
                                UlFilters.Controls.Add(li);
                            }
                            else { i++; continue; }
                        }
                        else if (i == 2) // Renk Sorgulama
                        {
                            string _ids = Request.QueryString[filter];
                            string[] ids = _ids.Split('+', ' ');
                            int _i = 0, _c = ids.Length;
                            List<int> idList = new List<int>();
                            int id = 0;
                            while (_i < _c) { if (Int32.TryParse(ids[_i], out id)) { idList.Add(id); } else { _i++; continue; } _i++; }
                            if (idList.Count > 0)
                            {
                                urunler = (from u in urunler
                                           where (from ru in data.RenkvsUruns
                                                  where (idList.Contains((int)ru.RenkID))
                                                  select ru.UrunID).Contains(u.UrunID)
                                           select u).ToList();
                                HtmlGenericControl li = new HtmlGenericControl("li");
                                Button button = new Button();
                                button.CssClass = "btn-link";
                                button.Text = "  Renk: " + string.Join("+", data.Renks.Where(r => idList.Contains(r.RenkID)).Select(r => r.RenkAdi).ToArray());
                                button.ID = "filter_clr";
                                button.Click += button_Click;
                                HtmlGenericControl i_ = new HtmlGenericControl("i");
                                i_.Attributes.Add("class", "fa fa-remove");
                                button.Controls.Add(i_);
                                li.Controls.Add(button);
                                UlFilters.Controls.Add(li);
                            }
                            else { i++; continue; }
                        }
                        else if (i == 3) // Marka Sorgulama
                        {
                            string _ids = Request.QueryString[filter];
                            string[] ids = _ids.Split('+', ' ');
                            int _i = 0, _c = ids.Length;
                            List<int> idList = new List<int>();
                            int id = 0;
                            while (_i < _c) { if (Int32.TryParse(ids[_i], out id)) { idList.Add(id); } else { _i++; continue; } _i++; }
                            if (idList.Count > 0)
                            {
                                urunler = (from u in urunler
                                           where (idList.Contains((int)u.MarkaID))
                                           select u).ToList();
                                HtmlGenericControl li = new HtmlGenericControl("li");
                                Button button = new Button();
                                button.CssClass = "btn-link";
                                button.Text = "  Marka: " + string.Join("+", data.Markas.Where(m => idList.Contains(m.MarkaID)).Select(m => m.MarkaAdi).ToArray());
                                button.ID = "filter_mrk";
                                button.Click += button_Click;
                                HtmlGenericControl i_ = new HtmlGenericControl("i");
                                i_.Attributes.Add("class", "fa fa-remove");
                                button.Controls.Add(i_);
                                li.Controls.Add(button);
                                UlFilters.Controls.Add(li);
                            }
                            else { i++; continue; }
                        }
                        else if (i == 4) // İsim Sorgulama
                        {
                            string text = Request.QueryString[filter];
                            if (text.Length > 0)
                            {
                                string[] tags = text.Split('+', ' ');
                                urunler = (from u in urunler
                                           where (from tag in tags
                                                  select u.UrunAdi.ToUpper().Contains(tag.ToUpper())).Any(b => b)
                                           select u).ToList();

                                List<string[]> tagList = (from t in tags
                                                          select new string[2] {
                                                              t,
                                                              data.Tags.Select(tg => tg.TagAdi.ToUpper()).Contains(t.ToUpper()) ?
                                                              data.Tags.FirstOrDefault(tg => tg.TagAdi.ToUpper() == t.ToUpper()).TagID.ToString() :
                                                              "-1"
                                                          }).ToList();
                                foreach (string[] tag in tagList)
                                {
                                    int tag_id = -1;
                                    Int32.TryParse(tag[1], out tag_id);
                                    if (tag_id == -1)
                                    {
                                        Tag yeniTag = new Tag();
                                        yeniTag.TagAdi = tag[0];
                                        yeniTag.TagAramaSayisi = 0;
                                        data.Tags.InsertOnSubmit(yeniTag);
                                        data.SubmitChanges();
                                    }
                                    else
                                    {
                                        Tag mevcutTag = data.Tags.FirstOrDefault(tg => tg.TagID == tag_id);
                                        mevcutTag.TagAramaSayisi += 1;
                                        data.SubmitChanges();
                                    }
                                }
                                HtmlGenericControl li = new HtmlGenericControl("li");
                                Button button = new Button();
                                button.CssClass = "btn-link";
                                button.Text = "  İsim: " + string.Join("+", tags);
                                button.ID = "filter_srch";
                                button.Click += button_Click;
                                HtmlGenericControl i_ = new HtmlGenericControl("i");
                                i_.Attributes.Add("class", "fa fa-remove");
                                button.Controls.Add(i_);
                                li.Controls.Add(button);
                                UlFilters.Controls.Add(li);
                            }
                            else { i++; continue; }
                        }
                        else if (i == 5) // Fiyat Aralığı Sorgulama
                        {
                            string values = Request.QueryString[filter];
                            string[] two_values = values.Split('+', ' ');
                            if (two_values.Length == 2)
                            {
                                decimal taban, tavan;
                                if (Decimal.TryParse(two_values[0], out taban) && Decimal.TryParse(two_values[1], out tavan))
                                {
                                    urunler = urunler.Where(u => u.BirimFiyat <= tavan && u.BirimFiyat >= taban).ToList();
                                    HtmlGenericControl li = new HtmlGenericControl("li");
                                    Button button = new Button();
                                    button.CssClass = "btn-link";
                                    button.Text = "  Fiyat: " + string.Join("-", two_values);
                                    button.ID = "filter_prc";
                                    button.Click += button_Click;
                                    HtmlGenericControl i_ = new HtmlGenericControl("i");
                                    i_.Attributes.Add("class", "fa fa-remove");
                                    button.Controls.Add(i_);
                                    li.Controls.Add(button);
                                    UlFilters.Controls.Add(li);
                                }
                            }
                            else { i++; continue; }
                        }
                        else if (i == 6) // Beden Sorgulama
                        {
                            string _ids = Request.QueryString[filter];
                            string[] ids = _ids.Split('+', ' ');
                            int _i = 0, _c = ids.Length;
                            List<int> idList = new List<int>();
                            int id = 0;
                            while (_i < _c) { if (Int32.TryParse(ids[_i], out id)) { idList.Add(id); } else { _i++; continue; } _i++; }
                            if (idList.Count > 0)
                            {
                                urunler = (from u in urunler
                                           where (from bu in data.BedenvsUruns
                                                  where (idList.Contains((int)bu.BedenID))
                                                  select bu.UrunID).Contains(u.UrunID)
                                           select u).ToList();
                                HtmlGenericControl li = new HtmlGenericControl("li");
                                Button button = new Button();
                                button.CssClass = "btn-link";
                                button.Text = "  Beden: " + string.Join("+", data.Bedens.Where(b => idList.Contains(b.BedenID)).Select(b => b.BedenBoyu).ToArray());
                                button.ID = "filter_sz";
                                button.Click += button_Click;
                                HtmlGenericControl i_ = new HtmlGenericControl("i");
                                i_.Attributes.Add("class", "fa fa-remove");
                                button.Controls.Add(i_);
                                li.Controls.Add(button);
                                UlFilters.Controls.Add(li);
                            }
                            else { i++; continue; }
                        }
                        else if (i == 7)
                        {
                            _page = 1;
                            if (!Int32.TryParse(Request.QueryString[filter], out _page))
                            {
                                int k = 0, f = page_array.Length;
                                while (k < f) { page_array[k] += _page > 3 ? (_page - 3) : 0; k++; }
                            }
                            else { i++; continue; }
                        }
                    }
                }
                catch
                {
                    i++; continue;
                }
                i++;
            }

            #endregion

            #region Sıralama Sayfalama

            // Sıralama
            if (IsPostBack) { Session["Siralama"] = ddlSort.SelectedValue; Session["SayfaUrunSayisi"] = ddlNumberOfPage.SelectedValue; Session.Timeout = 40; }
            string siralama = "sortByDate";
            if (Session["Siralama"] != null)
            {
                siralama = Session["Siralama"].ToString();
            }
            if (siralama == "sortByDate") { urunler = urunler.OrderByDescending(u => u.Tarih).ToList(); ddlSort.SelectedIndex = 0; }
            else if (siralama == "sortByName") { urunler = urunler.OrderBy(u => u.UrunAdi).ToList(); ddlSort.SelectedIndex = 1; }
            else if (siralama == "sortByPrice") { urunler = urunler.OrderBy(u => u.BirimFiyat).ToList(); ddlSort.SelectedIndex = 2; }
            else if (siralama == "sortByQuantity") { urunler = urunler.OrderByDescending(u => u.NetMiktar).ToList(); ddlSort.SelectedIndex = 3; }
            else if (siralama == "sortByLiked") { urunler = urunler.OrderByDescending(u => u.Begeniler).ToList(); ddlSort.SelectedIndex = 4; }
            else urunler = urunler.OrderByDescending(u => u.Tarih).ToList();
            // Sayfalama
            int _pageCount = 12;
            string sayfalama = "twelve";
            if (Session["SayfaUrunSayisi"] != null)
            {
                sayfalama = Session["SayfaUrunSayisi"].ToString();
            }
            if (sayfalama == "twelve") { _pageCount = 12; ddlNumberOfPage.SelectedIndex = 0; }
            else if (sayfalama == "eighteen") { _pageCount = 18; ddlNumberOfPage.SelectedIndex = 1; }
            else if (sayfalama == "twentyfour") { _pageCount = 24; ddlNumberOfPage.SelectedIndex = 2; }
            
            int urun_count = urunler.Count;
            int total_pages = (urun_count - (urun_count % _pageCount)) / _pageCount + 
                (urun_count % _pageCount == 0 ? 0 : 1);

            urunler = urunler.Skip((_page - 1) * _pageCount).Take(_pageCount).ToList();

            grid_row.InnerHtml = GridUrun(urunler, data);
            list_div.InnerHtml = ListUrun(urunler, data);

            if (_page != 1)
            {
                HtmlGenericControl li = new HtmlGenericControl("li");
                LinkButton pageLink = new LinkButton();
                HtmlGenericControl i_ctrl = new HtmlGenericControl("i");
                i_ctrl.Attributes.Add("class", "fa fa-caret-left");
                pageLink.ID = "pagePrev";
                pageLink.Controls.Add(i_ctrl);
                pageLink.Click += pageLink_Click;
                li.Controls.Add(pageLink);
                pagination_pages.Controls.Add(li);
            }
            i = 0; c = page_array.Length;
            while (i < c)
            {
                int __page = page_array[i];
                if (__page <= total_pages)
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    if (__page == _page) { li.Attributes.Add("class", "current"); }
                    LinkButton pageLink = new LinkButton();
                    pageLink.Text = __page.ToString();
                    pageLink.ID = "page" + __page;
                    pageLink.Click += pageLink_Click;
                    li.Controls.Add(pageLink);
                    pagination_pages.Controls.Add(li);
                }
                i++;
            }
            if (_page != total_pages)
            {
                HtmlGenericControl li = new HtmlGenericControl("li");
                LinkButton pageLink = new LinkButton();
                HtmlGenericControl i_ctrl = new HtmlGenericControl("i");
                i_ctrl.Attributes.Add("class", "fa fa-caret-right");
                pageLink.ID = "pageNext";
                pageLink.Controls.Add(i_ctrl);
                pageLink.Click += pageLink_Click;
                li.Controls.Add(pageLink);
                pagination_pages.Controls.Add(li);
            }

            quickview_wrapper.InnerHtml = QuickViewUrun(urunler, data);

            #endregion

            #region Kategori Seçenekleri

            UlKategoriGrup.InnerHtml = "";
            if (Request.QueryString["ctgr"] == null)
            {
                h2KategoriGrup.InnerText = "Kategori";
                foreach (Kategori k in data.Kategoris)
                {
                    LinkButton btnKategori = new LinkButton();
                    btnKategori.Text = k.KategoriAdi;
                    btnKategori.Click += btnKategori_Click;
                    btnKategori.ID = "kategori" + k.KategoriID;
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    li.Controls.Add(btnKategori);
                    UlKategoriGrup.Controls.Add(li);
                }
            }
            else
            {
                List<UrunGrubu> gruplar = UrunGruplari(urunler, data);
                foreach (UrunGrubu ug in gruplar)
                {
                    LinkButton btnGrup = new LinkButton();
                    btnGrup.Text = ug.GrupAdi + " (" + ug.Uruns.Count + ")";
                    btnGrup.Click += btnGrup_Click;
                    btnGrup.ID = "grup" + ug.GrupID;
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    li.Controls.Add(btnGrup);
                    UlKategoriGrup.Controls.Add(li);
                }
            }
            List<Marka> markalar = UrunMarkalari(urunler, data);
            foreach (Marka m in markalar)
            {
                LinkButton btnMarka = new LinkButton();
                btnMarka.Text = m.MarkaAdi + " (" + m.Uruns.Count + ")";
                btnMarka.Click += btnMarka_Click;
                btnMarka.ID = "marka" + m.MarkaID;
                HtmlGenericControl li = new HtmlGenericControl("li");
                li.Controls.Add(btnMarka);
                UlMarka.Controls.Add(li);
            }
            List<Renk> renkler = UrunRenkleri(urunler, data);
            foreach (Renk r in renkler)
            {
                LinkButton btnRenk = new LinkButton();
                btnRenk.Text = r.RenkAdi;
                btnRenk.Click += btnRenk_Click;
                btnRenk.ID = "renk" + r.RenkID;
                HtmlGenericControl li = new HtmlGenericControl("li");
                li.Controls.Add(btnRenk);
                UlRenk.Controls.Add(li);
            }
            List<Beden> bedenler = UrunBedenleri(urunler, data);
            foreach (Beden b in bedenler)
            {
                LinkButton btnBeden = new LinkButton();
                btnBeden.Text = b.BedenBoyu;
                btnBeden.Click += btnBeden_Click;
                btnBeden.ID = "beden" + b.BedenID;
                HtmlGenericControl li = new HtmlGenericControl("li");
                li.Controls.Add(btnBeden);
                UlBeden.Controls.Add(li);
            }

            #endregion

        }

        protected void pageLink_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string pageLinkLabel = btn.ID.Replace("page", "");
            int page = 1, targetPage;
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            bool exist = nameValues.AllKeys.Contains("page");
            if (exist) { if (!Int32.TryParse(nameValues["page"], out page)) { page = 1; } }
            else { page = 1; }
            if (Int32.TryParse(pageLinkLabel, out targetPage)) { }
            else if (pageLinkLabel == "Prev") { targetPage = page - 1; }
            else if (pageLinkLabel == "Next") { targetPage = page + 1; }
            if (targetPage <= 0) { targetPage = 1; }
            if (exist) { nameValues.Set("page", targetPage.ToString()); }
            else { nameValues.Add("page", targetPage.ToString()); }
            string url = Request.Url.AbsolutePath;
            Response.Redirect(url + "?" + nameValues);
        }

        protected void button_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender; string _id = btn.ID;
            _id = _id.Replace("filter_", "");
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            if (nameValues.AllKeys.Contains(_id)) { nameValues.Remove(_id); }
            string url = Request.Url.AbsolutePath;
            Response.Redirect(url + "?" + nameValues);
        }

        protected void search_price_ServerClick(object sender, EventArgs e)
        {
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            decimal tavan, taban;
            bool _tavan = Decimal.TryParse(txtTavanFiyat.Text, out tavan);
            bool _taban = Decimal.TryParse(txtTabanFiyat.Text, out taban);
            string _prms = "";
            bool exist = nameValues.AllKeys.Contains("prc");
            if (exist)
            {
                if (_tavan || _taban) { _prms = (_taban ? taban.ToString() : "1000000000") + " " + (_tavan ? tavan.ToString() : "0"); nameValues.Set("prc", _prms); }
            }
            else
            {
                if (_tavan || _taban) { _prms = (_taban ? taban.ToString() : "1000000000") + " " + (_tavan ? tavan.ToString() : "0"); nameValues.Add("prc", _prms); }
            }
            if (nameValues.AllKeys.Contains("page")) { nameValues.Set("page", "1"); }
            string url = Request.Url.AbsolutePath;
            Response.Redirect(url + "?" + nameValues);
        }

        protected void search_text_ServerClick(object sender, EventArgs e)
        {
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            bool exist = nameValues.AllKeys.Contains("srch");
            if (exist) { nameValues.Set("srch", txtArama.Text); }
            else { nameValues.Add("srch", txtArama.Text); }
            if (nameValues.AllKeys.Contains("page")) { nameValues.Set("page", "1"); }
            string url = Request.Url.AbsolutePath;
            Response.Redirect(url + "?" + nameValues);
        }

        protected void btnBeden_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int id = Int32.Parse(btn.ID.Replace("beden", ""));
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            bool exist = nameValues.AllKeys.Contains("sz");
            if (exist)
            {
                string _prms = nameValues["sz"];
                string[] prms = _prms.Split('+', ' ');
                if (!prms.Contains(id.ToString())) { _prms += " " + id.ToString(); nameValues.Set("sz", _prms); }
            }
            else { nameValues.Add("sz", id.ToString()); }
            if (nameValues.AllKeys.Contains("page")) { nameValues.Set("page", "1"); }
            string url = Request.Url.AbsolutePath;
            Response.Redirect(url + "?" + nameValues);
        }

        protected void btnRenk_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int id = Int32.Parse(btn.ID.Replace("renk", ""));
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            bool exist = nameValues.AllKeys.Contains("clr");
            if (exist)
            {
                string _prms = nameValues["clr"];
                string[] prms = _prms.Split('+', ' ');
                if (!prms.Contains(id.ToString())) { _prms += " " + id.ToString(); nameValues.Set("clr", _prms); }
            }
            else { nameValues.Add("clr", id.ToString()); }
            if (nameValues.AllKeys.Contains("page")) { nameValues.Set("page", "1"); }
            string url = Request.Url.AbsolutePath;
            Response.Redirect(url + "?" + nameValues);
        }

        protected void btnMarka_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int id = Int32.Parse(btn.ID.Replace("marka", ""));
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            bool exist = nameValues.AllKeys.Contains("mrk");
            if (exist)
            {
                string _prms = nameValues["mrk"];
                string[] prms = _prms.Split('+', ' ');
                if (!prms.Contains(id.ToString())) { _prms += " " + id.ToString(); nameValues.Set("mrk", _prms); }
            }
            else { nameValues.Add("mrk", id.ToString()); }
            if (nameValues.AllKeys.Contains("page")) { nameValues.Set("page", "1"); }
            string url = Request.Url.AbsolutePath;
            Response.Redirect(url + "?" + nameValues);
        }

        protected void btnKategori_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int id = Int32.Parse(btn.ID.Replace("kategori", ""));
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            nameValues.Clear();
            bool exist = nameValues.AllKeys.Contains("ctgr");
            if (exist) { nameValues.Set("ctgr", id.ToString()); }
            else { nameValues.Add("ctgr", id.ToString()); }
            if (nameValues.AllKeys.Contains("page")) { nameValues.Set("page", "1"); }
            string url = Request.Url.AbsolutePath;
            Response.Redirect(url + "?" + nameValues);
        }

        protected void btnGrup_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int id = Int32.Parse(btn.ID.Replace("grup", ""));
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            bool exist = nameValues.AllKeys.Contains("grp");
            if (exist)
            {
                string _prms = nameValues["grp"];
                string[] prms = _prms.Split('+', ' ');
                if (!prms.Contains(id.ToString())) { _prms += " " + id.ToString(); nameValues.Set("grp", _prms); }
            }
            else { nameValues.Add("grp", id.ToString()); }
            if (nameValues.AllKeys.Contains("page")) { nameValues.Set("page", "1"); }
            string url = Request.Url.AbsolutePath;
            Response.Redirect(url + "?" + nameValues);
        }

        protected void ddlNumberOfPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Response.Redirect(url + (nameValues.Keys.Count > 0 ? "?" + nameValues : ""));
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Response.Redirect(url + (nameValues.Keys.Count > 0 ? "?" + nameValues : ""));
        }

        protected List<UrunGrubu> UrunGruplari(List<Urun> _urunler, ModalDataContext _data)
        {
            return (from ug in _data.UrunGrubus
                    where (from u in _urunler
                        select u.GrupID).Contains(ug.GrupID)
                    select ug).OrderByDescending(ug => ug.Uruns.Count).ToList();
        }

        protected List<Marka> UrunMarkalari(List<Urun> _urunler, ModalDataContext _data)
        {
            return (from m in _data.Markas
                    where (from u in _urunler
                           select u.MarkaID).Contains(m.MarkaID)
                    select m).OrderByDescending(m => m.Uruns.Count).ToList();
        }

        protected List<Renk> UrunRenkleri(List<Urun> _urunler, ModalDataContext _data)
        {
            return _data.Renks.Where(b => _data.RenkvsUruns.Where(bu => _urunler.Select(u => u.UrunID).Contains((int)bu.UrunID)).Select(bu => bu.RenkID).Contains(b.RenkID)).ToList();
        }

        protected List<Beden> UrunBedenleri(List<Urun> _urunler, ModalDataContext _data)
        {
            return _data.Bedens.Where(b => _data.BedenvsUruns.Where(bu => _urunler.Select(u => u.UrunID).Contains((int)bu.UrunID)).Select(bu => bu.BedenID).Contains(b.BedenID)).ToList();
        }

        protected string GridUrun(List<Urun> _urunler, ModalDataContext _data)
        {
            string ret = "<div class=\"row\">";
            foreach (Urun u in _urunler)
            {
                string etiket = "", class_attr = "sale-product-label";
                if (u.NetMiktar != null) { if (u.NetMiktar > 0) { if (u.Tarih != null) { if ((DateTime.Now - (DateTime)u.Tarih).TotalDays < 7.0) { etiket = "Yeni"; class_attr = "new-product-label"; } else { etiket = "Satışta"; } } else { etiket = "Satışta"; } } else { etiket = "Tükendi"; } }
                string gorsel = u.UrunGorselis.OrderBy(ug => ug.GorselID).FirstOrDefault().GorselAdres;
                string gorsel_hover = u.UrunGorselis.OrderByDescending(ug => ug.GorselID).FirstOrDefault().GorselAdres;
                string uye_id = Session["UyeID"] == null ? "-1" : Session["UyeID"].ToString();
                string _u = "<div class=\"col-md-4 col-sm-4\">" +
                                "<div class=\"single-product-item\">" +
                                "<div class=\"" + class_attr + "\"><span>" + etiket + "</span></div>" +
                                    "<div class=\"single-product clearfix\">" +
                                        "<a href=\"product-details.aspx?UrunId=" + u.UrunID + "\">" +
                                            "<span class=\"product-image\">" +
                                                "<div style=\"width:262px;height:354px;display:table;background-color:rgba(255,255,255,.0);\">" +
                                                    "<div style=\"text-align:center;vertical-align:middle;display:table-cell;\">" +
                                                        "<img src=\"" + gorsel + "\" alt=\"\" style=\"max-width:262px;max-height:354px;\" />" +
                                                    "</div>" +
                                                "</div>" +
                                            "</span>" +
                                            "<span class=\"product-image hover-image\">" +
                                                "<div style=\"width:262px;height:354px;display:table;background-color:rgba(255,255,255,.0);\">" +
                                                    "<div style=\"text-align:center;vertical-align:middle;display:table-cell;\">" +
                                                        "<img src=\"" + gorsel_hover + "\" alt=\"\" style=\"max-width:262px;max-height:354px;\" />" +
                                                    "</div>" +
                                                "</div>" +
                                            "</span>" +
                                        "</a>" +
                                        "<div class=\"button-actions clearfix\">" +
                                            "<button class=\"button add-to-cart\" type=\"button\" onclick=\" addCart(" + u.UrunID + ", 1);\" >" +
                                                "<span><i class=\"fa fa-shopping-cart\"></i></span>" +
                                            "</button>" +
                                            "<ul class=\"add-to-links\">" +
                                                "<li class=\"quickview\">" +
                                                    "<a class=\"btn-quickview modal-view\" href=\"#\" data-toggle=\"modal\" data-target=\"#productModal" + u.UrunID + "\">" +
                                                        "<i class=\"fa fa-search-plus\"></i>" +
                                                    "</a>" +
                                                "</li>" +
                                                "<li>" +
                                                "<a class=\"link-wishlist\" href=\"#\" onclick=\" addFav(" + u.UrunID + ", " + uye_id + ");\" >" +
                                                        "<i class=\"fa fa-heart\"></i>" +
                                                    "</a>" +
                                                "</li>" +
                                                "<li>" +
                                                    "<a class=\"link-compare\" href=\"#\">" +
                                                        "<i class=\"fa fa-retweet\"></i>" +
                                                    "</a>" +
                                                "</li>" +
                                            "</ul>" +
                                        "</div>" +
                                    "</div>" +
                                    "<h3 class=\"single-product-name\"><a href=\"product-details.aspx?UrunId=" + u.UrunID + "\">" + (u.UrunAdi.ToString().Length > 32 ? u.UrunAdi.ToString().Substring(u.UrunAdi.ToString().Length - 30, 30).Insert(0, "..") : u.UrunAdi.ToString()) + "</a></h3>" +
                                    "<div class=\"price-box\">" +
                                        "<p class=\"special-price\">" +
                                            "<span class=\"price\">" + Convert.ToDouble(u.BirimFiyat).ToString("0.00") + " &#8378 </span>" +
                                        "</p>" +
                                    "</div>" +
                                "</div>" +
                            "</div>";
                ret += _u;
            }
            ret += "</div>";
            return ret;
        }

        protected string ListUrun(List<Urun> _urunler, ModalDataContext _data)
        {
            string ret = "";
            foreach (Urun u in _urunler)
            {
                string gorsel = u.UrunGorselis.OrderBy(ug => ug.GorselID).FirstOrDefault().GorselAdres;
                string uye_id = Session["UyeID"] == null ? "-1" : Session["UyeID"].ToString();
                string _u = "<div class=\"row\">" +
                            "<div class=\"col-md-12\">" +
                                "<div class=\"single-product-item\">" +
                                    "<div class=\"row\">" +
                                        "<div class=\"col-md-3 col-sm-4\">" +
                                            "<div class=\"single-product clearfix\">" +
                                                "<a href=\"product-details.aspx?UrunId=" + u.UrunID + "\">" +
                                                    "<span class=\"product-image\">" +
                                                        "<div style=\"width:181px;height:245px;display:table;background-color:rgba(255,255,255,.0);\">" +
                                                            "<div style=\"text-align:center;vertical-align:middle;display:table-cell;\">" +
                                                                "<img src=\"" + gorsel + "\" alt=\"\" style=\"max-width:181px;max-height:245px;\" />" +
                                                            "</div>" +
                                                        "</div>" +
                                                    "</span>" +
                                                "</a>" +
                                            "</div>" +
                                        "</div>" +
                                        "<div class=\"col-md-9 col-sm-8\">" +
                                            "<h2 class=\"single-product-name\"><a href=\"product-details.aspx?UrunId=" + u.UrunID + "\">" + u.UrunAdi + "</a></h2>" +
                                            "<div class=\"description\">" +
                                                "<p>" + u.Aciklama + " <a class=\"learn-more\" href=\"product-details.aspx?UrunId=" + u.UrunID + "\">Ürün Detayları</a></p>" +
                                            "</div>" +
                                            "<div class=\"price-box\">" +
                                                "<p class=\"special-price\">" +
                                                    "<span class=\"price\">" + Convert.ToDouble(u.BirimFiyat).ToString("0.00") + " &#8378 </span>" +
                                                "</p>" +
                                            "</div>" +
                                            "<div class=\"button-actions clearfix\">" +
                                                "<button class=\"button add-to-cart\" type=\"button\" onclick=\" addCart(" + u.UrunID + ", 1);\" >" +
                                                    "<span><i class=\"fa fa-shopping-cart\"></i></span>" +
                                                "</button>" +
                                                "<ul class=\"add-to-links\">" +
                                                    "<li>" +
                                                        "<a class=\"link-wishlist\" href=\"#\"  onclick=\" addFav(" + u.UrunID + ", " + uye_id + ");\" >" +
                                                            "<i class=\"fa fa-heart\"></i>" +
                                                        "</a>" +
                                                    "</li>" +
                                                    "<li>" +
                                                        "<a class=\"link-compare\" href=\"#\">" +
                                                            "<i class=\"fa fa-retweet\"></i>" +
                                                        "</a>" +
                                                    "</li>" +
                                                "</ul>" +
                                            "</div>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>";
                ret += _u;
            }
            return ret;
        }

        protected string QuickViewUrun(List<Urun> _urunler, ModalDataContext _data)
        {
            string ret = "";
            foreach (Urun u in _urunler)
            {
                string gorsel = u.UrunGorselis.OrderBy(ug => ug.GorselID).FirstOrDefault().GorselAdres;
                string uye_id = Session["UyeID"] == null ? "-1" : Session["UyeID"].ToString();
                string _u = "<div class=\"modal fade\" id=\"productModal" + u.UrunID + "\" tabindex=\"-1\" role=\"dialog\">" +
                                "<div class=\"modal-dialog\" role=\"document\">" +
                                    "<div class=\"modal-content\">" +
                                        "<div class=\"modal-header\">" +
                                            "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>" +
                                        "</div>" +
                                        "<div class=\"modal-body\">" +
                                            "<div class=\"modal-product\">" +
                                                "<div class=\"product-images\">" +
                                                    "<div class=\"main-image images\">" +
                                                        "<div style=\"width:254px;height:360px;display:table;background-color:rgba(255,255,255,.0);\">" +
                                                            "<div style=\"text-align:center;vertical-align:middle;display:table-cell;\">" +
                                                                "<img src=\"" + gorsel + "\" alt=\"\" style=\"max-width:254px;max-height:360px;width:auto;height:auto;\" />" +
                                                            "</div>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                                "<div class=\"product-info\">" +
                                                    "<h1>" + u.UrunAdi + "</h1>" +
                                                    "<div class=\"price-box\">" +
                                                        "<p class=\"price\"><span class=\"special-price\"><span class=\"amount\">" + Convert.ToDouble(u.BirimFiyat).ToString("0.00") + " &#8378 </span></span></p>" +
                                                    "</div>" +
                                                    "<a href=\"product-details.aspx?UrunId=" + u.UrunID + "\" class=\"see-all\">Ürün Detayları</a>" +
                                                    "<div class=\"quick-add-to-cart\">" +
                                                        "<form method=\"post\" class=\"cart\">" +
                                                            "<div class=\"numbers-row\">" +
                                                                "<input type=\"number\" id=\"french-hens" + u.UrunID + "\" value=\"1\" min=\"1\" max=\"12\">" +
                                                            "</div>" +
                                                            "<button class=\"single_add_to_cart_button\" type=\"submit\" onclick=\"addCart(" + u.UrunID + ", document.getElementById('french-hens" + u.UrunID + "').value); \">Sepete Ekle</button>" +
                                                        "</form>" +
                                                    "</div>" +
                                                    "<div class=\"quick-desc\">" +
                                                        u.Aciklama +
                                                    "</div>" +
                                                    "<div class=\"social-sharing\">" +
                                                        "<div class=\"widget widget_socialsharing_widget\">" +
                                                            "<h3 class=\"widget-title-modal\">Ürünü Paylaş</h3>" +
                                                            "<ul class=\"social-icons\">" +
                                                                "<li><a target=\"_blank\" title=\"Facebook\" href=\"#\" class=\"facebook social-icon\"><i class=\"fa fa-facebook\"></i></a></li>" +
                                                                "<li><a target=\"_blank\" title=\"Twitter\" href=\"#\" class=\"twitter social-icon\"><i class=\"fa fa-twitter\"></i></a></li>" +
                                                                "<li><a target=\"_blank\" title=\"Pinterest\" href=\"#\" class=\"pinterest social-icon\"><i class=\"fa fa-pinterest\"></i></a></li>" +
                                                                "<li><a target=\"_blank\" title=\"Google +\" href=\"#\" class=\"gplus social-icon\"><i class=\"fa fa-google-plus\"></i></a></li>" +
                                                                "<li><a target=\"_blank\" title=\"LinkedIn\" href=\"#\" class=\"linkedin social-icon\"><i class=\"fa fa-linkedin\"></i></a></li>" +
                                                            "</ul>" +
                                                        "</div>" +
                                                    "</div>" +
                                                "</div>" +
                                            "</div>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>" +
                            "</div>";
                ret += _u;
            }
            return ret;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class Blog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btn_search.ServerClick += Btn_search_ServerClick;

            ModalDataContext data = new ModalDataContext();
            int[] page_array = new int[9] { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
            int page = 1, ctgr = -1, auth = -1; string srch = ""; string month_year = "", tag = "";
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            if (nameValues.AllKeys.Contains("page")) { var _page = nameValues["page"]; if (Int32.TryParse(_page, out page)) { int k = 0, f = page_array.Length; while (k < f) { page_array[k] += page > 3 ? (page - 3) : 0; k++; } } }
            if (nameValues.AllKeys.Contains("srch")) { srch = nameValues["srch"]; }
            if (nameValues.AllKeys.Contains("arch")) { month_year = nameValues["arch"]; }
            if (nameValues.AllKeys.Contains("ctgr")) { var _ctgr = nameValues["ctgr"]; Int32.TryParse(_ctgr, out ctgr); }
            if (nameValues.AllKeys.Contains("tag")) { tag = nameValues["tag"]; }
            if (nameValues.AllKeys.Contains("auth")) { var _auth = nameValues["auth"]; Int32.TryParse(_auth, out auth); }
            int blog_count, total_pages, blogs_in_pages = 6;
            blog_count = data.Blogs.Count();
            total_pages = (blog_count - (blog_count % blogs_in_pages)) / blogs_in_pages + 
                (blog_count % blogs_in_pages == 0 ? 0 : 1);

            List<Blog> bloglar = data.Blogs.OrderByDescending(b => b.Tarih).ToList();
            if (srch != "")
            {
                string srch_upper = srch.ToUpper();
                bloglar = (from b in bloglar
                           where (b.BlogAdi.ToUpper().Contains(srch_upper) || b.OnBilgi.ToUpper().Contains(srch_upper))
                           select b).ToList();
            }
            if (month_year != "")
            {
                var arch = month_year.Split('-');
                if (arch.Length == 2)
                {
                    int month, year;
                    if (Int32.TryParse(arch[0], out month) && Int32.TryParse(arch[1], out year))
                    {
                        bloglar = (from b in bloglar
                                   where (((DateTime)b.Tarih).ToString("MM") == month.ToString() && ((DateTime)b.Tarih).ToString("yy") == year.ToString())
                                   select b).ToList();
                    }
                }
            }
            if (tag != "")
            {
                bloglar = (from b in bloglar
                           where (b.BlogTags.Select(bt => bt.Tag.TagAdi.ToUpper()).Contains(tag.ToUpper()))
                           select b).ToList();
            }
            if (auth != -1)
            {
                bloglar = (from b in bloglar
                           where (b.UyeID == auth)
                           select b).ToList();
            }
            if (ctgr != -1)
            {
                bloglar = (from b in bloglar
                           where (b.BlogGrubuID == ctgr)
                           select b).ToList();
            }

            bloglar = bloglar.Skip((page - 1) * blogs_in_pages).Take(blogs_in_pages).ToList();
            string bloglar_area_div_inner = "";
            foreach (Blog _b in bloglar)
            {
                bloglar_area_div_inner += BlogYaz(_b, data);
            }
            bloglar_area_div.InnerHtml = bloglar_area_div_inner;

            #region Sayfa Numaraları

            HtmlGenericControl _div = new HtmlGenericControl("div");
            _div.Attributes.Add("class", "row");
            HtmlGenericControl __div = new HtmlGenericControl("div");
            __div.Attributes.Add("class", "col-md-12");
            HtmlGenericControl ___div = new HtmlGenericControl("div");
            ___div.Attributes.Add("class", "pagination-content");
            HtmlGenericControl ____div = new HtmlGenericControl("div");
            ____div.Attributes.Add("class", "pagination-button");
            HtmlGenericControl pagination_pages = new HtmlGenericControl("ul");
            pagination_pages.Attributes.Add("class", "pagination");

            if (page != 1)
            {
                HtmlGenericControl li = new HtmlGenericControl("li");
                LinkButton pageLink = new LinkButton();
                HtmlGenericControl i_ctrl = new HtmlGenericControl("i");
                i_ctrl.Attributes.Add("class", "fa fa-caret-left");
                pageLink.ID = "pagePrev";
                pageLink.Controls.Add(i_ctrl);
                pageLink.Click += PageLink_Click;
                li.Controls.Add(pageLink);
                pagination_pages.Controls.Add(li);
            }
            int i = 0, c = page_array.Length;
            while (i < c)
            {
                int __page = page_array[i];
                if (__page <= total_pages)
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    if (__page == page) { li.Attributes.Add("class", "current"); }
                    LinkButton pageLink = new LinkButton();
                    pageLink.Text = __page.ToString();
                    pageLink.ID = "page" + __page;
                    pageLink.Click += PageLink_Click;
                    li.Controls.Add(pageLink);
                    pagination_pages.Controls.Add(li);
                }
                i++;
            }
            if (page != total_pages)
            {
                HtmlGenericControl li = new HtmlGenericControl("li");
                LinkButton pageLink = new LinkButton();
                HtmlGenericControl i_ctrl = new HtmlGenericControl("i");
                i_ctrl.Attributes.Add("class", "fa fa-caret-right");
                pageLink.ID = "pageNext";
                pageLink.Controls.Add(i_ctrl);
                pageLink.Click += PageLink_Click;
                li.Controls.Add(pageLink);
                pagination_pages.Controls.Add(li);
            }
            ____div.Controls.Add(pagination_pages);
            ___div.Controls.Add(____div);
            __div.Controls.Add(___div);
            _div.Controls.Add(__div);
            bloglar_area_div.Controls.Add(_div);

            #endregion

        }

        private void Btn_search_ServerClick(object sender, EventArgs e)
        {
            var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            bool exist = nameValues.AllKeys.Contains("srch");
            if (exist) { nameValues.Set("srch", txtSearch.Text); }
            else { nameValues.Add("srch", txtSearch.Text); }
            if (nameValues.AllKeys.Contains("page")) { nameValues.Set("page", "1"); }
            string url = Request.Url.AbsolutePath;
            Response.Redirect(url + "?" + nameValues);
        }

        private void PageLink_Click(object sender, EventArgs e)
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

        private static string[] aylar_array = new string[12]
        {
            "Oca", "Şub", "Mar", "Nis", "May", "Haz",
            "Tem", "Ağu", "Eyl", "Eki", "Kas", "Ara"
        };

        protected string BlogYaz(Blog _blog, ModalDataContext _data)
        {
            string gun, ay;
            gun = ((DateTime)_blog.Tarih).ToString("dd");
            ay = ((DateTime)_blog.Tarih).ToString("MM");
            ay = aylar_array[Convert.ToInt32(ay) - 1];
            Uye yazar = _data.Uyes.FirstOrDefault(u => u.UyeID == _blog.UyeID);
            string[] taglar = _blog.BlogTags.Select(bt => ("<a href = \"Blog-Details.aspx?tag=" + bt.Tag.TagID + "\" rel=\"category tag\">" + bt.Tag.TagAdi + "</a>")).ToArray();
            string _taglar = String.Join(", ", taglar);

            string blog_inner = "<div class=\"single-blog fix\">" +
                                    "<div class=\"post-thumbnail\">" +
                                        "<a href=\"Blog-Details.aspx?BlogId=" + _blog.BlogID + "\"><img src=\"" + _blog.BlogResmi + "\" alt=\"\" /></a>" +
                                    "</div>" +
                                    "<div class=\"postinfo-wrapper\">" +
                                        "<div class=\"post-date\">" +
                                            "<span class=\"day\">" + gun + "</span><span class=\"month\">" + ay + "</span>" +
                                        "</div>" +
                                        "<div class=\"post-info\">" +
                                            "<h1 class=\"blog-post-title\">" +
                                                "<a href=\"Blog-Details.aspx?BlogId=" + _blog.BlogID + "\">" + _blog.BlogAdi + "</a>" +
                                            "</h1>" +
                                            "<div class=\"entry-meta\">" +
                                                "<span class=\"author vcard\"><a class=\"url fn n\" href=\"Blog.aspx?auth=" + yazar.UyeID + "\" title=\"\" rel=\"author\">" + yazar.KullaniciAdi + "</a></span> tarafından yazıldı. / " + _taglar +
                                            "</div>" +
                                            "<div class=\"entry-summary\">" +
                                                "<p>" + _blog.OnBilgi + "</p>" +
                                            "</div>" +
                                            "<a class=\"read-button\" href=\"Blog-Details.aspx?BlogId=" + _blog.BlogID + "\"><span>Devamı</span></a>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>";



            return blog_inner;
        }
    }
}
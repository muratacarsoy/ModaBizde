using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class Blog_Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ModalDataContext data = new ModalDataContext();
            int blog_id = -1;
            if (Request.QueryString["BlogId"] != null)
            {
                string blog_id_str = Request.QueryString["BlogId"].ToString();
                if (Int32.TryParse(blog_id_str, out blog_id))
                {
                    Blog blog = data.Blogs.FirstOrDefault(b => b.BlogID == blog_id);
                    if (blog != null)
                    {
                        try
                        {
                            img_post_thumbnail.Src = blog.BlogResmi;
                            span_post_day.InnerText = ((DateTime)blog.Tarih).Day.ToString();
                            int month_index = ((DateTime)blog.Tarih).Month - 1;
                            span_post_month.InnerText = aylar_array[month_index].ToString();
                            h1_post_title.InnerText = blog.BlogAdi;
                            a_post_author.InnerText = blog.Uye.KullaniciAdi;
                            a_post_author.HRef = "Blog.aspx?auth=" + blog.UyeID;
                            string[] str_tag_array = blog.BlogTags.Select(bt => "<a href=\"Blog-Details.aspx?tag=" + bt.Tag.TagID + "\" rel=\"category tag\">" + bt.Tag.TagAdi + "</a>").ToArray();
                            string str_tags = String.Join(", ", str_tag_array);
                            div_post_tags.InnerHtml = str_tags;
                            div_post_entry.InnerHtml = blog.OnBilgi + blog.Icerik;
                            int yorum_c = blog.BlogYorums.Where(by => by.Onaylanma == true).Count();
                            a_post_comments_count.InnerText = yorum_c == 0 ? "Henüz yorum yazılmamış" : yorum_c + " adet yorum";
                            a_post_author_name.InnerText = blog.Uye.KullaniciAdi;
                            h3_post_comments_count.InnerText = yorum_c == 0 ? "Henüz yorum yazılmamış" : yorum_c + " adet yorum";
                            div_comments_area.InnerHtml = blogYorumlar(blog);
                            if (Session["UyeID"] != null)
                            {
                                string uyeid_str = Session["UyeID"].ToString();
                                int uyeid = -1;
                                if (Int32.TryParse(uyeid_str, out uyeid))
                                {
                                    Uye uye = data.Uyes.FirstOrDefault(u => u.UyeID == uyeid);
                                    if (uye != null)
                                    {
                                        input_comment_name.Value = uye.KullaniciAdi;
                                        input_comment_name.Disabled = true;
                                        input_comment_email.Value = uye.Mail;
                                        input_comment_email.Disabled = true;
                                        button_send_comment.ServerClick += Button_send_comment_ServerClick;
                                    }
                                    else { div_user_comment_area.InnerText = "Yorum yazabilmek için üye olmalısınız."; }
                                }
                                else { div_user_comment_area.InnerText = "Yorum yazabilmek için üye olmalısınız."; }
                            }
                            else { div_user_comment_area.InnerText = "Yorum yazabilmek için üye olmalısınız."; }
                        }
                        catch { Response.Redirect("NotFound404.aspx"); }
                    }
                    else { Response.Redirect("NotFound404.aspx"); }
                }
                else { Response.Redirect("NotFound404.aspx"); }
            }
            else { Response.Redirect("NotFound404.aspx"); }
        }

        private void Button_send_comment_ServerClick(object sender, EventArgs e)
        {
            ModalDataContext data = new ModalDataContext();
            int blog_id = -1;
            if (Request.QueryString["BlogId"] != null)
            {
                string blog_id_str = Request.QueryString["BlogId"].ToString();
                if (Int32.TryParse(blog_id_str, out blog_id))
                {
                    if (Session["UyeID"] != null)
                    {
                        string uyeid_str = Session["UyeID"].ToString();
                        int uyeid = -1;
                        if (Int32.TryParse(uyeid_str, out uyeid))
                        {
                            Uye uye = data.Uyes.FirstOrDefault(u => u.UyeID == uyeid);
                            if (uye != null)
                            {
                                BlogYorum by = new BlogYorum();
                                by.UyeID = uye.UyeID;
                                by.Onaylanma = false;
                                by.BlogID = blog_id;
                                by.Tarih = DateTime.Now;
                                by.Yorum = txtComment.Text;
                                data.BlogYorums.InsertOnSubmit(by);
                                data.SubmitChanges();
                            }
                        }
                    }
                }
            }
        }

        private static string[] aylar_array = new string[12]
        {
            "Oca", "Şub", "Mar", "Nis", "May", "Haz",
            "Tem", "Ağu", "Eyl", "Eki", "Kas", "Ara"
        };

        private string blogYorumlar(Blog _blog)
        {
            string ret = "";
            List<BlogYorum> yorumlar = _blog.BlogYorums.Where(by => by.Onaylanma == true).ToList();

            foreach(BlogYorum by in yorumlar)
            {
                string yorum_dt = aylar_array[((DateTime)by.Tarih).Month - 1] + " " + ((DateTime)by.Tarih).ToString("d, yyyy  h:mm");

                string yorum = "<div class=\"single-reply\">" +
                                    "<div class=\"comment-author\">" +
                                        "<img alt = \"\" src=\"img/avatar.jpg\" />" +
                                    "</div>" +
                                    "<div class=\"comment-info\">" +
                                        "<div class=\"comment-author-info\">" +
                                            "<a href = \"#\" ><b> " + by.Uye.KullaniciAdi + " </b></a>" +
                                            " tarafından yazıldı," +
                                            "<span> " + yorum_dt + "</span>" +
                                        "</div>" +
                                        "<p>" + by.Yorum + "</p>" +
                                    "</div>" +
                                "</div>";
                ret += yorum;
            }
            return ret;
        }


    }
}
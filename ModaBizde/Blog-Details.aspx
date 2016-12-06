<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="Blog-Details.aspx.cs" Inherits="ModaBizde.Blog_Details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!--Breadcrumb Start-->
        <div class="breadcrumb-container">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcrumbs">
                            <ul>
                                <li class="home"><a href="index.html">Home</a><span>/ </span></li>
                                <li><strong>Blog Yazısı</strong></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End of Breadcrumb-->
        <!--Blog Post Area Start-->
        <div class="blog-page-area details-page">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <div class="left-blog-sidebar">
                            <div class="sidebar-content">
                                <div class="section-title"><h2>Arama</h2></div>
                                    <input type="text" placeholder="Search" />
                                    <button class="submit"><i class="fa fa-search"></i></button>
                            </div>
                            <div class="sidebar-content">
                                <div class="section-title"><h2>Kategoriler</h2></div>
                                <div class="sidebar-category-list">
                                    <ul>
                                        <asp:Repeater ID="rptKategoriler" runat="server" DataSourceID="sqlKategoriler">
                                            <ItemTemplate>
                                                <li><a href="Blog.aspx?ctgr=<%# Eval("BlogGrubuID") %>"><%# Eval("GrupAdi") %> (<%# Eval("BlogSayisi") %>)</a></li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:SqlDataSource runat="server" ID="sqlKategoriler" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="select bg.BlogGrubuID, (select GrupAdi from BlogGrubu where BlogGrubu.BlogGrubuID = bg.BlogGrubuID) as GrupAdi, count(b.BlogID) as BlogSayisi from BlogGrubu bg left join Blog b on bg.BlogGrubuID = b.BlogGrubuID group by bg.BlogGrubuID"></asp:SqlDataSource>
                                    </ul>
                                </div>
                            </div>
                            <div class="sidebar-content post fix">
                                <div class="section-title"><h2>Son Eklenenler</h2></div>
                                <ul>
                                    <asp:Repeater ID="rptSonEklenenler" runat="server" DataSourceID="sqlSonEklenenler">
                                        <ItemTemplate>
                                            <li>
                                                <div class="post-thumb"><a href="Blog-Details.aspx?BlogId=<%# Eval("BlogID") %>"><img src="<%# Eval("BlogResmi") %>" alt="" /></a></div>
                                                <div class="post-info"><a href="Blog-Details.aspx?BlogId=<%# Eval("BlogID") %>"><%# Eval("BlogAdi") %></a><span><%# Convert.ToDateTime(Eval("Tarih")).ToString("dd MMM yyyy") %></span></div></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="sqlSonEklenenler" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="select top 3 BlogID, BlogAdi, BlogResmi, Tarih from Blog order by Tarih desc"></asp:SqlDataSource>
                                </ul>
                            </div>
                            <div class="sidebar-content">
                                <div class="section-title no-margin"><h2>En Çok Arananlar</h2></div>
                                <div class="popular-tags">
                                    <ul class="tag-list">
                                        <asp:Repeater ID="rptTags" runat="server" DataSourceID="sqlTags">
                                            <ItemTemplate>
                                            <li><a href="Shop.aspx?srch=<%# Eval("TagAdi") %>"><%# Eval("TagAdi") %></a></li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:SqlDataSource runat="server" ID="sqlTags" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="select top 20 * from Tag order by TagAramaSayisi desc"></asp:SqlDataSource>
                                    </ul>
                                    <div class="tag-actions">
                                        <a href="#">Tüm Arananlar</a>
                                    </div>
                                </div>
                            </div>
                            <div class="sidebar-content">
                                <div class="section-title"><h2>Blog Arşivi</h2></div>
                                <div class="sidebar-category-list">
                                    <ul>
                                        <li><a href="Blog.aspx?arch=1-17">Ocak 2017</a></li>
                                        <li><a href="Blog.aspx?arch=12-16">Aralık 2016</a></li>
                                        <li><a href="Blog.aspx?arch=11-16">Kasım 2016</a></li>
                                        <li><a href="Blog.aspx?arch=10-16">Ekim 2016</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="single-blog no-margin">
                            <div class="post-thumbnail"><img id="img_post_thumbnail" runat="server" src="img/blog/blog-1.jpg" alt="" /></div>
                            <div class="postinfo-wrapper">
                                <div class="post-date">
                                    <span class="day" id="span_post_day" runat="server">10</span><span class="month" id="span_post_month" runat="server">Mar</span>
                                </div>
                                <div class="post-info">
                                    <h1 class="blog-post-title" id="h1_post_title" runat="server">Blog Başlığı</h1>
                                    <div class="entry-meta">
                                        <span class="author vcard"><a class="url fn n" href="#" title="Bu yazarın bütün yazılarını okuyun" rel="author" id="a_post_author" runat="server">yazar</a> Tarafından Yazıldı</span> / <div id="div_post_tags" runat="server"><a href="#" rel="category tag">Fashion</a>, <a href="#" rel="category tag">WordPress</a></div>
                                    </div>
                                    <div class="entry-summary" id="div_post_entry" runat="server">
                                        <p>Donec vitae hendrerit arcu, sit amet faucibus nisl. Cras pretium arcu ex. Aenean posuere libero eu augue condimentum rhoncus. Praesent ornare tortor ac ante egestas hendrerit. Aliquam et metus pharetra, bibendum massa nec, fermentum odio. Nunc id leo ultrices, mollis ligula in, finibus tortor. Mauris eu dui ut lectus fermentum</p>
                                        <blockquote>
                                            <p>Quisque semper nunc vitae erat pellentesque, ac placerat arcu consectetur. In venenatis elit ac ultrices convallis. Duis est nisi, tincidunt ac urna sed, cursus blandit lectus. In ullamcorper sit amet ligula ut eleifend. Proin dictum tempor ligula, ac feugiat metus. Sed finibus tortor eu scelerisque scelerisque.</p>
                                        </blockquote>
                                        <p>Aenean et tempor eros, vitae sollicitudin velit. Etiam varius enim nec quam tempor, sed efficitur ex ultrices. Phasellus pretium est vel dui vestibulum condimentum. Aenean nec suscipit nibh. Phasellus nec lacus id arcu facilisis elementum. Curabitur lobortis, elit ut elementum congue, erat ex bibendum odio, nec iaculis lacus sem non lorem. Duis suscipit metus ante, sed convallis quam posuere quis. Ut tincidunt eleifend odio, ac fringilla mi vehicula nec. Nunc vitae lacus eget lectus imperdiet tempus sed in dui. Nam molestie magna at risus consectetur, placerat suscipit justo dignissim. Sed vitae fringilla enim, nec ullamcorper arcu.</p>
                                        <p>Suspendisse turpis ipsum, tempus in nulla eu, posuere pharetra nibh. In dignissim vitae lorem non mollis. Praesent pretium tellus in tortor viverra condimentum. Nullam dignissim facilisis nisl, accumsan placerat justo ultricies vel. Vivamus finibus mi a neque pretium, ut convallis dui lacinia. Morbi a rutrum velit. Curabitur sagittis quam quis consectetur mattis. Aenean sit amet quam vel turpis interdum sagittis et eget neque. Nunc ante quam, luctus et neque a, interdum iaculis metus. Aliquam vel ante mattis, placerat orci id, vehicula quam. Suspendisse quis eros cursus, viverra urna sed, commodo mauris. Cras diam arcu, fringilla a sem condimentum, viverra facilisis nunc. Curabitur vitae orci id nulla maximus maximus. Nunc pulvinar sollicitudin molestie.</p>
                                    </div>
                                    <div class="entry-meta">
                                        <a href="#" id="a_post_comments_count" runat="server">Henüz yorum yazılmamış</a>
                                    </div>
                                    <div class="share-icon">
                                        <h3>Bu Yazıyı paylaşın</h3>
                                        <ul>
                                            <li><a class="facebook" target="_blank" href="#"><i class="fa fa-facebook"></i></a></li>
                                            <li><a class="twitter" target="_blank" href="#"><i class="fa fa-twitter"></i></a></li>
                                            <li><a class="pinterest" target="_blank" href="#"><i class="fa fa-pinterest"></i></a></li>
                                            <li><a class="google-plus" target="_blank" href="#"><i class="fa fa-google-plus"></i></a></li>
                                            <li><a class="linkedin" target="_blank" href="#"><i class="fa fa-linkedin"></i></a></li>
                                        </ul>
                                    </div>
                                    <div class="author-info">
                                        <div class="author-avatar">
                                            <img alt="" src="img/avatar.png" />
                                        </div>
                                        <div class="author-description">
                                            <h2>Yazar Hakkında: 
                                                <a href="#" id="a_post_author_name" runat="server">yazar</a>
                                            </h2>
                                            <p>...</p>
                                        </div>
                                    </div>

                                    <div class="reply-comment-area">
                                        <h3 id="h3_post_comments_count" runat="server">Henüz yorum yazılmamış</h3>
                                        <div id="div_comments_area" runat="server"></div>
                                    </div>
                                    <div class="user-comment-form-area" id="div_user_comment_area" runat="server">
                                        <h3>Yorum Yazın</h3>
                                        <p>Email adresiniz görünmeyecektir. İşaretli alanlar zorunludur <span class="required">*</span></p>
                                        <ul class="form-list">
                                            <li>
                                                <div class="fields">
                                                    <div class="field name">
                                                        <label for="name"><em>*</em>İsim</label>
                                                        <div class="input-box">
                                                            <input type="text" class="input-text" title="Name" name="name" id="input_comment_name" runat="server"/>
                                                        </div>
                                                    </div>
                                                    <div class="field email">
                                                        <label for="email"><em>*</em>Email</label>
                                                        <div class="input-box">
                                                            <input type="text" class="input-text" title="Email" name="email" id="input_comment_email" runat="server"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="field comment">
                                                    <label for="comment">Yorumunuz (Maksimum 200 karakter girebilirsiniz)</label>
                                                    <div class="input-box">
                                                        <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" MaxLength="200" Rows ="5" Columns="30"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </li>
                                            <li><button type="button" class="button floatright" id="button_send_comment" runat="server"><span>Gönder</span></button></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End of Blog Post Area-->  
</asp:Content>

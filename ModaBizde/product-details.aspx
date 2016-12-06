<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="product-details.aspx.cs" Inherits="ModaBizde.product_details" %>

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
                            <li class="home"><a href="Default.aspx">Ana Sayfa</a><span>/ </span></li>
                            <li><strong>Ürün Detayları</strong></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--End of Breadcrumb-->
    <!--Product Details Area Start-->
    <div class="product-deails-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-9 col-md-9">
                    <div class="product-details-content row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="zoomWrapper">
                                <div id="img-1" class="zoomWrapper single-zoom">
                                    <a href="#">
                                        <img id="zoom1" runat="server" src="img/product/20.jpg" data-zoom-image="img/product/20.jpg" alt="big-1" class="zoomClass"/>
                                    </a>
                                </div>
                                <div class="product-thumb row">
                                    <ul class="p-details-slider" id="gallery_01">
                                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                                            <ItemTemplate>
                                                <li class="col-md-4">
                                                    <a class="elevatezoom-gallery" href="#" data-image="<%# Eval("GorselAdres") %>" data-zoom-image="<%# Eval("GorselAdres") %>" onmousemove=" $('.zoomClass').attr('src', '<%# Eval("GorselAdres") %>'); ">
                                                        <img src="<%# Eval("GorselAdres") %>" alt=""/></a>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="select * from UrunGorseli where UrunID=@UrunId">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="UrunId" Name="UrunId"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="product-details-conetnt">
                                <div class="shipping">
                                    <div class="single-service">
                                        <span class="fa fa-truck"></span>
                                        <div class="service-text-container">
                                            <h3>Ücretsiz kargo</h3>
                                            <p>100 &#8378 üzeri alışveriş</p>
                                        </div>
                                    </div>
                                    <div class="single-service">
                                        <span class="fa fa-cube"></span>
                                        <div class="service-text-container">
                                            <h3>Sınırsız İmkanlar</h3>
                                            <p>Hemen üye olun</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="product-name">
                                    <h1 id="UrunBasligi" runat="server">Donec ac tempus </h1>
                                </div>
                                <p class="no-rating no-margin"><a href="#">Görüntüleme Sayısı : <span id="GoruntulemeSayisi" runat="server"></span></a></p>
                                <p class="no-rating no-margin"><a href="#">Beğeni Sayısı : <span id="BegeniSayisi" runat="server">0</span></a></p>
                                <p class="availability">Durum: <span id="Stokta" runat="server">Stokta</span></p>
                                <div class="price-box">
                                    <p class="old-price">
                                        <span class="price" id="eskifiyat" runat="server">$170.00</span>
                                    </p>
                                    <p class="special-price">
                                        <span class="price" id="yenifiyat" runat="server">$120.00</span>
                                    </p>
                                </div>
                                <div class="details-description">
                                    <p id="aciklama" runat="server"></p>
                                    <img src="img/icon/social_link.png" alt="" />
                                </div>
                                <div class="add-to-buttons">
                                    <ul>
                                        <li><a href="#" onclick="addFav(<% Response.Write(Request.QueryString["UrunId"].ToString() + ", " + (Session["UyeID"] == null ? "-1" : Session["UyeID"].ToString())); %>); "><i class="fa fa-heart"></i></a></li>
                                        <li><a href="product-details?UrunId=<% Response.Write(Request.QueryString["UrunId"].ToString()); %>"><i class="fa fa-refresh"></i></a></li>
                                        <li><a href="#"><i class="fa fa-envelope"></i></a></li>
                                    </ul>
                                </div>
                                <div class="add-to-cart-qty">
                                    <div class="timer">
                                        <div data-countdown="2022/01/01" class="timer-grid"></div>
                                    </div>
                                    <div class="cart-qty-button">
                                        <label for="qty">Qty:</label>
                                        <input type="number" class="input-text qty" value="1" min="1" max="24" id="qty" name="qty" />
                                        <button class="button btn-cart" type="button" onclick="addCart(<% Response.Write(Request.QueryString["UrunId"].ToString()); %>, $('#qty').val()); "><span>Sepete Ekle</span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script type="text/javascript" src="js/cart.js"></script>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="p-details-tab">
                                <ul role="tablist" class="nav nav-tabs">
                                    <li class="active" role="presentation"><a data-toggle="tab" role="tab" aria-controls="description" href="#description">Yorumlar</a></li>
                                    <li role="presentation"><a data-toggle="tab" role="tab" aria-controls="reviews" href="#reviews">Derecelendirme</a></li>
                                    <li role="presentation"><a data-toggle="tab" role="tab" aria-controls="tags" href="#tags">Ürün Tagları</a></li>
                                </ul>
                            </div>
                            <div class="clearfix"></div>
                            <div class="tab-content review product-details">
                                <div id="description" class="tab-pane active" role="tabpanel">
                                    <div id="Yorumlar" runat="server" style="width:auto;height:auto;">

                                    </div>
                                </div>
                                <div id="reviews" class="tab-pane" role="tabpanel">
                                    <div class="row">
                                        <div class="col-lg-5 col-md-3 col-sm-12">
                                            <div class="review-left">
                                                <p><span>Ürün </span><a href="#">Puanları</a></p>
                                                <div class="review-rating">
                                                    <p>fiyat</p>
                                                    <div id="FiyatStars" class="rating" runat="server">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <p id="FiyatPuani" runat="server"></p>
                                                </div>
                                                <div class="review-rating">
                                                    <p>ürün</p>
                                                    <div id="UrunStars" class="rating" runat="server">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star-o"></i>
                                                    </div>
                                                    <p id="UrunPuani" runat="server"></p>
                                                </div>
                                                <div class="review-rating">
                                                    <p>kalite</p>
                                                    <div id="KaliteStars" class="rating" runat="server">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star-half-o"></i>
                                                    </div>
                                                    <p id="KalitePuani" runat="server"></p>
                                                </div>
                                                <p><span id="EklenmeTarihi" class="italic" runat="server"></span> tarihinde eklendi</p>
                                            </div>
                                        </div>
                                        <div class="col-lg-7 col-md-9 col-sm-12">
                                                <% bool oturum = Session["UyeID"] != null; string _style_txt = "";
                                                   if (!oturum) { _style_txt = "style=\"display:none;\""; } 
                                                %>
                                            <div class="review-right" <% Response.Write(_style_txt); %>>
                                                <h3 id="Goruntuluyorsunuz" runat="server"></h3>
                                                <h4>Ürünü derecelendirin</h4>
                                                    <div class="p-details-table table-responsive">
                                                        <table>
                                                            <thead>
                                                                <tr>
                                                                    <th></th>
                                                                    <th><span>1 yıldız</span></th>
                                                                    <th><span>2 yıldız</span></th>
                                                                    <th><span>3 yıldız</span></th>
                                                                    <th><span>4 yıldız</span></th>
                                                                    <th><span>5 yıldız</span></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <th>Fiyat</th>
                                                                    <td>
                                                                        <input id="FiyatPuan1" type="radio" value="" class="radio" name="group_fiyat" runat="server" /></td>
                                                                    <td>
                                                                        <input id="FiyatPuan2" type="radio" value="" class="radio" name="group_fiyat" runat="server" /></td>
                                                                    <td>
                                                                        <input id="FiyatPuan3" type="radio" value="" class="radio" name="group_fiyat" runat="server" /></td>
                                                                    <td>
                                                                        <input id="FiyatPuan4" type="radio" value="" class="radio" name="group_fiyat" runat="server" /></td>
                                                                    <td>
                                                                        <input id="FiyatPuan5" type="radio" value="" class="radio" name="group_fiyat" runat="server" /></td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Ürün</th>
                                                                    <td>
                                                                        <input id="UrunPuan1" type="radio" value="" class="radio" name="group_urun" runat="server" /></td>
                                                                    <td>
                                                                        <input id="UrunPuan2" type="radio" value="" class="radio" name="group_urun" runat="server" /></td>
                                                                    <td>
                                                                        <input id="UrunPuan3" type="radio" value="" class="radio" name="group_urun" runat="server" /></td>
                                                                    <td>
                                                                        <input id="UrunPuan4" type="radio" value="" class="radio" name="group_urun" runat="server" /></td>
                                                                    <td>
                                                                        <input id="UrunPuan5" type="radio" value="" class="radio" name="group_urun" runat="server" /></td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Kalite</th>
                                                                    <td>
                                                                        <input id="KalitePuan1" type="radio" value="" class="radio" name="group_kalite" runat="server" /></td>
                                                                    <td>
                                                                        <input id="KalitePuan2" type="radio" value="" class="radio" name="group_kalite" runat="server" /></td>
                                                                    <td>
                                                                        <input id="KalitePuan3" type="radio" value="" class="radio" name="group_kalite" runat="server" /></td>
                                                                    <td>
                                                                        <input id="KalitePuan4" type="radio" value="" class="radio" name="group_kalite" runat="server" /></td>
                                                                    <td>
                                                                        <input id="KalitePuan5" type="radio" value="" class="radio" name="group_kalite" runat="server" /></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                <div class="form-top">
                                                    <div class="row">
                                                        <div id="review-form">
                                                            <div class="form-group col-sm-12 col-md-12 col-lg-12">
                                                                <label>Kullanıcı Adı<span class="" title=""></span></label>
                                                                <asp:TextBox ID="txtKullaniciAdi" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                            <div class="form-group col-sm-12 col-md-12 col-lg-12">
                                                                <label>Yorum Başlığı<span class="" title=""></span></label>
                                                                <asp:TextBox ID="txtBaslik" CssClass="form-control" runat="server" MaxLength="32"></asp:TextBox>
                                                            </div>
                                                            <div class="form-group col-sm-12 col-md-12 col-lg-12">
                                                                <label>Yorum<span class="" title=""></span></label>
                                                                <asp:TextBox ID="txtYorum" CssClass="yourmessage" runat="server" MaxLength="300" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="buttons-set">
                                                    <asp:Button ID="btnGonder" CssClass="button" runat="server" Text="Gönder" OnClick="btnGonder_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tags" class="tab-pane" role="tabpanel">
                                    <div class="product-tag-name">
                                            <div class="form-top">
                                                <div class="row">
                                                    <div class="form-group col-sm-12 col-md-12 col-lg-12">
                                                        <label>Add Your Tags:</label>
                                                        <input type="text" class="form-control" />
                                                    </div>
                                                    <div class="clearfix"></div>
                                                    <div class="col-md-12">
                                                        <button class="button" type="button">
                                                            <span>Add Tags</span>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        <p>Use spaces to separate tags. Use single quotes (') for phrases.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="product-carousel-area section-top-padding">
                        <div class="row">
                            <div class="col-md-12">
                                <%  bool yeterli = false;
                                    System.Data.DataTable gecmisTablo = new System.Data.DataTable();
                                    if (HttpContext.Current.Session["GecmisteBakilanUrunler"] != null)
                                    {
                                        gecmisTablo = (System.Data.DataTable)HttpContext.Current.Session["GecmisteBakilanUrunler"];
                                        yeterli = gecmisTablo.Rows.Count > 3;
                                    }
                                %>
                                <div class="section-title">
                                    <h2><% Response.Write(yeterli ? "Baktıklarınız" : "Beğenilenler"); %></h2>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="upsell-product-details-carousel">
                                <%
                                    if (yeterli)
                                    {
                                        int gTblCount = gecmisTablo.Rows.Count;
                                        for (int j = gTblCount - 1; j > 0 && j > gTblCount - 7; j--)
                                        {

                                %>
                                <div class="col-md-3">
                                    <div class="single-product-item">
                                        <div class="single-product clearfix">
                                            <a href="product-details.aspx?UrunId=<% Response.Write(gecmisTablo.Rows[j]["UrunID"].ToString()); %>">
                                                <span class="product-image">
                                                    <img src="<% Response.Write(gecmisTablo.Rows[j]["GorselAdres"].ToString()); %>" alt="" />
                                                </span>
                                            </a>
                                        </div>
                                        <h2 class="single-product-name">
                                            <a href="product-details.aspx?UrunId=<% Response.Write(gecmisTablo.Rows[j]["UrunID"].ToString()); %>"><% Response.Write(gecmisTablo.Rows[j]["UrunAdi"].ToString()); %></a>
                                        </h2>
                                        <div class="price-box">
                                            <p class="special-price">
                                                <span class="price"><% Response.Write(gecmisTablo.Rows[j]["BirimFiyat"].ToString()); %> &#8378 </span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <%  
                                        }
                                    }
                                    else
                                    {
                                %>
                            <asp:Repeater ID="rptBegenilenler" runat="server" DataSourceID="sqlBegenilenler">
                                <ItemTemplate>
                                <div class="col-md-3">
                                    <div class="single-product-item">
                                        <div class="single-product clearfix">
                                            <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>">
                                                <span class="product-image">
                                                    <img src="<%# Eval("GorselAdres") %>" alt="" />
                                                </span>
                                            </a>
                                        </div>
                                        <h2 class="single-product-name">
                                            <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>"><%# Eval("UrunAdi") %></a>
                                        </h2>
                                        <div class="price-box">
                                            <p class="special-price">
                                                <span class="price"><%# Convert.ToDouble(Eval("BirimFiyat")).ToString("0.00") %> &#8378</span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="sqlBegenilenler" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="select top 6 u.UrunID, u.UrunAdi, u.BirimFiyat, (select top 1 GorselAdres from UrunGorseli where u.UrunID = UrunGorseli.UrunID) as GorselAdres from Urun u inner join UrunGrubu ug on u.GrupID = ug.GrupID where KategoriID = (select top 1 ug.KategoriID from Urun u inner join UrunGrubu ug on u.GrupID = ug.GrupID where UrunID = @UrunId) and UrunID != @UrunId order by Begeniler desc">
                                <SelectParameters>
                                    <asp:QueryStringParameter QueryStringField="UrunId" Name="UrunId"></asp:QueryStringParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                                <%  } %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <div class="single-products-category">
                        <div class="section-title">
                            <h2>İLGİLİ ÜRÜNLER</h2>
                        </div>
                        <div class="category-products">
                            <asp:Repeater ID="rptIlgiliUrunler" runat="server" DataSourceID="sqlIlgiliUrunler">
                                <ItemTemplate>
                                    <div class="product-items">
                                        <div class="p-category-image">
                                            <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>">
                                                <div style="width:80px;height:100px;display:table;background-color:rgba(255,255,255,.0);">
                                                    <div style="text-align:center;vertical-align:middle;display:table-cell;">
                                                        <img alt="" src="<%# Eval("GorselAdres") %>" style="max-width:80px;max-height:100px;width:auto;height:auto;"/>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                        <div class="p-category-text">
                                            <h2 class="category-product-name"><a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>"><%# Eval("UrunAdi") %></a></h2>
                                            <div class="price-box">
                                                <p class="special-price">
                                                    <span class="price"><%# Convert.ToDouble(Eval("BirimFiyat")).ToString("0.00") %> &#8378 </span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="sqlIlgiliUrunler" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="select top 3 UrunID, UrunAdi, BirimFiyat, (select top 1 GorselAdres from UrunGorseli where UrunGorseli.UrunID = Urun.UrunID) as GorselAdres from Urun where GrupID = (select GrupID from Urun where UrunID = @UrunId) and UrunID != @UrunId">
                                <SelectParameters>
                                    <asp:QueryStringParameter QueryStringField="UrunId" Name="UrunId"></asp:QueryStringParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="sidebar-content">
                        <div class="section-title no-margin">
                            <h2>En Çok Arananlar</h2>
                        </div>
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
                        <div class="banner-box">
                            <a href="#"><img alt="" src="img/banner/14.jpg" /></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--End of Product Details Area-->
</asp:Content>

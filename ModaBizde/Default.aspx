<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ModaBizde.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Slider Area Start-->
    <div class="slider-area-home-four">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <div class="preview-2">
                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ol class="carousel-indicators">
                                <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
                                    <ItemTemplate>
                                        <li data-target="#carousel-example-generic"
                                            data-slide-to="<%# Container.ItemIndex %>" class="<%# Container.ItemIndex==0?"active":"" %>"></li>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="sp_UrunGrubunaGoreUrun" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                            </ol>

                            <!-- Wrapper for slides -->

                            <div class="carousel-inner" role="listbox">
                                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                                    <ItemTemplate>
                                        <div class="item <%# Container.ItemIndex==0?"active":"" %>">
                                            <div style="width:576px;height:567px;display:table;background-color:rgba(255,255,255,.0);">
                                                <div style="text-align:center;vertical-align:middle;display:table-cell;">
                                                    <img src="<%# Eval("GorselAdres") %>" alt="<%# Eval("UrunAdi") %>" style="max-width:576px;max-height:567px;" />
                                                </div>
                                            </div>
                                            <div class="carousel-caption">
                                                <%# Eval("UrunAdi") %>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="sp_UrunGrubunaGoreUrun" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                            </div>

                            <!-- Controls -->
                            <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6">
                    <div class="banner-area-home-four">
                        <div class="row">
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                                <ItemTemplate>
                                    <div class="col-md-6 col-sm-6">
                                        <div class="banner-container">
                                            <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>">
                                                <div style="width:280px;height:260px;display:table;background-color:rgba(255,255,255,.0);">
                                                    <div style="text-align:center;vertical-align:middle;display:table-cell;">
                                                        <img src="<%# Eval("GorselAdres") %>" alt="<%# Eval("UrunAdi") %>" style="max-width:280px;max-height:260px;width:auto;height:auto;" />
                                                    </div>
                                                </div>
                                            </a>
                                            &nbsp;&nbsp;&nbsp;<div class="banner-text">
                                                <h3><%# Eval("UrunAdi") %></h3>
                                                <p><%# Eval("Aciklama").ToString().Length > 100 ? Eval("Aciklama").ToString().Substring(0, 99) + "..." : Eval("Aciklama").ToString() %></p>
                                                <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>">Ürün Detayları</a>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="select top 4 *,(select top 1 GorselAdres from UrunGorseli where UrunID=Urun.UrunID) as GorselAdres from Urun order by Tarih desc"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--End of Slider Area-->
    <!--Featured Product Carousel Area Start-->
    <div class="featured-product-carousel-area">
        <div class="container">
            <div class="section-padding">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-title">
                            <h2>Öne Çıkan Ürünler</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="product-carousel">
                        <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource4">
                            <ItemTemplate>
                                <div class="col-md-3">
                                    <!--item 1 start-->
                                    <div class="single-product-item">
                                        <div class="sale-product-label"><span><%# Convert.ToInt32(Eval("NetMiktar")) > 0 ? "Stokta" : "Tükendi" %></span></div>
                                        <div class="single-product clearfix">
                                            <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>">
                                                <span class="product-image">
                                                    <div style="width:230px;height:263px;display:table;background-color:rgba(255,255,255,.0);">
                                                        <div style="text-align:center;vertical-align:middle;display:table-cell;">
                                                            <img src="<%# Eval("GorselAdres") %>" alt="<%# Eval("UrunAdi") %>" style="max-width:230px;max-height:263px;width:auto;height:auto;" />
                                                        </div>
                                                    </div>
                                                </span>
                                                <span class="product-image hover-image">
                                                    <div style="width:230px;height:263px;display:table;background-color:rgba(255,255,255,.0);">
                                                        <div style="text-align:center;vertical-align:middle;display:table-cell;">
                                                            <img src="<%# Eval("GorselAdresHover") %>" alt="<%# Eval("UrunAdi") %>" style="max-width:230px;max-height:263px;width:auto;height:auto;" />
                                                        </div>
                                                    </div>
                                                </span>
                                                </a><div class="button-actions clearfix">
                                                <button id="add-to-cart-id-<%# Eval("UrunID") %>" class="button add-to-cart" type="button" onclick="addCart(<%# Eval("UrunID") %>, 1);" >
                                                    <span><i class="fa fa-shopping-cart"></i></span>
                                                </button>
                                                <ul class="add-to-links">
                                                    <li class="quickview">
                                                        <a class="btn-quickview modal-view" href="#" data-toggle="modal" data-target="#productModal<%# Eval("UrunID") %>">
                                                            <i class="fa fa-search-plus"></i>
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a class="link-wishlist" href="#" onclick="addFav(<%# Eval("UrunID") %>, <% Response.Write(Session["UyeID"] == null ? "-1" : Session["UyeID"].ToString()); %> );">
                                                            <i class="fa fa-heart"></i>
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a class="link-compare" href="#">
                                                            <i class="fa fa-retweet"></i>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <h2 class="single-product-name"><a href="#"><%# Eval("UrunAdi") %> </a></h2>
                                        <div class="price-box">
                                            <p class="old-price">
                                                <span class="price"><%# (double.Parse(Eval("BirimFiyat").ToString()) * 1.30).ToString("0.00")  %> &#8378</span>
                                            </p>
                                            <p class="special-price">
                                                <span class="price"><%# Convert.ToDouble(Eval("BirimFiyat")).ToString("0.00") %> &#8378</span>
                                            </p>
                                        </div>
                                    </div>
                                    <!--end of item 1-->
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource runat="server" ID="SqlDataSource4" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="sp_OneCikanUrunler" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--End of Featured Product Carousel Area-->
    <!--Banner Area Start-->
    <div class="banner-area">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-sm-8 hidden-xs">
                    <div class="banner-box">
                        <a href="#">
                            <img src="img/banner/6.jpg" alt="" />
                        </a>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="banner-box">
                        <a href="#">
                            <img src="img/banner/7.jpg" alt="" />
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--End of Banner Area-->
    <!--Product Category Area Start-->
    <div class="product-category-area section-padding">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-4">
                    <div class="single-products-category">
                        <div class="section-title">
                            <h2>En Yenı Ürünler</h2>
                        </div>
                        <div class="category-products">
                            <asp:Repeater ID="Repeater6" runat="server" DataSourceID="SqlDataSource5">
                                <ItemTemplate>
                                    <div class="product-items">
                                        <div class="p-category-image">
                                            <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>">
                                                <div style="width:100px;height:130px;display:table;background-color:rgba(255,255,255,.0);">
                                                    <div style="text-align:center;vertical-align:middle;display:table-cell;">
                                                        <img src="<%# Eval("GorselAdres") %>" alt="" style="max-width:100px;max-height:130px;" />
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                        <div class="p-category-text">
                                            <h2 class="category-product-name"><a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>"><%# Eval("UrunAdi") %></a></h2>
                                            <div class="price-box">
                                                <p class="special-price">
                                                    <span class="price"><%# Convert.ToDouble(Eval("BirimFiyat")).ToString(".00") %> &#8378</span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="SqlDataSource5" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="sp_EnYeniUrunler" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4">
                    <div class="single-products-category">
                        <div class="section-title">
                            <h2>Satişta Olan Ürünler</h2>
                        </div>
                        <div class="category-products">
                            <asp:Repeater ID="Repeater7" runat="server" DataSourceID="SqlDataSource6">
                                <ItemTemplate>
                                    <div class="product-items">
                                        <div class="p-category-image">
                                            <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>">
                                                <div style="width:100px;height:130px;display:table;background-color:rgba(255,255,255,.0);">
                                                    <div style="text-align:center;vertical-align:middle;display:table-cell;">
                                                        <img src="<%# Eval("GorselAdres") %>" alt="" style="max-height:130px;max-width:100px;" />
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                        <div class="p-category-text">
                                            <h2 class="category-product-name"><a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>"><%# Eval("UrunAdi") %></a></h2>
                                            <div class="price-box">
                                                <p class="special-price">
                                                    <span class="price"><%# Convert.ToDouble(Eval("BirimFiyat")).ToString(".00") %> &#8378</span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="SqlDataSource6" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="sp_SatistakiUrunler" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4">
                    <div class="single-products-category">
                        <div class="section-title">
                            <h2>En Beğenilen</h2>
                        </div>
                        <div class="category-products">
                            <asp:Repeater ID="Repeater9" runat="server" DataSourceID="SqlDataSource8">
                                <ItemTemplate>
                                    <div class="product-items">
                                        <div class="p-category-image">
                                            <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>">
                                                <div style="width:100px;height:130px;display:table;background-color:rgba(255,255,255,.0);">
                                                    <div style="text-align:center;vertical-align:middle;display:table-cell;">
                                                        <img src="<%# Eval("GorselAdres") %>" alt="" style="max-height:130px;max-width:100px;" />
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                        <div class="p-category-text">
                                            <h2 class="category-product-name"><a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>"><%# Eval("UrunAdi") %></a></h2>
                                            <div class="price-box">
                                                <p class="special-price">
                                                    <span class="price"><%# Convert.ToDouble(Eval("BirimFiyat")).ToString(".00") %> &#8378</span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="SqlDataSource8" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="sp_EnFazlaGoruntulenenler" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 hidden-sm">
                    <div class="single-products-category">
                        <div class="section-title">
                            <h2>Ekonomik Ürünler</h2>
                        </div>
                        <div class="category-products">
                            <asp:Repeater ID="Repeater8" runat="server" DataSourceID="SqlDataSource7">
                                <ItemTemplate>
                                    <div class="product-items">
                                        <div class="p-category-image">
                                            <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>">
                                                <div style="width:100px;height:130px;display:table;background-color:rgba(255,255,255,.0);">
                                                    <div style="text-align:center;vertical-align:middle;display:table-cell;">
                                                        <img src="<%# Eval("GorselAdres") %>" alt="" style="max-width:100px;max-height:130px;" />
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                        <div class="p-category-text">
                                            <h2 class="category-product-name"><a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>"><%# Eval("UrunAdi") %></a></h2>
                                            <div class="price-box">
                                                <p class="special-price">
                                                    <span class="price"><%# Convert.ToDouble(Eval("BirimFiyat")).ToString(".00") %> &#8378</span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="SqlDataSource7" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="sp_EkonomikUrunler" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--End of Product Category Area-->
    <!--Blog Area Start-->
    <div class="blog-area">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-title">
                        <h2>From the blog</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="blog-carousel">
                    <div class="col-md-4">
                        <div class="banner-box">
                            <a href="#" class="image-blog"><img src="img/blog/1.jpg" alt="" /></a>
                            <div class="single-blog">
                                <span class="date-time">
                                    <span class="days">18</span>
                                    <span class="months">Feb</span>
                                </span>
                                <a class="blog-title" href="blog-details.html"><span>voluptatibus maiores aut</span></a>
                                <p class="author">By BootExperts<span> ( 0 comments )</span></p>
                                <p class="no-margin">Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores aut find fault with...</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="banner-box">
                            <a href="#" class="image-blog"><img src="img/blog/2.jpg" alt="" /></a>
                            <div class="single-blog">
                                <span class="date-time">
                                    <span class="days">09</span>
                                    <span class="months">Jan</span>
                                </span>
                                <a class="blog-title" href="blog-details.html"><span>Beguiled  and demoralized</span></a>
                                <p class="author">By BootExperts<span> ( 0 comments )</span></p>
                                <p class="no-margin">Laboriosam ipsa temporibus magni assumenda vitae expedita incidunt, aperiam explicabo dignissimos...</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="banner-box">
                            <a href="#" class="image-blog"><img src="img/blog/3.jpg" alt="" /></a>
                            <div class="single-blog">
                                <span class="date-time">
                            <span class="days">01</span>
                            <span class="months">Mar</span>
                                </span>
                                <a class="blog-title" href="blog-details.html"><span>Lorem ipsum adipisicing </span></a>
                                <p class="author">By BootExperts<span> ( 0 comments )</span></p>
                                <p class="no-margin">Consectetur adipisicing elit. Nihil repellat impedit deleniti harum repellendus nobis dolore fuga....</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="banner-box">
                            <a href="#" class="image-blog"><img src="img/blog/1.jpg" alt="" /></a>
                            <div class="single-blog">
                                <span class="date-time">
                                    <span class="days">28</span>
                                    <span class="months">Jan</span>
                                </span>
                                <a class="blog-title" href="blog-details.html"><span>Repreherit labore totam </span></a>
                                <p class="author">By BootExperts<span> ( 0 comments )</span></p>
                                <p class="no-margin">In officia cumque ipsam neque ex non beatae, fugit quo qui error. Consectetur, quibusdam quidem fuga possimus.....</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--End of Blog Area-->
    <!--Quickview Product Start -->
    <div id="quickview-wrapper">
        <!-- Modal -->
        <asp:Repeater ID="Repeater5" runat="server" DataSourceID="SqlDataSource4">
            <ItemTemplate>
                <div class="modal fade" id="productModal<%# Eval("UrunID") %>" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <div class="modal-product">
                                    <div class="product-images">
                                        <div class="main-image images">
                                            <div style="width:254px;height:360px;display:table;background-color:rgba(255,255,255,.0);">
                                                <div style="text-align:center;vertical-align:middle;display:table-cell;">
                                                    <img src="<%# Eval("GorselAdres") %>" alt="" style="max-width:254px;max-height:360px;width:auto;height:auto;" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-info">
                                        <h1><%# Eval("UrunAdi") %></h1>
                                        <div class="price-box">
                                            <p class="price"><span class="special-price"><span class="amount"><%# Convert.ToDouble(Eval("BirimFiyat")).ToString("0.00") %> &#8378</span></span></p>
                                        </div>
                                        <a href="product-details.aspx?UrunId=<%# Eval("UrunID") %>" class="see-all">Ürün Detayları</a>
                                        <div class="quick-add-to-cart">
                                            <form method="post" class="cart">
                                                <div class="numbers-row">
                                                    <input type="number" id="french-hens<%# Eval("UrunID") %>" value="1" min="1" max="12">
                                                </div>
                                                <button class="single_add_to_cart_button" type="submit" onclick="addCart(<%# Eval("UrunID") %>, document.getElementById('french-hens<%# Eval("UrunID") %>').value); ">Sepete Ekle</button>
                                            </form>
                                        </div>
                                        <div class="quick-desc">
                                            <%# Eval("Aciklama") %>
                                        </div>
                                        <div class="social-sharing">
                                            <div class="widget widget_socialsharing_widget">
                                                <h3 class="widget-title-modal">Ürünü Paylaş</h3>
                                                <ul class="social-icons">
                                                    <li><a target="_blank" title="Facebook" href="#" class="facebook social-icon"><i class="fa fa-facebook"></i></a></li>
                                                    <li><a target="_blank" title="Twitter" href="#" class="twitter social-icon"><i class="fa fa-twitter"></i></a></li>
                                                    <li><a target="_blank" title="Pinterest" href="#" class="pinterest social-icon"><i class="fa fa-pinterest"></i></a></li>
                                                    <li><a target="_blank" title="Google +" href="#" class="gplus social-icon"><i class="fa fa-google-plus"></i></a></li>
                                                    <li><a target="_blank" title="LinkedIn" href="#" class="linkedin social-icon"><i class="fa fa-linkedin"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- .product-info -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <!--End of Quickview Product-->
</asp:Content>

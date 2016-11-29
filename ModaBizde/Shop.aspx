<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="ModaBizde.Shop" EnableEventValidation="false" %>
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
                                <li class="home"><a href="Default.aspx">AnaSayfa</a><span>/ </span></li>
                                <li><strong>Alışveriş</strong></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End of Breadcrumb-->
        <!--Shop Main Area Start-->
        <script type="text/javascript" src="js/cart.js"></script>
        <div class="shop-main-area">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <div class="sidebar-content">
                            <div class="section-title"><h2 id="h2KategoriGrup" runat="server">Kategori</h2></div>
                            <div class="sidebar-category-list">
                                <ul id="UlKategoriGrup" runat="server">
                                    <%-- Kategoriler veya Ürün Grupları --%>
                                </ul>
                            </div>
                            <div class="section-title border-none"><h2>Fiyat Aralığı</h2></div>
                            <div class="sidebar-category-list">
                                <div class="price_filter">
                                    <div id="slider-range"></div>
                                    <div class="price_slider_amount">
                                        <div class="slider-values">
                                            <asp:TextBox ID="txtTabanFiyat" runat="server" PlaceHolder="Alt Fiyat"></asp:TextBox>
                                        </div>
                                        <div class="slider-values">
                                            <asp:TextBox ID="txtTavanFiyat" runat="server" PlaceHolder="Üst Fiyat"></asp:TextBox>
                                        </div>
                                    </div>
                                    <button id="search_price" type="button" class="button" runat="server"><span><span>Ara</span></span></button>
                                </div>
                            </div>
                            <div class="section-title"><h2>Arama</h2></div>
                            <div class="sidebar-category-list">
                                <div class="price_filter">
                                    <div class="price_slider_amount">
                                        <div class="slider-values">
                                           <asp:TextBox ID="txtArama" runat="server" ></asp:TextBox>
                                        </div>
                                    </div>
                                    <button id="search_text" type="button" class="button" runat="server"><span><span>Ara</span></span></button>
                                </div>
                            </div>
                            <div class="section-title border-none"><h2>Markalar</h2></div>
                            <div class="sidebar-category-list">
                                <ul id="UlMarka" runat="server">
                                    <%-- Markalar --%>
                                </ul>
                            </div>
                            <div class="section-title border-none"><h2>Renkler</h2></div>
                            <div class="sidebar-category-list">
                                <ul id="UlRenk" runat="server">
                                    <%-- Renkler --%>
                                </ul>
                            </div>
                            <div class="section-title border-none"><h2>Bedenler</h2></div>
                            <div class="sidebar-category-list">
                                <ul id="UlBeden" runat="server">
                                    <%-- Bedenler --%>
                                </ul>
                            </div>
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
                    </div>
                    <div class="col-md-9">
                        <div class="shop-item-filter">
                            <div class="popular-tags">
                                <ul class="tag-list" id="UlFilters" runat="server">
                                    <%-- Filtreler --%>
                                </ul>
                            </div>
                            <div class="shop-tab clearfix">
                                <!-- Nav tabs -->
                                <ul class="nav nav-tabs navbar-left" role="tablist">
                                    <li role="presentation" class="active"><a href="#grid" class="grid-view" aria-controls="grid" role="tab" data-toggle="tab">Tablo</a></li>
                                    <li role="presentation"><a href="#list" class="list-view" aria-controls="list" role="tab" data-toggle="tab">Liste</a></li>
                                </ul>
                                <div class="filter-by">
                                    <h4>Sıra </h4>
                                    <div class="select-filter">
                                        <asp:DropDownList ID="ddlSort" runat="server" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged" AutoPostBack="true" EnableViewState="true">
                                            <asp:ListItem Value="sortByDate" Text="Tarih"></asp:ListItem>
                                            <asp:ListItem Value="sortByName" Text="İsim"></asp:ListItem>
                                            <asp:ListItem Value="sortByPrice" Text="Fiyat"></asp:ListItem>
                                            <asp:ListItem Value="sortByQuantity" Text="Miktar"></asp:ListItem>
                                            <asp:ListItem Value="sortByLiked" Text="Beğeni"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <p class="page floatright">Ürün Sayısı</p>
                                <div class="filter-by floatright">
                                    <h4>Sayfadaki </h4>
                                    <div class="select-filter">
                                        <asp:DropDownList ID="ddlNumberOfPage" runat="server" OnSelectedIndexChanged="ddlNumberOfPage_SelectedIndexChanged" AutoPostBack="true" EnableViewState="true">
                                            <asp:ListItem Value="twelve" Text="12"></asp:ListItem>
                                            <asp:ListItem Value="eighteen" Text="18"></asp:ListItem>
                                            <asp:ListItem Value="twentyfour" Text="24"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div> 
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="grid">
                                <div id="grid_row" class="row" runat="server">
                                    <%-- Ürünler --%>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane shop-list" id="list">
                                <div id="list_div" runat="server">
                                    <%-- Ürünler --%>
                                </div>
                            </div>    
                        </div>   
                        <div class="row">
                            <div class="col-md-12">
                                <div class="pagination-content">
                                    <div class="pagination-button">
                                        <ul class="pagination" id ="pagination_pages" runat="server">
                                        </ul>
                                        <span><strong>Sayfa: </strong></span>
                                    </div>
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
        <!--End of Shop Main Area-->
        <!--Quickview Product Start -->
        <div id="quickview_wrapper" runat="server">

        </div>
        <!--End of Quickview Product-->

</asp:Content>

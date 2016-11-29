<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="Blog.aspx.cs" Inherits="ModaBizde.Blog" EnableEventValidation="false" %>
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
                                <li class="home"><a href="Default.aspx">Anasayfa</a><span>/ </span></li>
                                <li><strong>Blog</strong></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End of Breadcrumb-->
        <!--Blog Post Area Start-->
        <div class="blog-page-area">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <div class="left-blog-sidebar">
                            <div class="sidebar-content">
                                <div class="section-title"><h2>Arama</h2></div>
                                <asp:TextBox ID="txtSearch" runat="server" Placeholder="Arayın"></asp:TextBox>
                                <button class="submit" id="btn_search" runat="server"><i class="fa fa-search"></i></button>
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
                                                <div class="post-info"><a href="Blog-Details.aspx?BlogId=<%# Eval("BlogID") %>"><%# Eval("BlogAdi") %></a><span><%# Eval("Tarih") %></span></div></li>
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
                                        <li><a href="Blog.aspx?arch=12-16">Aralık 2016</a></li>
                                        <li><a href="Blog.aspx?arch=11-16">Kasım 2016</a></li>
                                        <li><a href="Blog.aspx?arch=10-16">Ekim 2016</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9" runat="server" id="bloglar_area_div">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="pagination-content">
                                    <div class="pagination-button">
                                        <ul class="pagination">
                                            <li class="current"><a href="#">1</a></li>
                                            <li><a href="#">2</a></li>
                                            <li><a href="#"><i class="fa fa-caret-right"></i></a></li>
                                        </ul>
                                        <span><strong>Page: </strong></span>
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

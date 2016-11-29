<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="ModaBizde.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--Cart Main Area Start-->
    <div class="cart-main-area area-padding">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="page-title">
                        <h1>Alışveriş Sepeti</h1>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="cart-table table-responsive">
                        <table>
                            <thead>
                                <tr>
                                    <th class="p-image">Ürün Resmi</th>
                                    <th class="p-name">Ürün Adı</th>
                                    <th class="p-edit"></th>
                                    <th class="p-amount">Birim Fiyat</th>
                                    <th class="p-quantity">Adet</th>
                                    <th class="p-total">Toplam</th>
                                    <th class="p-times"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% System.Data.DataTable tablo = (System.Data.DataTable)HttpContext.Current.Session["sepet"]; %>
                                <%  for (int i = 0; i < (HttpContext.Current.Session["sepet"] == null ? 0 : tablo.Rows.Count); i++)
                                   { %>
                                <tr id="tr_product_id_<% Response.Write(tablo.Rows[i]["UrunID"].ToString()); %>">
                                    <td class="p-image">
                                        <a href="product-details.html">
                                            <img alt="" src="<% Response.Write(tablo.Rows[i]["Resim"].ToString()); %>" class="floatleft" /></a>
                                    </td>
                                    <td class="p-name"><a href="product-details.html"><% Response.Write(tablo.Rows[i]["UrunAdi"].ToString()); %></a></td>
                                    <td class="edit"><a href="product-details.html">Edit</a></td>
                                    <td class="p-amount"><% Response.Write((Convert.ToDouble(tablo.Rows[i]["Fiyat"])).ToString("0.00")); %></td>
                                    <td class="p-quantity">
                                        <input id="nmb_qnty_<% Response.Write(tablo.Rows[i]["UrunID"].ToString()); %>" type="number" value="<% Response.Write(tablo.Rows[i]["Miktar"].ToString()); %>" name="quantity" min="1" onchange=" changeCartQuantity(<% Response.Write(tablo.Rows[i]["UrunID"].ToString()); %>); " />
                                    </td>
                                    <td class="p-total"><% Response.Write((Convert.ToDouble(tablo.Rows[i]["Fiyat"]) * (Convert.ToDouble(tablo.Rows[i]["Miktar"]))).ToString("0.00")); %> &#8378</td>
                                    <td class="p-action"><a onclick=" deleteCart(<% Response.Write(tablo.Rows[i]["UrunID"].ToString()); %>); " style="cursor:pointer;"><i class="fa fa-times"></i></a></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <script type="text/javascript" src="js/cart.js"></script>
                        <div class="all-cart-buttons">
                            <button class="button" type="button" id="btn_devam_et" runat="server"><span>Alışverişe Devam Et</span></button>
                            <div class="floatright">
                                <button class="button clear-cart" type="button" id="btn_sepeti_temizle" runat="server"><span>Sepeti Temizle</span></button>
                                <button class="button" type="button" id="btn_sepeti_guncelle" runat="server"><span>Sepeti Güncelle</span></button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="shipping-discount">
                                <div class="shipping-title">
                                    <h3>Kargo ve Vergiyi Hesaplayın</h3>
                                </div>
                                <p>Kargoyu alacağınız bölgeyi seçin</p>
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 col-sm-6">
                                        <div class="level">
                                            Bölge <span class="">*</span>
                                        </div>
                                        <div class=" shipping-wrapper">
                                            <select class="country">
                                                <option value="state">Select options</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-6">
                                        <div class="level">
                                            İl/Şehir
                                        </div>
                                        <div class=" shipping-wrapper">
                                            <select class="country">
                                                <option value="state">Select options</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <div class="postal-code">
                                            <div class="level">
                                                Posta Kodu 
                                                   
                                            </div>
                                            <input type="text" placeholder="" name="zip-code" />
                                        </div>
                                        <div class="buttons-set">
                                            <button class="button" type="button"><span>Hesapla</span></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="shipping-discount">
                                <div class="shipping-title">
                                    <h3>İndirim Kodu</h3>
                                </div>
                                <p>Eğer varsa lütfen kupon kodunuzu giriniz</p>
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <div class="postal-code">
                                            <input type="text" placeholder="" />
                                        </div>
                                        <div class="buttons-set">
                                            <button class="button" type="button"><span>Kuponu Onayla</span></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="amount-totals">
                                <p class="total">Toplam Tutar <span>$156.87</span></p>
                                <p class="total">Ödenecek Tutar <span>$313.74</span></p>
                                <button class="button" type="button" id="btn_devam" runat="server"><span>Devam Et</span></button>
                                <div class="clearfix"></div>
                                <p class="floatright"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--End of Cart Main Area-->

</asp:Content>

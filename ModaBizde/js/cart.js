

function addCart(id, qty) {
    $.ajax({
        type: 'POST',
        url: 'Default.aspx/SepeteEkle',
        data: '{"id":"' + id + '","adet":"' + qty + '"}',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            showCart();
        },
        error: function () { alert('ajax error'); }
    });
    document.getElementById("text_message").value = "";
}

function showCart() {
    $.ajax({
        type: 'POST',
        url: 'Default.aspx/SepetiYukle',
        data: '{ }',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (data) {
            var cart_home_four = document.getElementsByClassName('header-r-cart cart-home-four')[0];
            cart_home_four.innerHTML = '';
            var cart_home_four_inner_html = '';
            var cart_products_inner_html = '';
            var toplam = ''; var urun_sayisi = 0;
            $.each(data.d, function (i) {
                var product_inner_html = '<div class="cart-products">' +
                    '<div class="cart-image">' +
                        '<a href="product-details.aspx?UrunId=' + this.id + '">' +
                            '<div style="width:70px;height:70px;display:table;background-color:rgba(255,255,255,.0);">' +
                                '<div style="text-align:center;vertical-align:middle;display:table-cell;">' +
                                    '<img src="' + this.resim + '" style="max-width:70px;max-height:70px;width:auto;height:auto;" alt="" />' +
                                '</div>' +
                            '</div>' +
                        '</a>' +
                    '</div>' +
                    '<div class="cart-product-info">' +
                        '<a href="product-details.aspx?UrunId=' + this.id + '" class="product-name">' + this.ad + '</a>' +
                        '<a class="edit-product">Edit item</a>' +
                        '<a class="remove-product" onclick=" deleteCart(' + this.id + '); ">Remove item</a>' +
                        '<div class="price-times">' +
                            '<span class="quantity"><strong>' + this.miktar + ' x </strong></span>' +
                            '<span class="p-price">' + this.fiyat + ' &#8378 = ' + this.toplam + ' &#8378 </span>' +
                        '</div>' +
                    '</div></div>';
                cart_products_inner_html = cart_products_inner_html + product_inner_html;
                toplam = this.tamtoplam; urun_sayisi++;
            });
            cart_home_four_inner_html = '<li><a class="cart" href="Cart.aspx"><span>' + urun_sayisi +
                '</span>Sepet:' + toplam + ' &#8378 </a><div class="mini-cart-content">' +
                '<div class="cart-products-list">' + cart_products_inner_html + '</div>' +
                '<div class="cart-price-list"><p class="price-amount">Toplam : <span>' + toplam +
                ' &#8378 </span></p><div class="cart-buttons"><a href="Checkout.aspx">Satın Al</a></div></div></div></li>';
            cart_home_four.innerHTML = cart_home_four_inner_html;
        },
        error: function () { }
    });
}

function addFav(urunid, uyeid) {
    if (uyeid == '-1') return;
    $.ajax({
        type: 'POST',
        url: 'Default.aspx/Begen',
        data: '{"urunid":"' + urunid + '","uyeid":"' + uyeid + '"}',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
        },
        error: function () { alert('ajax error'); }
    });
    document.getElementById("text_message").value = "";
}

function deleteCart(urunid) {
    var ret = 0;
    $.ajax({
        type: 'POST',
        url: 'Default.aspx/SepettenSil',
        data: '{"urunid":"' + urunid + '"}',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            showCart();
            var tr_elm = document.getElementById('tr_product_id_' + urunid);
            if (tr_elm != null) {
                tr_elm.parentNode.removeChild(tr_elm);
            }
        },
        error: function () { alert('ajax error'); }
    });
    return ret;
}

function changeCartQuantity(urunid) {
    var nmb_qnt = document.getElementById('nmb_qnty_' + urunid);
    $.ajax({
        type: 'POST',
        url: 'Cart.aspx/MiktarDegistir',
        data: '{"urunid":"' + urunid + '","miktar":"' + nmb_qnt.value + '"}',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            showCart();
        },
        error: function () { alert('ajax error'); }
    });
}


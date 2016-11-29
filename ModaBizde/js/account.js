


function changeAddress(st, uyeid) {
    var adres_div_p_elm = document.getElementById('adres_div_p');
    if (st == 0) { // Değiştir
        var adres_degistir_txt_elm = document.getElementById('adres_degistir_txt');
        var eski_adres = document.getElementById('adres_div_li').getElementsByTagName('p')[0].innerHTML;
        adres_degistir_txt_elm.innerHTML = eski_adres;
        $('#adres_degistir_li').show();
        $('#adres_div_li').hide();
        $('#btn_adres_kaydet').show();
        $('#btn_adres_degistir').hide();
    } else if (st == 1) { // Kaydet
        $('#adres_degistir_li').hide();
        $('#adres_div_li').show();
        $('#btn_adres_kaydet').hide();
        $('#btn_adres_degistir').show();
        var newAddress = $('#adres_degistir_txt').val();
        $.ajax({
            type: 'POST',
            url: 'Account.aspx/AdresDegistir',
            data: '{"uyeid":"' + uyeid + '","yeniadres":"' + newAddress + '"}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (msg) {
                document.getElementById('adres_div_li').getElementsByTagName('p')[0].innerHTML = newAddress;
                alert('Adres Başarıyla Değiştirildi');
            },
            error: function () { alert('ajax error'); }
        });
    }
}



<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="ModaBizde.AboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!--About Area Start-->
        <div class="home-hello-info">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="f-title text-center">
							<h3 class="title text-uppercase">Hakkımızda</h3>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-7 col-sm-12 col-xs-12">
						<div class="about-page-cntent">
							<h3>Moda Bizde Hakkında</h3>
							<p>Bu websitesi ASP.NET ile hazır template üzerine Master Page içeren bir proje olarak geliştirilmiştir. Veriler arkaplanda MS-SQL veritabanında tutulmaktadır. Sitenin geliştirilmesinde kullanılan bazı unsurlar detayları ile şöyledir:</p>
							<blockquote>
								<p>Veritabanındaki birbiri ile ilişkili tablo sayısı N' dir. Verilerin girişleri, değiştirilmesi veya silinmesi (insert, update, delete) işlemlerinde çalışan trigger' lar mevcuttur. Örneğin tek bir müşterinin satın alacağı birden fazla ürün için yine birden fazla fatura detayı girildiğinde tek bir faturada toplam ücreti belirtmek gibi... Bir kullanıcının ürün beğenmesi veya puan vermesi gibi işlemlerde de veritabanında ürünlerin tutulduğu tabloya güncelleme yapan tetikleyiciler (trigger) mevcuttur.</p>
                                <p>Veritabanında en çok satılan, her kategorinin en çok görüntülenen veya en çok beğenilen ilk dört ürünü çekmek gibi işlemler için prosedürler de mevcuttur. Bu işlemlerin çoğu anasayfada uygulanmakta olup,ürün detayı görüntülenirken kenar ve aşağı kısımlarda ürünle ilgili olan diğer ürünler de veritabanından bu şekilde alınmaktadır.</p>
								<p>Ürünlerin anasayfada listelenmesinde bir ASP.NET nesnesi olan Repeater kullanılmıştır. Çeşitli MS-SQL sorguları ve prosedürler ile belli başlı ürünler anasayfada görüntülenmektedir.</p>
								<p>Alışveriş yapan müşterinin sepete eklediği ürünler kendi oturum bilgisini içeren nesne olan Session' da tutulmaktadır. Javascript tarafında AJAX ile yazılmış fonksiyonlar sayesinde sayfa yenilemeksizin eklenen, silinen, adedi değiştirilen ürünler sepette güncellenebilmektedir.</p>
								<p>Web uygulamasının bazı işlemleri server ve client arasındaki ilişki (client tarafından gönderilen bir komut veya bilgi gibi), post (yani sayfayı tamamen yenileme) gerektirmektedir. Ancak bazı işlemler de AJAX sayesinde local post ile sayfayı tamamen yenilemeksizin sağlanabilmektedir.</p>
								<p>Örneğin sepet güncellemesi sayfayı tamamen yenilemezken, Ürün tablosu veya listesinde (Shop.aspx) arama işlemine uygulanan her filtre veya kaldırılan her filtre C# tarafındaki kodlarla çalıştığı için sayfayı yenilemektedir. Hatta post işleminden ziyade QueryString (sayfa adresi parametreleri) nesnesine ekleme, silme ve düzenleme yaparak yeniden yönlendirme yapılmaktadır. Örneğin; 'Shop.aspx?srch=pantolon' ismi içerisinde pantolon ifadesi geçen ürünleri listelerken sonradan eklenen lacivert renk filtresi ile 'Shop.aspx?srch=pantolon&clr=6' adresine yeniden yönlendirme yapılmaktadır. ( Respond.Redirect(...) )</p>
								<p>Ürün tablosu ve ürün listesinin bulunduğu Shop.aspx de veriler, Entity Framework ile veritabanından alınmaktadır. Filtre işlemleri (yani ürünün belirlenen kriterlere göre aranması) Entity' nin sunduğu LINQ sorgulamaları ile yazılmıştır.</p>
							</blockquote>
							<p>Projeye ulaşabileceğiniz GitHub adresi:</p>
                            <blockquote>
                                <p></p>
                            </blockquote>
							<p>Diğer projelerim</p>
                            <blockquote>
                                <p></p>
                            </blockquote>
						</div>
					</div>
					<div class="col-md-5 col-sm-12 col-xs-12">
						<div class="img-element">
							<img alt="banner1" src="img/logo/biglogo.png" />
						</div>
					</div>
				</div>
			</div>
		</div>
        <!--End of About Area-->
</asp:Content>

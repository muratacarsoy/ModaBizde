<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="ModaBizde.Account" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!-- Account Area start -->
        <div class="account-area area-padding">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="account-link-list">
                            <div class="page-title">
                                <h1>Üyelik Bilgilerim</h1>
                            </div>
                            <p class="account-info">Hesap ayarlarınızı buradan değiştirebilir güncelleyebilir ve alışveriş detaylarınızı inceleyebilirsiniz.</p>
                            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingOne">
                                        <h4 class="panel-title">
                                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#order">        
                                                <i class="fa fa-list-ol"></i><span>Fatura Geçmişi ve Detayları</span>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="order" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                        <div class="panel-body">
                                            <p class="panel-title">Üyeliğiniz oluşturulduğundan beri mevcut tüm siparişleriniz.</p>
                                            <div id="orders-history">
                                                <div id="faturalar_div" runat="server">
			                                        <p class="warning">Şu ana kadar mevcut bir siparişiniz yoktur.</p>
                                                </div>
	                                       </div>                                    
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingTwo">
                                        <h4 class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#credit">
                                                <i class="fa fa-file-o"></i><span>Geri ödemelerim</span>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="credit" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                        <div class="panel-body">
                                            <p class="panel-title">Herhangi bir geri ödemeniz bulunmamaktadır. </p>
                                            <div id="order-history">
			                                    <p class="warning">Herhangi bir geri ödemeniz yoktur.</p>
	                                       </div>                                    
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingThree">
                                        <h4 class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#address">
                                                <i class="fa fa-building"></i><span>Adresim</span>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="address" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                        <div class="panel-body">
                                            <p class="panel-title">Adresinizi buradan girebilir veya değiştirebilirsiniz. </p>
                                            <p>Güncel adresinizi girdiğinizden emin olun.</p>
                                            <div class="row">
                                                <div class="col-lg-6 col-md-8 col-sm-10 address">
                                                    <ul class="address-information">
                                                        <li><h3>Adresim</h3></li>
                                                        <li id="adres_div_li">
                                                            <p class="address" id="adres_div_p" name="adres_div_p" runat="server"></p>
                                                        </li>
                                                        <li id="adres_degistir_li" style="display:none;">
                                                            <textarea id="adres_degistir_txt" style="width:300px;height:200px;"></textarea>
                                                        </li>
                                                        <li class="address-update">
                                                            <button class="button" type="button" onclick=" changeAddress(0, <% Response.Write(Session["UyeID"] != null ? Session["UyeID"] : "-1"); %>); " id="btn_adres_degistir"><span>Değiştir</span></button>
                                                            <button class="button" type="button" onclick=" changeAddress(1, <% Response.Write(Session["UyeID"] != null ? Session["UyeID"] : "-1"); %>); " style="display:none;" id="btn_adres_kaydet"><span>Kaydet</span></button>
                                                        </li>
                                                    </ul>
                                                    <div class="clearfix"></div>
                                                    <script type="text/javascript" src="js/account.js"></script>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingFour">
                                        <h4 class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#information">
                                                <i class="fa fa-user"></i><span>Kişisel Bilgilerim</span>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="information" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                                        <div class="panel-body">
                                            <div class="row">   
                                                <div class="personal-info col-lg-6 col-md-8 col-sm-10">
                                                    <p class="panel-title">Please be sure to update your personal information if it has changed. </p>
                                                    <div id="account-info">
                                                        <div class="row">
                                                            <div class="form-group required">
                                                                <label class="col-md-12 col-sm-12 control-label">Ad</label>
                                                                <div class="col-md-12 col-sm-12">
                                                                    <input type="text" class="form-control" id="input-payment-fname" placeholder="Adınız" value="" name="firstname" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group required">
                                                                <label class="col-md-12 col-sm-12 control-label">Soyad</label>
                                                                <div class="col-md-12 col-sm-12">
                                                                    <input type="text" class="form-control" id="input-payment-lastname" placeholder="Soyadınız" value="" name="lastname" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group required">
                                                                <label class="col-md-12 col-sm-12 control-label">Email</label>
                                                                <div class="col-md-12 col-sm-12">
                                                                    <input type="text" class="form-control" id="email" placeholder="Email Adresiniz" value="" name="email" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group required">
                                                                <label class="col-md-12 col-sm-12 control-label">Telefon</label>
                                                                <div class="col-md-12 col-sm-12">
                                                                    <input type="text" class="form-control" id="phone" placeholder="Telefonunuz" value="" name="phone" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group required">
                                                                <label class="col-md-12 col-sm-12 control-label"> Mevcut Şifre </label>
                                                                <div class="col-md-12 col-sm-12">
                                                                    <input type="password" name="current-psw" class="form-control psw" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group required">
                                                                <label class="col-md-12 col-sm-12 control-label"> Yeni Şifre </label />
                                                                <div class="col-md-12 col-sm-12">
                                                                    <input type="password" name="new-psw" class="form-control psw" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group required">
                                                                <label class="col-md-12 col-sm-12 control-label"> Yeni Şifre (Onay) </label>
                                                                <div class="col-md-12 col-sm-12">
                                                                    <input type="password" name="confirm-psw" class="form-control psw" /> 
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12">
                                                                <div class="check-box">
                                                                    <div id="offers">
                                                                        <span><input type="checkbox" value="1" name="offer" id="offer" /></span>
                                                                        <span>Yeniliklerden haberdar olmak ve yeni teklifleri takip etmek istiyorum! </span>
                                                                    </div> 
                                                                </div>
                                                                <div class="buttons-set">
                                                                    <button class="button" type="button"><span>Kaydet</span></button>
                                                                </div>
                                                            </div>
                                                        </div>       
                                                    </div>
                                                </div>
                                            </div>    
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingFive">
                                        <h4 class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#wishlist">
                                                <i class="fa fa-heart"></i><span>Beğendiklerim</span>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="wishlist" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="wishlist-container">
                                                        <h3>Beğendiğiniz ürünler</h3>
                                                    </div>
                                                </div>   
                                            </div>    
                                        </div>
                                    </div>
                                </div>
                            </div>   
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="button-back">
                            <a href="account.html" class="read-button floatleft"><span>Back to your Account</span></a>
                        </div>
                        <div class="button-home">
                            <a href="index.html" class="read-button floatleft"><span>Home</span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End of Account Area-->	
</asp:Content>

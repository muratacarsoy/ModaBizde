<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="CheckOut.aspx.cs" Inherits="ModaBizde.CheckOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <!--Checkout Area Start-->
        <div class="checkout-area area-padding">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="page-title">
                            <h1>Checkout</h1>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-9 col-md-9">
                        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                            <% bool oturum = Session["UyeID"] != null;
                               if (!oturum)
                               {
                            %>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#checkout">
                                            <span>1</span>Ödeme Şekli
                                        </a>
                                    </h4>
                                </div>
                                <div id="checkout" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                    <div class="panel-body">
                                        <div class="row">   
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                                <div class="single-checkout">
                                                    <h3 class="login-title">Misafir olarak ödeme yapın veya kayıt olun</h3>
                                                    <p class="heading-p">Gelecekteki alışverişleriniz için kayıt olun!</p>
                                                        <label>
                                                            <input id="radPay1" type="radio" name="check" value="guest" checked="checked" onchange="$('#btnPayAsGuest').show(); $('#btnRegisterNow').hide(); " />
                                                            <span>Misafir olarak öde</span>
                                                        </label>
                                                        <label>
                                                            <input id="radPay2" type="radio" name="check" value="user" onchange="$('#btnPayAsGuest').hide(); $('#btnRegisterNow').show(); " />
                                                            <span>Kayıt Ol</span>
                                                        </label>
                                                </div>
                                                <div class="single-checkout">
                                                    <h4>Kısa sürede kayıt olun</h4>
                                                    <p class="heading-p">Gelecekteki alışverişleriniz için kayıt olun!</p>
                                                    <p class="fast-check">Hızlı ve kolay ödeme</p><br />
                                                    <a id="btnPayAsGuest" role="button" data-toggle="collapse" data-parent="#accordion" href="#checkout#billing" class="c-btn">Devam Et</a>
                                                    <a id="btnRegisterNow" href="Register.aspx" class="c-btn" style="display:none;">Devam Et</a>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                                <div class="single-checkout right">
                                                    <h3 class="login-title">Giriş</h3>
                                                    <h4>Zaten kayıtlı mısınız?</h4>
                                                    <p>Giriş yapmak için :</p>
                                                    <div class="login-form">
                                                        <p>Kullanıcı Adınız<span>*</span></p>
                                                        <asp:TextBox ID="txtAccountName" runat="server"></asp:TextBox>
                                                        <p>Şifreniz<span>*</span></p>
                                                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                        <a href="help-center.html" class="forgot-pass">Şifrenizi mi unuttunuz?</a>
                                                        <asp:LinkButton ID="btnLogin" CssClass="login-btn" runat="server" OnClick="btnLogin_Click" CausesValidation="false">Giriş</asp:LinkButton>
                                                    </div>
                                                </div>    
                                            </div>
                                        </div>    
                                    </div>
                                </div>
                            </div>
                            <% }%>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingTwo">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#billing">
                                            <span><% if (oturum) Response.Write("1"); else Response.Write("2"); %></span> Müşteri Bilgileri
                                        </a>
                                    </h4>
                                </div>
                                <div id="billing" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                    <div class="panel-body">
                                        <div class="login-form">
                                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                            <div class="customer-name">
                                                <div class="first-name">
                                                    <p>Ad<span>*</span></p>
                                                    <asp:TextBox ID="txtFirstName" runat="server" ></asp:TextBox>
                                                </div>
                                                <div class="last-name">
                                                    <p>Soyad<span>*</span></p>
                                                    <asp:TextBox ID="txtLastName" runat="server" ></asp:TextBox>
                                                </div>
                                                <div class="last-name">
                                                    <p>TC Kimlik<span>*</span></p>
                                                    <asp:TextBox ID="txtTCKimlik" runat="server" ></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                                        ErrorMessage="Boş Geçilemez" ControlToValidate="txtTCKimlik"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="11 Hane Olacak" 
                                                        ControlToValidate="txtTCKimlik" ValidationExpression="[0-9]{11}"></asp:RegularExpressionValidator>
                                                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTCKimlik" Mask="99999999999" MaskType="Number" />
                                                </div>
                                            </div>
                                            <div class="customer-info">
                                                <div class="company-name">
                                                    <p>Kurum</p>
                                                    <asp:TextBox ID="txtCompany" runat="server"></asp:TextBox>
                                                </div>
                                                <div class="email-address">
                                                    <p>Email Adresi<span>*</span></p>
                                                    <asp:TextBox ID="txtEmailBilling" runat="server" ></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                        ErrorMessage="Boş Geçilemez" ControlToValidate="txtEmailBilling"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                                        ErrorMessage="Uygun Format Degil" ControlToValidate="txtEmailBilling"
                                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ></asp:RegularExpressionValidator>
                                                </div>
                                                <div class="email-address">
                                                    <p>Kargo<span>*</span></p>
                                                    <asp:DropDownList ID="ddlKargo" runat="server" DataSourceID="SqlDataSource1" DataTextField="KargoAdi" DataValueField="KargoID"  ></asp:DropDownList>
                                                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="SELECT [KargoID], [KargoAdi] FROM [Kargo]"></asp:SqlDataSource>
                                                </div>
                                            </div>
                                            <p>Address<span>*</span></p>
                                            <asp:TextBox ID="txtAddress1" runat="server" ></asp:TextBox>
                                            <asp:TextBox ID="txtAddress2" runat="server"></asp:TextBox>
                                            <div class="customer-info">
                                                <div class="telephone">
                                                    <p>Telephone<span>*</span></p>
                                                    <asp:TextBox ID="txtTelephone" runat="server" ></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                                        ErrorMessage="Boş Geçilemez" ControlToValidate="txtTelephone"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="buttons-set">
                                                <a class="c-btn" role="button" data-toggle="collapse" data-parent="#accordion" href="#billing#payment-info">Devam Et</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#payment-info">
                                            <span><% if (oturum) Response.Write("2"); else Response.Write("3"); %></span> Ödeme Bilgileri
                                        </a>
                                    </h4>
                                </div>
                                <div id="payment-info" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                        <div class="ship-method payment">
                                            <div class="ship-wrap">
                                                <div class="ship-address">
                                                    <input type="radio" name="check" value="check" />
                                                    <span>Banka Hesabı </span>
                                                </div>
                                                 <div class="ship-address">
                                                    <input type="radio" name="check" value="credit" />
                                                    <span>Kredi Kartı </span>
                                                </div>
                                            </div>
                                            <div class="buttons-set">
                                                <p class="back-link"><a class="c-btn" role="button" data-toggle="collapse" data-parent="#accordion" href="#payment-info#billing">Geri</a></p>
                                                <p class="back-link"><a class="c-btn" role="button" data-toggle="collapse" data-parent="#accordion" href="#payment-info#order-review">Devam</a></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingFour">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#order-review">
                                            <span><% if (oturum) Response.Write("3"); else Response.Write("4"); %></span> Sipariş Önizleme
                                        </a>
                                    </h4>
                                </div>
                                <div id="order-review" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                            <div class="checkout-table table-responsive">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th class="p-name alignleft">Ürün Adı</th>
                                                            <th class="p-amount">Fiyat</th>
                                                            <th class="p-quantity">Adet</th>
                                                            <th class="p-total">Toplam</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% System.Data.DataTable sepet = new System.Data.DataTable();
                                                           sepet = (System.Data.DataTable)HttpContext.Current.Session["sepet"];
                                                           double toplam = 0.0;
                                                           for (int i = 0; i < (HttpContext.Current.Session["sepet"] == null ? 0 : sepet.Rows.Count); i++)
                                                           {
                                                               toplam += Convert.ToDouble(sepet.Rows[i]["Fiyat"]) * Convert.ToDouble(sepet.Rows[i]["Miktar"]);
                                                        %>
                                                        <tr>
                                                            <td class="p-name"><% Response.Write(sepet.Rows[i]["UrunAdi"].ToString()); %></td>
                                                            <td class="p-amount"><span class="amount"><% Response.Write(Convert.ToDouble(sepet.Rows[i]["Fiyat"]).ToString(".00")); %> &#8378 </span></td>
                                                            <td class="p-quantity"><% Response.Write(sepet.Rows[i]["Miktar"].ToString()); %></td>
                                                            <td class="p-total alignright"><% Response.Write((Convert.ToDouble(sepet.Rows[i]["Fiyat"]) * Convert.ToDouble(sepet.Rows[i]["Miktar"])).ToString()); %> &#8378 </td>
                                                        </tr>
                                                        <% } %>
                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <td colspan="3" class="alignright">Toplam Fiyat</td>
                                                            <td class="floatright"> <% Response.Write(toplam.ToString("0.00")); %> &#8378 </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" class="alignright">Kargo Ücreti</td>
                                                            <td class="floatright">7,00 &#8378 </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" class="alignright"><strong>Toplam Tutar</strong></td>
                                                            <td class="alignright"><strong> <% Response.Write((toplam + 7).ToString("0.00")); %> &#8378 </strong></td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                                <div class="checkout-buttons">
                                                    <p class="floatleft">Bir ürün mü unuttunuz? <a href="#"> Ödeme Ayarlarınızı Düzenleyin.</a></p>
                                                    <asp:Button ID="btnFaturaKaydet" CssClass="c-btn" runat="server" Text="Siparişi Ödeyin" OnClick="btnFaturaKaydet_Click" />
                                                </div>
                                            </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3">
                        <div class="checkout-progress">
                            <div class="section-title"><h2>Checkout Progress</h2></div>
                            <ul class="check">
                                <li><a href="#"><i class="fa fa-angle-right"></i>Billing address</a></li>
                                <li><a href="#"><i class="fa fa-angle-right"></i>Shipping address</a></li>
                                <li><a href="#"><i class="fa fa-angle-right"></i>shipping method</a></li>
                                <li><a href="#"><i class="fa fa-angle-right"></i>payment method</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End of Checkout Area-->      
</asp:Content>

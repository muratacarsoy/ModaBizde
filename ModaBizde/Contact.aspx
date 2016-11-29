<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="ModaBizde.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Contact Us Area Start-->
    <div class="contact-us-area area-padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-3">
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
                                <a href="#">Tüm Arananları Göster</a>
                            </div>
                        </div>
                    </div>
                    <div class="sidebar-content">
                        <div class="banner-box">
                            <a href="#"><img src="img/banner/14.jpg" alt="" /></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
                    <div class="contact-us-area">
                        <!-- google-map-area start -->
                        <div class="google-map-area">
                            <!--  Map Section -->
                            <div id="contacts" class="map-area">
                                <div id="googleMap" style="width: 100%; height: 430px;">
                                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3011.609313654861!2d29.026607314729798!3d40.990035028497324!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14cab868a9505821%3A0x9d555518287662c0!2sSmartpro+Bilgisayar+Akademisi!5e0!3m2!1str!2str!4v1478701720392" width="100%" height="100%" frameborder="0" style="border: 0" allowfullscreen></iframe>
                                </div>
                            </div>
                        </div>
                        <!-- google-map-area end -->
                        <!-- contact us form start -->
                        <div class="contact-us-form">
                            <div class="page-title">
                                <h1>Checkout</h1>
                            </div>
                            <div class="contact-form">
                                <span class="legend">Contact Information</span>
                                <div class="form-top">
                                    <div class="form-group col-sm-6 col-md-6 col-lg-6">
                                        <label>İsim<span class="" title="">*</span></label>
                                        <asp:TextBox ID="txtname" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="FieldValidator1" runat="server" ErrorMessage="Boş Geçilmez" ControlToValidate="txtname" CssClass="alert-danger"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-sm-6 col-md-6 col-lg-6">
                                        <label>Email<span class="" title="">*</span></label>
                                        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-sm-6 col-md-6 col-lg-6">
                                        <label>Telefon<span class="" title="">*</span></label>
                                        <asp:TextBox ID="txtNumber" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-sm-12 col-md-12 col-lg-12">
                                        <label>Mesaj<span class="" title="">*</span></label>
                                        <asp:TextBox ID="txtMessage" CssClass="yourmessage" runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="submit-form form-group col-sm-12 submit-review">
                                    <p class="floatright"><sup>*</sup>  Zorunlu Alanlar</p>
                                    <div class="clearfix"></div>
                                    <asp:Button ID="btnGonder" CssClass="btn btn-success floatright" runat="server" Text="Gönder" OnClick="btnGonder_Click" />
                                </div>
                            </div>
                        </div>
                        <!-- contact us form end -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--End of Contact Us ARea-->
</asp:Content>

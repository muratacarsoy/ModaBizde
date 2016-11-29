<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="NotFound404.aspx.cs" Inherits="ModaBizde.NotFound404" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="main" class="clearfix " style="">
        <div class="fusion-row" style="">
            <div id="content" class="full-width">
                <div id="post-404page">
                    <div class="post-content">
                        <div class="fusion-title fusion-title-size-two sep-single" style="margin-top:50px; margin-bottom: 30px;margin-left:100px;">
                            <h2 class="title-heading-left">Özür dileriz, bu sayfa kullanımda değil</h2>
                            <div class="title-sep-container">
                                <div class="title-sep sep-single"></div>
                            </div>
                        </div>
                        <div class="fusion-clearfix"></div>
                        <div class="error-page">
                            <div class="fusion-columns fusion-columns-3">
                                <div class="fusion-column col-lg-4 col-md-4 col-sm-4">
                                    <div class="error-message">404</div>
                                </div>
                                <div class="fusion-column col-lg-4 col-md-4 col-sm-4">
                                    <h3>Websitemizi arayın</h3>
                                    <p>İstediğiniz ürünü bulamadıysanız ürünün adını kutuya yazarak aratın</p>
                                    <div class="search-page-search-form">
                                        <div class="search-table">
                                            <div class="search-field">
                                                <input type="text" value="" name="s" class="s" placeholder="Arayın ..." runat="server" id="txt_search" />
                                            </div>
                                            <div class="search-button">
                                                <input type="submit" class="searchsubmit" value="Ara" runat="server" id="btn_search" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- fusion-row -->
    </div>
</asp:Content>

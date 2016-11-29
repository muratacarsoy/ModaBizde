<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ModaBizde.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>ÜYE GİRİŞİ</h1>
        <div class="row h5">
            <div class="col-md-3 text-right">
                Kullanıcı Adı :
            </div>
            <div class="col-md-9">
                <asp:TextBox ID="txtKullaniciAdi" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="FieldValidator1" runat="server"
                    ErrorMessage="Boş Geçilemez" ControlToValidate="txtKullaniciAdi"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row h5">
            <div class="col-md-3 text-right">
                Şifre :
            </div>
            <div class="col-md-9">
                <asp:TextBox ID="txtSifre" TextMode="Password" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="FieldValidator2" runat="server"
                    ErrorMessage="Boş Geçilemez" ControlToValidate="txtSifre"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <asp:Button ID="btnGiris" CssClass="btn btn-success" runat="server" Text="Giriş Yap" OnClick="btnGiris_Click" />
            </div>
        </div>
    </div>
</asp:Content>

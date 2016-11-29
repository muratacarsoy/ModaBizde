<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSablon.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ModaBizde.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row h5">
            <div class="col-md-12 h1">
                <h1>Yeni Uye</h1>
            </div>
        </div>
        <div class="divider"></div>
        <div class="row h5">
            <div class="col-md-3 text-right">
                Kullanıcı Adı :
            </div>
            <div class="col-md-9">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:TextBox ID="txtKullaniciAdi" runat="server" OnTextChanged="txtKullaniciAdi_TextChanged" AutoPostBack="True"></asp:TextBox>
                        <asp:Label ID="lblMesaj" Visible="false" runat="server" Text="Sistemde Kayıtlı"></asp:Label>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtKullaniciAdi" EventName="TextChanged" />
                    </Triggers>
                </asp:UpdatePanel>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ErrorMessage="Boş Geçilemez" ControlToValidate="txtKullaniciAdi"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row h5">
            <div class="col-md-3 text-right">
                Şifre :
            </div>
            <div class="col-md-9">
                <asp:TextBox ID="txtSifre" TextMode="Password" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ErrorMessage="Boş Geçilemez" ControlToValidate="txtSifre"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row h5">
            <div class="col-md-3 text-right">
                Şifre (Tekrar) :
            </div>
            <div class="col-md-9">
                <asp:TextBox ID="txtSifreTekrar" TextMode="Password" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                    ErrorMessage="Boş Geçilemez" ControlToValidate="txtSifreTekrar"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Şifreler Uyuşmuyor"
                    ControlToValidate="txtSifreTekrar" ControlToCompare="txtSifre"></asp:CompareValidator>
            </div>
        </div>
        <div class="row h5">
            <div class="col-md-3 text-right">
                E-Mail :
            </div>
            <div class="col-md-9">
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                    ErrorMessage="Boş Geçilemez" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ErrorMessage="Uygun Format Degil" ControlToValidate="txtEmail"
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="row h5">
            <div class="col-md-3 text-right">
                Ad Soyad :
            </div>
            <div class="col-md-9">
                <asp:TextBox ID="txtAdSoyad" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                    ErrorMessage="Boş Geçilemez" ControlToValidate="txtAdSoyad"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row h5">
            <div class="col-md-3 text-right">
                Tc Kimlik :
            </div>
            <div class="col-md-9">
                <asp:TextBox ID="txtTcKimlik" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                    ErrorMessage="Boş Geçilemez" ControlToValidate="txtTcKimlik"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="11 Hane Olacak" 
                    ControlToValidate="txtTcKimlik" ValidationExpression="[0-9]{11}"></asp:RegularExpressionValidator>
                <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTcKimlik" Mask="99999999999" MaskType="Number" />
            </div>
        </div>
        <div class="row h5">
            <div class="col-md-3 text-right">
                Adres :
            </div>
            <div class="col-md-9">
                <asp:TextBox ID="txtAdres" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                    ErrorMessage="Boş Geçilemez" ControlToValidate="txtAdres"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row h5">
            <div class="col-md-3 text-right">
                Telefon :
            </div>
            <div class="col-md-9">
                <asp:TextBox ID="txtTelefon" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                    ErrorMessage="Boş Geçilemez" ControlToValidate="txtTelefon"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <asp:Button ID="btnRegister" CssClass="btn btn-success" runat="server" Text="Kayıt Ol" OnClick="btnRegister_Click" />
            </div>
        </div>
    </div>
</asp:Content>

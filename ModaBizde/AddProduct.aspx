<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSablon.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="ModaBizde.AddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row h5">
            <div class="col-md-12 h1">
                <h3>Ürün Ekle</h3>
            </div>
        </div>
        <hr />
        <div class="col-md-4">
            <div class="row h5 table-bordered">
                <div class="col-md-2 text-right">
                    Ürün Adı:
                </div>
                <div class="col-md-10">
                    <asp:TextBox ID="txtUrunAdi" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUrunAdi" runat="server"
                        ErrorMessage="Boş Geçilemez" ControlToValidate="txtUrunAdi"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row h5 table-bordered">
                <div class="col-md-2 text-right">
                    Bitiş Tarihi:
                </div>
                <div class="col-md-10">
                    <asp:Calendar ID="cldBitisTarihi" runat="server"></asp:Calendar>
                </div>
            </div>
            <div class="row h5 table-bordered">
                <div class="col-md-2 text-right">
                    Fiyat:
                </div>
                <div class="col-md-10">
                    <asp:TextBox ID="txtFiyat" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFiyat" runat="server"
                        ErrorMessage="Boş Geçilemez" ControlToValidate="txtFiyat"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revFiyat" runat="server"
                        ErrorMessage="Uygun Format Degil (Örn. 49,99)" ControlToValidate="txtFiyat"
                        ValidationExpression="^[0-9]+[,][0-9]{2}$"></asp:RegularExpressionValidator>
                </div>
        </div>
        <div class="row h5 table-bordered">
            <div class="col-md-2 text-right">
                Marka:
            </div>
            <div class="col-md-10">
                <asp:DropDownList ID="ddlMarkalar" runat="server" DataSourceID="sqlMarkalar" DataTextField="MarkaAdi" DataValueField="MarkaID"></asp:DropDownList>
                <asp:SqlDataSource ID="sqlMarkalar" runat="server" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="SELECT * FROM [Marka]"></asp:SqlDataSource>
            </div>
        </div>
        <div class="row h5 table-bordered">
            <div class="col-md-2 text-right">
                Açıklama:
            </div>
            <div class="col-md-10">
                <asp:TextBox ID="txtAciklama" runat="server" TextMode="MultiLine" Columns="40" Rows="9"></asp:TextBox>
            </div>
        </div>
    </div>
        <div class="col-md-4">
            <div class="row h5 table-bordered">
                <div class="col-md-3 text-right">
                    Kategori:
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlKategoriler" runat="server" DataSourceID="sdsKategoriler" DataTextField="KategoriAdi" DataValueField="KategoriID" AutoPostBack="true" OnSelectedIndexChanged="ddlKategoriler_SelectedIndexChanged"></asp:DropDownList>
                    <asp:SqlDataSource ID="sdsKategoriler" runat="server" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="SELECT * FROM [Kategori]"></asp:SqlDataSource>
                </div>
                <div class="col-md-3 text-right">
                    Grup:
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlUrunGrubu" runat="server" DataSourceID="sdsGruplar" DataTextField="GrupAdi" DataValueField="GrupID"></asp:DropDownList>
                    <asp:SqlDataSource ID="sdsGruplar" runat="server" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="SELECT * FROM [UrunGrubu] WHERE KategoriID = 1"></asp:SqlDataSource>
                </div>
            </div>
            <div class="row h5 table-bordered">
                <div class="col-md-3 text-right">
                    Miktar:
                </div>
                <div class="col-md-9">
                    <asp:TextBox ID="txtMiktar" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMiktar" runat="server"
                        ErrorMessage="Boş Geçilemez" ControlToValidate="txtMiktar"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revMiktar" runat="server"
                        ErrorMessage="Uygun Format Degil" ControlToValidate="txtMiktar"
                        ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row h5 table-bordered">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-3 text-right">
                            Renk:
                        </div>
                        <div class="col-md-5">
                            <asp:DropDownList ID="ddlRenkler" runat="server" DataSourceID="sdsRenkler" DataTextField="RenkAdi" DataValueField="RenkID"></asp:DropDownList>
                            <asp:SqlDataSource ID="sdsRenkler" runat="server" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="SELECT * FROM [Renk]"></asp:SqlDataSource>
                        </div>
                        <div class="col-md-4">
                            <asp:Button ID="btnRenkEkle" runat="server" CssClass="btn-link" Text="Ekle" OnClick="btnRenkEkle_Click" CausesValidation="false" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-6">
                            <asp:Button ID="btnRenkleriSil" runat="server" CssClass="btn-link" Text="Temizle" OnClick="btnRenkleriSil_Click" Visible="false" CausesValidation="false" />
                        </div>
                        <div class="col-md-6">
                            <asp:BulletedList ID="blRenkler" runat="server" BulletStyle="Square"></asp:BulletedList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row table-bordered">
                <div class="row h5">
                    <div class="col-md-12">
                        <div class="col-md-3 text-right">
                            Görseller:
                        </div>
                        <div class="col-md-9">
                            <asp:FileUpload ID="fuGorselUpload" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="row h5">
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <div class="col-md-12">
                                <div class="row h5">
                                    <asp:Button ID="btnGorselEkle" runat="server" CssClass="btn-link" Text="Ekle" OnClick="btnGorselEkle_Click" CausesValidation="false" />
                                </div>
                                <div class="row h5">
                                    <asp:Button ID="btnGorselleriSil" runat="server" CssClass="btn-link" Text="Temizle" OnClick="btnGorselleriSil_Click" Visible="false" CausesValidation="false" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <%
                                System.Data.DataTable dtG = new System.Data.DataTable();
                                if (Session["YuklenenGorseller"] == null)
                                    dtG = new System.Data.DataTable();
                                else dtG = (System.Data.DataTable)Session["YuklenenGorseller"];
                                int i = 0, c = dtG.Rows.Count;
                                while (i < c)
                                {
                                    string gorselAdres = dtG.Rows[i]["GorselAdres"].ToString();
                            %>
                            <div style="width: 100px; height: 130px; display: table; background-color: rgba(255,255,255,.0); float: left;">
                                <div style="text-align: center; vertical-align: middle; display: table-cell;">
                                    <img src="<% Response.Write(gorselAdres); %>" alt="" style="max-width: 100px; max-height: 130px;" />
                                </div>
                            </div>
                            <%
                                    i++;
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="row h5 table-bordered">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-3 text-right">
                            Beden:
                        </div>
                        <div class="col-md-5">
                            <asp:DropDownList ID="ddlBedenler" runat="server" DataSourceID="sdsBedenler" DataTextField="BedenBoyu" DataValueField="BedenID"></asp:DropDownList>
                            <asp:SqlDataSource ID="sdsBedenler" runat="server" ConnectionString='<%$ ConnectionStrings:baglantimetni %>' SelectCommand="SELECT * FROM [Beden]"></asp:SqlDataSource>
                        </div>
                        <div class="col-md-4">
                            <asp:Button ID="btnBedenEkle" runat="server" CssClass="btn-link" Text="Ekle" OnClick="btnBedenEkle_Click" CausesValidation="false" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-6">
                            <asp:Button ID="btnBedenleriSil" runat="server" CssClass="btn-link" Text="Temizle" OnClick="btnBedenleriSil_Click" Visible="false" CausesValidation="false" />
                        </div>
                        <div class="col-md-6">
                            <asp:BulletedList ID="blBedenler" runat="server" BulletStyle="Square"></asp:BulletedList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row h5">
                <div class="row">
                    <div class="col-md-12">
                        <asp:Button ID="btnKaydet" runat="server" CssClass="login-btn" Text="Kaydet" OnClick="btnKaydet_Click" />
                    </div>
                </div>
            </div>
            <div class="row h5">
                <div class="row">
                    <div class="col-md-12">
                        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

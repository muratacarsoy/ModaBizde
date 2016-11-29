using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public bool MailGonder(string konu, string icerik)
        {
            MailMessage ePosta = new MailMessage();
            ePosta.From = new MailAddress("dos.cem@gmail.com");
            ePosta.To.Add("dos.cem@gmail.com");
            ePosta.IsBodyHtml = true;
            ePosta.Subject = konu;
            ePosta.Body = icerik;
            SmtpClient smtp = new SmtpClient();
            #region Sifre
            string sifre = "27689495156@_";
            #endregion
            smtp.Credentials = new System.Net.NetworkCredential("dos.cem@gmail.com", sifre);
            smtp.Port = 587;
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            try
            {
                smtp.Send(ePosta);
                return true;
            }
            catch (Exception ex)
            {
                Response.Write(string.Format("<script>alert('{0}');</script>", ex.Message));
                return false;
            }
        }

        protected void btnGonder_Click(object sender, EventArgs e)
        {
            bool cevap=MailGonder("Site Maili Hk.",string.Format(@"<h1>{0} kişisi tarafından</h1>
                                          <h3>Email : {1}</h3>
                                          <h3>Telefon : {2}</h3>
                                          <h3>Kişinin Gönderdiği Mail:</h3>
                                          <h5>{3}</h5>", txtname.Text, txtEmail.Text, txtNumber.Text, txtMessage.Text));
            if (cevap)
                Response.Write("<script>alert('Mesaj Tarafımıza İletildi...!');</script>");
        }
    }
}
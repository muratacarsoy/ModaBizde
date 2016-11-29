using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ModaBizde
{
    public partial class NotFound404 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btn_search.ServerClick += Btn_search_ServerClick;
        }

        private void Btn_search_ServerClick(object sender, EventArgs e)
        {
            string arama = txt_search.Value;
            if (arama.Length > 0)
            {
                Response.Redirect("Shop.aspx?srch=" + arama);
            }
        }
    }
}
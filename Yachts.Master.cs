using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace yatch_project
{
    public partial class Yachts : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    if (HiddenField1.Value == "mainPage.aspx")
            //    {
            //        Button2.BackColor =System.Drawing.Color.Crimson;
            //    }
            //    if (HiddenField1.Value == "WebForm1.aspx")
            //    {
            //        Button1.BackColor = System.Drawing.Color.Crimson;
            //    }
            //    Label Label_contentPage = ContentPlaceHolder1.FindControl("Label_contentPage") as Label;
            //    Label_contentPage.Text = "2019夏季日劇 凪的新生活(由 MasterPage 讀取 ContentPage 的 Controls)";
            //}

        }

        //protected void LinkButton1_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("Yachts_Layout.aspx");
        //}

        //protected void Button2_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("Yachts_Layout.aspx");
        //}


    }
}
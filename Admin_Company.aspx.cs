using CKFinder;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace yatch_project
{
    public partial class Admin_Company : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            FileBrowser fileBrowser = new FileBrowser();
            fileBrowser.BasePath = "/ckfinder";
            fileBrowser.SetupCKEditor(CKEditorControl1);
            fileBrowser.SetupCKEditor(CKEditorControl2);
            AboutUsHTML();
            CertificateHTML();
            }
        }

        private void AboutUsHTML()
        {
            //取得 About Us 頁面 HTML 資料
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sql = "SELECT content FROM Company WHERE id = 1";
            SqlCommand command = new SqlCommand(sql, connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            if (reader.Read())
            {
                //渲染畫面
                CKEditorControl1.Text = HttpUtility.HtmlDecode(reader["content"].ToString());
                AboutUsContent.Text = HttpUtility.HtmlDecode(reader["content"].ToString());
            }


            connection.Close();
        }

        protected void UploadAboutUsBtn_Click(object sender, EventArgs e)
        {
            //取得 CKEditorControl 的 HTML 內容
         
            string aboutUsHtmlStr = HttpUtility.HtmlEncode(CKEditorControl1.Text);
            //更新 About Us 頁面 HTML 資料
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sqlupdate = "UPDATE Company SET content = @content WHERE id = 1";
            SqlCommand command = new SqlCommand(sqlupdate, connection);
            command.Parameters.AddWithValue("@content", aboutUsHtmlStr);
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();

            //渲染畫面提示
            DateTime nowtime = DateTime.Now;
            UploadAboutUsLab.Visible = true;
            UploadAboutUsLab.Text = "*Upload Success! - " + nowtime.ToString("G");

            //Literal1.Text = HttpUtility.HtmlEncode(CKEditorControl1.Text);
           // Response.AddHeader("Refresh", "0");
            //AboutUsHTML();
        }

        protected void EditAboutUsBtn_Click(object sender, EventArgs e)
        {
            CKEditorControl1.Visible = true;
            UploadAboutUsBtn.Visible = true;
            AboutUsCancleBtn.Visible = true;
            AboutUsContent.Visible = false;
            EditAboutUsBtn.Visible = false;

        }

        
        protected void CancleBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_Company.aspx");

        }

        private void CertificateHTML()
        {
            //取得 About Us 頁面 HTML 資料
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sql = "SELECT content FROM Company WHERE id = 2";
            SqlCommand command = new SqlCommand(sql, connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            if (reader.Read())
            {
                //渲染畫面
                CKEditorControl2.Text = HttpUtility.HtmlDecode(reader["content"].ToString());
                CertificateContent.Text = HttpUtility.HtmlDecode(reader["content"].ToString());
            }

            connection.Close();
        }



        protected void UploadCertificateBtn_Click(object sender, EventArgs e)
        {
            //取得 CKEditorControl 的 HTML 內容

            string aboutUsHtmlStr = HttpUtility.HtmlEncode(CKEditorControl2.Text);
            //更新 About Us 頁面 HTML 資料
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sqlupdate = "UPDATE Company SET content = @content WHERE id = 2";
            SqlCommand command = new SqlCommand(sqlupdate, connection);
            command.Parameters.AddWithValue("@content", aboutUsHtmlStr);
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();

            //渲染畫面提示
            DateTime nowtime = DateTime.Now;

            UploadCertificateLab.Visible = true;
            UploadCertificateLab.Text = "*Upload Success! - " + nowtime.ToString("G");
            //重整畫面
           // Response.AddHeader("Refresh", "0");
     
        }

        protected void EditCertificateBtn_Click(object sender, EventArgs e)
        {
            CKEditorControl2.Visible = true;
            UploadCertificateBtn.Visible = true;
            CertificateCancleBtn.Visible = true;
            CertificateContent.Visible = false;
            EditCertificateBtn.Visible = false;

        }

    }
}
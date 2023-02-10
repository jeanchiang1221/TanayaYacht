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
    public partial class News_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadCkeditorContent();
            }
        }
        private void loadCkeditorContent()
        {

            string guidStr = Request.QueryString["id"];

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sql = $"SELECT * FROM News WHERE guid =@guid";
            SqlCommand command = new SqlCommand(sql, connection);
            connection.Open();
            command.Parameters.AddWithValue("@guid", guidStr);

            SqlDataReader reader = command.ExecuteReader();

            if (reader.Read())
            {
                //渲染畫面
                CKEditorControl1.Text = HttpUtility.HtmlDecode(reader["content"].ToString());
                ctl00_ContentPlaceHolder1_title.Text = reader["title"].ToString();

            }
            connection.Close();
            //渲染畫面

        }
    }
}
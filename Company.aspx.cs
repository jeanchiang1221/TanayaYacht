using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace yatch_project
{
    public partial class compan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadCkeditorContent();
                loadLeftMenu();
            }
        }


        private void loadCkeditorContent()
        {
  
            string id = Request.QueryString["id"];
            //如果是company進來的首頁就會抓不到id
            if (id == null)
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
                string sql = $"SELECT * FROM Company WHERE id =1";
                SqlCommand command = new SqlCommand(sql, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                StringBuilder TopLinkHTML = new StringBuilder();
               
                if (reader.Read())
                {
                    //渲染畫面
                    CKEditorControl1.Text = HttpUtility.HtmlDecode(reader["content"].ToString());
                    string menuName = reader["menu_name"].ToString();
                    menuTitle.Text = menuName;
                    TopLinkHTML.Append($"<a href='Company.aspx?id=1'>{menuName}</a>");
                }
                connection.Close();
                //渲染畫面
                TopLink.Text = TopLinkHTML.ToString();
            }
            else
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
                string sql = $"SELECT * FROM Company WHERE id={id}";
                SqlCommand command = new SqlCommand(sql, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                StringBuilder TopLinkHTML = new StringBuilder();
              
                if (reader.Read())
                {
                    CKEditorControl1.Text = HttpUtility.HtmlDecode(reader["content"].ToString());
                    string ID = reader["id"].ToString();
                    string menuName = reader["menu_name"].ToString();
                    TopLinkHTML.Append($"<a href='Company.aspx?id={ID}'>{menuName}</a>");
                    menuTitle.Text = menuName;
                }
                connection.Close();

                //渲染畫面
                TopLink.Text = TopLinkHTML.ToString();
                
            }

        }

        private void loadLeftMenu()
        {
            StringBuilder leftMenuHtml = new StringBuilder();

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sqlCountry = "SELECT * FROM Company";
            SqlCommand commandCountry = new SqlCommand(sqlCountry, connection);
            connection.Open();
            SqlDataReader reader = commandCountry.ExecuteReader();

            while (reader.Read())
            {
                string idStr = reader["id"].ToString();
                string menuName = reader["menu_name"].ToString();
                // StringBuilder 用 Append 加入字串內容
                leftMenuHtml.Append($"<li><a href='Company.aspx?id={idStr}'>{menuName}</a></li>");
            }
            connection.Close();

            //渲染畫面
            LeftMenu.Text = leftMenuHtml.ToString();

        }


    }
}
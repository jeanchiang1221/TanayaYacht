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
    public partial class Yachts_Specification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLeftMenu();
                LoadSpecificationContent();
                LoadYachtAlbum();
            }

        }
        private void LoadLeftMenu()
        {
            StringBuilder leftMenuHtml = new StringBuilder();
            //取得yacht model
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sql = "SELECT * FROM yachtManager";
            SqlCommand command = new SqlCommand(sql, connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            while (reader.Read())
            {
                string guidStr = reader["guid"].ToString();
                string yachtModelName = reader["yachtModelName"].ToString();
                bool isNewBuilding = (bool)reader["isNewBuilding"];
                // StringBuilder 用 Append 加入字串內容
                if (isNewBuilding)
                {
                    leftMenuHtml.Append($"<li><a href='Yachts_OverView.aspx?id={guidStr}'>{yachtModelName} (New Building)</a></li>");
                }
                else
                {
                    leftMenuHtml.Append($"<li><a href='Yachts_OverView.aspx?id={guidStr}'>{yachtModelName}</a></li>");
                }

            }
            connection.Close();

            //渲染畫面
            LeftMenu.Text = leftMenuHtml.ToString();
        }

        private void LoadSpecificationContent()
        {
            string guid = Request.QueryString["id"];
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            connection.Open();

            //如果是overview首頁，就不會有id(id=null)，那就預設為第一個yacht頁面
            if (guid == null)
            {
                //先找出第一個guid
                SqlCommand yachtFirstGuidCommand = new SqlCommand($"SELECT top 1 guid FROM [yachtManager] order by id", connection);//SQL語法

                SqlDataReader reader = yachtFirstGuidCommand.ExecuteReader();
                if (reader.Read())
                {
                    guid = reader["guid"].ToString();
                }
                reader.Close();
            }

            SqlCommand yachtFirstCommand = new SqlCommand($"SELECT * FROM yachtManager where guid='{guid}'", connection);
            SqlDataReader readerYacht = yachtFirstCommand.ExecuteReader();

            StringBuilder TopLinkHTML = new StringBuilder();
            StringBuilder TopMenuHTML = new StringBuilder();
            while (readerYacht.Read())
            {
                string yachtModelNameStr = readerYacht["yachtModelName"].ToString();
                yachtName.Text = yachtModelNameStr;
                bool isNewBuilding = (bool)readerYacht["isNewBuilding"];
                if (isNewBuilding)
                {
                    yachtName.Text = yachtModelNameStr+" (New Building)" ;
                }
                else
                {
                    yachtName.Text = yachtModelNameStr;
                }

                TopLinkHTML.Append($"<a href='Yachts_OverView.aspx?id={guid}'>{yachtModelNameStr}</a>");
                TopMenuHTML.Append($"<ul><li class='menu_y00'>YACHTS</li><li><a class='menu_yli01' href='Yachts_OverView.aspx?id={guid}'>OverView</a></li><li><a class='menu_yli02' href='Yachts_Layout.aspx?id={guid}'>Layout & deck plan</a></li><li><a class='menu_yli03' href='Yachts_Specification.aspx?id={guid}'>Specification</a></li><li></li></ul>");
                CKEditorControl3.Text = HttpUtility.HtmlDecode(readerYacht["specificationContent"].ToString());

            }

            readerYacht.Close();
            connection.Close();

            //渲染畫面
            TopLink.Text = TopLinkHTML.ToString();
            TopMenu.Text = TopMenuHTML.ToString();

        }

        private void LoadYachtAlbum()
        {

            string guid = Request.QueryString["id"];

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);

            //先取出yacht Modal的id
            string id = "";
            if (guid == null)
            {
                //先找出第一個guid
                SqlCommand yachtFirstGuidCommand = new SqlCommand($"SELECT top 1 id FROM [yachtManager] order by id", connection);//SQL語法
                connection.Open();
                SqlDataReader guidReader = yachtFirstGuidCommand.ExecuteReader();
                if (guidReader.Read())
                {
                    id = guidReader["id"].ToString();
                    connection.Close();
                }
                guidReader.Close();
            }
            else
            {
                SqlCommand command = new SqlCommand($"SELECT * from yachtManager where guid='{guid}'", connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    id = reader["id"].ToString();
                    connection.Close();
                }
            }

            ////取得yacht model

            SqlCommand Command = new SqlCommand($"SELECT imagesFileName FROM yachtAlbum where yachtId={id}", connection);
            connection.Open();

            SqlDataReader readerAlbum = Command.ExecuteReader();


            StringBuilder albumHtmlStringBuilder = new StringBuilder();

            while (readerAlbum.Read())
            {
                string imagesFileName = readerAlbum["imagesFileName"].ToString();

                // StringBuilder 用 Append 加入字串內容
                albumHtmlStringBuilder.Append($"<li><a href='upload/Images/{imagesFileName}'><img src ='upload/Images/{imagesFileName}' class='mage0'/></a></li>");
            }
            connection.Close();
            //readerAlbum.Close();

            //渲染畫面
            albumHtml.InnerHtml = albumHtmlStringBuilder.ToString();
        }

    }
}
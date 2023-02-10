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
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadIndexAlbum();
                LoadIndexNews();
            }

        }

        private void LoadIndexAlbum()
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            SqlCommand command = new SqlCommand($"SELECT imagesFileName,yachtModelName,isNewBuilding from yachtAlbum inner join yachtManager on yachtAlbum.yachtId=yachtManager.id where firstImage='1';", connection);

            connection.Open();
            
            SqlDataReader reader = command.ExecuteReader();
            StringBuilder albumHtmlStringBuilder = new StringBuilder();
            StringBuilder thumbnailAlbumHtmlStringBuilder = new StringBuilder();

            while (reader.Read())
            {
                string imagesFileName = reader["imagesFileName"].ToString();
                string yachtModelName = reader["yachtModelName"].ToString();
                string[] yachtModelNameArr = yachtModelName.Split();
                bool isNewBuilding = (bool)reader["isNewBuilding"];
                int isNewBuildingStr = Convert.ToInt32(isNewBuilding);
                //受否出現Newbuilding標示，是由value=0 or1決定，讀出isNewBuilding後，並轉型成int格式
                albumHtmlStringBuilder.Append($@"<li class='info'><a href=''target='_blank'><img src = 'upload/Images/{imagesFileName}'/></a>
                                                <div class='wordtitle'>{yachtModelNameArr[0]}<span>{yachtModelNameArr[1]}</span><br/>
                                                <p>SPECIFICATION SHEET</p></div>
                                                <div class='new'' style='display:none'>
                                                <img src = 'images/new01.png' alt='new'/>
                                                </div>
                                                <input type = 'hidden' value='{isNewBuildingStr}'/>
                                                </li>");
                thumbnailAlbumHtmlStringBuilder.Append($@" <li><div><p class='bannerimg_p'><img src = 'upload/Images/{imagesFileName}' width=100% alt = '{yachtModelNameArr[0]}{yachtModelNameArr[1]}SPECIFICATION SHEET'/></p></div></li>");
            }
            connection.Close();




            //渲染畫面
            albumHtml.InnerHtml = albumHtmlStringBuilder.ToString();
            thumbnailAlbumHtml.InnerHtml = thumbnailAlbumHtmlStringBuilder.ToString();
        }

        private void LoadIndexNews()
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            SqlCommand command = new SqlCommand($"SELECT top 3 * from News order by date desc", connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            StringBuilder newsHtmlStringBuilder = new StringBuilder();

            while (reader.Read())
            {
                string coverImg = reader["coverImg"].ToString();
                string date = Convert.ToDateTime(reader["date"]).ToString("yyyy-MM-dd");
                string guid = reader["guid"].ToString();
                string title = reader["title"].ToString();
                bool isTop = (bool)reader["isTop"];
                int isTopStr = Convert.ToInt32(isTop);
                //受否出現Newbuilding標示，是由value=0 or1決定，讀出isNewBuilding後，並轉型成int格式
                newsHtmlStringBuilder.Append($@"<li><div class='news01'><div class='newstop' style='display: none'><img src = 'images/new_top01.png'/></div>
                                                 <div class='news02p1'><p class='news02p1img'><img id ='Repeater3_ctl01_Image1' src='upload/Images/{coverImg}' style='border-width:0px;' /></p></div>
                                                 <p class='news02p2'><span><font color ='#02a5b8'>{date}</font></span >
                                                 <span><a href='news_view.aspx?id={guid}'>{title}</a></span></p>
                                                 <input type ='hidden' value='{isTopStr}'/></div></li>");
            }
            connection.Close();

            //渲染畫面
            newsHtml.InnerHtml = newsHtmlStringBuilder.ToString();
            
        }
    }
}
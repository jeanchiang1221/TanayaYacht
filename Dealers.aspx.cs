using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace yatch_project
{
    public partial class Dealers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadLeftMenu();
                countryTitle();
               loadDealersContent();
            }

        }


        private void loadLeftMenu()
        {

            //反覆變更字串的值建議用 StringBuilder 效能較好
            StringBuilder leftMenuHtml = new StringBuilder();


            //取得國家分類
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sqlCountry = "SELECT * FROM dealers_country";
            SqlCommand commandCountry = new SqlCommand(sqlCountry, connection);
            connection.Open();
            SqlDataReader readerCountry = commandCountry.ExecuteReader();

            while (readerCountry.Read())
            {
                string idStr = readerCountry["id"].ToString();
                string countryStr = readerCountry["countryName"].ToString();
                // StringBuilder 用 Append 加入字串內容
                leftMenuHtml.Append($"<li><a href='dealers.aspx?id={idStr}'>{countryStr}</a></li>");

            }


            connection.Close();

            //渲染畫面
            LeftMenu.Text = leftMenuHtml.ToString();

        }

        private void countryTitle()
        {
            string id = Request.QueryString["id"];
            string config = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString;
            StringBuilder TopLinkHTML = new StringBuilder();
            SqlConnection connection = new SqlConnection(config); //與資料庫做連結的大門
            if (id == null)
            {
                SqlCommand Command = new SqlCommand($"SELECT top 1 * FROM [dealers_country]", connection);//SQL語法
                connection.Open();
                SqlDataReader reader = Command.ExecuteReader();
                if (reader.Read())
                {
                    countryName.Text = reader["countryName"].ToString();
                    string ID = reader["id"].ToString();
                    string CountryName = reader["countryName"].ToString();
                    TopLinkHTML.Append($"<a href='dealers.aspx?id={ID}'>{CountryName}</a>");
                }

                reader.Close();

                //渲染畫面
                TopLink.Text = TopLinkHTML.ToString();
            }
            else if (id != null)
            {
                SqlCommand Command = new SqlCommand($"SELECT * FROM [dealers_country] where id = {id}", connection);//SQL語法

                connection.Open();

                SqlDataReader reader = Command.ExecuteReader();
                if (reader.Read())
                {
                    countryName.Text = reader["countryName"].ToString();
                    TopLink.Text = reader["countryName"].ToString();
                    string ID = reader["id"].ToString();
                    string CountryName = reader["countryName"].ToString();
                    TopLinkHTML.Append($"<a href='dealers.aspx?id={ID}'>{CountryName}</a>");
                }

                reader.Close();
                //渲染畫面
                TopLink.Text = TopLinkHTML.ToString();
            }

        }

        private void loadDealersContent()
        {
            string id = Request.QueryString["id"];
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);

            //反覆變更字串的值建議用 StringBuilder 效能較好
            StringBuilder dealersContentHtml = new StringBuilder();

            connection.Open();

            SqlDataReader readerCountry; //先宣告變數，因為while迴圈會用到

            //如果是dealers首頁，就不會有id(id=null)，那就預設為第一個國家的dealers頁面
            if (id == null)
            {
                //先找出第一個country id
                SqlCommand countryFirstIdCommand = new SqlCommand($"SELECT top 1 id FROM [dealers_country]", connection);//SQL語法

                SqlDataReader reader = countryFirstIdCommand.ExecuteReader();
                string countryFirstId = "";
                if (reader.Read())
                {
                    countryFirstId = reader["id"].ToString();
                }

                reader.Close();
                //帶入第一個country id
                string sqlCountry = $"SELECT * FROM dealers where country_id={countryFirstId}";
                SqlCommand commandCountry = new SqlCommand(sqlCountry, connection);
                // connection.Open();
                readerCountry = commandCountry.ExecuteReader();

            }
            else
            {
                string sqlCountry = $"SELECT * FROM dealers where country_id={id}";
                SqlCommand commandCountry = new SqlCommand(sqlCountry, connection);
                readerCountry = commandCountry.ExecuteReader();

            }


            while (readerCountry.Read())
            {
                string areaStr = readerCountry["area"].ToString();
                string dealerImgPath = readerCountry["dealerImgPath"].ToString();
                string nameStr = readerCountry["name"].ToString();
                string contactStr = readerCountry["contact"].ToString();
                string addressStr = readerCountry["address"].ToString();
                string telStr = readerCountry["tel"].ToString();
                string faxStr = readerCountry["fax"].ToString();
                string emailStr = readerCountry["email"].ToString();
                string linkStr = readerCountry["link"].ToString();
                // StringBuilder 用 Append 加入字串內容
                dealersContentHtml.Append($@"<li><div class='list02'><ul><li class='list02li'>
                    <div><p><img alt='Thumbnail Image' src='upload/Images/{dealerImgPath}' Width='209px' style='border-width:0px;'/></p></div></li>
                    <li class='list02li02'> <span>{areaStr}</span><br/>
                    {nameStr}<br/>Contact：{contactStr}<br/>" );

                if (!String.IsNullOrEmpty(addressStr))
                {
                    dealersContentHtml.Append($@"Address：{addressStr}<br/>");
                }
                if (!String.IsNullOrEmpty(telStr))
                {
                    dealersContentHtml.Append($@"TEL：{telStr}<br/>");
                }
                if (!String.IsNullOrEmpty(faxStr))
                {
                    dealersContentHtml.Append($@"Fax：{faxStr}<br/>");
                }
                if (!String.IsNullOrEmpty(emailStr))
                {
                    dealersContentHtml.Append($@"E-Mail: {emailStr}<br/>");
                }
                if (!String.IsNullOrEmpty(linkStr))
                {
                    dealersContentHtml.Append($@"<a href = '{linkStr}' target= '_blank' >{linkStr}</a>");
                }

                dealersContentHtml.Append($@"</li></ul></div></li>");
           
            }

            readerCountry.Close();
            connection.Close();

            //渲染畫面
            dealersContent.Text = dealersContentHtml.ToString();
        }
    }
}
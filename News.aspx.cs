using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Text;

namespace yatch_project
{
    public partial class News : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNewsList();
            }
        }

        private void LoadNewsList()
        {
            //1.連線資料庫
            string config = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString;
            SqlConnection connection = new SqlConnection(config); //與資料庫做連結的大門


            //2.建立判斷網址是否有傳值邏輯 (網址傳值功能已於製作控制項時已完成)
            int page = 1; //預設為第1頁
            //判斷網址後有無參數
            //也可用String.IsNullOrWhiteSpace
            if (!String.IsNullOrEmpty(Request.QueryString["page"]))
            {
                page = Convert.ToInt32(Request.QueryString["page"]);
            }

            //3.設定頁面參數屬性
            //設定控制項參數: 一頁幾筆資料
            WebUserControl_Page.limit = 5;
            //設定控制項參數: 作用頁面完整網頁名稱
            WebUserControl_Page.targetPage = "News.aspx";

            //4.建立計算分頁資料顯示邏輯 (每一頁是從第幾筆開始到第幾筆結束)
            //計算每個分頁的第幾筆到第幾筆
            var floor = (page - 1) * WebUserControl_Page.limit + 1; //每頁的第一筆
            var ceiling = page * WebUserControl_Page.limit; //每頁的最末筆


            //5.建立計算資料筆數的 SQL 語法
            //算出我們要秀的資料數
            string sql_countTotal = "SELECT COUNT(id) FROM News";
            SqlCommand commandForTotal = new SqlCommand(sql_countTotal, connection);

            //6.將取得的資料數設定給參數 count
            connection.Open();
            //用 ExecuteScalar() 來算數量
            int count = Convert.ToInt32(commandForTotal.ExecuteScalar());
            connection.Close();

            //7.將取得的資料筆數設定給頁面參數屬性
            //設定控制項參數: 總共幾筆資料
            WebUserControl_Page.totalitems= count;

            //8.使用 showPageControls() 渲染至網頁 (方法於製作控制項時已完成)
            //渲染分頁控制項
            WebUserControl_Page.showPageControls();

            //9.將原始資料表的 SQL 語法使用 CTE 暫存表改寫，並使用 ROW_NUMBER() 函式製作資料項流水號 rowindex
            // SQL 用 CTE 暫存表 + ROW_NUMBER 去生出我的流水號 rowindex 後以流水號為條件來查詢暫存表
            //以isTop(置頂貼文) 跟時間來做排序
            SqlCommand Command = new SqlCommand($"WITH temp AS (SELECT ROW_NUMBER() OVER (ORDER BY isTop DESC, date DESC) AS rowindex, * FROM News) SELECT * FROM temp WHERE rowindex >= {floor} AND rowindex <= {ceiling}", connection);

            //10.取得每頁的新聞列表資料製作成 HTML 內容
            connection.Open();
            SqlDataReader reader = Command.ExecuteReader();

            StringBuilder newsListHtml = new StringBuilder();

            while (reader.Read())
            {
                string title = reader["title"].ToString();
                string date = Convert.ToDateTime(reader["date"]).ToString("yyyy-MM-dd");
               // string[] dateArr = date.Split(' ');
                string coverImg = reader["coverImg"].ToString();
                string summary = reader["summary"].ToString();
                bool isTop = (bool)reader["isTop"];

                string guidStr = reader["guid"].ToString();

                // StringBuilder 用 Append 加入字串內容，如果是置頂貼文就多一行標註
                if (isTop)
                {
                    newsListHtml.Append($@"<li>
                                        <div class='list01'>
                                        <ul>
                                            <li>
                                                <div>
                                                    <p><img src = 'upload/Images/{coverImg}' style = 'border-width:0px;'/></p>
                                                </div>
                                            </li>
                                           <span style='color:red;'>*置頂新聞*</span><br/>   
                                           <li><span>{date}</span><br/>
                                            <a href='News_View.aspx?id={guidStr}'>{title}</a>
                                           </li>
                                            <br/>
                                         <li>{summary}</li>
                                        </ul>
                                        </div>
                                    </li>");
                }
                else
                {
                    newsListHtml.Append($@"<li>
                                        <div class='list01'>
                                        <ul>
                                            <li>
                                                <div>
                                                    <p><img src = 'upload/Images/{coverImg}' style = 'border-width:0px;'/></p>
                                                </div>
                                            </li>
                                           <li><span>{date}</span><br/>
                                            <a href='News_View.aspx?id={guidStr}'>{title}</a>
                                           </li>
                                            <br/>
                                         <li>{summary}</li>
                                        </ul>
                                        </div>
                                    </li>");
                }

            }


            reader.Close();
            connection.Close();  //渲染畫面
            newslist.Text = newsListHtml.ToString();
        }

        
        
}
}
using CKFinder;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace yatch_project
{
    public partial class Admin_News : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FileBrowser fileBrowser = new FileBrowser();
                fileBrowser.BasePath = "/ckfinder";
                fileBrowser.SetupCKEditor(CKEditorControl1);
                fileBrowser.SetupCKEditor(CKEditorControl2);
                //預設時間為今天
                 datepicker.Text = DateTime.Now.ToString("yyyy-MM-dd");
                //datepicker.Text = Convert.ToDateTime("2022/01/01").ToString("yyyy-MM-dd");
            }

        }

        protected void UploadNewsBtn_Click(object sender, EventArgs e)
        {
            //設定存檔路徑，需填完整路徑，結尾反斜線如果沒加要用 Path.Combine() 可自動添加
            string savePath = Server.MapPath("/upload/Images/");

            // string dealerImgPath = "";

            //判斷有選檔案才可上傳
            if (imageUpload.HasFile)
            {
                //儲存圖片檔案及圖片名稱
                //檢查專案資料夾內有無同名檔案，有同名就加流水號
                DirectoryInfo directoryInfo = new DirectoryInfo(savePath);
                //取得選取檔案名稱
                string fileName = imageUpload.FileName;
                string[] fileNameArr = fileName.Split('.');
                int count = 0;
                foreach (var fileItem in directoryInfo.GetFiles())
                {
                    if (fileItem.Name.Contains(fileNameArr[0]))
                    {
                        count++;
                    }
                }
                fileName = fileNameArr[0] + $"({count + 1})." + fileNameArr[1];
                imageUpload.SaveAs(savePath + fileName);
                //string dealerImgPath = savePath + fileName;


                //建立與資料庫建立起連接的通道

                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
                string sqlupdate = "Insert into News(date,coverImg,title,summary,content,guid,isTop) VALUES(@date,@coverImg,@title,@summary,@content,@guid,@isTop)";
                SqlCommand command = new SqlCommand(sqlupdate, connection);

                //取得輸入日期
                string date = datepicker.Text;

                //取得 CKEditorControl 的 HTML 內容後，用正規表達式處理掉html的標籤，並取前30個字當作summary
                string newsStr = HttpUtility.HtmlEncode(CKEditorControl1.Text);
                string summary = "";
                string temp = Regex.Replace(CKEditorControl1.Text, "<[^>]*>", "");
                if (temp.Length <= 30)
                {
                    summary = temp;
                }
                else
                {
                    summary = temp.Remove(30, temp.Length - 30) + "...";
                }


                //產生 GUID 隨機碼 + 時間2位秒數 (加強避免重複)
                DateTime nowTime = DateTime.Now;
                string nowSec = nowTime.ToString("ff");
                string guid = Guid.NewGuid().ToString().Trim() + nowSec;

                command.Parameters.AddWithValue("@date", date);
                command.Parameters.AddWithValue("@coverImg", fileName);
                command.Parameters.AddWithValue("@title", title.Value);
                command.Parameters.AddWithValue("@summary", summary);
                command.Parameters.AddWithValue("@content", newsStr);
                command.Parameters.AddWithValue("@guid", guid);
                command.Parameters.AddWithValue("@isTop", isTop.Checked);


                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();


                //清空畫面
                UploadNewsContent.Visible = false;
                postedNews.Visible = false;

                //渲染畫面
                DateTime nowtime = DateTime.Now;
                UploadText.Visible = true;

                UploadText.ForeColor = Color.Green;
                UploadText.Text = "上傳成功 - " + nowtime.ToString("G");
                AfterUploadedReturn.Visible = true;


            }
            else
            {
                //警告沒有選取檔案
                UploadImgText.Visible = true;
                UploadImgText.ForeColor = Color.Red;
                UploadImgText.Text = "尚未上傳圖片，請上傳";

            }



        }


        protected void EditNewsBtn_Click(object sender, EventArgs e)
        {
            UploadNews.Visible = false;
            EditNews.Visible = true;
            EditedNewsContent.Visible = true;
            UploadEditedText.Visible = false;
            AfterEditedReturn.Visible = false;
  

            // 取得按下按鈕的那一列
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            //按鈕傳值
            string guidstr = btn.CommandArgument.ToString().Trim();

            //取得 Post News 頁面 HTML 資料
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sql = $"SELECT * FROM News WHERE guid='{guidstr}'"; //guidstr是字串，要多加單引號
            SqlCommand command = new SqlCommand(sql, connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            StringBuilder previewOriginalHTML = new StringBuilder();

            if (reader.Read())
            {
                //渲染畫面

                CKEditorControl2.Text = HttpUtility.HtmlDecode(reader["content"].ToString());
                string date = Convert.ToDateTime(reader["date"]).ToString("yyyy/MM/dd");
                datepickerEdit.Text = Convert.ToDateTime(reader["date"]).ToString("yyyy-MM-dd"); //這個我研究超久終於成功了QQ
                titleOriginal.Value = reader["title"].ToString();
                isTopEdit.Checked = (bool)reader["isTop"];
                String coverImg = reader["coverImg"].ToString();
                // StringBuilder 用 Append 加入字串內容
                previewOriginalHTML.Append($@"<div id='picview'><img src = 'upload/Images/{coverImg}'/></div>");
                HiddenGuid.Value = guidstr; //藏guid在這裡，之後上傳更新後才抓得到
                connection.Close();

            }
            previewOriginal.Text = previewOriginalHTML.ToString();


        }


        protected void UploadEditedNewsBtn_Click(object sender, EventArgs e)
        {
            //按鈕傳值
            string guidstr = HiddenGuid.Value;

            //建立與資料庫建立起連接的通道

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sqlupdate = $"Update News set title=@title,date=@date,content=@content,summary=@summary,isTop=@isTop WHERE guid='{guidstr}';";
            SqlCommand command = new SqlCommand(sqlupdate, connection);

            //取得日期
            string date = datepickerEdit.Text;

            //取得 CKEditorControl2 的 HTML 內容後，用正規表達式處理掉html的標籤，並取前30個字當作summary
            string summary = "";
            string temp = Regex.Replace(CKEditorControl2.Text, "<[^>]*>", "");
            if (temp.Length <= 30)
            {
                summary = temp;
            }
            else
            {
                summary = temp.Remove(30, temp.Length - 30) + "...";
            }

            //設定存檔路徑，需填完整路徑，結尾反斜線如果沒加要用 Path.Combine() 可自動添加
            string savePath = Server.MapPath("/upload/Images/");

            //判斷有選檔案才可上傳，如果沒有檔案，就是沿用舊圖(sql沒有更新圖片)
            if (imageEditedUpload.HasFile)
            {
                //儲存圖片檔案及圖片名稱
                //檢查專案資料夾內有無同名檔案，有同名就加流水號
                DirectoryInfo directoryInfo = new DirectoryInfo(savePath);
                //取得選取檔案名稱
                string fileName = imageEditedUpload.FileName;
                string[] fileNameArr = fileName.Split('.');
                int count = 0;
                foreach (var fileItem in directoryInfo.GetFiles())
                {
                    if (fileItem.Name.Contains(fileNameArr[0]))
                    {
                        count++;
                    }
                }
                fileName = fileNameArr[0] + $"({count + 1})." + fileNameArr[1];
                imageEditedUpload.SaveAs(savePath + fileName);
                SqlConnection Connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
                string Sqlupdate = $"Update News set coverImg=@coverImg WHERE guid='{guidstr}';";
                SqlCommand Command = new SqlCommand(Sqlupdate, Connection);

                Command.Parameters.AddWithValue("@coverImg", fileName);
                Connection.Open();
                Command.ExecuteNonQuery();
                Connection.Close();
            }


            command.Parameters.AddWithValue("@date", date);
            command.Parameters.AddWithValue("@title", titleOriginal.Value);
            command.Parameters.AddWithValue("@content", CKEditorControl2.Text);
            command.Parameters.AddWithValue("@summary", summary);
            command.Parameters.AddWithValue("@isTop", isTopEdit.Checked);

            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();

            //清空畫面
            EditedNewsContent.Visible = false;
            postedNews.Visible = false;

            //渲染上傳成功的字
            DateTime nowtime = DateTime.Now;
            UploadEditedText.Visible = true;
            UploadEditedText.ForeColor = Color.Green;
            UploadEditedText.Text = "上傳成功 - " + nowtime.ToString("G");
            AfterEditedReturn.Visible = true;
        }


        protected void Return_Click(object sender, EventArgs e) 
        {
            UploadEditedText.Visible = false;
            UploadText.Visible = false;
            Response.Redirect("Admin_News.aspx");
        }



        protected void CancleUploadNewsBtn_Click(object sender, EventArgs e)
        {
            //清空輸入欄位
            title.Value = "";
            CKEditorControl1.Text = "";
            datepicker.Text = null;
            isTop.Checked = false;
            imageUpload.FileName.DefaultIfEmpty();//如果有選好檔案，檔案清空
        }

        protected void CancleEditedBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_News");
            //清空輸入欄位
            title.Value = "";
            CKEditorControl1.Text = "";
            datepicker.Text = null;
            isTop.Checked = false;
            imageUpload.FileName.DefaultIfEmpty();//如果有選好檔案，檔案清空
        }


    }
}
using CKFinder;
using System;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.UI.WebControls;


namespace yatch_project
{
    public partial class Admin_Yacht : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                yachtModelNameList.DataBind();
                GridView1.DataBind();
                 LoadView();

                FileBrowser fileBrowser = new FileBrowser();
                fileBrowser.BasePath = "/ckfinder";
                fileBrowser.SetupCKEditor(CKEditorControl1);
                fileBrowser.SetupCKEditor(CKEditorControl2);
                fileBrowser.SetupCKEditor(CKEditorControl3);
            }
        }

        private void LoadView()
        {
            ClearDownloadFile_btn.Visible = false;
            albumRadioButtonList.Items.Clear();

            if (yachtModelNameList.SelectedValue == "0")
            {
                OverviewContentText.Text = "(請先選擇yacht model)";
                OverviewDimensionText.Text = "(請先選擇yacht model)";
                OverviewDownLoadText.Text = "(請先選擇yacht model)";
                LayoutText.Text = "(請先選擇yacht model)";
                SpecificationText.Text = "(請先選擇yacht model)";
                AlbumText.Text = "(請先選擇yacht model)";
                OverviewContentText.ForeColor = Color.Orange;
                OverviewDimensionText.ForeColor = Color.Orange;
                OverviewDownLoadText.ForeColor = Color.Orange;
                LayoutText.ForeColor = Color.Orange;
                SpecificationText.ForeColor = Color.Orange;
                AlbumText.ForeColor = Color.Orange;
                overviewContentPart.Visible = false;
                overviewDimensionPart.Visible = false;
                overviewDownLoadPart.Visible = false;
                LayoutPart.Visible = false;
                SpecificationPart.Visible = false;
                AlbumPart.Visible = false;
                //ClearDownloadFile_btn.Visible = false;
                // albumRadioButtonList.Items.Clear();

            }
            else
            {
                overviewContentPart.Visible = true;
                overviewDimensionPart.Visible = true;
                overviewDownLoadPart.Visible = true;
                LayoutPart.Visible = true;
                SpecificationPart.Visible = true;
                AlbumPart.Visible = true;

                string guidStr = yachtModelNameList.SelectedValue;
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
                string sql = $"SELECT * FROM yachtManager where guid='{guidStr}'"; //guidStr是字串，要多加單引號
                SqlCommand command = new SqlCommand(sql, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                StringBuilder previewOriginalHTML = new StringBuilder();
                StringBuilder dimensionTableStringBuilder = new StringBuilder();
                StringBuilder dimensionDownloadStringBuilder = new StringBuilder();

                string yachtId = "";
                if (reader.Read())
                {
                    CKEditorControl1.Text = HttpUtility.HtmlDecode(reader["overviewContent"].ToString());
                    OverviewContentText.Text = reader["yachtModelName"].ToString() + "-";
                    OverviewDimensionText.Text = reader["yachtModelName"].ToString() + "-";
                    OverviewDownLoadText.Text = reader["yachtModelName"].ToString() + "-";
                    LayoutText.Text = reader["yachtModelName"].ToString() + "-";
                    SpecificationText.Text = reader["yachtModelName"].ToString() + "-";
                    AlbumText.Text = reader["yachtModelName"].ToString() + "-";
                    yachtId = reader["id"].ToString();

                    //overviewDimensions從資料庫撈出資料後，處理完變成HTML格式渲染於畫面
                    String dimensionTableStrHTMLText = reader["overviewDimensions"].ToString();
                    //要不為空值才可以渲染進去
                    if (dimensionTableStrHTMLText != "")
                    {
                        string[] dimensionStrArr = dimensionTableStrHTMLText.Split(',');
                        int a = 0;
                        foreach (string i in dimensionStrArr)
                        {
                            a++;
                            if (a % 2 != 0)
                            {
                                dimensionTableStringBuilder.Append($"<tr><td>{i}</td>");
                            }
                            else
                            {
                                dimensionTableStringBuilder.Append($"<td>{i}</td><td><input type=\"button\" class=\"delete\" value=\"刪除\"><input type=\"button\" class=\"edit\" value=\"編輯\"></td></tr>");
                            }
                        }
                    }

                    String overviewDimensionsImg = reader["overviewDimensionsImg"].ToString();
                    previewOriginalHTML.Append($@"<div id='picview'><img src = 'upload/Images/{overviewDimensionsImg}'/></div>");
                    string overviewDownLoadStr = reader["overviewDownLoad"].ToString();
                    if (overviewDownLoadStr != "")
                    {
                        dimensionDownloadStringBuilder.Append($@"<span>目前檔案:</span><a href='upload/Files/{overviewDownLoadStr}' target='_blank'>{overviewDownLoadStr}</a>");
                        ClearDownloadFile_btn.Visible = true;
                    }

                    CKEditorControl2.Text = HttpUtility.HtmlDecode(reader["layoutDeckPlanContent"].ToString());
                    CKEditorControl3.Text = HttpUtility.HtmlDecode(reader["specificationContent"].ToString());


                }

                connection.Close();


                string sqlAlbum = $"SELECT * from yachtAlbum where yachtId={yachtId}"; //guidStr是字串，要多加單引號
                SqlCommand commandAlbum = new SqlCommand(sqlAlbum, connection);
                connection.Open();


                SqlDataReader readerAlbum = commandAlbum.ExecuteReader();
                if (readerAlbum.HasRows)
                {
                    while (readerAlbum.Read())
                    {
                        string imagesFileName = readerAlbum["imagesFileName"].ToString();
                        string albumId = readerAlbum["id"].ToString();
                        bool firstImage = (bool)readerAlbum["firstImage"];
                        if (firstImage)
                        {
                            ListItem listItem = new ListItem($"<img src='/upload/Images/{imagesFileName}' alt='thumbnail' class='img-thumbnail' width='200px' style='border: orange 2px solid'>", albumId); //分別為DataTextField(給用戶看的)和DataValueField(給開發人員用的)
                            albumRadioButtonList.Items.Add(listItem);
                        }
                        else
                        {
                            ListItem listItem = new ListItem($"<img src='/upload/Images/{imagesFileName}' alt='thumbnail' class='img-thumbnail' width='200px'/>", albumId); //分別為DataTextField(給用戶看的)和DataValueField(給開發人員用的)
                            albumRadioButtonList.Items.Add(listItem);
                        }

                    }
                }
                connection.Close();


                previewOriginal.Text = previewOriginalHTML.ToString();
                dimensionTableStrHTML.InnerHtml = dimensionTableStringBuilder.ToString();
                overviewDownLoadaLink.InnerHtml = dimensionDownloadStringBuilder.ToString();
            }
        }
        protected void yachtModel_Changed(object sender, EventArgs e)
        {
            LoadView();
        }
        protected void AddYachtModel_Click(object sender, EventArgs e)
        {
            //1.連線資料庫
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            //2.sql語法
            string sqlCheck = "SELECT * FROM yachtManager WHERE yachtModelName = @yachtModelName";
            string sql = "INSERT INTO yachtManager(yachtModelName,guid) VALUES(@yachtModelName,@guid)";
            //3.創建command物件
            SqlCommand commandCheck = new SqlCommand(sqlCheck, connection);
            SqlCommand command = new SqlCommand(sql, connection);

            //檢查有無重複遊艇名稱
            commandCheck.Parameters.AddWithValue("@yachtModelName", AddYachtModelText.Value);
            connection.Open();
            SqlDataReader readerCountry = commandCheck.ExecuteReader();
            bool haveSameYacht = false;
            if (readerCountry.Read())
            {
                haveSameYacht = true;
                Response.Write($@"<script language='javascript'>alert('遊艇名稱已重複!')</script>"); ; //帳號重複通知
            }
            connection.Close();

            if (!haveSameYacht)
            {
                //產生 GUID 隨機碼 + 時間2位秒數 (加強避免重複)
                DateTime nowTime = DateTime.Now;
                string nowSec = nowTime.ToString("ff");
                string guid = Guid.NewGuid().ToString().Trim() + nowSec;

                //4.參數化避免攻擊
                string AddYachtModelName = AddYachtModelText.Value;
                command.Parameters.AddWithValue("@yachtModelName", AddYachtModelName);
                command.Parameters.AddWithValue("@guid", guid);
                //5.資料庫連線開啟
                connection.Open();
                //6.執行sql (新增刪除修改)
                command.ExecuteNonQuery(); //無回傳值
                                           //7.資料庫關閉
                connection.Close();

                //畫面渲染

                //清空輸入欄位
                AddYachtModelText.Value = "";
                //畫面渲染

                GridView1.DataBind();
                yachtModelNameList.Items.Add(new ListItem($"{AddYachtModelName}", guid));
            }
        }

        protected void DeleteYachtModel_Click(object sender, EventArgs e)
        {


            //按鈕傳值
            Button btn = (Button)sender;
            string id = btn.CommandArgument.ToString().Trim();

            //1.連線資料庫
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            //2.sql語法
            string sql = "DELETE FROM [yachtManager] WHERE [id] = @id";
            //3.創建command物件
            SqlCommand command = new SqlCommand(sql, connection);

            //4.參數化避免攻擊
            command.Parameters.AddWithValue("@id", id);
            //5.資料庫連線開啟
            connection.Open();
            //6.執行sql (新增刪除修改)
            command.ExecuteNonQuery(); //無回傳值
                                       //7.資料庫關閉
            connection.Close();
            //畫面渲染

            //清空輸入欄位
            AddYachtModelText.Value = "";
            //畫面渲染

            GridView1.DataBind();
            yachtModelNameList.Items.Clear();
            yachtModelNameList.Items.Add(new ListItem("請選擇yacht model", "0"));
            yachtModelNameList.DataBind();
            LoadView();


        }
        protected void UploadOverviewContent_Click(object sender, EventArgs e)
        {
            string guidStr = yachtModelNameList.SelectedValue;
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sql = $"UPDATE yachtManager SET overviewContent=@overviewContent WHERE guid='{guidStr}'"; //guidStr是字串，要多加單引號
            SqlCommand command = new SqlCommand(sql, connection);
            connection.Open();

            string contentStr = HttpUtility.HtmlEncode(CKEditorControl1.Text);
            command.Parameters.AddWithValue("@overviewContent", contentStr);

            command.ExecuteNonQuery();
            connection.Close();
            //通知畫面
            DateTime nowtime = DateTime.Now;
            string time = nowtime.ToString();
            Response.Write($@"<script language='javascript'>alert('{time}-Overview內容 上傳成功!')</script>");
            LoadView();

        }

        protected void CancleUploadOverviewContentBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_Yacht.aspx");
        }

        protected void UploadDimension_Click(object sender, EventArgs e)
        {
            //先抓到guid的值
            string guidStr = yachtModelNameList.SelectedValue;

            //設定存檔路徑，需填完整路徑，結尾反斜線如果沒加要用 Path.Combine() 可自動添加
            string savePath = Server.MapPath("/upload/Images/");

            //判斷有選檔案才可上傳
            if (dimensionImgUpload.HasFile)
            {
                //儲存圖片檔案及圖片名稱
                //檢查專案資料夾內有無同名檔案，有同名就加流水號
                DirectoryInfo directoryInfo = new DirectoryInfo(savePath);
                //取得選取檔案名稱
                string fileName = dimensionImgUpload.FileName;
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
                dimensionImgUpload.SaveAs(savePath + fileName);
                //建立與資料庫建立起連接的通道
                //guidStr = yachtModelNameList.SelectedValue;

                SqlConnection Connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
                string sqlDimensionsImgupdate = $"UPDATE yachtManager SET overviewDimensionsImg=@overviewDimensionsImg WHERE guid='{guidStr}'";
                SqlCommand Command = new SqlCommand(sqlDimensionsImgupdate, Connection);
                Command.Parameters.AddWithValue("@overviewDimensionsImg", fileName);
                Connection.Open();
                Command.ExecuteNonQuery();
                Connection.Close();

            }

            //將存進來的HTML格式先做完字串處理後再存到資料庫
            string dimensionStrHTML = dimensionStr.Value;
            dimensionStrHTML = dimensionStrHTML.Replace("</td></tr>", "");
            dimensionStrHTML = dimensionStrHTML.Replace("</td>", ",");
            dimensionStrHTML = Regex.Replace(dimensionStrHTML, "<[^>]*>", "");
            dimensionStrHTML = dimensionStrHTML.Trim();
            dimensionStrHTML = dimensionStrHTML.Trim(',');

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sql = $"UPDATE yachtManager SET overviewDimensions=@overviewDimensions WHERE guid='{guidStr}'"; //guidStr是字串，要多加單引號
            SqlCommand command = new SqlCommand(sql, connection);
            connection.Open();
            command.Parameters.AddWithValue("@overviewDimensions", dimensionStrHTML);
            command.ExecuteNonQuery();
            connection.Close();

            //通知畫面
            DateTime nowtime = DateTime.Now;
            string time = nowtime.ToString();
            Response.Write($@"<script language='javascript'>alert('{time}-Overview Dimension 上傳成功!')</script>");
            LoadView();

        }

        protected void UploadoverviewFile_Click(object sender, EventArgs e)
        {
            //先抓到guid的值
            string guidStr = yachtModelNameList.SelectedValue;

            //設定存檔路徑，需填完整路徑，結尾反斜線如果沒加要用 Path.Combine() 可自動添加
            string savePath = Server.MapPath("/upload/files/");

            //判斷有選檔案才可上傳
            if (overviewFileUpload.HasFile)
            {
                //儲存文件檔案及文件名稱
                //檢查專案資料夾內有無同名檔案，有同名就加流水號
                DirectoryInfo directoryInfo = new DirectoryInfo(savePath);
                //取得選取檔案名稱
                string fileName = overviewFileUpload.FileName;
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
                overviewFileUpload.SaveAs(savePath + fileName);
                //建立與資料庫建立起連接的通道

                SqlConnection Connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
                string sqlDimensionsImgupdate = $"UPDATE yachtManager SET overviewDownload=@overviewDownload WHERE guid='{guidStr}'";
                SqlCommand Command = new SqlCommand(sqlDimensionsImgupdate, Connection);
                Command.Parameters.AddWithValue("@overviewDownload", fileName);
                Connection.Open();
                Command.ExecuteNonQuery();
                Connection.Close();

                //通知畫面
                DateTime nowtime = DateTime.Now;
                string time = nowtime.ToString();
                Response.Write($@"<script language='javascript'>alert('{time}-Overview檔案 上傳成功!');</script>");
                LoadView();
            }
        }

        protected void ClearDownloadFile_Click(object sender, EventArgs e)
        {
            //先抓到guid的值
            string guidStr = yachtModelNameList.SelectedValue;
            SqlConnection Connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sqlDimensionsImgupdate = $"UPDATE yachtManager SET overviewDownload=@overviewDownload WHERE guid='{guidStr}'";
            SqlCommand Command = new SqlCommand(sqlDimensionsImgupdate, Connection);
            Command.Parameters.AddWithValue("@overviewDownload", "");
            Connection.Open();
            Command.ExecuteNonQuery();
            Connection.Close();

            //通知畫面
            DateTime nowtime = DateTime.Now;
            string time = nowtime.ToString();
            Response.Write($@"<script language='javascript'>alert('{time}-檔案刪除成功!')</script>");
            LoadView();

        }

        protected void UploadLayoutContent_Click(object sender, EventArgs e)
        {
            string guidStr = yachtModelNameList.SelectedValue;
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sql = $"UPDATE yachtManager SET layoutDeckPlanContent=@layoutDeckPlanContent WHERE guid='{guidStr}'"; //guidStr是字串，要多加單引號
            SqlCommand command = new SqlCommand(sql, connection);
            connection.Open();

            string contentStr = HttpUtility.HtmlEncode(CKEditorControl2.Text);
            command.Parameters.AddWithValue("@layoutDeckPlanContent", contentStr);

            command.ExecuteNonQuery();
            connection.Close();
            //通知畫面
            DateTime nowtime = DateTime.Now;
            string time = nowtime.ToString();
            Response.Write($@"<script language='javascript'>alert('{time}-Layout & DeckPlan 上傳成功!');opener.location.reload();</script>");
            LoadView();
        }

        protected void CancleUPloadLayoutContent_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_Yacht.aspx");
        }

        protected void UploadSpecification_Click(object sender, EventArgs e)
        {
            string guidStr = yachtModelNameList.SelectedValue;
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sql = $"UPDATE yachtManager SET specificationContent=@specificationContent WHERE guid='{guidStr}'"; //guidStr是字串，要多加單引號
            SqlCommand command = new SqlCommand(sql, connection);
            connection.Open();

            string contentStr = HttpUtility.HtmlEncode(CKEditorControl3.Text);
            command.Parameters.AddWithValue("@specificationContent", contentStr);

            command.ExecuteNonQuery();
            connection.Close();
            //通知畫面
            DateTime nowtime = DateTime.Now;
            string time = nowtime.ToString();
            Response.Write($@"<script language='javascript'>alert('{time}-dSpecification 上傳成功!');</script>");
            LoadView();
        }

        protected void CancleUPloadSpecification_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_Yacht.aspx");
        }
        protected void yachtAlbumUpload_Click(object sender, EventArgs e)
        {
            //先抓到guid的值
            string guidStr = yachtModelNameList.SelectedValue;

            //設定存檔路徑，需填完整路徑，結尾反斜線如果沒加要用 Path.Combine() 可自動添加
            string savePath = Server.MapPath("/upload/images/");

            //判斷有選檔案才可上傳
            if (yachtAlbumFileUpload.HasFile)
            {
                //儲存文件檔案及文件名稱
                //檢查專案資料夾內有無同名檔案，有同名就加流水號
                DirectoryInfo directoryInfo = new DirectoryInfo(savePath);
                //取得選取檔案名稱
                string fileName = yachtAlbumFileUpload.FileName;
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
                yachtAlbumFileUpload.SaveAs(savePath + fileName);
                //建立與資料庫建立起連接的通道

                SqlConnection Connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
                //先取出yacht Modal的id
                SqlCommand command = new SqlCommand($"SELECT id from yachtManager where guid='{guidStr}'", Connection);
                Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                string id = "";
                if (reader.Read())
                {
                    id = reader["id"].ToString();
                    Connection.Close();
                }

                //寫入上傳的圖片
                SqlCommand Command = new SqlCommand($"INSERT INTO yachtAlbum(imagesFileName,yachtId) VALUES (@imagesFileName,@yachtId)", Connection);
                Command.Parameters.AddWithValue("@imagesFileName", fileName);
                Command.Parameters.AddWithValue("@yachtId", id);
                Connection.Open();
                Command.ExecuteNonQuery();
                Connection.Close();

                //通知畫面
                DateTime nowtime = DateTime.Now;
                string time = nowtime.ToString();

                Response.Write($@"<script language='javascript'>alert('{time}-yacht相片 上傳成功!');</script>");
                LoadView();
            }

        }

        protected void deleteYachtPhoto_Click(object sender, EventArgs e)
        {
            //string guidStr = yachtModelNameList.SelectedValue;
            string id = albumRadioButtonList.SelectedValue;
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sql = $"DELETE FROM yachtAlbum WHERE id={id}";
            SqlCommand command = new SqlCommand(sql, connection);
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
            //通知畫面
            DateTime nowtime = DateTime.Now;
            string time = nowtime.ToString();

            Response.Write($@"<script language='javascript'>alert('{time}-yacht照片刪除成功!')</script>");
            LoadView();

        }

        protected void setFirstImage_Click(object sender, EventArgs e)
        {
            string guidStr = yachtModelNameList.SelectedValue;
            string id = albumRadioButtonList.SelectedValue;
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            //先取出yacht Modal的id
            SqlCommand command = new SqlCommand($"SELECT id from yachtManager where guid='{guidStr}'", connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            string yachtId = "";
            if (reader.Read())
            {
                yachtId = reader["id"].ToString();
                connection.Close();
            }

            //先把其他的原為首圖的圖片一律改為非首圖
            string sqlCheck = $"UPDATE yachtAlbum set firstImage=0 WHERE yachtId={yachtId}";
            SqlCommand commandCheck = new SqlCommand(sqlCheck, connection);
            connection.Open();
            commandCheck.ExecuteNonQuery();
            connection.Close();

            //選項設為首圖
            string sql = $"UPDATE yachtAlbum set firstImage=1 WHERE id={id}";
            SqlCommand commandSetFirtImage = new SqlCommand(sql, connection);
            connection.Open();
            commandSetFirtImage.ExecuteNonQuery();
            connection.Close();
            //通知畫面
            DateTime nowtime = DateTime.Now;
            string time = nowtime.ToString();

            Response.Write($@"<script language='javascript'>alert('{time}-yacht首圖設定成功!')</script>");
            LoadView();
        }
    }
}
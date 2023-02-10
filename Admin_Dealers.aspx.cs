using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Controls;

namespace yatch_project
{
    public partial class Admin_Dealers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //新增國家別
        protected void Button1_Click(object sender, EventArgs e)
        {
            //1.連線資料庫
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            //2.sql語法
            string sql = "INSERT INTO dealers_country(countryName) VALUES(@countryName)";
            //3.創建command物件
            SqlCommand command = new SqlCommand(sql, connection);
            //4.參數化避免攻擊
            command.Parameters.AddWithValue("@countryName", Text1.Value);
            //5.資料庫連線開啟
            connection.Open();
            //6.執行sql (新增刪除修改)
            command.ExecuteNonQuery(); //無回傳值
                                       //7.資料庫關閉
            connection.Close();
            //畫面渲染
            GridView1.DataBind();
            //DropDownList1.DataBind();
            //清空輸入欄位
            Text1.Value = "";
            //渲染畫面
            GridView1.DataBind();
            //通知畫面
            DateTime nowtime = DateTime.Now;
            string time = nowtime.ToString();

            Response.Write($@"<script language='javascript'>alert('{time}-新增國家成功!')</script>");
        }




        protected void AddDealers_Click(object sender, EventArgs e)
        {
            //設定存檔路徑，需填完整路徑，結尾反斜線如果沒加要用 Path.Combine() 可自動添加
            string savePath = Server.MapPath("/upload/Images/");

            string dealerImgPath="";

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
                 dealerImgPath = fileName;

 
               //取得config連接字串資訊

                string getconfig = System.Web.Configuration.WebConfigurationManager
                .ConnectionStrings["yachtConnectionString"].ConnectionString;

                //建立與資料庫建立起連接的通道，以getconfig內的連接字串連接所對應的資料庫

                SqlConnection Connection = new SqlConnection(getconfig);

                //取得下拉選單國家的值 (id)
                string selCountry = DropDownList1.SelectedValue;
               // selCountry= selCountry+1;

                //要對SQL Server下達的SQL指令並且參數化

                SqlCommand command = new SqlCommand($"INSERT INTO Dealers(country_id,dealerImgPath,area,name,contact,address,tel,fax,email,link) VALUES(@country_id,@dealerImgPath,@area,@name,@contact,@address,@tel,@fax,@email,@link); ", Connection);


                //賦予參數資料型態與值
                command.Parameters.AddWithValue("@country_id",selCountry);
                command.Parameters.AddWithValue("@dealerImgPath",dealerImgPath);
                command.Parameters.AddWithValue("@area", Area.Value);
                command.Parameters.AddWithValue("@name", Name.Value);
                command.Parameters.AddWithValue("@contact", Contact.Value);
                command.Parameters.AddWithValue("@address", Address.Value);
                command.Parameters.AddWithValue("@tel", Tel.Value);
                command.Parameters.AddWithValue("@fax", Fax.Value);
                command.Parameters.AddWithValue("@email", Email.Value);
                command.Parameters.AddWithValue("@link", Link.Value);

                Connection.Open();//開啟通道
                command.ExecuteNonQuery();//執行command的SQL語法，回傳受影響的資料數目
                Connection.Close();//關閉通道

                //清空輸入欄位
                Area.Value = "";
                Name.Value = "";
                Contact.Value = "";
                Address.Value = "";
                Address.Value = "";
                Tel.Value = "";
                Fax.Value = "";
                Email.Value = "";
                Link.Value = "";
                UploadImgText.Visible = false;
                UploadText.Visible = false;
                DropDownList1.SelectedValue = null;

                //渲染畫面
                GridView2.DataBind();
                //通知畫面
                DateTime nowtime = DateTime.Now;
                string time = nowtime.ToString();

                Response.Write($@"<script language='javascript'>alert('{time}-新增dealers成功!')</script>");

            }
            else
            {
                //警告沒有選取檔案
                Response.Write($@"<script language='javascript'>alert('尚未上傳圖片，請上傳!')</script>");
                
            }

         

        }

    }
}


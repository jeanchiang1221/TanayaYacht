using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using Konscious.Security.Cryptography;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.IO;

namespace yatch_project
{
    public partial class Admin_User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RegisterUser_Click(object sender, EventArgs e)
        {
            bool haveSameAccount = false;

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            string sqlCheck = "SELECT * FROM Admin_account WHERE account = @account";
            string sqlAdd = "INSERT INTO Admin_account (user_name,account,password,salt,email,avatar) VALUES(@user_name,@account,@password,@salt,@email,@avatar)";
            SqlCommand commandCheck = new SqlCommand(sqlCheck, connection);
            SqlCommand commandAdd = new SqlCommand(sqlAdd, connection);

            //檢查有無重複帳號
            commandCheck.Parameters.AddWithValue("@account",account.Value);
            connection.Open();
            SqlDataReader readerCountry = commandCheck.ExecuteReader();
            if (readerCountry.Read())
            {
                haveSameAccount = true;
                LabelAdd.Visible = true; //帳號重複通知
            }
            connection.Close();

            // 設定存檔路徑，需填完整路徑，結尾反斜線如果沒加要用 Path.Combine() 可自動添加
            string savePath = Server.MapPath("/upload/Images/");
            //無重複帳號才執行加入
            if (!haveSameAccount&& avatarUpload.HasFile)
            {
                //Hash 加鹽加密
                string passwordStr = password.Value;
                var salt = CreateSalt();
                string saltStr = Convert.ToBase64String(salt); //將 byte 改回字串存回資料表
                var hash = HashPassword(passwordStr, salt);
                string hashPassword = Convert.ToBase64String(hash);

                //儲存圖片檔案及圖片名稱
                //檢查專案資料夾內有無同名檔案，有同名就加流水號
                DirectoryInfo directoryInfo = new DirectoryInfo(savePath);
                //取得選取檔案名稱
                string fileName = avatarUpload.FileName;
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
                avatarUpload.SaveAs(savePath + fileName);

                commandAdd.Parameters.AddWithValue("@user_name", userName.Value);
                commandAdd.Parameters.AddWithValue("@account", account.Value);
                commandAdd.Parameters.AddWithValue("@password", hashPassword);
                commandAdd.Parameters.AddWithValue("@salt", saltStr);
                commandAdd.Parameters.AddWithValue("@email", email.Value);
                commandAdd.Parameters.AddWithValue("@avatar", fileName);

                connection.Open();
                commandAdd.ExecuteNonQuery();
                connection.Close();
                //畫面渲染
             
                GridView2.DataBind();
                //清空輸入欄位
                userName.Value = "";
                account.Value = "";
                password.Value = "";
                email.Value = "";
                avatarUpload.FileName.DefaultIfEmpty();//檔案清空
                //通知畫面
                DateTime nowtime = DateTime.Now;
                string time = nowtime.ToString();
                Response.Write($@"<script language='javascript'>alert('{time}-註冊成功!')</script>");
            }
        }

        // Argon2 加密
        //產生 Salt 功能
        private byte[] CreateSalt()
        {
            var buffer = new byte[16];
            var rng = new RNGCryptoServiceProvider();
            rng.GetBytes(buffer);
            return buffer;
        }
        // Hash 處理加鹽的密碼功能
        private byte[] HashPassword(string password, byte[] salt)
        {
            var argon2 = new Argon2id(Encoding.UTF8.GetBytes(password));
            
            //底下這些數字會影響運算時間，而且驗證時要用一樣的值
            argon2.Salt = salt;
            argon2.DegreeOfParallelism = 8; // 4 核心就設成 8
            argon2.Iterations = 4; // 迭代運算次數
            argon2.MemorySize = 1024 * 1024; // 1 GB

            return argon2.GetBytes(16);
        }


    }
}
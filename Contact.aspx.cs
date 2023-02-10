using MimeKit;
using MailKit.Net.Smtp;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.ComponentModel.DataAnnotations;

namespace yatch_project
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //  LoadDropDownList();
                LoadYachtDropDownList();
            }

        }

        //因為留言者的國家別好像跟dealers的國家沒什麼關係，所以先不顯示這段程式碼
        //private void LoadDropDownList()
        //{
        //    SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
        //    SqlCommand command = new SqlCommand($"SELECT countryName FROM dealers_country", connection); 
        //    connection.Open();
        //    SqlDataReader reader = command.ExecuteReader();
        //    while (reader.Read())
        //    {
        //        string countryName = reader["countryName"].ToString();
        //        CountryDropDownList.Items.Add($"{countryName}");
        //    }
        //    connection.Close();
        //}


        private void LoadYachtDropDownList()
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            SqlCommand command = new SqlCommand($"SELECT * FROM yachtManager", connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                string yachtModelName = reader["yachtModelName"].ToString();
                bool isNewBuilding = (bool)reader["isNewBuilding"];
                if (isNewBuilding)
                {
                    YachtDropDownList.Items.Add($"{yachtModelName} (New Building)");
                }
                else
                {
                    YachtDropDownList.Items.Add($"{yachtModelName}");
                }
            }
            connection.Close();
        }

        protected void SendMessageBtn_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(RecaptchaWidget1.Response))
            {
                Response.Write($@"<script language='javascript'>alert('Captcha cannot be empty.')</script>");
            }
            else
            {
                var result = RecaptchaWidget1.Verify();
                if (result.Success)
                {
                    //此處可加入"我不是機器人驗證"成功後要做的事
                    sendGmail();

                    SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
                    SqlCommand command = new SqlCommand("INSERT INTO Contact(name,email,phone,country,selectYachtModel,comments,guid,summary) VALUES(@name,@email,@phone,@country,@selectYachtModel,@comments,@guid,@summary)", connection);
                    connection.Open();
                    //產生 GUID 隨機碼 + 時間2位秒數 (加強避免重複)
                    DateTime nowTime = DateTime.Now;
                    string nowSec = nowTime.ToString("ff");
                    string guid = Guid.NewGuid().ToString().Trim() + nowSec;

                    command.Parameters.AddWithValue("@name", Name.Value);
                    command.Parameters.AddWithValue("@email", Email.Value);
                    command.Parameters.AddWithValue("@phone", Phone.Value);
                    command.Parameters.AddWithValue("@country", CountryDropDownList.SelectedValue);
                    command.Parameters.AddWithValue("@selectYachtModel", YachtDropDownList.SelectedValue);
                    command.Parameters.AddWithValue("@comments", comments.Value);
                    command.Parameters.AddWithValue("@guid", guid);
                    if (comments.Value.Length >= 30)
                    {
                        string summary = comments.Value.Remove(30) + "...";
                        command.Parameters.AddWithValue("@summary", summary);
                    }
                    else
                    {
                        string summary = comments.Value;
                        command.Parameters.AddWithValue("@summary", summary);
                    }


                    command.ExecuteNonQuery();
                    connection.Close();
                    //畫面渲染

                    //清空輸入欄位
                    Name.Value = "";
                    Email.Value = "";
                    Phone.Value = "";
                    CountryDropDownList.SelectedValue = null;
                    YachtDropDownList.SelectedValue = null;
                    comments.Value = "";
                    //通知畫面
                    DateTime nowtime = DateTime.Now;
                    string time = nowtime.ToString();
                    Response.Write($@"<script language='javascript'>alert('{time}-留言發送成功!')</script>");

                }
                else
                {
                    Response.Write($@"<script language='javascript'>alert('Error(s):')</script>");
                    //lblMessage.Text = "Error(s): ";

                    foreach (var err in result.ErrorCodes)
                    {
                        Response.Write($@"<script language='javascript'>alert('Error(s): {err}')</script>");
                        //  lblMessage.Text = lblMessage.Text + err;
                    }
                }
            }







        }

        private void sendGmail()
        {
            //宣告使用 MimeMessage
            var message = new MimeMessage();
            //設定發信地址 ("發信人", "發信 email")
            message.From.Add(new MailboxAddress(Name.Value.Trim(), Email.Value.Trim()));

            //設定收信地址 ("收信人", "收信 email")
            message.To.Add(new MailboxAddress("TayanaYacht", "testjean2112@gmail.com"));
            //寄件副本email
            // message.Cc.Add(new MailboxAddress("收信人名稱", "XXXXXXX@gmail.com"));
            //設定優先權
            //message.Priority = MessagePriority.Normal;
            //信件標題
            message.Subject = "TayanaYacht Auto Email";
            //建立 html 郵件格式
            BodyBuilder bodyBuilder = new BodyBuilder();
            bodyBuilder.HtmlBody =
                "<h1>Thank you for contacting us!</h1>" +
                $"<h3>Name : {Name.Value.Trim()}</h3>" +
                $"<h3>Email : {Email.Value.Trim()}</h3>" +
                $"<h3>Phone : {Phone.Value.Trim()}</h3>" +
                $"<h3>Country : {CountryDropDownList.SelectedValue}</h3>" +
                $"<h3>Type : {YachtDropDownList.SelectedValue}</h3>" +
                $"<h3>Comments : </h3>" +
                $"<p>{comments.Value.Trim()}</p>";
            //設定郵件內容
            message.Body = bodyBuilder.ToMessageBody(); //轉成郵件內容格式

            using (var client = new MailKit.Net.Smtp.SmtpClient())
            {
                //有開防毒時需設定 false 關閉檢查
                client.CheckCertificateRevocation = false;
                //設定連線 gmail ("smtp Server", Port, SSL加密) 
                client.Connect("smtp.gmail.com", 587, false); // localhost 測試使用加密需先關閉 
                //申請的應用程式密碼: lxtebgykzxqmpaiy
                // Note: only needed if the SMTP server requires authentication
                client.Authenticate("testjean2112@gmail.com", "lxtebgykzxqmpaiy");
                //發信
                client.Send(message);
                //結束連線
                client.Disconnect(true);
            }
        }


    }
}
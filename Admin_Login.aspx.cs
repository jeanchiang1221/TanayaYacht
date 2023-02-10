using Konscious.Security.Cryptography;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;

namespace yatch_project
{
    public partial class Admin_Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        // Argon2 驗證加密密碼
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

        //驗證
        private bool VerifyHash(string password, byte[] salt, byte[] hash)
        {
            var newHash = HashPassword(password, salt);
            return hash.SequenceEqual(newHash); // LinQ
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string password = TextBox2.Text;

            //1.連線資料庫
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            //2.sql語法 (@參數化避免隱碼攻擊)
            string sql = $"SELECT * FROM admin_account WHERE account = @account";
            //3.創建command物件
            SqlCommand command = new SqlCommand(sql, connection);
            //4.放入參數化資料
            command.Parameters.AddWithValue("@account", TextBox1.Text);
            //5.資料庫用Adapter執行指令
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            //6.建立一個空的Table
            DataTable dataTable = new DataTable();
            //7.將資料放入Table
            dataAdapter.Fill(dataTable);
            //登入流程管理 (Cookie)
            if (dataTable.Rows.Count > 0)
            {
                //SQL有找到資料時執行

                //將字串轉回byte
                byte[] hash = Convert.FromBase64String(dataTable.Rows[0]["password"].ToString());
                byte[] salt = Convert.FromBase64String(dataTable.Rows[0]["salt"].ToString());
                //驗證密碼
                bool success = VerifyHash(password, salt, hash);

                if (success)
                {
                    //宣告驗證票要夾帶的資料 (先用;區隔，取出時再用;切)
                    //也可以將之資料庫物件序列化轉成JSON字串，取出時反序列化使用
                    string userData = dataTable.Rows[0]["highest_authority"].ToString() + ";" + dataTable.Rows[0]["account"].ToString() + ";" + dataTable.Rows[0]["user_name"].ToString() + ";" + dataTable.Rows[0]["email"].ToString();
                    //設定驗證票(夾帶資料，cookie命名) //需額外引入using System.Web.Configuration;
                    SetAuthenTicket(userData, TextBox1.Text);

                    Response.Redirect("Admin_Index.aspx");
                }
                else
                {
                    //資料庫裡找不到相同資料時，表示密碼有誤!
                    Response.Write($@"<script language='javascript'>alert('密碼有誤，請重新輸入')</script>");
                    connection.Close();
                    //終止程式
                    //Response.End(); //會清空頁面
                    return;
                }
            }
            else
            {
                //資料庫裡找不到相同資料時，表示帳號有誤!
                Response.Write($@"<script language='javascript'>alert('帳號有誤，請重新輸入')</script>");
                connection.Close();
                //終止程式
                //Response.End(); //會清空頁面
                return;
            }
        }

        //設定驗證票
        private void SetAuthenTicket(string userData, string userId)
        {
            //宣告一個驗證票 //需額外引入using System.Web.Security;
            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, userId, DateTime.Now, DateTime.Now.AddHours(3), false, userData);
            //加密驗證票
            string encryptedTicket = FormsAuthentication.Encrypt(ticket);
            //建立Cookie
            HttpCookie authenticationCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
            //將Cookie寫入回應
            Response.Cookies.Add(authenticationCookie);
        }

    }
}
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace yatch_project
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            //清除Cache，避免登出後按上一頁還會顯示Cache頁面
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //權限關門判斷 (Cookie)
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("Admin_login.aspx"); //導回登入頁
            }
            else
            {
                NewMessageCount();
                MessageDropdownListLoad();
                UserNameCardLoad();
                ProfileModalLoad();

                //取得驗證票夾帶資訊
                string ticketUserData = ((FormsIdentity)(HttpContext.Current.User.Identity)).Ticket.UserData;
                string[] ticketUserDataArr = ticketUserData.Split(';');

                //最高權限的管理者才可以看到帳號管理的功能
                if (ticketUserDataArr[0].Equals("True"))
                {
                    accountManager.Visible = true;
                }
                else
                {
                    accountManager.Visible = false;
                }
            }


            //為了避免一直進行登入浪費時間，先執行這段就好，最後改完再刪掉這段，並且解掉馬賽克上面的部分
            //NewMessageCount();
            //MessageDropdownListLoad();
            //UserNameCardLoad();
            //ProfileModalLoad();


        }

        private void NewMessageCount()
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);

            SqlCommand command = new SqlCommand("Select COUNT(*) from Contact where isRead='false'", connection);
            connection.Open();
            newMessageNum.Text = "<span class='badge badge-danger badge-counter'>" + Convert.ToString(command.ExecuteScalar()) + "</span>";

        }

        private void MessageDropdownListLoad()
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);

            SqlCommand command = new SqlCommand("Select *  from Contact where isRead='false' order by date desc", connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            StringBuilder messagesDropdownStr = new StringBuilder();


            if (reader.Read())
            {
                messagesDropdownStr.Append($@"<h6 class='dropdown-header'>New Message</h6>");
                string guid = reader["guid"].ToString();
                string summary = reader["summary"].ToString();
                string name = reader["name"].ToString();
                string date = Convert.ToDateTime(reader["date"]).ToString("yyyy-MM-dd");
                messagesDropdownStr.Append($@"<a class='dropdown-item d-flex align-items-center' href='Admin_Message_Main.aspx?guid={guid}'>
                                            <div class='dropdown-list-image mr-3'><img class='rounded-circle' src='/upload/images/avatar.png' alt='...'></div>
                                    <div><div class='text-truncate'>{summary}</div>
                                        <div class='small text-gray-500'>{name} · {date}</div>
                                    </div></a>");
            }
            while (reader.Read())
            {
                string guid = reader["guid"].ToString();
                string summary = reader["summary"].ToString();
                string name = reader["name"].ToString();
                string date = Convert.ToDateTime(reader["date"]).ToString("yyyy-MM-dd");
                messagesDropdownStr.Append($@"<a class='dropdown-item d-flex align-items-center' href='Admin_Message_Main.aspx?guid={guid}'>
                                            <div class='dropdown-list-image mr-3'><img class='rounded-circle' src='/upload/images/avatar.png' alt='...'></div>
                                    <div><div class='text-truncate'>{summary}</div>
                                        <div class='small text-gray-500'>{name} · {date}</div>
                                    </div></a>");

            }
            //如果沒有讀到"未讀"的message的話
            if (!reader.HasRows)
            {
                messagesDropdownStr.Append($@"<h6 class='dropdown-header'>There is no new message.</h6></span>");
            }
            messagesDropdownStr.Append($@"<a class='dropdown-item text-center small text-gray-500' href='Admin_Message.aspx'>Read More Messages</a>");


            messagesDropdownList.InnerHtml = messagesDropdownStr.ToString();
        }

        private void UserNameCardLoad()
        {
            //取得驗證票夾帶資訊
            string ticketUserData = ((FormsIdentity)(HttpContext.Current.User.Identity)).Ticket.UserData;
            string[] ticketUserDataArr = ticketUserData.Split(';');

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            SqlCommand command = new SqlCommand($"Select user_name,avatar,id from admin_account WHERE account = @account", connection);
            command.Parameters.AddWithValue("@account", ticketUserDataArr[1]);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            StringBuilder userNameCardHTML = new StringBuilder();

            if (reader.Read())
            {
                string userName = reader["user_Name"].ToString();
                string avatar = reader["avatar"].ToString();
                string id = reader["id"].ToString();
                //userNameCardHTML.Append($@"<a><a class='nav-link dropdown-toggle' href='#' id='userDropdown' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>
                //                            <span class='mr-2 d-none d-lg-inline text-gray-600 small'>{userName}</span>
                //                             <img class='img-profile rounded-circle' src='upload/Images/{avatar}'></a></a>
                //                         <div class='dropdown-menu dropdown-menu-right shadow animated--grow-in' aria-labelledby ='userDropdown'>
                //                          <a class='dropdown-item' href='Admin_User_Profile.aspx?id={id}'>
                //                            <i class='fas fa-user fa-sm fa-fw mr-2 text-gray-400'></i>Profile</a>
                //                        <div class='dropdown-divider'></div><a class='dropdown-item' href='#' data-toggle='modal' data-target='#logoutModal'>
                //                        <i class='fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400'></i>Logout</a></div>");
                userNameCardHTML.Append($@"<a><a class='nav-link dropdown-toggle' href='#' id='userDropdown' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>
                                            <span class='mr-2 d-none d-lg-inline text-gray-600 small'>{userName}</span>
                                             <img class='img-profile rounded-circle' src='upload/Images/{avatar}'></a></a>
                                         <div class='dropdown-menu dropdown-menu-right shadow animated--grow-in' aria-labelledby ='userDropdown'>
                                          <a class='dropdown-item' href='#' data-toggle='modal' data-target='#profileModal'>
                                            <i class='fas fa-user fa-sm fa-fw mr-2 text-gray-400'></i>Profile</a>
                                        <div class='dropdown-divider'></div><a class='dropdown-item' href='#' data-toggle='modal' data-target='#logoutModal'>
                                        <i class='fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400'></i>Logout</a></div>");
            }
            userNameCard.InnerHtml = userNameCardHTML.ToString();
        }

        private void ProfileModalLoad()
        {
            //取得驗證票夾帶資訊
            string ticketUserData = ((FormsIdentity)(HttpContext.Current.User.Identity)).Ticket.UserData;
            string[] ticketUserDataArr = ticketUserData.Split(';');

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            SqlCommand command = new SqlCommand($"Select * from admin_account WHERE account = @account", connection);
            command.Parameters.AddWithValue("@account", ticketUserDataArr[1]);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            StringBuilder profileModalContentHTML = new StringBuilder();

            if (reader.Read())
            {
                bool highest_authority = (bool)reader["highest_authority"];
                string userName = "";
                if (highest_authority)
                {
                    userName = reader["user_name"].ToString() + "(最高權限管理者)";
                }
                else
                {
                    userName = reader["user_name"].ToString();
                }
      
                string avatar = reader["avatar"].ToString();

                string email = reader["email"].ToString();
                profileModalContentHTML.Append($@"<div class='d-flex' style='align-items:center'>
                                                    <div class='mr-2'> 
                                                    <img class='img-profile rounded-circle' style='width:150px' src='upload/Images/{avatar}'>
                                                    </div>
                                                    <div><span>使用者名稱:{userName}</span><br/><br/>
                                                       <span>帳號:{ticketUserDataArr[1]}</span><br/><br/>
                                                       <span>Email:{email}</span><br/><br/>
                                                       </div></div>");
            }
            profileModalContent.InnerHtml = profileModalContentHTML.ToString();
        }

    }
}
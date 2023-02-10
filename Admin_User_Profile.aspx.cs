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
    public partial class Admin_User_Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        {
            string id = Request.QueryString["id"];

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);
            SqlCommand command = new SqlCommand($"SELECT * FROM admin_account where id={id}", connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            StringBuilder avatarHtml = new StringBuilder();

            if (reader.Read())
            {
                
                bool highest_authority = (bool)reader["highest_authority"];
                string avatarStr = reader["avatar"].ToString();
                if (highest_authority)
                {
                    userName.Text = reader["user_name"].ToString()+"(最高權限管理者)";
                }
                else
                {
                    userName.Text = reader["user_name"].ToString();
                }
                account.Text = reader["account"].ToString();
                email.Text = reader["email"].ToString();

                avatarHtml.Append($"<img class='img-profile rounded-circle' style='width:300px' src='upload/Images/{avatarStr}'>");
            }
            connection.Close();
            avatar.InnerHtml = avatarHtml.ToString() ;
        }
    }
}
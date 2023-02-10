using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace yatch_project
{
    public partial class Admin_Message_Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMessage();
                IsRead();
            }
        }

        private void LoadMessage()
        {
            string guidStr = Request.QueryString["guid"];
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);

            SqlCommand command = new SqlCommand($"Select *  from Contact where guid='{guidStr}'", connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();


            if (reader.Read())
            {
                messageName.Text ="姓名:" +reader["name"].ToString();
                messageDate.Text= "時間:" + reader["date"].ToString();
                messagePhone.Text = "連絡電話:" + reader["phone"].ToString();
                messageEmail.Text = "Email:" + reader["email"].ToString();
                selectedYachModel.Text= "選擇的Yacht Model: " + reader["selectYachtModel"].ToString();
                messageComments.Text =reader["comments"].ToString();
            }
        }

        private void IsRead()
        {
            string guidStr = Request.QueryString["guid"];
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["yachtConnectionString"].ConnectionString);

            SqlCommand command = new SqlCommand($"UPDATE Contact set isRead=@isRead where guid='{guidStr}'", connection);
            connection.Open();
            bool read = true;
            command.Parameters.AddWithValue("@isRead", read);
            command.ExecuteNonQuery();
            connection.Close();

        }

        protected void ReplyMessage_Click(object sender, EventArgs e)
        {
            Response.Redirect("https://mail.google.com/mail/u/0/#inbox?compose=new");
        }
    }
}
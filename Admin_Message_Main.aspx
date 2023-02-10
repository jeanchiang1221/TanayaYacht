<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin_Message_Main.aspx.cs" Inherits="yatch_project.Admin_Message_Main" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">留言內容</h6>
        </div>

        <div class="card-body">
            <asp:Label ID="messageName" runat="server" Text=""></asp:Label> <br />
           <asp:Label ID="messageDate" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="selectedYachModel" runat="server" Text=""></asp:Label><br />
             <asp:Label ID="messagePhone" runat="server" Text=""></asp:Label><br />
             <asp:Label ID="messageEmail" runat="server" Text=""></asp:Label><br />
            <hr />
            <span>內容 :</span><br />
            <asp:Label ID="messageComments" runat="server" Text=""></asp:Label>

  
        </div>
    </div>

     <asp:Button ID="ReplyMessageBtn" runat="server" Visible="True" Text="回信" class="btn btn-outline-primary btn-block mt-3 w-25 " onClick="ReplyMessage_Click"/>

</asp:Content>

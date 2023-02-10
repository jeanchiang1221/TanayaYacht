<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin_User_Profile.aspx.cs" Inherits="yatch_project.Admin_User_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Profile</h6>
        </div>

        <div class="card-body">
            <div class="d-flex" style="align-items: center;">
                <div class="mr-5" id="avatar" runat="server">
                    
                </div>
                <div>
                    <span>使用者名稱: </span>
                    <asp:Label ID="userName" runat="server" Text="Label"></asp:Label>
                    <br />
                    <br />
                    <span>帳號: </span>
                    <asp:Label ID="account" runat="server" Text="Label"></asp:Label>
                    <br />
                    <br />
                    <span>Email: </span>
                    <asp:Label ID="email" runat="server" Text="Label"></asp:Label>
                    <br />
                    <br />

                </div>

            </div>
        </div>
    </div>

</asp:Content>

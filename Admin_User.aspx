
<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin_User.aspx.cs" Inherits="yatch_project.Admin_User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">最高管理者</h6>
        </div>

        <div class="card-body">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" class="table table-bordered" >
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" />
                    <asp:TemplateField HeaderText="user_name" SortExpression="user_name">
                        <ItemTemplate>
                             <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Bind("user_name") %>' NavigateUrl='<%# "Admin_User_Profile.aspx?id="+Eval("id") %>'>HyperLink</asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="account" HeaderText="account" SortExpression="account" />
                    <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:yachtConnectionString %>" SelectCommand="SELECT [id], [user_name], [account], [email] FROM [admin_account] where [highest_authority] =1;"></asp:SqlDataSource>

        </div>
    </div>

        <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">其他管理者名單</h6>
        </div>

        <div class="card-body">
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" DataKeyNames="id" class="table table-bordered" >
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" />
                    <asp:TemplateField HeaderText="user_name" SortExpression="user_name">
                        <ItemTemplate>
                             <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Bind("user_name") %>' NavigateUrl='<%# "Admin_User_Profile.aspx?id="+Eval("id") %>'>HyperLink</asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="account" HeaderText="account" SortExpression="account" />
                    <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                             <asp:LinkButton  runat="server" CommandName="Delete" Text="刪除" OnClientClick="return confirm('確定要刪除嗎?')" CausesValidation="False"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:yachtConnectionString %>" 
                SelectCommand="SELECT [id], [user_name], [account], [email] FROM [admin_account] where [highest_authority] =0;"
               DeleteCommand="DELETE FROM [admin_account] WHERE [id] = @id">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="String" />
                </DeleteParameters>

            </asp:SqlDataSource>

        </div>
    </div>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">新增管理者</h6>
        </div>

        <div class="card-body">
            <div class="d-flex">
                <div class="mr-5">
                    <span>使用者名稱: </span>
                    <input id="userName" type="text" runat="server"/>
                    <br />
                    <br />
                    <span>帳號: </span>
                    <input id="account" type="text"  runat="server"/>
                    <br />
                    <br />
                    <span>密碼: </span>
                    <input id="password" type="password" runat="server"/>
                    <br />
                    <br />
                    <span>Email: </span>
                    <input id="email" type="email" runat="server" />
                    <br />
                    <br />

                </div>
                <div>
                    <span>大頭貼: </span><br />
                      <asp:FileUpload ID="avatarUpload" runat="server" class="btn btn-outline-primary btn-block" AllowMultiple="True" onchange="picview(this)" />
                     <div id="picview"></div>
                </div>
            </div>
             <asp:Label ID="LabelAdd" runat="server" Visible="False"><span class="badge badge-pill badge-warning text-dark">* Account Name has repeated !</span></asp:Label>
                    
              <asp:Button ID="RegisterUserBtn" runat="server" Visible="True" Text="註冊" class="btn btn-outline-primary btn-block mt-3 w-25 " OnClick="RegisterUser_Click" />
        </div>
    </div>

    <%--圖片預覽功能的js及css--%>

    <style type="text/css">
        #picview img {
            max-height: 180px;
            max-width: 180px;
            border-width: 0px;
            padding: 5px;
            border: 1px solid #cccccc;
        }
        #picviewEdited img {
            height: 121px;
            width: 161px;
            border-width: 0px;
            padding: 5px;
            border: 1px solid #cccccc;
        }
    </style>

    <script type="text/javascript">
        function picview(file) {
            var picviewDiv = document.getElementById('picview');
            if (file.files && file.files[0]) {
                var reader = new FileReader();
                reader.onload = function (evt) {
                    picviewDiv.innerHTML = '<img src="' + evt.target.result + '" />';
                }
                reader.readAsDataURL(file.files[0]);
            }
            else {
                picviewDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
            }
        }
        function picviewEdited(file) {
            var picviewEditedDiv = document.getElementById('picviewEdited');
            var picviewDiv = document.getElementById('picview');
            if (file.files && file.files[0]) {
                var reader = new FileReader();
                reader.onload = function (evt) {
                    picviewEditedDiv.innerHTML = '<img src="' + evt.target.result + '" />';
                    picviewDiv.style.display = "none"; //上傳新的圖片後，原本的圖片預覽給隱藏
                }
                reader.readAsDataURL(file.files[0]);
            }
            else {
                picviewEditedDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
            }
        }
    </script>

</asp:Content>


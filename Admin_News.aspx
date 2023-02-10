<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin_News.aspx.cs" Inherits="yatch_project.Admin_News" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

    <div class="card shadow mb-4" id="UploadNews" runat="server">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">發布新聞</h6>
        </div>

        <div class="card-body" id="UploadNewsContent" runat="server">
            <div class="d-md-flex">

                <div class="w-50">
                    <span>新增新聞封面:</span>
                    <asp:FileUpload ID="imageUpload" runat="server" class="btn btn-outline-primary btn-block" AllowMultiple="True" onchange="picview(this)" />
                    <asp:Label ID="UploadImgText" runat="server" Text="Label" Visible="false"></asp:Label>
                    <div>
                        <span>圖片預覽:</span>
                        <div id="picview"></div>
                    </div>
                </div>
                <div class="pl-2">
                    <span>新聞發布日期:</span></br>
                    <asp:TextBox ID="datepicker" runat="server" TextMode="Date"></asp:TextBox>
                </div>
            </div>


            <span>新聞標題 :</span>
            <input id="title" runat="server" type="text" style="width: 70%" />
            <asp:CheckBox ID="isTop" runat="server" Text="是否置頂" />
            <br />

            <span>新聞內容 :</span>
            <CKEditor:CKEditorControl ID="CKEditorControl1" BasePath="/Scripts/ckeditor/" runat="server"></CKEditor:CKEditorControl>

            <asp:Label ID="UploadNewsLab" runat="server" Visible="False" ForeColor="#009933" class="d-flex justify-content-center"></asp:Label>
            <div class="d-flex">
                <asp:Button ID="UploadNewsBtn" runat="server" Visible="True" Text="上傳新聞" class="btn btn-outline-primary btn-block mt-3 w-25 " OnClick="UploadNewsBtn_Click" />
                  <asp:Button ID="CancleUploadNewsBtn" runat="server" Visible="True" Text="取消/清空" class="btn btn-outline-secondary btn-block mt-3 w-25 " OnClick="CancleUploadNewsBtn_Click" />
            </div>
            
        </div>
        <asp:Label ID="UploadText" runat="server" Text="Label" Visible="false"></asp:Label>
        <asp:Button ID="AfterUploadedReturn" runat="server" Visible="false" Text="返回" class="btn btn-outline-primary btn-block mt-3 w-25 " OnClick="Return_Click" />
    </div>

    <div class="card shadow mb-4" id="EditNews" runat="server" visible="false">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">修改新聞內容</h6>
        </div>

        <div class="card-body" runat="server" id="EditedNewsContent">
            <div class="d-md-flex">

                <div class="w-50">
                    <span>新聞封面:</span>
                    <asp:Label ID="previewOriginal" runat="server" Text="Label"></asp:Label>

                    <div id="picviewEdited" visible="false" onchange="picviewEdited(this)"></div>
                    <span>更新新聞封面:</span>
                    <asp:FileUpload ID="imageEditedUpload" runat="server" class="btn btn-outline-primary btn-block" AllowMultiple="True" onchange="picview(this)" />
                    <asp:Label ID="UploadEditedImgText" runat="server" Text="Label" Visible="false"></asp:Label>
                    <div>
                    </div>
                </div>
                <div class="w-50"> 
                    <span>新聞發布時間:</span>
                    <asp:TextBox ID="datepickerEdit" runat="server" TextMode="Date" ></asp:TextBox>

                </div>

            </div>
            <asp:HiddenField ID="HiddenGuid" runat="server" Value="" />
            <span>新聞標題 :</span>
            <input id="titleOriginal" runat="server" type="text" style="width: 70%" />
            <asp:CheckBox ID="isTopEdit" runat="server" Text="是否置頂" />
            <br />

            <span>新聞內容 :</span>
            <CKEditor:CKEditorControl ID="CKEditorControl2" BasePath="/Scripts/ckeditor/" runat="server"></CKEditor:CKEditorControl>

            <asp:Label ID="Label2" runat="server" Visible="False" ForeColor="#009933" class="d-flex justify-content-center"></asp:Label>
            <div class="d-flex">
                <asp:Button ID="UploadEditedNewsBtn" runat="server" Visible="True" Text="上傳更新新聞" class="btn btn-outline-primary btn-block mt-3 w-25 " OnClick="UploadEditedNewsBtn_Click" />
                <asp:Button ID="CancleEditedBtn" runat="server" Visible="True" Text="取消" class="btn btn-outline-secondary btn-block mt-3 w-25 " OnClick="CancleEditedBtn_Click"/>
            </div>
         
        </div>
           <asp:Label ID="UploadEditedText" runat="server" Text="Label" Visible="false"></asp:Label>
        <asp:Button ID="AfterEditedReturn" runat="server" Visible="false" Text="返回" class="btn btn-outline-primary btn-block mt-3 w-25 " OnClick="Return_Click" />
    </div>

    <div class="card shadow mb-4" id="postedNews" runat="server">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">已發布之新聞內容</h6>
        </div>

        <div class="card-body">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="guid" class="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                    <asp:BoundField DataField="date" HeaderText="date" SortExpression="date" />
                    <asp:BoundField DataField="title" HeaderText="title" SortExpression="title" />
                    <asp:CheckBoxField DataField="isTop" HeaderText="isTop" SortExpression="isTop" />


                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="EditBtn" runat="server" CausesValidation="false" Text="編輯" OnClick="EditNewsBtn_Click" DataField="guid" CommandArgument='<%#Eval("guid") %>' />

                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Delete" ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="Button2" runat="server" CommandName="Delete" Text="刪除" OnClientClick="return confirm('確定要刪除嗎?')" CausesValidation="False"></asp:Button>
                        </ItemTemplate>
                   <%--     <ControlStyle BorderColor="#66CCFF" BorderStyle="Solid" BorderWidth="1px" CssClass="btn btn-danger btn-block" ForeColor="White" />--%>
                    </asp:TemplateField>


                </Columns>
            </asp:GridView>


            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:yachtConnectionString7 %>"
                SelectCommand="SELECT [id], [date], [title], [content], [isTop],[guid] FROM [News]"
                DeleteCommand="DELETE FROM [News] WHERE [guid] = @guid">
                <DeleteParameters>
                    <asp:Parameter Name="guid" Type="String" />
                </DeleteParameters>

            </asp:SqlDataSource>


        </div>

    </div>

    <%--圖片預覽功能的js及css--%>

    <style type="text/css">
        #picview img {
            height: 121px;
            width: 161px;
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

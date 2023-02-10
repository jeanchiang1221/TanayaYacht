<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin_Yacht.aspx.cs" Inherits="yatch_project.Admin_Yacht" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

    <!--新增yacht model -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">新增 /編輯yacht model</h6>
        </div>

        <div class="card-body">
            <span>Yacht Model 列表</span>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id"  class="table table-bordered" DataSourceID="SqlDataSource2">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                    <asp:BoundField DataField="yachtModelName" HeaderText="名稱" SortExpression="yachtModelName" />
                    <asp:CheckBoxField DataField="isNewBuilding" HeaderText="是否為新型" SortExpression="isNewBuilding" />
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:Button runat="server" CausesValidation="False" CommandName="Update" Text="更新"/>
                            &nbsp;<asp:Button runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Button  runat="server" CausesValidation="False" CommandName="Edit" Text="編輯" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button  runat="server" CausesValidation="False" CommandName="Delete" Text="刪除" DataField="id" CommandArgument='<%#Eval("id") %>' OnClick="DeleteYachtModel_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:yachtConnectionString11 %>" 
                SelectCommand="SELECT [id], [yachtModelName], [isNewBuilding] FROM [yachtManager]"
                 DeleteCommand="DELETE FROM [yachtManager] WHERE [id] = @id"
                UpdateCommand="UPDATE [yachtManager] SET [yachtModelName] = @yachtModelName,[isNewBuilding]=@isNewBuilding WHERE [id] = @id">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="String" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="id" Type="String" />
                    <asp:Parameter Name="yachtModelName" Type="String" />
                    <asp:Parameter Name="isNewBuilding" Type="Boolean" />
                </UpdateParameters>
                </asp:SqlDataSource>
      
            <hr />
            <span>新增Yach Model</span><br />
           <input id="AddYachtModelText" runat="server" type="text" placeholder="請輸入yacht model" />
            <asp:Button ID="AddYachtModel_btn" runat="server" Text="新增yacht model" OnClick="AddYachtModel_Click" />
            
        </div>
    </div>

    <!--選擇yacht model -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">新增/修改Yacht內容</h6>
        </div>

        <div class="card-body">
            <asp:DropDownList ID="yachtModelNameList" runat="server" AppendDataBoundItems="True" OnSelectedIndexChanged="yachtModel_Changed"
                AutoPostBack="true" DataTextField="yachtModelName" DataValueField="guid" DataSourceID="SqlDataSource1" class="btn btn-warning" >

                <asp:ListItem Value="0" class="dropdown-item" >請選擇yacht model</asp:ListItem>
            </asp:DropDownList>

   <%--         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="yachtModelNameList"
                ErrorMessage="請選擇項目" InitialValue="0"></asp:RequiredFieldValidator>--%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:yachtConnectionString8 %>" SelectCommand="SELECT [yachtModelName], [guid] FROM [yachtManager]"></asp:SqlDataSource>
            <br />
            <br />
 


    <!-- Overview Content編輯 -->
    <div class="card shadow mb-4">
        <!-- Card Header - Accordion -->
        <a href="#overviewContent" class="d-block card-header py-3" data-toggle="collapse"
            role="button" aria-expanded="false" aria-controls="overviewContent">
            <h6 class="m-0 font-weight-bold text-primary">
                <asp:Label ID="OverviewContentText" runat="server" Text="Label"></asp:Label>Overview Content編輯</h6>
        </a>
        <!-- Card Content - Collapse -->
        <div class="collapse" id="overviewContent">
            <div class="card-body">

                <div id="overviewContentPart" visible="false" runat="server">
                    <ckeditor:ckeditorcontrol ID="CKEditorControl1" BasePath="/Scripts/ckeditor/" runat="server"></ckeditor:ckeditorcontrol>

                    <asp:Label ID="UploadOverviewContent" runat="server" Visible="False" ForeColor="#009933" class="d-flex justify-content-center"></asp:Label>
                    <div class="d-flex">
                        <asp:Button ID="UploadOverviewContentBtn" runat="server" Visible="True" Text="上傳" class="btn btn-outline-primary btn-block mt-3 w-25 " OnClick="UploadOverviewContent_Click" />
                        <asp:Button ID="CancleUploadOverviewContentBtn" runat="server" Visible="True" Text="取消/回上頁" class="btn btn-outline-secondary btn-block mt-3 w-25 " OnClick="CancleUploadOverviewContentBtn_Click" />
                    </div>
                </div>
     
            </div>
        </div>
    </div>


    <!-- Overview Dimension編輯 -->
    <div class="card shadow mb-4">
        <!-- Card Header - Accordion -->
        <a href="#overviewDimension" class="d-block card-header py-3" data-toggle="collapse"
            role="button" aria-expanded="false" aria-controls="overviewDimension">
            <h6 class="m-0 font-weight-bold text-primary">
                <asp:Label ID="OverviewDimensionText" runat="server" Text=""></asp:Label>Overview Dimension編輯</h6>
        </a>
        <!-- Card Content - Collapse -->
        <div class="collapse" id="overviewDimension">
            <div class="card-body">

                <div id="overviewDimensionPart" visible="false" runat="server">
                    <div class="d-flex">
                        <%--    Dimension表格--%>
                        <table class="dimensionTable">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Content</th>
                                    <th>功能</th>
                                </tr>
                            </thead>
                            <%--      從資料庫撈出來的dimension--%>
                            <tbody class="dimensionTableStrOld" id="dimensionTableStrHTML" runat="server">
                            </tbody>
                            <%--      要新增的的dimension--%>
                            <tbody class="dimensionTableStr">
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td>
                                        <input type='text' class='titleTxt' placeholder='請輸入Title'></td>
                                    <td>
                                        <input type='text' class='contentTxt' placeholder='請輸入Content'></td>
                                    <td>
                                        <input type="button" class='save' value='送出' /></td>
                                </tr>
                            </tfoot>

                        </table>
                        <%-- Dimension圖片--%>
                        <div>
                            <span>新增/修改DIMENSIONS圖片:</span>
                            <asp:FileUpload ID="dimensionImgUpload" runat="server" class="btn btn-outline-primary btn-block" AllowMultiple="True" onchange="picview(this)" />
                            <asp:Label ID="dimensionImgUploadText" runat="server" Text="Label" Visible="false"></asp:Label>
                            <span>圖片預覽:</span>
                            <asp:Label ID="previewOriginal" runat="server" Text=""></asp:Label>
                            <div id="picview" class="picview"></div>
                        </div>

                    </div>
                    <asp:HiddenField ID="dimensionStr" ClientIDMode="Static" runat="server" Value="" />
                    <asp:Button ID="UploadDimensionBtn" runat="server" Visible="True" Text="儲存" class="btn btn-outline-primary btn-block mt-3 w-25 submit" OnClick="UploadDimension_Click" />
                </div>
            </div>
        </div>
    </div>


    <!--Overview DownLoad 編輯 -->
    <div class="card shadow mb-4">
        <!-- Card Header - Accordion -->
        <a href="#overviewDownLoad" class="d-block card-header py-3" data-toggle="collapse"
            role="button" aria-expanded="false" aria-controls="overviewDownLoad">
            <h6 class="m-0 font-weight-bold text-primary">
                <asp:Label ID="OverviewDownLoadText" runat="server" Text=""></asp:Label>Overview DownLoad 編輯
            </h6>
        </a>
        <!-- Card Content - Collapse -->
        <div class="collapse" id="overviewDownLoad">
            <div class="card-body">
                <div id="overviewDownLoadPart" visible="false" runat="server">
                    <span id="overviewDownLoadaLink" runat="server"></span>
                    <asp:LinkButton ID="ClearDownloadFile_btn" class="btn btn-danger btn-circle btn-sm" Visible="false" runat="server" OnClick="ClearDownloadFile_Click"><i class="fas fa-trash"></i></asp:LinkButton>
                    <br />
                    <span>新增/修改規格檔案:</span>
                    <asp:FileUpload ID="overviewFileUpload" runat="server" class="btn btn-outline-primary btn-block" AllowMultiple="True" />
                    <asp:Button ID="overviewFileUpload_btn" runat="server" Visible="True" Text="儲存" class="btn btn-outline-primary btn-block mt-3 w-25 submit" OnClick="UploadoverviewFile_Click" />
                </div>
            </div>
        </div>
    </div>


    <!-- Layout編輯 -->
    <div class="card shadow mb-4">
        <!-- Card Header - Accordion -->
        <a href="#Layout" class="d-block card-header py-3" data-toggle="collapse"
            role="button" aria-expanded="false" aria-controls="Layout">
            <h6 class="m-0 font-weight-bold text-primary">
                <asp:Label ID="LayoutText" runat="server" Text=""></asp:Label>Layout & Deck Plan 編輯
            </h6>
        </a>
        <!-- Card Content - Collapse -->
        <div class="collapse" id="Layout">
            <div class="card-body">
                <div id="LayoutPart" runat="server">
                    <ckeditor:ckeditorcontrol ID="CKEditorControl2" BasePath="/Scripts/ckeditor/" runat="server"></ckeditor:ckeditorcontrol>

                    <asp:Label ID="LayoutContent" runat="server" Visible="False" ForeColor="#009933" class="d-flex justify-content-center"></asp:Label>
                    <div class="d-flex">
                        <asp:Button ID="UploadLayoutContent_btn" runat="server" Visible="True" Text="上傳" class="btn btn-outline-primary btn-block mt-3 w-25 " OnClick="UploadLayoutContent_Click" />
                        <asp:Button ID="CancleUPloadLayoutContent_btn" runat="server" Visible="True" Text="取消/回上頁" class="btn btn-outline-secondary btn-block mt-3 w-25 " OnClick="CancleUPloadLayoutContent_Click" />
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Specification編輯 -->
    <div class="card shadow mb-4">
        <!-- Card Header - Accordion -->
        <a href="#Specification" class="d-block card-header py-3" data-toggle="collapse"
            role="button" aria-expanded="false" aria-controls="Specification">
            <h6 class="m-0 font-weight-bold text-primary">
                <asp:Label ID="SpecificationText" runat="server" Text=""></asp:Label>Specification 編輯
            </h6>
        </a>
        <!-- Card Content - Collapse -->
        <div class="collapse" id="Specification">
            <div class="card-body">
                <div id="SpecificationPart" runat="server">
                    <ckeditor:ckeditorcontrol ID="CKEditorControl3" BasePath="/Scripts/ckeditor/" runat="server"></ckeditor:ckeditorcontrol>
                    <div class="d-flex">
                        <asp:Button ID="UploadSpecification_btn" runat="server" Visible="True" Text="上傳" class="btn btn-outline-primary btn-block mt-3 w-25 " OnClick="UploadSpecification_Click" />
                        <asp:Button ID="CancleUPloadSpecification_btn" runat="server" Visible="True" Text="取消/回上頁" class="btn btn-outline-secondary btn-block mt-3 w-25 " OnClick="CancleUPloadSpecification_Click" />
                    </div>
                </div>

            </div>
        </div>
    </div>

        <!-- Yacht Album -->
        <div class="card shadow mb-4">
            <!-- Card Header - Accordion -->
            <a href="#album" class="d-block card-header py-3" data-toggle="collapse"
                role="button" aria-expanded="false" aria-controls="test">
                <h6 class="m-0 font-weight-bold text-primary">
                    <asp:Label ID="AlbumText" runat="server" Text=""></asp:Label>Yacht Album編輯</h6>
            </a>
            <!-- Card Content - Collapse -->
            <div class="collapse card-body" id="album">
                <div class="card-body">
                    <div id="AlbumPart" runat="server">
                    <span>上傳新圖片</span><br />
                    <asp:FileUpload ID="yachtAlbumFileUpload" runat="server"  class="btn btn-outline-primary btn-block" AllowMultiple="True" />
                     <asp:Button ID="Button1" runat="server" Visible="True" Text="上傳" class="btn btn-outline-primary btn-block mt-3 w-25 " OnClick="yachtAlbumUpload_Click" />
                    <hr />
                     <span>目前圖片</span><br />
                    <asp:RadioButtonList ID="albumRadioButtonList" runat="server" RepeatDirection="Horizontal" AutoPostBack="false" CellPadding="10" RepeatColumns="4">

                    </asp:RadioButtonList>
                    <asp:Button ID="deleteYachtPhoto_btn" runat="server" Visible="true" Text="刪除" class="btn btn-outline-danger btn-block mt-3 w-25 " OnClick="deleteYachtPhoto_Click" />
                         <asp:Button ID="setFirstImage_btn" runat="server" Visible="true" Text="設為首圖" class="btn btn-outline-warning btn-block mt-3 w-25 " OnClick="setFirstImage_Click" />
                    </div>
                </div>
            </div>
        </div>

                    </div>
    </div>

        <%--dimensions的新增/編輯/刪除--%>
        <script type="text/javascript">
            let titleTxt = document.querySelector('.titleTxt')
            let contentTxt = document.querySelector('.contentTxt')
            let save = document.querySelector('.save')
            let edit = document.querySelector('.edit')
            let dimensionTableStr = document.querySelector('.dimensionTableStr')
            let dimensionTableStrOld = document.querySelector('.dimensionTableStrOld')
            let dimensionStr = document.getElementById('dimensionStr');

            let submit = document.querySelector('.submit')

            let data = [];
            function renderData() {
                let str = "";

                data.forEach(function (item, index) {
                    str += `<tr><td>${item.title}</td>
                                    <td>${item.content}</td>
                                    <td><input type='button' class='delete' value='刪除' data-num=${index}><input type='button' class='edit' value='編輯' data-num=${index}></td></tr>`
                })
                dimensionTableStr.innerHTML = str;
                titleTxt.value = "";
                contentTxt.value = "";
            }

            save.addEventListener('click', function (e) {
                let obj = {};
                obj.title = titleTxt.value;
                obj.content = contentTxt.value;
                data.push(obj);
                renderData();
            })


            dimensionTableStr.addEventListener('click', function (e) {
                if (e.target.getAttribute('class') == 'delete') {
                    let num = e.target.getAttribute('data-num');
                    console.log(num);
                    data.splice(num, 1);

                    renderData();
                }
                else if (e.target.getAttribute('class') == 'edit') {
                    var value = e.target.parentNode.parentNode;
                    let num = e.target.getAttribute('data-num');
                    let editobj = data[num];
                    console.log(editobj);
                    value.innerHTML = "";
                    value.innerHTML = `<tr><td><input type='text' class='editedTitleTxt' value=${editobj.title}></td><td><input type='text' class='editedContentTxt' value=${editobj.content}></td><td><input type='button' class='edited' data-num=${num} value='編輯完成'></td></tr>`;

                }
                else if (e.target.getAttribute('class') == 'edited') {
                    let num = e.target.getAttribute('data-num');
                    let editobj = data[num];
                    editobj.title = document.querySelector('.editedTitleTxt').value;
                    editobj.content = document.querySelector('.editedContentTxt').value;
                    renderData();
                }

            })

            /*  從資料庫撈出來的表格的內容的監聽*/
            dimensionTableStrOld.addEventListener('click', function (e) {
                if (e.target.getAttribute('class') == 'delete') {
                    e.target.parentNode.parentNode.remove();
                    renderData();
                }
                else if (e.target.getAttribute('class') == 'edit') {
                    var value = e.target.parentNode.parentNode;
                    var item1 = e.target.parentNode.parentNode.childNodes[0].innerText;
                    var item2 = e.target.parentNode.parentNode.childNodes[1].innerText;
                    if (item2 == null) {
                        item2 = e.target.parentNode.parentNode.childNodes[2].innerText;
                    }
                    console.log(item2);
                    console.log(e.target.parentNode.parentNode.childNodes[2].innerText);

                    value.innerHTML = "";
                    value.innerHTML = `<tr><td><input type='text' class='editedTitleTxt' value=${item1}></td><td><input type='text' class='editedContentTxt' value=${item2}></td><td><input type='button' class='edited' value='編輯完成'></td></tr>`;
                }
                else if (e.target.getAttribute('class') == 'edited') {
                    var value = e.target.parentNode.parentNode;
                    var item1 = e.target.parentNode.parentNode.childNodes[0].childNodes[0].value;
                    var item2 = e.target.parentNode.parentNode.childNodes[1].childNodes[0].value;
                    console.log(item2);
                    let num = e.target.getAttribute('data-num');

                    value.innerHTML = `<tr><td>${item1}</td>
                                    <td>${item2}</td>
                                    <td><input type='button' class='delete' value='刪除'><input type='button' class='edit' value='編輯'></td></tr>`

                    renderData();
                }

            })

            submit.addEventListener('click', function (e) {

                dimensionStr.value = "";
                dimensionStr.value += dimensionTableStrOld.innerHTML;
                dimensionStr.value += dimensionTableStr.innerHTML;
            })



        </script>


        <%--圖片預覽功能的js及css--%>

        <style type="text/css">
            #picview img {
                height: 345px;
                width: 278px;
                border-width: 0px;
                border: 1px solid #34a9d4;
            }

            #picviewEdited img {
                height: 345px;
                width: 278px;
                border-width: 0px;
                border: 1px solid #34a9d4;
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

        <%--dimensions1表格的css--%>
        <link href="css/dimensionTable.css" rel="stylesheet" type="text/css" />
</asp:Content>

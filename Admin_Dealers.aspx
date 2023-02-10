<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin_Dealers.aspx.cs" Inherits="yatch_project.Admin_Dealers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Dealers編輯</h1>
    </div>


    <!-- 新增dealers -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">新增dealers內容</h6>
        </div>
        <div class="card-body">
            <div>
                <span>圖片預覽:</span>
                <div id="picview" class="picview"></div>

            </div>
            <div class="w-50">
                <span>新增大頭貼:</span>
                <asp:FileUpload ID="imageUpload" runat="server" class="btn btn-outline-primary btn-block" AllowMultiple="True" onchange="picview(this)" />
              <asp:Label ID="UploadImgText" runat="server" Text="Label" Visible="false"></asp:Label>
                </div>
        </div>



        <div class="card-body">
            <span>Country:</span>
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="countryName" DataValueField="id" ></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:yachtConnectionString3 %>" SelectCommand="SELECT [id], [countryName] FROM [dealers_country]"></asp:SqlDataSource>

        </div>
        <div class="card-body">
            <span>Area:</span>
            <input id="Area" runat="server" type="text" placeholder="請輸入地區" required="required" />
        </div>
        <div class="card-body">
            <span>Name:</span>
            <input id="Name" runat="server" type="text" placeholder="請輸入公司姓名"  />
        </div>
        <div class="card-body">
            <span>Contact:</span>
            <input id="Contact" runat="server" type="text" placeholder="請輸入聯絡人姓名" />
        </div>
        <div class="card-body">
            <span>Address:</span>
            <input id="Address" runat="server" type="text" placeholder="請輸入地址" />
        </div>
        <div class="card-body">
            <span>Tel:</span>
            <input id="Tel" runat="server" type="text" placeholder="請輸入電話" />
        </div>
        <div class="card-body">
            <span>Fax:</span>
            <input id="Fax" runat="server" type="text" placeholder="請輸入傳真" />
        </div>
        <div class="card-body">
            <span>Email:</span>
            <input id="Email" runat="server" type="email" placeholder="請輸入Email" />
        </div>
        <div class="card-body">
            <span>Link:</span>
            <input id="Link" runat="server" type="text" placeholder="請輸入網站連結" />
            <br />
            <br />
            <asp:Button ID="AddDealers" runat="server" Text="新增dealers" OnClick="AddDealers_Click" />
        </div>
                <asp:Label ID="UploadText" runat="server" Text="Label" Visible="false"></asp:Label>

    </div>

    <%--   dealers內容的 grdiview --%>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">dealers內容</h6>
        </div>
        <div class="card-body">

            <asp:GridView ID="GridView2" class="table-responsive" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" DataKeyNames="id" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" ReadOnly="True" />
                    <asp:BoundField DataField="country_id" HeaderText="country_id" SortExpression="country_id" />
                    <asp:BoundField DataField="area" HeaderText="area" SortExpression="area" />
                    <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                    <asp:BoundField DataField="contact" HeaderText="contact" SortExpression="contact" />
                    <asp:BoundField DataField="address" HeaderText="address" SortExpression="address" />
                    <asp:BoundField DataField="tel" HeaderText="tel" SortExpression="tel" />
                    <asp:BoundField DataField="fax" HeaderText="fax" SortExpression="fax" />
                    <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
                    <asp:BoundField DataField="link" HeaderText="link" SortExpression="link" />
                    <asp:BoundField DataField="initDate" HeaderText="initDate" SortExpression="initDate" />



                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:Button runat="server" CausesValidation="True" CommandName="Update" Text="更新" />
                            &nbsp;<asp:Button runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Button runat="server" CausesValidation="False" CommandName="Edit" Text="編輯" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Delete" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="Button2" runat="server" CommandName="Delete" Text="刪除" OnClientClick="return confirm('確定要刪除嗎?')" CausesValidation="False"></asp:LinkButton>
                        </ItemTemplate>
                        <ControlStyle BorderColor="#66CCFF" BorderStyle="Solid" BorderWidth="1px" CssClass="btn btn-danger btn-block" ForeColor="White" />
                    </asp:TemplateField>

                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:yachtConnectionString6 %>"
                SelectCommand="SELECT* FROM [dealers]"
                DeleteCommand="DELETE FROM [dealers] WHERE [id] = @id"
                UpdateCommand="UPDATE [dealers] SET [country_id] = @country_id,[area]=@area,[name]=@name,[contact]=@contact,[address]=@address,[tel]=@tel,[fax]=@fax,[email]=@email,[link]=@link WHERE [id] = @id">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="String" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="country_id" Type="String" />
                    <asp:Parameter Name="id" Type="String" />
                    <asp:Parameter Name="area" Type="String" />
                    <asp:Parameter Name="name" Type="String" />
                    <asp:Parameter Name="contact" Type="String" />
                    <asp:Parameter Name="address" Type="String" />
                    <asp:Parameter Name="tel" Type="String" />
                    <asp:Parameter Name="fax" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="link" Type="String" />

                </UpdateParameters>
            </asp:SqlDataSource>

        </div>

    </div>
    <br />
    <br />
    <!--新增國家 -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">新增國家</h6>
        </div>

        <div class="card-body">
            <input id="Text1" runat="server" type="text" placeholder="請輸入國家" />
            <asp:Button ID="Button1" runat="server" Text="新增國家" OnClick="Button1_Click" />
        </div>
    </div>

    <!--國家內容的 grdiview -->
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" class="table table-bordered" DataKeyNames="id" Width="100%" DataSourceID="SqlDataSource1">
        <Columns>

            <asp:BoundField DataField="id" HeaderText="ID Number" SortExpression="id" ReadOnly="True">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="countryName" HeaderText="Country Name" SortExpression="countryName" />
            <asp:BoundField DataField="initDate" HeaderText="Creation Date" SortExpression="initDate" ReadOnly="True" InsertVisible="False" />
            <asp:TemplateField HeaderText="Delete" ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="BtnDeleteCountry" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('確定要刪除嗎?')" CausesValidation="False"></asp:LinkButton>
                </ItemTemplate>
                <ControlStyle BorderColor="#66CCFF" BorderStyle="Solid" BorderWidth="1px" CssClass="btn btn-danger btn-block" ForeColor="White" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Edit" ShowHeader="False">
                <EditItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="更新" />
                    &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                </ItemTemplate>
                <ControlStyle BorderColor="#66CCFF" BorderStyle="Solid" BorderWidth="1px" CssClass="btn btn-primary btn-block" ForeColor="White" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>



    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:yachtConnectionString %>"
        SelectCommand="SELECT * FROM [dealers_country]"
        DeleteCommand="DELETE FROM [dealers_country] WHERE [id] = @id"
        UpdateCommand="UPDATE [dealers_country] SET [countryName] = @countryName WHERE [id] = @id">

        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="countryName" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <%--圖片預覽功能的js及css--%>

    <style type="text/css">
        #picview, .img, img {
            Width:209px;
            border-width: 0px;
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
    </script>

</asp:Content>






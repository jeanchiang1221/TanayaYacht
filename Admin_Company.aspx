<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin_Company.aspx.cs" Inherits="yatch_project.Admin_Company" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">About us內容</h6>
        </div>

        <div class="card-body">
            <asp:Literal ID="AboutUsContent" runat="server"></asp:Literal>
            <asp:Button ID="EditAboutUsBtn" runat="server" Text="編輯" class="btn btn-outline-primary btn-block mt-3 w-25" OnClick="EditAboutUsBtn_Click" />

            <CKEditor:CKEditorControl ID="CKEditorControl1" runat="server" BasePath="/Scripts/ckeditor/" Visible="false"></CKEditor:CKEditorControl>

            <asp:Label ID="UploadAboutUsLab" runat="server" Visible="False" ForeColor="#009933" class="d-flex justify-content-center"></asp:Label>
            <div class="d-flex">
                <asp:Button ID="UploadAboutUsBtn" runat="server" Visible="false" Text="更新內容" class="btn btn-outline-primary btn-block mt-3 w-25 " OnClick="UploadAboutUsBtn_Click" />
                <asp:Button ID="AboutUsCancleBtn" runat="server" Visible="false" Text="取消/回上一頁" class="btn btn-outline-secondary btn-block mt-3 w-25 ml-3" OnClick="CancleBtn_Click" />
            </div>
        </div>

    </div>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Certificate內容</h6>
        </div>

        <div class="card-body">
            <asp:Literal ID="CertificateContent" runat="server"></asp:Literal>
            <asp:Button ID="EditCertificateBtn" runat="server" Text="編輯" class="btn btn-outline-primary btn-block mt-3 w-25" OnClick="EditCertificateBtn_Click" />

            <CKEditor:CKEditorControl ID="CKEditorControl2" runat="server" BasePath="/Scripts/ckeditor/" Visible="false"></CKEditor:CKEditorControl>

            <asp:Label ID="UploadCertificateLab" runat="server" Visible="False" ForeColor="#009933" class="d-flex justify-content-center"></asp:Label>
            <div class="d-flex">
                <asp:Button ID="UploadCertificateBtn" runat="server" Visible="false" Text="更新內容" class="btn btn-outline-primary btn-block mt-3 w-25" OnClick="UploadCertificateBtn_Click" />
                <asp:Button ID="CertificateCancleBtn" runat="server" Visible="false" Text="取消/回上一頁" class="btn btn-outline-secondary btn-block mt-3 w-25 ml-3" OnClick="CancleBtn_Click" />
            </div>
        </div>
    </div>

</asp:Content>

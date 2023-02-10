<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admin_Message.aspx.cs" Inherits="yatch_project.Admin_Message" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" class="table table-bordered">
        <Columns>
            <asp:BoundField DataField="date" HeaderText="date" SortExpression="date" />
            <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
            <asp:BoundField DataField="selectYachtModel" HeaderText="selectYachtModel" SortExpression="selectYachtModel" />
            <asp:TemplateField HeaderText="comments" SortExpression="comments">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Bind("summary") %>' NavigateUrl='<%# "Admin_Message_Main.aspx?guid="+Eval("guid") %>'>HyperLink</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CheckBoxField DataField="isRead" HeaderText="isRead" SortExpression="isRead" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:yachtConnectionString12 %>" SelectCommand="SELECT * FROM [Contact]"></asp:SqlDataSource>

    
</asp:Content>

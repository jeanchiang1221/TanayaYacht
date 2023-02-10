<%@ Page Title="" Language="C#" MasterPageFile="~/Yachts.Master" AutoEventWireup="true" CodeBehind="Yachts_OverView.aspx.cs" Inherits="yatch_project.Yachts_OverView" %>

<%--<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>--%>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--遮罩-->
    <div class="bannermasks">
        <img src="images/banner01_masks.png" alt="&quot;&quot;" />
    </div>
    <!--遮罩結束-->
    <div class="banner1">
        <input type="hidden" name="ctl00$ContentPlaceHolder1$Gallery1$HiddenField1"
            id="ctl00_ContentPlaceHolder1_Gallery1_HiddenField1" value="1" />
        <div id="gallery" class="ad-gallery">
            <div class="ad-image-wrapper">
            </div>
            <div class="ad-controls">
            </div>
            <div class="ad-nav">
                <div class="ad-thumbs">
                    <ul class="ad-thumb-list" id="albumHtml" runat="server">
<%--                        <li><a href='upload/Images/20120426102841.jpg'>
                            <img src='upload/Images/s20120426102841.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120426103429.jpg'>
                            <img src='upload/Images/s20120426103429.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120426104207.jpg'>
                            <img src='upload/Images/s20120426104207.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120416101428.jpg'>
                            <img src='upload/Images/s20120416101428.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120508044845.jpg'>
                            <img src='upload/Images/s20120508044845.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120402043502--1.jpg'>
                            <img src='upload/Images/s20120402043502--1.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120402043509--1.jpg'>
                            <img src='upload/Images/s20120402043509--1.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120414121142.jpg'>
                            <img src='upload/Images/s20120414121142.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120414121319.jpg'>
                            <img src='upload/Images/s20120414121319.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120613095933.jpg'>
                            <img src='upload/Images/s20120613095933.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120613095943.jpg'>
                            <img src='upload/Images/s20120613095943.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120613095959.jpg'>
                            <img src='upload/Images/s20120613095959.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120613100018.jpg'>
                            <img src='upload/Images/s20120613100018.jpg' class="image0" />
                        </a></li>
                        <li><a href='upload/Images/20120613100029.jpg'>
                            <img src='upload/Images/s20120613100029.jpg' class="image0" />
                        </a></li>--%>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="conbg">
        <!--------------------------------左邊選單開始---------------------------------------------------->
        <div class="left">
            <div class="left1">
                <p>
                    <span>YACHTS</span>
                </p>
                <ul>
                    <asp:Label ID="LeftMenu" runat="server"></asp:Label>
                    <%--              <li><a href='Yachts_Layout.html?id=6d245b62-ff07-463b-95b3-277f0e5aac25'>Tayana 37</a></li>
              <li><a href='Yachts_Layout.html?id=5fb84e15-0414-44f9-b723-32a1c4685aa3'>Tayana 46</a></li>
              <li><a href='Yachts_Layout.html?id=c0ae6c69-7b36-486d-97e6-fd3bf20064e5'>Tayana 48</a></li>
              <li><a href='Yachts_Layout.html?id=782a2862-ede1-4f8e-9e2e-d3e88dd0e356'>Tayana 54 (New Building)</a></li>
              <li><a href='Yachts_Layout.html?id=8fa5ce3e-437f-4b1b-b717-2602e7158e40'>Tayana 58</a></li>
              <li><a href='Yachts_Layout.html?id=ee951dda-fad8-42b9-9056-52473170d729'>Tayana 64</a></li>
              <li><a href='Yachts_Layout.html?id=3c507857-e6da-44e0-95ab-f058d793c09a'>ISARA 50</a></li>--%>
                </ul>
            </div>
        </div>
        <!--------------------------------左邊選單結束---------------------------------------------------->
        <!--------------------------------右邊選單開始---------------------------------------------------->
        <div id="crumb1">
            <a href="index.html">Home</a> >> <a href="#">Yachts</a> >> <a href="Yachts_OverView.aspx"><span class="on1">
                <asp:Label ID="TopLink" runat="server"></asp:Label>
            </span></a>
        </div>
        <div class="right">
            <div class="right1">
                <div class="title">
                    <asp:Label ID="yachtName" runat="server"></asp:Label>
                </div>
                <!--------------------------------內容開始---------------------------------------------------->
                <!--次選單-->
                <div class="menu_y">
                    <asp:Label ID="TopMenu" runat="server" Text=""></asp:Label>
                    <%--              <ul>
                <li class="menu_y00">YACHTS</li>
                <li><a class="menu_yli01" href="Yachts_OverView.aspx">OverView</a></li>
                <li><a class="menu_yli02" href="Yachts_Layout.aspx">Layout & deck plan</a></li>
                <li><a class="menu_yli03" href="Yachts_Specification.aspx">Specification</a></li>
                <li>
                </li>
              </ul>--%>
                </div>

                <!--Overview的內容-->
                <!--次選單-->
                <div class="box1">
                    <asp:Label ID="CKEditorControl1" runat="server" Text="Label"></asp:Label>
                </div>
                <br />
                <br />
                <div class="box3">
                    <h4>37 DIMENSIONS</h4>
                    <table class="table02">
                        <tbody>
                            <tr>
                                <td class="table02td01">
                                    <table>
                                        <tbody id="dimensionTableStrHTML" runat="server">
                                        </tbody>
                                    </table>
                                </td>
                                <td id="overviewDimensionsImgStrHTML" runat="server"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <p class="topbuttom">
                    <img src="images/top.gif" alt="top" /></p>
                <!--下載開始-->
                <div id="ctl00_ContentPlaceHolder1_divDownload" class="downloads">
                    <p>
                        <img src="images/downloads.gif" alt="&quot;&quot;" /></p>
                    <ul id="overviewDownloadStrHTML" runat="server">
                        <%-- <li><a id="ctl00_ContentPlaceHolder1_RepFile_ctl01_HyperLink1" href="upload/Files/20120413015548--1.pdf" target="_blank">TAYANA37-STANDARD SPECIFICATIONS</a></li>--%>
                    </ul>
                </div>
                <!--下載結束-->
                <!--------------------------------內容結束------------------------------------------------------>
            </div>
        </div>
        <!--------------------------------右邊選單結束---------------------------------------------------->
    </div>





    <%--      <asp:Label ID="Label_contentPage" runat="server" Text="ContentPage_Label"></asp:Label><br/>
    <img alt="" src="https://i.ytimg.com/vi/ZodCFTlUiW0/maxresdefault.jpg" style="  object-fit: cover ; width: 100%; height: 300px;" /><br/>--%>
</asp:Content>

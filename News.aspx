<%@ Page Title="" Language="C#" MasterPageFile="~/Yachts.Master" AutoEventWireup="true" CodeBehind="News.aspx.cs" Inherits="yatch_project.News" %>

<%@ Register Src="~/WebUserControl_Page.ascx" TagPrefix="uc1" TagName="WebUserControl_Page" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--遮罩-->
    <div class="bannermasks">
        <img src="images/banner02_masks.png" alt="&quot;&quot;" />
    </div>
    <!--遮罩結束-->
    <!--<div id="buttom01"><a href="#"><img src="images/buttom01.gif" alt="next" /></a></div>-->
    <!--小圖開始-->
    <!--<div class="bannerimg">
      <ul>
      <li> <a href="#"><div class="on"><p class="bannerimg_p"><img  src="images/pit003.jpg" alt="&quot;&quot;" /></p></div></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" width="300" /></p>
      </a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      </ul>
      <ul>
      <li> <a class="on" href="#"><p class="bannerimg_p"><img  src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <p class="bannerimg_p"><a href="#"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      <li> <a href="#"><p class="bannerimg_p"><img src="images/pit003.jpg" alt="&quot;&quot;" /></p></a></li>
      </ul>
      </div>-->
    <!--小圖結束-->
    <!--<div id="buttom02"> <a href="#"><img src="images/buttom02.gif" alt="next" /></a></div>-->
    <!--------------------------------換圖開始---------------------------------------------------->
    <div class="banner">
        <ul>
            <li>
                <img src="images/newbanner.jpg" alt="Tayana Yachts" />
            </li>
        </ul>
    </div>
    <!--------------------------------換圖結束---------------------------------------------------->
    <div class="conbg">
        <!--------------------------------左邊選單開始---------------------------------------------------->
        <div class="left">
            <div class="left1">
                <p>
                    <span>NEWS</span>
                </p>
                <ul>
                    <li><a href="News.aspx">News & Events</a></li>
                </ul>
            </div>
        </div>
        <!--------------------------------左邊選單結束---------------------------------------------------->
        <!--------------------------------右邊選單開始---------------------------------------------------->
        <div id="crumb">
            <a href="Index.aspx">Home</a> >> <a href="News.aspx">News </a>>> <a href="News.aspx">
                <span class="on1">News & Events</span></a>
        </div>
        <div class="right">
            <div class="right1">
                <div class="title">
                    <span>News & Events</span>
                </div>
                <!--------------------------------內容開始---------------------------------------------------->
                <div class="box2_list">
                    <ul>

                        <asp:Label ID="newslist" runat="server" Text=""></asp:Label>
                        <%--              <li>
                  <div class="list01">
                    <ul>
                      <li>
                        <div>
                          <p>
                            <img id="ctl00_ContentPlaceHolder1_Repeater1_ctl01_Image1" src="upload/Images/s20191118095837.jpg" style="border-width:0px;" />
                          </p>
                        </div>
                      </li>
                      <li><span>2019/11/18</span><br />
                        <a href="News_View.aspx">Tayana 54 Stock Boat for sale with a special price </a>
                      </li><br />
                      <li>Tayana 54 Stock Boat for sale with a special price </li>
                    </ul>
                  </div>
                </li>--%>

              </ul>
                <div>
                        <uc1:WebUserControl_Page runat="server" id="WebUserControl_Page" />
                 
                </div>
                        <%-- <div class="pagenumber">
                  <div class="pagination">共<span style="color:red">63</span>筆資料
                    <span class="disabled">上一頁</span>
                    <span class="current">1</span>
                    <a href="new_list.html?page=2">2</a>
                    <a href="new_list.html?page=3">3</a>
                    <a href="new_list.html?page=4">4</a>
                    <a href="new_list.html?page=5">5</a>
                    <a href="new_list.html?page=6">6</a>
                    <a href="new_list.html?page=7">7</a>
                    <a href="new_list.html?page=2">下一頁</a>
                  </div>--%>
                </div>
               
                <!--------------------------------內容結束------------------------------------------------------>
            </div>
        </div>
        <!--------------------------------右邊選單結束---------------------------------------------------->
        </div>


</asp:Content>

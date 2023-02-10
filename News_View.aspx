<%@ Page Title="" Language="C#" MasterPageFile="~/Yachts.Master" AutoEventWireup="true" CodeBehind="News_View.aspx.cs" Inherits="yatch_project.News_View" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <!--遮罩-->
      <div class="bannermasks"><img src="images/banner02_masks.png" alt="&quot;&quot;" /></div>
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
          <li><img src="images/newbanner.jpg" alt="Tayana Yachts" /></li>
        </ul>
      </div>
      <!--------------------------------換圖結束---------------------------------------------------->
      <div class="conbg">
        <!--------------------------------左邊選單開始---------------------------------------------------->
        <div class="left">
          <div class="left1">
            <p><span>NEWS</span></p>
            <ul>
              <li><a href="News.aspx">News & Events</a></li>
            </ul>
          </div>
        </div>
        <!--------------------------------左邊選單結束---------------------------------------------------->
        <!--------------------------------右邊選單開始---------------------------------------------------->
        <div id="crumb"><a href="index.html">Home</a> >> <a href="News.aspx">News </a> >> <a href="#"><span class="on1">News & Events</span></a></div>
        <div class="right">
          <div class="right1">
            <div class="title"> <span>News & Events</span></div>
            <!--------------------------------內容開始---------------------------------------------------->
            <div class="box3">
              <h4>
                  <asp:Label id="ctl00_ContentPlaceHolder1_title" runat="server" Text="Label"></asp:Label>
              </h4>
                  <asp:Label ID="CKEditorControl1" runat="server" Text="Label"></asp:Label>

      <%--        <p>
                <span style="font-size:16px;"><span style="font-size:22px;"><strong><span style="color:#ff0000;">Tayana 54 </span></strong></span>Stock Boat for sale with &nbsp;a<span style="color:#ff0000;"><span
                      style="font-size:22px;"> <span style="font-size:28px;"><kbd><var><strong><cite>special
                                price</cite></strong></var></kbd></span></span></span></span>
              </p>
              <p>
                <img alt="" src="/upload/images/TAYANA54-Layout.png" style="width: 700px; height: 360px;" />
              </p>
              <p>
                <img alt="" src="/upload/images/TAYANA54-Layout (1).png" style="width: 700px; height: 360px;" />
              </p>
              <p>
                <span style="font-size:16px;"><span style="color:#ff0000;"><span style="font-size:22px;"><span
                        style="font-size:28px;"><kbd><var><strong><cite><img alt="" src="/upload/images/IMG_9840.jpg"
                                  style="width: 700px; height: 525px;" /></cite></strong></var></kbd></span></span></span></span>
              </p>
              <p>
                <span style="font-size:16px;"><span style="color:#ff0000;"><span style="font-size:22px;"><span
                        style="font-size:28px;"><kbd><var><strong><cite><img alt="" src="/upload/images/IMG_9843.jpg"
                                  style="width: 700px; height: 525px;" /></cite></strong></var></kbd></span></span></span></span>
              </p>
              <p>
                <span style="font-size:16px;"><span style="color:#ff0000;"><span style="font-size:22px;"><span
                        style="font-size:28px;"><kbd><var><strong><cite><img alt="" src="/upload/images/IMG_9852.jpg"
                                  style="width: 700px; height: 525px;" /></cite></strong></var></kbd></span></span></span></span>
              </p>
              <p>
                <span style="font-size:16px;"><span style="color:#ff0000;"><span style="font-size:22px;"><span
                        style="font-size:28px;"><kbd><var><strong><cite><img alt="" src="/upload/images/IMG_9854.jpg"
                                  style="width: 700px; height: 525px;" /></cite></strong></var></kbd></span></span></span></span>
              </p>
              <p>
                <img alt="" src="/upload/images/IMG_9866.jpg" style="width: 700px; height: 525px;" />
              </p>
              <p>
                <img alt="" src="/upload/images/IMG_9862.jpg" style="width: 700px; height: 525px;" />
              </p>
              <p>
                <img alt="" src="/upload/images/IMG_9870.jpg" style="width: 700px; height: 933px;" />
              </p>
              <p>
                <img alt="" src="/upload/images/IMG_9860.jpg" style="width: 700px; height: 933px;" />
              </p>
              <p>
                &nbsp;</p>
              <p>
                &nbsp;</p>--%>
            </div>
            <!--下載開始-->
            <!--下載結束-->
            <div class="buttom001"><a href="javascript:window.history.back();"><img src="images/back.gif"alt="&quot;&quot;" width="55" height="28" /></a></div>
            <!--------------------------------內容結束------------------------------------------------------>
          </div>
        </div>
        <!--------------------------------右邊選單結束---------------------------------------------------->
      </div>
</asp:Content>

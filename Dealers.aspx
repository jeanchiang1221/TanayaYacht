<%@ Page Title="" Language="C#" MasterPageFile="~/Yachts.Master" AutoEventWireup="true" CodeBehind="Dealers.aspx.cs" Inherits="yatch_project.Dealers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!--遮罩-->
      <div class="bannermasks"><img src="images/DEALERS.jpg" alt="&quot;&quot;" width="967" height="371" /></div>
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
            <p><span>DEALERS</span></p>
            <ul>
                <asp:Label ID="LeftMenu" runat="server"></asp:Label> 
             <%-- <li><asp:HyperLink ID="LeftMenu" runat="server" NavigateUrl='<%# "Dealers.aspx?id="+Eval("id") %>'>HyperLink</asp:HyperLink></li>--%>
                 
            </ul>
          </div>
        </div>
        <!--------------------------------左邊選單結束---------------------------------------------------->
    <!--------------------------------右邊選單開始---------------------------------------------------->
        <div id="crumb"><a href="Index.aspx">Home</a> >> <a href="Dealers.aspx">Dealers </a> >> 
             <asp:Label ID="TopLink" runat="server"></asp:Label> 
<%--            <asp:HyperLink ID="TopLink" runat="server" NavigateUrl='<%# "Dealers.aspx?id="+Eval("id") %>'> HyperLink</asp:HyperLink>--%>
        </div>
        <div class="right">
          <div class="right1">
            <div class="title">
                <asp:Label ID="countryName" runat="server"></asp:Label> 
           </div>
            <!--------------------------------內容開始---------------------------------------------------->
              <div class="box2_list">
              <ul>

                <asp:Label ID="dealersContent" runat="server"></asp:Label> 
 
              </ul>
              <div class="pagenumber"> </div>
            </div>
            <!--------------------------------內容結束------------------------------------------------------>
          </div>
        </div>
        <!--------------------------------右邊選單結束---------------------------------------------------->
      </div>

</asp:Content>

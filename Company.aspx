<%@ Page Title="" Language="C#" MasterPageFile="~/Yachts.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="yatch_project.compan"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

   <!--遮罩-->
      <div class="bannermasks"><img src="images/company.jpg" alt="&quot;&quot;" width="967" height="371" /></div>
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
            <p><span>COMPANY</span></p>
            <ul>
               <asp:Label ID="LeftMenu" runat="server"></asp:Label> 

            </ul>
          </div>
        </div>
        <!--------------------------------左邊選單結束---------------------------------------------------->
 

        <!--------------------------------右邊選單開始---------------------------------------------------->
        <div id="crumb"><a href="Index.aspx">Home</a> >> <a href="Company.aspx">Company</a> >> 
             <asp:Label ID="TopLink" runat="server" class="on1"></asp:Label> 
          </div>
        <div class="right">
          <div class="right1 title">
              <asp:Label ID="menuTitle" runat="server" ></asp:Label> 
            </div>
            <!--------------------------------內容開始---------------------------------------------------->
             <div class="box3">  
                 <asp:Label ID="CKEditorControl1" runat="server" Text="Label"></asp:Label>
             </div>

<%--           
              <p class="box3pright"><img src="images/pit010.jpg" alt="&quot;&quot;" width="274" height="192" /></p>
              “Our aim is to create outstanding styling, live aboard comfort, and safety at sea for every proud Tayana
              owner.”<br /><br />
              Founded in 1973, Ta Yang Building Co., Ltd. Has built over 1400 blue water cruising yachts to date. This
              world renowned custom yacht builder offers a large compliment of sailboats ranging from 37’ to 72’, many
              offer aft or center cockpit design, deck saloon or pilothouse options.<br />
              <br />
              In 2003, Tayana introduced the new Tayana 64 Deck Saloon, designed by Robb Ladd, which offers the latest
              in building techniques, large sail area and a beam of 18 feet. <br />
              <br />Tayana Yachts have been considered the leader in building custom interiors for the last two decades,
              offering it`s clients the luxury of a living arrangement they prefer rather than have to settle for the
              compromise of a production boat. Using the finest in exotic woods, the best equipment such as Lewmar,
              Whitlock, Yanmar engines, Selden spars to name a few, Ta yang has achieved the reputation for building one
              of the finest semi custom blue water cruising yachts in the world, at an affordable price.
              <br />
            </div>--%>
            <!--------------------------------內容結束------------------------------------------------------>
          </div>
       
        <!--------------------------------右邊選單結束---------------------------------------------------->
      </div>




</asp:Content>

<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Yachts.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="yatch_project.Contact" %>

<%@ Register Assembly="Recaptcha.Web" Namespace="Recaptcha.Web.UI.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--遮罩-->
    <div class="bannermasks">
        <img src="images/contact.jpg" alt="&quot;&quot;" width="967" height="371" />
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
                <img src="images/newbanner.jpg" alt="Tayana Yachts" /></li>
        </ul>
    </div>
    <!--------------------------------換圖結束---------------------------------------------------->
    <div class="conbg">
        <!--------------------------------左邊選單開始---------------------------------------------------->
        <div class="left">
            <div class="left1">
                <p><span>CONTACT</span></p>
                <ul>
                    <li><a href="#">contacts</a></li>
                </ul>
            </div>
        </div>
        <!--------------------------------左邊選單結束---------------------------------------------------->
        <!--------------------------------右邊選單開始---------------------------------------------------->
        <div id="crumb"><a href="index.html">Home</a> >> <a href="#"><span class="on1">Contact</span></a></div>
        <div class="right">
            <div class="right1">
                <div class="title"><span>Contact</span></div>
                <!--------------------------------內容開始---------------------------------------------------->
                <!--表單-->
                <form method="post" runat="server">
                    <div class="from01">
                        <p>
                            Please Enter your contact information<span class="span01">*Required</span>
                        </p>
                        <br />
                        <table>
                            <tr>
                                <td class="from01td01">Name :</td>
                                <td><span>*</span>
                                    <input name="ctl00$ContentPlaceHolder1$Name" type="text" runat="server"
                                    id="Name" style="width: 250px;" />
                                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="必填" ControlToValidate="Name"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="from01td01">Email :</td>
                                <td><span>*</span><input name="ctl00$ContentPlaceHolder1$Email" type="text" runat="server" required="required"
                                    id="Email" style="width: 250px;" /></td>
                                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="必填" ControlToValidate="Email"></asp:RequiredFieldValidator>
                            </tr>
                            <tr>
                                <td class="from01td01">Phone :</td>
                                <td><span>*</span>
                                    <input name="ctl00$ContentPlaceHolder1$Phone" type="text" runat="server"  id="Phone" required="required"/></td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="必填" ControlToValidate="Phone"></asp:RequiredFieldValidator>
                            </tr>
                            <tr>
                                <td class="from01td01">Country :</td>
                                <td><span>*</span>
                                    <asp:DropDownList ID="CountryDropDownList" runat="server">
                                        <asp:ListItem Text="USA" />
                                        <asp:ListItem Text="ASIA" />
                                        <asp:ListItem Text="EUROPE" />
                                        <asp:ListItem Text="NORTH AMERICA" />
                                        <asp:ListItem Text="CENTRAL AMERICA" />
                                        <asp:ListItem Text="SOUTH AMERICA" />
                                        <asp:ListItem Text="AFRICA" />
                                        <asp:ListItem Text="OCEANIA" />
                                    </asp:DropDownList>
                                    <%--               <select name="ctl00$ContentPlaceHolder1$Country" id="Country"  runat="server" >
                     <option value="USA">USA</option>
                      <option value="ASIA">ASIA</option>
                      <option value="EUROPE">EUROPE</option>
                      <option value="NORTH AMERICA">NORTH AMERICA</option>
                      <option value="CENTRAL AMERICA">CENTRAL AMERICA</option>
                      <option value="SOUTH AMERICA">SOUTH AMERICA</option>
                      <option value="AFRICA">AFRICA</option>
                      <option value="OCEANIA">OCEANIA</option>
                    </select>--%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"><span>*</span>Brochure of interest *Which Brochure would you like to view?</td>
                            </tr>
                            <tr>
                                <td class="from01td01">&nbsp;</td>
                                <td>
                                    <asp:DropDownList ID="YachtDropDownList" runat="server"></asp:DropDownList>
                                    <%--                    <select name="ctl00$ContentPlaceHolder1$Yachts" id="ctl00_ContentPlaceHolder1_Yachts">
                      <option value="Tayana 37">Tayana 37</option>
                      <option value="Tayana 46">Tayana 46</option>
                      <option value="Tayana 48">Tayana 48</option>
                      <option value="Tayana 54   (New Building)">Tayana 54 (New Building)</option>
                      <option value="Tayana 58">Tayana 58</option>
                      <option value="Tayana 64">Tayana 64</option>
                      <option value="ISARA 50">ISARA 50</option>
                    </select>--%>
                                </td>
                            </tr>
                            <tr>
                                <td class="from01td01">Comments:</td>
                                <td>
                                    <textarea ID="comments" runat="server" name="ctl00$ContentPlaceHolder1$Comments" rows="2" cols="20" style="height: 150px; width: 330px;"></textarea>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="必填" ControlToValidate="comments"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="from01td01"></td>
                                <td colspan="2">
                                    <cc1:RecaptchaWidget ID="RecaptchaWidget1" runat="server" />
                                 </td>
                            </tr>
                            <tr>
                                <td class="from01td01">&nbsp;</td>
                                <td class="f_right">
                                    <%--                      <asp:Button Text="text" runat="server"  onclick="SendMessageBtn_Click" src="images/buttom03.gif"   />--%>
                                    <%--                    <input type="image" name="ctl00$ContentPlaceHolder1$ImageButton1"
                      id="SendMessage_btn" src="images/buttom03.gif" style="border-width:0px;" runat="server"/>--%>
                                    <asp:LinkButton ID="SendMessage_btn" Text=" " runat="server" Style="border-width: 0px;" OnClick="SendMessageBtn_Click">
                          <img src="images/buttom03.gif" alt="Alternate Text"  />
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                </form>
                <!--表單-->
                <div class="box1">
                    <span class="span02">Contact with us</span><br />
                    Thanks for your enjoying our web site as an introduction to the Tayana world and our range of yachts.
              As all the designs in our range are semi-custom built, we are glad to offer a personal service to all our
              potential customers.
              If you have any questions about our yachts or would like to take your interest a stage further, please
              feel free to contact us.
                </div>
                <div class="list03">
                    <p>
                        <span>TAYANA HEAD OFFICE</span><br />
                        NO.60 Haichien Rd. Chungmen Village Linyuan Kaohsiung Hsien 832 Taiwan R.O.C<br />
                        tel. +886(7)641 2422<br />
                        fax. +886(7)642 3193<br />
                    </p>
                </div>
                <div class="box4">
                    <h4>Location</h4>
                    <p>
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3683.3234115653463!2d120.2960838138162!3d22.604395097023733!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x346e037799f9afb1%3A0xb9f297a86cf40dfb!2z6auY6ZuE6Luf6auU56eR5oqA5ZyS5Y2A!5e0!3m2!1szh-TW!2stw!4v1657699186697!5m2!1szh-TW!2stw" width="600" height="450" style="border: 0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        <%-- <iframe width="695" height="518" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=d&amp;source=s_d&amp;saddr=%E5%8F%B0%E7%81%A3%E9%AB%98%E9%9B%84%E5%B8%82%E5%B0%8F%E6%B8%AF%E5%8D%80%E4%B8%AD%E5%B1%B1%E5%9B%9B%E8%B7%AF%E9%AB%98%E9%9B%84%E5%B0%8F%E6%B8%AF%E6%A9%9F%E5%A0%B4&amp;daddr=%E5%8F%B0%E7%81%A3%E9%AB%98%E9%9B%84%E5%B8%82%E6%9E%97%E5%9C%92%E5%8D%80%E4%B8%AD%E9%96%80%E6%9D%91%E6%B5%B7%E5%A2%98%E8%B7%AF%EF%BC%96%EF%BC%90%E8%99%9F&amp;hl=zh-en&amp;geocode=FRthWAEdwlwsByGxkQ4S1t-ckinNS9aM0xxuNDELEXJZh6Soqg%3BFRRmVwEdMKssBym5azbzl-JxNDGd62mwtzGaDw&amp;aq=0&amp;oq=%E9%AB%98%E9%9B%84%E5%B0%8F%E6%B8%AF%E6%A9%9F&amp;sll=22.50498,120.36792&amp;sspn=0.008356,0.016512&amp;g=%E5%8F%B0%E7%81%A3%E9%AB%98%E9%9B%84%E5%B8%82%E6%9E%97%E5%9C%92%E5%8D%80%E4%B8%AD%E9%96%80%E6%9D%91%E6%B5%B7%E5%A2%98%E8%B7%AF%EF%BC%96%EF%BC%90%E8%99%9F&amp;mra=ls&amp;ie=UTF8&amp;t=m&amp;ll=22.537135,120.360718&amp;spn=0.08213,0.119133&amp;z=13&amp;output=embed"></iframe>--%>
                    </p>
                </div>
                <!--------------------------------內容結束------------------------------------------------------>
            </div>
        </div>
        <!--------------------------------右邊選單結束---------------------------------------------------->
    </div>

</asp:Content>

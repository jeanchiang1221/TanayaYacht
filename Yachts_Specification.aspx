<%@ Page Title="" Language="C#" MasterPageFile="~/Yachts.Master" AutoEventWireup="true" CodeBehind="Yachts_Specification.aspx.cs" Inherits="yatch_project.Yachts_Specification" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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
              <ul class="ad-thumb-list"  id="albumHtml" runat="server">
<%--                <li><a href='upload/Images/20120426102841.jpg'>
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
              <!--Specfication的內容-->
                   <div class="box5">
              <h4>DETAIL SPECIFICATION</h4>
               <asp:Label ID="CKEditorControl3" runat="server" Text="Label"></asp:Label>
 <%--             <p>HULL</p>
              <ul>
                <li>Hand laid up FRP hull, white with blue cove stripe and boot top.</li>
                <li> Teak rubrail.<br />
                </li>
              </ul>
              <p>DECK/HARDWARE</p>
              <ul>
                <li>Hand laid up FRP cord deck.</li>
                <li>Teak cockpit seats and cockpit grating</li>
                <li>Teak skylight</li>
                <li>Teak companionway hatch with doors &amp; stormboards</li>
                <li>Teak or alumnum forward hatch</li>
                <li>Teak exterior trim</li>
                <li>Teak exterior handrails</li>
                <li>Teak samsom posts forward</li>
                <li>Laminated bow sprit with teak platform &amp; anchor rollers</li>
                <li>Chain locker and one deck pipe</li>
                <li>SS stanchions, vinyl covered dbl lifelines w/ gates P&amp;S</li>
                <li>SS bow pulpit</li>
                <li>SS stern pulpit</li>
                <li>Stainless hawse pipes &amp; mooring cleats (six)</li>
                <li>Stainless steel opening ports (ten)</li>
                <li>Dorade vents (four)</li>
                <li>FRP seahood</li>
                <li>Propane locker for two 20 lb tanks, vented overboard</li>
                <li>Two coaming lockers</li>
                <li>Aluminium mainsheet traveler w/ roller car</li>
                <li>Staysail track</li>
                <li>Aluminium genoa tracks with cars</li>
                <li>Teak sliding companionway hatch</li>
                <li>Teak coaming caps</li>
                <li>Winch handles</li>
                <li>Seven Lewmar winches <br />
                  Two 40CST jib sheet<br />
                  One 40CSTmain sheet<br />
                  One 30CST staysail<br />
                  One 30CST jib halyard<br />
                  One 30CST main halyard<br />
                  One 30CST staysail halyard</li>
              </ul>
              <p>ENGINE/MACHINERY</p>
              <ul>
                <li>01Diesel engine – Yanmar 4JHE, fresh water cooled, 55HP</li>
                <li>Engine cooling water intake strainer</li>
                <li>Dripless shaft gland</li>
                <li>Bronze three blade propeller</li>
                <li>Fiberglass drip pan
                </li>
              </ul>
              <p>STEERING</p>
              <ul>
                <li>Pedestal steering </li>
                <li>Teak traditional steering wheel</li>
                <li>Teak &amp; SS emergency tiller</li>
                <li>SS rudder shaft<br />
                </li>
              </ul>
              <p>SPARS/RIGGING</p>
              <ul>
                <li>Alumnium mast &amp; boom, mast with electrical conduits</li>
                <li>5/16” SS standing rigging w/ swaged terminals</li>
                <li>Staysail boom &amp; fittings </li>
              </ul>
              <p>SAILS</p>
              <ul>
                <li>Main, 8 oz, w/2 reef points</li>
                <li>Yankee jib, 8 oz, 100%</li>
                <li>Staysail, 8 oz</li>
                <li>Mizzon, 8 oz (ketch only)</li>
                <li>Sail bags for all sails</li>
                <li>Sail covers for all sails (blue)<br />
                </li>
              </ul>
              <p>INTERIOR</p>
              <ul>
                <li>Teak and holly cabin sole</li>
                <li>White formica counters in head &amp; galley. Teak veneer chart &amp; dinette table tops.</li>
                <li>Teak framed mirror in head</li>
                <li>Interior teak handrails</li>
                <li>V-berth filler (if applicable)</li>
                <li>Vinyl cushion covers</li>
                <li>Ice chest insulated w/ 4” PU foam &amp; SS lined</li>
                <li>Interior varnished quality polyurethane satin</li>
                <li>Stove alcove SS lined</li>
                <li>Easily removable head liner</li>
                <li>Ceiling on all exposed hull areas </li>
              </ul>
              <p>ELECTRICAL</p>
              <ul>
                <li>Dual l20AH, 12 volt batteries in FRP boxes</li>
                <li>Eight l2 volt cabin lights overhead &amp; six reading lights</li>
                <li>12 volt electrical system w/ 3 way switch, electric panel w/ breakers &amp; volt meter &amp; ammeter
                  and DC outltes</li>
                <li>ll0 volt shore power system w/ 30amp power socket, electric panel w/ breakers &amp;
                  volt meter and ammeter, ll0 volt outlets throughout yacht</li>
                <li>International rules running lights</li>
                <li>Deck flood light</li>
                <li>Anchor light </li>
              </ul>
              <p>PLUMBING</p>
              <ul>
                <li>90 gallon mild steel fuel tank</li>
                <li>l00 gallon SS fresh water tank</li>
                <li>30 gallon FRP holding tank</li>
                <li>Manual marine head</li>
                <li>Hot and cold pressure water system</li>
                <li>One heavy duty electrical bilge pump</li>
                <li>One high capacity manual bilge pump to pump bilge &amp; holding tank</li>
                <li>l0 gallon water heater, (ll0 or 220volt) &amp; engine heated</li>
                <li>Bilge pump strainer</li>
                <li>Sea cocks on all through hull fittings</li>
                <li>Double clamps on all through-hulls below water line<br />
                </li>
              </ul>--%>
            </div>
            <p class="topbuttom"><img src="images/top.gif" alt="top" /></p>
            <!--------------------------------內容結束------------------------------------------------------>
          </div>
        </div>
        <!--------------------------------右邊選單結束---------------------------------------------------->
      </div>

</asp:Content>

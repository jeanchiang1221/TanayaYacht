using Microsoft.AspNet.FriendlyUrls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace yatch_project
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // 應用程式啟動時執行的程式碼
            //RouteConfig.RegisterRoutes(RouteTable.Routes);
            //BundleConfig.RegisterBundles(BundleTable.Bundles);

            // 設定不顯示副檔名 (如果只想隱藏副檔名做到此區塊就好)
            var routes = RouteTable.Routes;
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            // 執行短網址路由方法
            RegisterRouters(RouteTable.Routes);
        }
        void RegisterRouters(RouteCollection routes)
        {
            // MapPageRoute("自訂路由名稱", "替換後的網址區塊", "原本實際執行的網頁位置")
            // {shortUrl} 為短網址名稱，可以視為之後要用來抓取的參數
            routes.MapPageRoute("shortUrlRoute", "ShowList/{shortUrl}", "~/Tayanahtml/dealers.aspx");
            //可以建立多個規則
        }
    }
}
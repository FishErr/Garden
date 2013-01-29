<!DOCTYPE html>
<html>
<head>
  {asset name="Head"}
</head>
<body id="{$BodyID}" class="{$BodyClass}">
   <div id="Frame">
       <div id="top">
           <div id="top_left"></div>
           <div id="top_right"></div>
           <a href="/">
               <div id="top_inside">
                   <div id="top_inside_left"></div>
                   <div id="top_inside_right">
                       E-platform<br>Разная информация по платформе

                   </div>
               </div>
           </a>
       </div>



      <div class="Head" id="Head">
         <div class="Row">
            <!--strong class="SiteTitle"><a href="{link path="/"}">{logo}</a></strong-->
            <!--div class="SiteSearch">{searchbox}</div-->
            <ul class="SiteMenu">
               {dashboard_link}
               {discussions_link}
               <!--{activity_link}-->
                {inbox_link}
               <!--{custom_menu}-->
                <li>
                {profile_link wrap=span}
               {signinout_link wrap=''}
                </li>
            </ul>
         </div>
      </div>

      <div id="Body">
         <div class="Row">
            <div class="BreadcrumbsWrapper">{breadcrumbs}</div>
            <div class="Column PanelColumn" id="Panel">
               {module name="MeModule"}
               {asset name="Panel"}
            </div>
            <div class="Column ContentColumn" id="Content">{asset name="Content"}</div>
         </div>
      </div>
       <div id="footer">
           <div id="footer_inside">
               Украина, Крым, 95034, г. Симферополь, ул. Киевская, 81, тел.: (0652) 61-09-54, факс: 54-59-62.Разрешается и приветствуется любое неискаженное цитирование материалов этого ресурса.
           </div>
       </div>
   </div>
   {event name="AfterBody"}
</body>
</html>
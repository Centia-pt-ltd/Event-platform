<%@ Page Language="C#" AutoEventWireup="true" CodeFile="lobby.aspx.cs" Inherits="lobby" %>
<%@ Register Src="~/UserControl/ucDoc.ascx" TagName="docMenu" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>QStudy</title>
  <link href="WebCSS/font-awesome.min.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="WebCSS/bootstrap.min.css" />
  <script src="WebJS/Ajax_jquery.min.js"></script>
  <script src="WebJS/popper.min.js"></script>
  <script src="WebJS/bootstrap.min.js"></script>
        <link href="css_latest/style.css" type="text/css" rel="stylesheet" />

   
    	<%--<link href="https://fonts.googleapis.com/css?family=Raleway+Dots" rel="stylesheet" type="text/css" />--%>

    <style>
       
        .lobbybg{
         
    width: 100%;
    overflow: hidden;
    position: relative;
        }
/*        @media only screen and (min-device-width: 320px) and (max-device-width: 1024px) and (orientation: landscape){
.menu-container {
    margin-top: -30% !important;
}}*/
    </style>
</head>
<body style="background-color:black;">
    <form id="form1" runat="server">
        <input type="hidden" id="hfLang" runat="server" />
    <asp:HiddenField ID="hdfUserId" runat="server" />
          
       <input type="hidden" id="hd1" />
 
       <div class="img_bglobbyNew">
             <video  playsinline autoplay muted loop id="myVideoLobby" >
  <source src="img/Lobbyback1.mp4" type="video/mp4" />
</video>
  <a href='javascript:void();' onclick="return Skip();"> 
       <div id="arrowAnim">
  <div class="arrowSliding">
    <div class="arrow"></div>
  </div>
  <div class="arrowSliding delay1">
    <div class="arrow"></div>
  </div>
  <div class="arrowSliding delay2">
    <div class="arrow"></div>
  </div>
  <div class="arrowSliding delay3">
    <div class="arrow"></div>
  </div> 
         <h2 class="blink">SKIP</h2>
</div></a>
          
    </div>


           <uc:docMenu ID="doc" runat="server" />



   

    <audio preload="auto" autoplay="autoplay" controls="controls" class="audio_box">
        <source src="audio/English/Expo Lobby (english).mp3" type="audio/mp3" />
    </audio>

    

    <script type="text/javascript">
        //window.onload = function () {
        //        chatscript();
        //}

       
        //function chatscript() {
        //    var str = '';
        //    $.ajax({
        //        type: "POST",
        //        url: "WebService.asmx",
        //        data: "{}",
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (response) {
        //            if (response.d != "") {
        //                str = response.d;
        //            }
        //            $('#hd1').val(str);
        //            var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
        //            (function () {
        //                chatscript();
        //                var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
        //                var src = $('#hd1').val();
        //                s1.async = true;
        //                s1.src = src;
        //                s1.charset = 'UTF-8';
        //                s1.setAttribute('crossorigin', '*');
        //                s0.parentNode.insertBefore(s1, s0);
        //            })();
        //        },
        //        error: function (response) {
        //            return 'ex';
        //        }

        //    });
        //}
    </script>
         <script>
             window.onload = function () {
               
        }
             function PlayAudio(lang) {
                 var lang = $("#hfLang").val();
                 if (lang == "") { lang = "English"; }
                 document.getElementsByTagName('audio')[0].src = '';
                 document.getElementsByTagName('audio')[0].src = "audio/" + lang + "/Expo Lobby (" + lang + ").mp3";
                 document.getElementsByTagName('audio')[0].play();
             }

             function getParameterByName(name, url = window.location.href) {
                 name = name.replace(/[\[\]]/g, '\\$&');
                 var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                     results = regex.exec(url);
                 if (!results) return null;
                 if (!results[2]) return '';
                 return decodeURIComponent(results[2].replace(/\+/g, ' '));
             }
            

             $(document).ready(function () {
                
                 var qrs = getParameterByName('move');
                 if (qrs == 'yes') {

                     $(".menu-pane li").css("pointer-events", "none");

                     var lang = $("#hfLang").val();
                     if (lang == "") { lang = "English"; }
                     PlayAudio(lang);

                     setTimeout(function () {
                         $(".page-1").fadeOut();
                         //$(".page-3").fadeIn(3000);
                         window.location.replace("UniversityBooth/CouncilRoom.aspx").fadeIn(3000);
                     }, 30030);


                 }
                 else {
                     var lang = $("#hfLang").val();
                     if (lang == "") { lang = "English"; }
                     PlayAudio(lang);
                     $("#arrowAnim").css("display","none")
                     //document.getElementsByTagName('audio')[0].src = '';
                 }
                
             });

             function Skip() {
                 window.location.replace("UniversityBooth/CouncilRoom.aspx");
             }
         </script>
    </form>
</body>
</html>

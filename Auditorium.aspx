<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Auditorium.aspx.cs" Inherits="Auditorium" %>
<%@ Register Src="~/UserControl/ucDoc.ascx" TagName="docMenu" TagPrefix="uc" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
        <title>QStudy</title>
        <link rel="stylesheet" href="WebCSS/bootstrap.min.css" />
        <script src="WebJS/Ajax_jquery.min.js"></script>
        <script src="WebJS/bootstrap.min.js"></script>
<%--        <link href="WebCSS/FontfamilyRaleway.css" rel="stylesheet" type="text/css" />--%>
        <link href="WebCSS/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="css_latest/style.css" type="text/css" rel="stylesheet" />

        <style>
        h4 {
            /* font-weight: bold; */
            font-size:1.2rem;
            text-shadow: 2px -1px 0px #2a07e9;
            color: white !important;
        }
       /* .menu-container .row{
                margin-left:0;
        }*/
    </style>
 
    </head>
    <body style=" background-color: #4b4d4e;">
       
        <form id="form1" runat="server">  
           <input type="hidden" id="hfLang" runat="server" />
            <asp:HiddenField ID="hdfUserId" runat="server" />
        		<div class="image-wrapper"> 
			<div class="img_bg_auditorium">
          <div class="video_wrap">
            <div class="logo" style="float: left;">
              <img src="img/logo.png" alt="logo" />
            </div>
            <div class="univideo" style="background-color:#1a2841 !important;">
                <video id="bg-video" autoplay="autoplay" muted="muted" loop="loop" controls="controls" playsinline  style=" height:100%; width:100%" >
                    <source src="videos/Auditorium.mp4" type="video/mp4"/>
                </video>
                    <iframe id="iVideo"  class="ifVideoAudi" [attr.src]="src ? src = null"  style="display:none; height:100%;width:100%;" allow='autoplay' onload="onLoadHandler();">
                        
                    </iframe>
                
            </div>
            <div class="univideo_thumnail">
                 <%--<button class="btn videos_btn" id="btnUniversity" type="button">CHOOSE UNIVERSITY
                <span class="caret"></span></button>--%>
               <%-- <div class="btn videos_btn">--%>
                    <select id='ddlUniversity' class='btn videos_btn' style="color:white;text-align:left;" onchange="SelectVideo(this.value);"> </select>
               <%-- </div>--%>

                <ul id="ulVideoList" class="dropdown-menu1"  style="max-height:440px;overflow-y:auto;">
                    
                </ul>
            </div>  
          </div>
      
   
              
</div><uc:docMenu ID="doc" runat="server" />
                      
		  </div>
    <audio id="a1" preload="auto"  autoplay="autoplay" controls="controls" class="audio_box">
        <source src="#" type="audio/mp3" />
    </audio>
    <script>
        function Video1(url) {
            document.getElementById("bg-video").style.display = "none";
            document.getElementById("iVideo").src = url;
            document.getElementById("iVideo").style.display = "block";
            
        }
        function Video2(url) {
            document.getElementById("bg-video").style.display = "none";
            document.getElementById("iVideo").src = url;
            document.getElementById("iVideo").style.display = "block";

        }
        function Video3(url) {
            document.getElementById("bg-video").style.display = "none";
            document.getElementById("iVideo").src = url;
            document.getElementById("iVideo").style.display = "block";

        }
    </script>
<script type="text/javascript">
    function onLoadHandler() {
        $("#iVideo").contents().find("#a1").remove();

    }
    window.onload = function () {
        var lang = $("#hfLang").val();
        if (lang == "") { lang = "English"; }
        PlayAudio(lang);
    }
    function PlayAudio(lang) {
        var lang = $("#hfLang").val();
        if (lang == "") { lang = "English"; }
        document.getElementsByTagName('audio')[0].src = '';
        document.getElementsByTagName('audio')[0].src = "audio/" + lang + "/Auditorium (" + lang + ").mp3";
        document.getElementsByTagName('audio')[0].play();
    }
</script>

	<script type="text/javascript">
        function BindUniversity() {
            $.ajax({
                type: "POST",
                url: "Auditorium.aspx/BindUniversity",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#ddlUniversity").html(response.d);
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        $(document).ready(function () {
            BindUniversity();
            var str = "<li><a href='#' onclick=Video1('https://www.youtube.com/embed/kMzwH53tC00?autoplay=1')><h4> Education Expo</h4>";
            str += "<img src='img/youtube-dark.png' style='width:130px;height:80px;'>";
            str += "</img></a ></li><li><a href='#' onclick=Video2('https://www.youtube.com/embed/ntOqjPnsRvk?autoplay=1')>";
            str += "<h4>University</h4><img src='img/youtube-dark.png' style='width:130px;height:80px;'>";
            str += " </img></a></li><li><a href='#' onclick=Video3('https://www.youtube.com/embed/OPYFTpl5AO0?autoplay=1')><h4>Government Universities</h4>";
            str += " <img src='img/youtube-dark.png' style='width:130px;height:80px;'></img></a></li>";
            $("#ulVideoList").html(str);

        });
        function SelectVideo(Uid) {
            $.ajax({
                type: "POST",
                url: "Auditorium.aspx/BindVideo",
                data: "{'Uid':'" + Uid+"'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    
                        $("#ulVideoList").html(response.d);
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        function PlayVideo(Url) {
            const videoId = "//www.youtube.com/embed/" + getId(Url) +"?autoplay=1";
            document.getElementById("bg-video").style.display = "none";
            document.getElementById("iVideo").src = videoId;
            document.getElementById("iVideo").style.display = "block";
        }

        function getId(url) {
            const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
            const match = url.match(regExp);

            return (match && match[2].length === 11)
                ? match[2]
                : null;
        }

    </script>    
           
    </form> 
       
</body>
</html>

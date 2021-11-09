<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reception.aspx.cs" Inherits="reception" %>
<%@ Register Src="~/UserControl/ucDoc.ascx" TagName="docMenu" TagPrefix="uc" %>
<%@ Register Src="~/UserControl/ChatWindow.ascx" TagName="ucchat" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <title>QStudy</title>



  <link rel="stylesheet" href="WebCSS/bootstrap.min.css" />
  <script src="WebJS/Ajax_jquery.min.js"></script>
    <script src="WebJS/bootstrap.min.js"></script>
    <link href="css_latest/style.css" type="text/css" rel="stylesheet" />

<%--  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>--%>
<%--  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>--%>
<%--    <link href="https://fonts.googleapis.com/css?family=Raleway+Dots" rel="stylesheet" type="text/css" />--%>
<%--  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />--%>

</head>
<body>
    <form id="form1" runat="server">
         <asp:HiddenField ID="hdfUserId" runat="server" />
        <input type="hidden" id="hfLang" runat="server" />

         <input type="hidden" id="hdChatUrl" />
        <div class="image-wrapper" style="background-color: #000000;">
			<div class="img_bg5" >
           <%-- <div class="img_bg5_mobile">
                <div id="demo" class="carousel slide" data-ride="carousel" data-interval="2000">
                    <div class="carousel-inner lobby-slider">
                        <div class="carousel-item active">
                            <img src="slide-logo/qlogo.png" alt="Los Angeles">
                        </div>
                        <div class="carousel-item">
                            <img src="slide-logo/MMU-Logo.jpg" alt="Los Angeles">
                        </div>
                        <div class="carousel-item">
                            <img src="slide-logo/MSU-Logo.jpg" alt="Los Angeles">
                        </div>
                        <div class="carousel-item">
                            <img src="slide-logo/HELP-Logo.jpg" alt="Los Angeles">
                        </div>
                    </div>
                </div>

            </div>  --%>    
      </div>
            

		  </div>

              <uc:docMenu ID="doc" runat="server" />
            <uc:ucchat ID="chat" runat="server" />
         <audio preload="auto" autoplay="autoplay" controls="controls" class="audio_box">
        <source src="audio/English/Helpdesk (English).mp3" type="audio/mp3" />
    </audio>
    </form>
    
    <script type="text/javascript">
        window.onload = function () {
                chatscript();
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
            document.getElementsByTagName('audio')[0].src = "audio/" + lang + "/Helpdesk (" + lang + ").mp3";
            document.getElementsByTagName('audio')[0].play();
        }
    </script>
   <%--  <script type="text/javascript">
        function chatscript() {
            var UserId = $("#hdfUserId").val()
            var str = '';
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/WebService.asmx/CreateChat")%>',
                data: "{'Uid':'" + UserId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != "") {
                        str = response.d;
                    }
                    $('#hdChatUrl').val(str);
                    var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
                    (function () {
                        chatscript();
                        var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
                        var src = $('#hdChatUrl').val();
                        s1.async = true;
                        s1.src = src;
                        s1.charset = 'UTF-8';
                        s1.setAttribute('crossorigin', '*');
                        s0.parentNode.insertBefore(s1, s0);
                    })();
                },
                error: function (response) {
                    return 'ex';
                }

            });
        }
    </script>
    <script type="text/javascript">      

        Tawk_API.onLoad = function () {
            Tawk_API.maximize();
        };
    </script>--%>
</body>
</html>

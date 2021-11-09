<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CouncilRoom.aspx.cs" Inherits="UniversityBooth_CouncilRoom" %>
<%@ Register Src="~/UserControl/ucDoc.ascx" TagName="docMenu" TagPrefix="uc" %>
<%@ Register Src="~/UserControl/ChatWindow.ascx" TagName="ucchat" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=0" />
<title>QStudy</title>
<!-- Libraries CSS -->
                                                                                                       
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
   <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet" />
   <link href="css/styleBooth.css" type="text/css" rel="stylesheet" />
   <link href="css/all.css" type="text/css" rel="stylesheet" />
   <link href="https://fonts.googleapis.com/css2?family=Pragati+Narrow:wght@400;700&display=swap" rel="stylesheet" />
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

</head>
<body>  <form id="form1" runat="server">
            <input type="hidden" id="hfLang" runat="server" />

      <div class="booth_bgbanner">
     
   
<header class="main-header light">
    <div class="logo">
        <img src="img/trans_branding.png" alt="logo" />
    </div>
   <div class="nav">
        <div class="nav-right">
         </div>
       </div>
  
</header>

  


        <audio preload="auto" autoplay="autoplay" controls="controls" class="audio_box">
  <source src="../audio/English/Video call pop out (English).mp3" type="audio/mp3" />
</audio>
        <div>
            <asp:HiddenField ID="hdfUserId" runat="server" />
         	<div class="booth_bgcounselor">
      <div class="booth_layar">
   
<div class="container-fluid">
    <div class="row">

        <div style="width:80%;height: calc(100vh - 100px);margin-left:10%;">
                <iframe id="ifrmmodify" allow="camera; microphone; fullscreen; speaker; display-capture" 
                    style="height:100%;width:100%;margin-top:7%;">
                </iframe>
        </div>

    </div>
                 
           
         </div>
		</div>
                 </div>

            </div>
    
<uc:docMenu ID="doc" runat="server" />
<uc:ucchat ID="chat" runat="server" />
  </div>
          </form>
    <!--Start of Tawk.to Script-->
<%--<script type="text/javascript">
    var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
    (function () {
        var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
        s1.async = true;
        s1.src = '<%=strTawkCode%>';
        s1.charset = 'UTF-8';
        s1.setAttribute('crossorigin', '*');
        s0.parentNode.insertBefore(s1, s0);
    })();
</script>--%>
<%--<script type="text/javascript">      

    Tawk_API.onLoad = function () {
        Tawk_API.maximize();
    };
</script>--%>

<!--End of Tawk.to Script-->
   <script>

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
           if (qrs == 'no') {
           }
           else {
               var lang = $("#hfLang").val();
               if (lang == "") { lang = "English"; }
               PlayAudio(lang);
           }
       });
       function PlayAudio(lang) {
           var lang = $("#hfLang").val();
           if (lang == "") { lang = "English"; }
           document.getElementsByTagName('audio')[0].src = '';
           document.getElementsByTagName('audio')[0].src = "../audio/" + lang + "/Video call pop out (" + lang + ").mp3";
           document.getElementsByTagName('audio')[0].play();
       }
       function SelectUniversityToMove() {
           var UserId = $("#hdfUserId").val()
           $.ajax({
               type: "POST",
               url: "CouncilRoom.aspx/SelectUniversityToMove",
               data: "{'UserId':'" + UserId + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
			   success: function (response) {
                   if (response.d != "") {
                       window.location.replace(response.d);
                   }
               },
               error: function (response) {
                   //showMsg("ERROR", "Something went wrong.!");
               }
           });
       }

       //function RefreshList() {
       setInterval(function () {
           var qrs = getParameterByName('move');
           if (qrs == 'no') {
           }
           else {
               SelectUniversityToMove();
           }
           }, 3000);
       //}
       //window.onload = RefreshList();

       function SetIFrameSource() {
           $("#ifrmmodify").attr("src", "<%=strVideoAPI%>");
       }
       $(function () { SetIFrameSource(); });

   </script>
</body>
</html>

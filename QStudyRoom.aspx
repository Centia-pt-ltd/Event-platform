<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QStudyRoom.aspx.cs" Inherits="QStudyRoom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>QStudy</title>
     <meta charset="utf-8">
  <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' />
 

  <!-- Libraries CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Pragati+Narrow:wght@400;700&display=swap" rel="stylesheet"/>
  <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet" />
  <link href="css/style.css" type="text/css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>

</head>
<body>
    <form id="form1" runat="server">
       <div>
        <div class="container-fluid">
 <div class="booth-page">
     
        <img src="img/abimage1.jpg" alt="booth" class="booth_bg"/>
        <a href="#" class="logo_booths"><img src="img/new_logo.png" alt="logo"/></a>
            <span class="univertitext">QStudy Abroad Expo</span>
         <!-- <div class="chatb_videob">
                <a href="#"><i class="fa fa-commenting" title="chat"></i></a>
                <a href="#"></a>
            </div> -->
            
    

   </div>
<div class="thumnil_links">
     
            <div class="option_text">choose an option</div>
      <a href="lobbyarea.html"><i class="fa fa-home" title="go to lobby"></i></a>
      <a href="javascript:void(Tawk_API.toggle())"><i class="fa fa-commenting" title="start chat"></i></a>
      <a href="https://kmilab.zoom.us/j/9612749677?pwd=V0lHZGY0MW8zMkdORWJtUkMvWDVLZz09"><i class="fa fa-video-camera" aria-hidden="true" title="start a call"></i></a>
      <a href="exibition-hall.html"><i class="fa fa-window-restore" title="go to booth area"></i></a>
      <%--<a href="QStudyRoom.aspx"><i class="fa fa-question-circle" title="help"></i></a>--%>
     </div>
</div>
 

    </div>
    </form>
    
 <!-- Latest compiled and minified CSS -->
    <!--Start of Tawk.to Script-->
<script type="text/javascript">
    var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
    (function () {
        var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
        s1.async = true;
        s1.src = 'https://embed.tawk.to/610a5b61d6e7610a49ae85de/1fc879u0q';
        s1.charset = 'UTF-8';
        s1.setAttribute('crossorigin', '*');
        s0.parentNode.insertBefore(s1, s0);
    })();
</script>
<!--End of Tawk.to Script-->

  <script src="js/jquery.min.js"></script>
  <script src="js/owl.carousel.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/function.js"></script>
  <script>

      var autoPlayVideo = document.getElementById("ocScreencapVideo");
      autoPlayVideo.oncanplaythrough = function () {
          autoPlayVideo.muted = true;
          autoPlayVideo.play();
          autoPlayVideo.pause();
          autoPlayVideo.play();
      }



      $(document).ready(function () {
          setTimeout(function () {
              $(".reception_bg").addClass('active');
          }, 3000);
          setTimeout(function () {
              $(".advertisement_wrapper,.datacontent_logo").fadeIn();
          }, 20000);
      });

      function getURL() {
          const queryString = window.location.search;
          const urlParams = new URLSearchParams(queryString);
          var name = urlParams.get('name');
          document.getElementById("lblWelcomeName").innerHTML = "Hi " + name + " , welcome to QStudy event. Let me take you to the Auditorium.";
      }
      window.onload = getURL();

      function GotoZoom() {
          setTimeout(function () {
              window.location.href = "https://kmilab.zoom.us/";
          }, 31000);
      }
      window.onload = GotoZoom();

  </script>
    
</body>
</html>

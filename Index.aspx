<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>QStudy</title>
 <link href="css_latest/bootstrap.min.css" type="text/css" rel="stylesheet">
    <link href="css_latest/style.css" type="text/css" rel="stylesheet" />
	<link href="https://fonts.googleapis.com/css?family=Raleway+Dots" rel="stylesheet" type="text/css">
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



</head>
<body>
    <form id="form1" runat="server">	
      
      
    <div class="image-wrapper">
      <a href="#" class="brand"><!-- <img src="img/trans_branding.png" alt="logo"> --></a>
			<div class="img_bg">
        <div class="clouds">
          <img src="img/giphy.gif" alt="clouds">
        </div>
        <div class="road">
          <div class="car1"></div>
          <div class="car2"></div>
          <div class="car3"></div>
        </div>
      </div>

</div>

<div class="index-mobil-slide">
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
      <img src="slide-logo/help-logo.jpg" alt="Los Angeles">
    </div>
  </div>
</div>
</div>
	
       
<div class="popup_massege">
  <div class="index_radio_btn text-center">
 <label for="html">
    <input type="radio"  id="html" name="fav_language" value="HTML" checked="checked" /> English
  </label>
 
 <label for="css">
<input type="radio" id="css" disabled="disabled" name="fav_language" value="CSS" />
 Arabic
  </label>
 
 <label for="javascript">
  <input type="radio" disabled="disabled" id="javascript" name="fav_language" value="JavaScript" /> French</label>
 
 <label for="age1"> 
  <input type="radio" disabled="disabled" id="age1" name="age" value="30" />Russian</label>
 
 <label for="age2"><input disabled="disabled" type="radio" id="age2" name="age" value="60" /> Indonesian</label>  

        </div>
        <a href="home.aspx"> Enter Event</a> 
              <a href="registration.aspx">New Registration</a>
		</div>
  <div class="voice_wrapper">
    <img src="img/robot1.png" alt="robot" />
  </div>


   <div class="whatsapp_icon">
    <a href="https://web.whatsapp.com/">
    <img src="img/whatsapp1.png" alt="whatsapp" />
  </a>
    <span>Help Desk WhatsApp</span>
</div>
    
        <input type="submit" id="aaa" style="display:none"/>
         <button id = "btn" style="display:none"> Click me</button >

     <%--      <audio id="audioWelcome" preload="auto" autoplay="autoplay">         
         <source src="audio/Voice(ExpoOutdoor).mp3" type="audio/mpeg" />
        </audio>--%>
        
</form>   
<script type="text/javascript">
   
   // var promise=  document.getElementById("audioWelcome").play(); 
     
  
    var audio = document.createElement("AUDIO")
    document.body.appendChild(audio);
    audio.src = "audio/Voice(ExpoOutdoor).mp3"
    document.body.addEventListener("mousemove", function () {
        audio.play();
    }) 
//    $(document).ready(function () {
//        // Try automatically playing our audio via script. This would normally trigger and error.
//        document.getElementById('audioWelcome').play()
//});
</script>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>QStudy</title>
    <link href="css_latest/style.css" type="text/css" rel="stylesheet" />
	<link href="https://fonts.googleapis.com/css?family=Raleway+Dots" rel="stylesheet" type="text/css">
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>
<body>
   
    <form id="form1" runat="server">
         <audio src="audio/Voice(Entrance).mp3"  runat="server" typeof="audio/mpeg" preload="auto" autoplay="autoplay">
        </audio>
       <div class="container-fluid">
        <div class="image-wrapper">
            <a href="#" class="brand"><!-- <img src="img/logo.png" alt="logo"> --></a>
            <div class="img_bg1"></div>
        </div>
        <div class="mform">
            <!--    <span id="lblmsg"></span> -->
            <asp:Label ID="lblmsg" runat="server"></asp:Label>
            <h2>Enter Your Registration No</h2>
            <p>(Check Your Email)</p>
            <div class="">
                <input name="txtFullName" type="text" id="txtFullName" class="form-control" required="" maxlength="15" placeholder="Enter your registration no.">
            </div>


            <a href="all-page.html" id="btn_hide" class="registration_btn">
                <%--<button type="submit" class="btn btnblue btn-block">
                    <span class="log_text" id="spanWait">Enter Event</span>
                </button>--%>
           <asp:Button ID="btnLogin" runat="server" class="btn btnblue btn-block" Text="ENTER EVENT" OnClick="btnLogin_Click" />

            </a>
            <a href="registration.aspx" id="btn_hide" class="registration_btn">
                <button type="submit" class="btn btnblue btn-block">
                    <span class="log_text" id="spanWait">New Registration</span>
                </button>

            </a>
        </div>
        <div class="voice_wrapper">
            <img style="display:none" src="img/robot1.png" alt="robot" />
        </div>

        <div class="whatsapp_icon">
            <a href="https://web.whatsapp.com/">
                <img src="img/whatsapp1.png" alt="whatsapp" />
            </a>
            <span style="color:white!important; text-shadow:none!important; margin-left:5px">Help Desk WhatsApp</span>
        </div>

        <!--<audio controls autoplay class="audio_box">
            <source src="audio/Voice(Entrance).mp3" type="audio/mp3">
        </audio>-->
        
    </div>
    </form>
</body>
</html>

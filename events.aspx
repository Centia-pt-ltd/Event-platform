<%@ Page Language="C#" AutoEventWireup="true" CodeFile="events.aspx.cs" Inherits="events" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" /><title>
	QStudy
</title>
    <!-- Latest compiled and minified CSS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
<!-- Optional theme -->

<!-- Libraries CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" /><link href="css/bootstrap.min.css" type="text/css" rel="stylesheet" /><link href="css/style.css" type="text/css" rel="stylesheet" /><link href="css/all.css" type="text/css" rel="stylesheet" /><link href="https://fonts.googleapis.com/css2?family=Pragati+Narrow:wght@400;700&amp;display=swap" rel="stylesheet" />

         <!-- 2nd code-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"></script>
    <!--end -->

    <style>
        .country_maindiv{
            border-radius:4px;
            box-shadow: rgb(0 63 136) 0px 1px 0px;
            padding-bottom:12px
            

        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <!--<div class="container-fluid">-->
            <!--<div class="bg_login_video" id="login_container">-->
                    
<div class="videoContainer" id="login_container">
<video class="logovideo" id="ocScreencapVideo" autoplay="autoplay" muted="muted" loop="loop" playsinline="playsinline" preload="metadata" data-aos="fade-up">
  <source src="videos/QStudyWelcome.mp4"
          type="video/mp4">
</video>



                <div class="mform">
                     <a href="#" class="branding"><img src="img/branding.png" alt="logo"></a>
                    <div>
                        <asp:Label ID="lblmsg" runat="server"></asp:Label>
                        <h2>Enter Your Registration No</h2>
                        
                        <input name="txtFullName" type="text" id="txtFullName" class="form-control" maxlength="8" placeholder="Enter your registration no." />
                        
                        </div>
                       <a href="" id="btn_hide" class="registration_btn"> 

                           <asp:Button ID="btnLogin" runat="server" class="btn btnblue btn-block" Text="Proceed" OnClick="btnLogin_Click" />

                          <!-- <button type="submit" class="btn btnblue btn-block"><span class="log_text" id="spanWait">Proceed</span></button>-->

                       </a>
                      <a href="http://qstudyabroad.com/mena" class="registration_btn btn btnblue btn-block" target="_blank">

                          New Registration
                        <!---<button type="submit" class="btn btnblue btn-block">
                            <span class="log_text">New Registration</span>
                        </button>-->

                    </a>

                      </div>
                     <div style="display:none"> </div>
                </div>

    
        <input type="hidden" name="hdfCountry" id="hdfCountry" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Optional theme -->

<!-- Libraries CSS -->
<link href="css/style.css" type="text/css" rel="stylesheet" />
<link href="css/all.css" type="text/css" rel="stylesheet" />
<script>

var autoPlayVideo = document.getElementById("ocScreencapVideo");
    autoPlayVideo.oncanplaythrough = function() {
        autoPlayVideo.muted = true;
        autoPlayVideo.play();
        autoPlayVideo.pause();
        autoPlayVideo.play();
    }


    $(document).ready(function () {
        $("#btn_hide").click(function (e) {
           // e.preventDefault();
           // $(".mform").fadeOut(1000);
           // $("#login_container").addClass('active');

            var name = $('#txtFullName').val();
            if (name.trim() == "") {
                alert('Please Enter Registration No. !!!');
                $('#txtFullName').focus();
              //  $(".mform").fadeIn(1000);
               // $("#login_container").removeClass('active');
                return false;
            }

            document.getElementById('btnLogin').value = "Please Wait...";
            setTimeout(function () {
                var btn = document.getElementById('btnLogin');
                btn.click();
            }, 10000);           

        });
    });
    function ValidateLogin() {        
        
    }
</script>
    </form>
</body>
</html>

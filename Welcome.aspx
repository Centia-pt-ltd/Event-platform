<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Welcome.aspx.cs" Inherits="Welcome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>QStudy</title>
    <link href="css_latest/style.css" type="text/css" rel="stylesheet" />
     <link href="css_latest/StyleDoc.css" type="text/css" rel="stylesheet" />
  <link href="WebCSS/font-awesome.min.css" rel="stylesheet" type="text/css" />
  <script src="WebJS/jquery-3.6.0.js"></script>
   <link rel="stylesheet" href="WebCSS/bootstrap.min.css" />
  <script src="WebJS/bootstrap.min.js"></script>

<%--  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="css_latest/bootstrap.min.css" type="text/css" rel="stylesheet" />--%>
<%--	<link href="https://fonts.googleapis.com/css?family=Raleway+Dots" rel="stylesheet" type="text/css">--%>
<%--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>--%>
    <style>
      
        .error{
                color: #ff1f1f;
                text-shadow: 0.2px 0.2px #d32031;
        }
        .loading{
            width:5%;
            margin-left:47%;margin-top:20%;
        }
       
 </style>

</head>
<body style="background-color:black;">
    <form id="form1" runat="server">	
        <input type="hidden" id="hfLang" runat="server" />
        <input type="hidden" id="hfCount" runat="server" />
        <div class="img_bg1">
      <video  playsinline autoplay muted loop id="myVideo" >
  <source src="img/wlcPage.mp4" type="video/mp4" />
</video>
            </div>
      
    <div class="image-wrapper">
      <a href="#" class="brand"></a>
			<div class=""></div>
     
</div>

	
       
<div class="mform" >


    <div class="index_radio_btn text-center" style="color:white;width:210px;" id="divLanguage">
    <span>Choose Language </span><br />
 <label class="language language_active" id="English" onclick="SelectLanguage(this.id);" >English</label>
 
 <label class="language" id="Arabic" onclick="SelectLanguage(this.id);">Arabic</label>
 
 <label class="language" id="Russian" onclick="SelectLanguage(this.id);">Russian</label>
 
 <label class="language" id="Indonesian" onclick="SelectLanguage(this.id);">Indonesian</label>  
      
        </div>

 
           
            <div id="tmpDivButton" style="display:none"><asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" /></div>
    <div class="row">
                <input name="txtFullName" type="text" id="txtFullName" style="width:200px;margin:5px auto " class="form-control" required="" maxlength="15" placeholder="Enter your registration no." />
            </div>

    <div class="row">
            <a href="javascript:void();" class="btngreen btn-block" id="btnEnterEvent" onclick="return ClickLogin();"> Enter Event</a>
         </div>
    <div class="row">
         <a href="registration.aspx"class="btnorange btn-block"><span class="log_text" id="spanWait">New Registration</span></a>
</div>
		</div>
  <div class="voice_wrapper" style="display:none">
    <img src="img/robot1.png" alt="robot" />
  </div>


   <div class="whatsapp_icon">
    <a href="https://web.whatsapp.com/">
    <img src="img/whatsapp1.png" alt="whatsapp" />

  </a>
     <span style="color:white!important; text-shadow:none!important; margin-left:5px">Help Desk WhatsApp</span>
</div>
    
        <input type="submit" id="aaa" style="display:none"/>
         <button id = "btn" style="display:none"> Click me</button >

    <div class="modal fade" id="modelMove" role="dialog" data-backdrop="static" data-keyboard="false" >
               <img id="loading" src="img/loading.gif" class="loading"/>

            
        </div>
      

        <div class="MessagePanelDiv">
    <asp:Panel ID="pnlMessage" runat="server" Visible="False">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
         <asp:Label ID="labelMessage" runat="server"></asp:Label>
    </asp:Panel>
             <audio preload="auto" autoplay="autoplay" controls="controls" class="audio_box">
        <source src="#" type="audio/mp3" />
    </audio>

</div>
</form>   
   <style type="text/css">
       .MessagePanelDiv {
           position: fixed;
           left: 35%;
           top: 2%;
           width: 35%;
       }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#hfCount").val(0);
            window.setTimeout(function () {
                $(".alert").fadeTo(1500, 0).slideUp(500, function () {
                    $(this).remove();
                });
            }, 3000);

            PlayAudio("English");
        });
        //window.onload = function () {

        //    PlayAudio("");
        //}
    </script>
<script type="text/javascript">

    function OpenMoveModel() {
        $("#modelMove").modal("show");
       
    }
    //var audio = document.createElement("AUDIO")
    //document.body.appendChild(audio);
    
    function PlayAudio(lang) {
        var lang = $("#hfLang").val();
        if (lang == "") { lang = "English"; }
        var audio = document.getElementsByTagName('audio')[0];
       // document.getElementsByTagName('audio')[0].src = '';
        audio.src = '';
        audio.src = "audio/" + lang + "/Expo entrance (" + lang + ").mp3";
        audio.play();       
    }
   
    //document.body.addEventListener("mousemove", function () {
       
    //    if ($("#hfCount").val() <5) {           
    //        PlayAudio("");
    //        audio.play();
    //        var c = $("#hfCount").val();
    //        c++;
    //        $("#hfCount").val(c);
    //    }
    //    })

    function SelectLanguage(eleId) {
        var div = document.getElementById("divLanguage");
        var lebel = div.getElementsByTagName('label');
        var len = lebel.length;
        var tmpId = '';
        for (var k = 0; k < len; k++) {          
                tmpId = lebel[k].id;
                if ($("#" + tmpId).hasClass("language_active") == true) {
                    $("#" + tmpId).removeClass("language_active");
                }
        }
        $("#" + eleId).addClass("language_active");
        $("#hfLang").val(eleId);

        PlayAudio(eleId);
        return false;
    }
    function ClickLogin() {        
        if (document.getElementById('txtFullName').value == '') {            
            document.getElementById("txtFullName").style.borderColor = "red";
            document.getElementById('txtFullName').focus();
            return false;
        }
        else if (document.getElementById('txtFullName').value.trim().length < 6) {
            document.getElementById("txtFullName").style.borderColor = "red";
            document.getElementById('txtFullName').focus();
            return false;
        }
        OpenMoveModel();
        setTimeout(function () { document.getElementById('btnLogin').click(); }, 3000);
    }
</script>
</body>
</html>

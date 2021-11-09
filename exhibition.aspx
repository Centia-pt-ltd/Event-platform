<%@ Page Language="C#" AutoEventWireup="true" CodeFile="exhibition.aspx.cs" Inherits="exhibition" %>
<%@ Register Src="~/UserControl/ucDoc.ascx" TagName="docMenu" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>QStudy</title>
<%--<script src="WebJS/Ajax_jquery.min.js"></script>
    <script src="WebJS/bootstrap.min.js"></script>
     <script src="WebJS/jquery-3.6.0.js"></script>
  <link href="WebCSS/font-awesome.min.css" rel="stylesheet" type="text/css" />
  <link href="css_latest/style.css" type="text/css" rel="stylesheet" />
     <link href="WebCSS/bootstrap.min.css" type="text/css" rel="stylesheet" />--%>

            <link rel="stylesheet" href="WebCSS/bootstrap.min.css" />
        <script src="WebJS/Ajax_jquery.min.js"></script>
        <script src="WebJS/bootstrap.min.js"></script>
        <link href="WebCSS/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="css_latest/style.css" type="text/css" rel="stylesheet" />

    <style>
        .hamburger-icon {
    top: -65px !important;
}
        .hamburger-icon span {
    height: 5px !important;
   
}
       
        .menu-container .row{
                margin-left:-15px;
        }
  
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="hfLang" runat="server" />
        <asp:HiddenField ID="hdfUserId" runat="server" />
         <div class="container-fluid" style="padding:0 !important">
        <div class="exhi_page1">
            <div class="image-wrapper position_exibition" id="Exlevel1">
                
            </div>
        </div>
        <div class="label">
            <a href="#">Lobby-Level</a>
            <a href="#">First Floor</a>
            <!-- <a href="#">Second Floor</a> -->
        </div>
    

    <div class="exhi_page2">
        <div class="image-wrapper position_exibition" id="Exlevel2">
           
        </div>
    </div>

    <div class="label">
        <a href="#">Lobby-Level</a>
        <a href="#">First Floor</a>
        <!-- <a href="#">Second Floor</a> -->
    </div>


    <div class="exhi_page3">
        <h1 class="l_page_h">Second Floor</h1>
        <div class="image-wrapper">
            <div class="img_bg6">
                <div class="add_wrapper1">143x95</div>
                <div class="add_wrapper2">143x95</div>
                <div class="add_wrapper3">143x95</div>
                <div class="add_wrapper4">143x95</div>
                <div class="add_wrapper5">143x95</div>
                <div class="add_wrapper6">143x95</div>
                <div class="add_wrapper7">143x95</div>
                <div class="add_wrapper8">143x95</div>
                <div class="add_wrapper9">143x95</div>
                <div class="add_wrapper10">143x95</div>
                <div class="add_wrapper11">143x95</div>
                <div class="add_wrapper12">143x95</div>
            </div>
        </div>
    </div>

    <div class="label">
        <a href="#" id="level1">Lobby-Level</a>
        <a href="#" id="level2">First Floor</a>
        <!--  <a href="#" id="level3">Second Floor</a> -->
    </div>
             <uc:docMenu ID="doc" runat="server" />
</div>
 

    <audio preload="auto" autoplay="autoplay" controls="controls" class="audio_box">
        <source src="audio/English/Exhibition hall (English).mp3" type="audio/mp3" />
    </audio>



    </form>
    
    <script>
        window.onload = function () {
            selectBoothDetail();
            var lang = $("#hfLang").val();
            if (lang == "") { lang = "English"; }
            PlayAudio(lang);
        }
        function PlayAudio(lang) {
            var lang = $("#hfLang").val();
            if (lang == "") { lang = "English"; }
            document.getElementsByTagName('audio')[0].src = '';
            document.getElementsByTagName('audio')[0].src = "audio/" + lang + "/Exhibition hall (" + lang + ").mp3";
            document.getElementsByTagName('audio')[0].play();
        }

        $(document).ready(function () {
            $("#level1").click(function () {
                $(".exhi_page1").fadeIn(1000);
                $(".exhi_page2").fadeOut(1000);
                $(".exhi_page3").fadeOut(1000);
            });
            $("#level2").click(function () {
                $(".exhi_page2").fadeIn(1000);
                $(".exhi_page3").fadeOut(1000);
                $(".exhi_page1").fadeOut(1000);
            });
            $("#level3").click(function () {
                $(".exhi_page1").fadeOut(1000);
                $(".exhi_page2").fadeOut(1000);
                $(".exhi_page3").fadeIn(1000);
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".tab").click(function () {
                $(".tab").removeClass("active");
                $(this).addClass("active");
            });
        });

        function selectBoothDetail() {
            $.ajax({
                type: "POST",
                url: "exhibition.aspx/selectBoothDetail",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    $("#Exlevel1").empty();
                    $("#Exlevel2").empty();
                    var Data1 = "<div class='img_bg7'><h1 class='l_page_h'>Lobby - Level</h1 >";
                    var Data2 = "<div class='img_bg7'><h1 class='l_page_h'>First Floor</h1>";
                    if (len > 0) {
                        for (var i = 0; i < len; i++) {
                            var Id = response.d[i].Position;
                            if (Id <= 12) {
                                Data1 += "<div class='" + response.d[i].ImgClass1 + "'>";
                                Data1 += "<a href = 'UniversityBooth/Boothui.aspx?Uid=" + response.d[i].UniversityId + "' style = 'display: block;height: 100%;'>";
                                Data1 += "<img src = 'Boothlogo/" + response.d[i].Url + "' style = 'width:100%;height:100%;'/></a>";
                                Data1 += "</div >";
                            }
                            else {
                                Data2 += "<div class='" + response.d[i].ImgClass2 + "'>";
                                Data2 += "<a href = 'UniversityBooth/Boothui.aspx?Uid=" + response.d[i].UniversityId + "' style = 'display: block;height: 100%;'>";
                                Data2 += "<img src = 'Boothlogo/" + response.d[i].Url + "' style = 'width:100%;height:100%;'/></a>";
                                Data2 += "</div >";
                            }
                        }
                        Data1 += "</div>";
                        Data2 += "</div>";
                        $("#Exlevel1").html(Data1);
                        $("#Exlevel2").html(Data2);
                    } else {
                        Data1 += "<div style='text-align: center;'><h1 style='background-color: lavender; margin: 0;'> Curently there are no event to display !!</h1>";
                        Data1 += "</div >";
                        Data2 += "<div style='text-align: center;'><h1 style='background-color: lavender; margin: 0;'> Curently there are no event to display !!</h1>";
                        Data2 += "</div >";
                        Data1 += "</div>";
                        Data2 += "</div>";
                        $("#Exlevel1").html(Data1);
                        $("#Exlevel2").html(Data2);
                    }
                },
                error: function (response) {
                    //showMsg("ERROR", "Something went wrong.!");
                }
            });

            return false;
        }
    </script>
</body>
</html>

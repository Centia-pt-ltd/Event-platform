<%@ Page Title="" Language="C#" MasterPageFile="~/UniversityBooth/BoothMasterPage.master" AutoEventWireup="true" CodeFile="BoothView.aspx.cs" Inherits="UniversityBooth_BoothView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <%--<ul class="navright_menu">
                <li class="next_booth" id="aprev"><a href='javascript:void();' onclick="return PrevRecords();">&#8249;</a></li>
                <li class="next_booth" id="anext" ><a href='javascript:void();' onclick="return NextRecords();">&#8250;</a></li>
                       </ul>--%>
    <ul class="navright_menu">
                <li class="next_booth" id="aprev"><a href='javascript:void();' onclick="return PrevRecords();" title="Prev Booth..">
                     <div id="arrowAnimLeft">
                 <table><tr><td> <h2 class="blinkLeft"><div class="arrowBack"></div></h2></td><td><h2 class="blinkLeft">PREV</h2></td></tr></table>
 <%-- <div class="arrowSlidingBack">
    <div class="arrowBack"></div>
  </div>
  <div class="arrowSlidingBack delay1">
    <div class="arrowBack"></div>
  </div>--%>
   <%--<div class="arrowSlidingBack delay2">
    <div class="arrowBack"></div>
  </div>
  <div class="arrowSlidingBack delay3">
    <div class="arrowBack"></div>
  </div>--%>
        
</div></a></li>
                <li class="next_booth" id="anext" ><a href='javascript:void();' onclick="return NextRecords();" title="Next Booth.."><div id="arrowAnimRight">
   <%-- <div class="arrowSlidingNext">
    <div class="arrowNext"></div>
  </div>
 <div class="arrowSlidingNext delay1">
    <div class="arrowNext"></div>
  </div>--%>
  <%-- <div class="arrowSlidingNext delay2">
    <div class="arrowNext"></div>
  </div>
  <div class="arrowSlidingNext delay3">
    <div class="arrowNext"></div>
  </div>--%>
   <table><tr><td><h2 class="blinkLeft">NEXT</h2></td><td> <h2 class="blinkLeft"><div class="arrowNext"></div></h2></td></tr></table>
    
</div></a></li>
                       </ul>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:HiddenField ID="hdfUserId" runat="server" />
    <asp:HiddenField ID="hdfBid" runat="server" />
    <asp:HiddenField ID="hdfUid" runat="server" />
    <asp:HiddenField ID="hdfPid" runat="server" />
    <asp:HiddenField ID="hdfEventId" runat="server" />
    <asp:HiddenField ID="hdfMax" runat="server" />
    <asp:HiddenField ID="hdfMin" runat="server" />
    <asp:HiddenField ID="hdChat" runat="server" />
     <asp:HiddenField ID="hfLang" runat="server" />

     <audio preload="auto" autoplay="autoplay" controls="controls" class="audio_box">
  <source src="#" type="audio/mp3" />
</audio>

    <div id="dvUniName"> <h2 class="bootcuname" id="universityName" runat="server" ></h2> </div>
   <%-- <div class="university_booth_wrapper" style="margin-top:2%;">
           <div> <h2 class="bootcuname" id="universityName" runat="server" ></h2> </div>
        <div class="col-md-12 col-lg-12" style="margin-top:1%;">
               
                <img src="#" alt="apu" id="bigImg" runat="server" />
                <div  id="divBrand1" style="text-align: center;" runat="server">
                    <img src="#" id="imgBrand1" runat="server" class="booth_brand"/>  </div>
                <div id="divBrand2" style="text-align: center;" runat="server" >
                    <img src="#" id="imgBrand2" runat="server" class="booth_name" />
                </div>


                
            </div>
      
    </div>--%>
  
     <!---Chat Code Start----->
       
       <%-- <script type="text/javascript">
            var Tawk_API = Tawk_API || { }, Tawk_LoadStart = new Date();
            (function () {
                var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
                s1.async = true;
                s1.src = "<%=strTawkCode%>"; //ChatString
            s1.charset = 'UTF-8';
            s1.setAttribute('crossorigin', '*');
            s1.setAttribute('id', 'scrptTawk');
            s0.parentNode.insertBefore(s1, s0);
        })();
    </script>--%>

   <%-- <script type="text/javascript">      

        Tawk_API.onLoad = function () {
                  Tawk_API.maximize();
        };
    </script>--%>
    <!----Chat Code End------>
        <script type="text/javascript">
            $(document).ready(function () {
                var lang = $("#ContentPlaceHolder1_hfLang").val();
                if (lang == "") { lang = "English"; }
                PlayAudio(lang);
            });
            function PlayAudio(lang) {
                var UniId = $("#ContentPlaceHolder1_hdfUid").val();
                var lang = $("#ContentPlaceHolder1_hfLang").val();
                if (lang == "") { lang = "English"; }
                document.getElementsByTagName('audio')[0].src = '';
                document.getElementsByTagName('audio')[0].src = "../audio/" + lang + "/University/" + UniId + ".mp3";
                document.getElementsByTagName('audio')[0].play();
            }



            var popUpObj;
            function enableDisable() {
            var maxId = $("#ContentPlaceHolder1_hdfMax").val();
            var minId = $("#ContentPlaceHolder1_hdfMin").val();
            var nextId = $("#ContentPlaceHolder1_hdfPid").val();
            if (nextId == maxId) {
                $("#anext").css('display', 'none');
            }
            else {
                $("#anext").css('display', 'block');
            }
            if (nextId == minId) {
                $("#aprev").css('display', 'none');
            }
            else {
                $("#aprev").css('display', 'block');
            }
        }
        window.onload = enableDisable();
        function next(Uid,Pid) {
            location.href = "BoothView.aspx?Uid=" + Uid + "&Pid=" + Pid;
            return false;
        }

        function NextRecords() {
            var nextId=$("#ContentPlaceHolder1_hdfPid").val();
            var EventId = $("#ContentPlaceHolder1_hdfEventId").val();
            //$("#ContentPlaceHolder1_hdfBid").val('');            
            
            $.ajax({
                type: "POST",
                url: "BoothView.aspx/NextBoothDetail",
                data: "{'EventId':'" + EventId +"','nextId':'" + nextId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    if (len > 0) {
                        $("#ContentPlaceHolder1_hdfBid").val(response.d[0].BoothId);
                        $("#ContentPlaceHolder1_hdfUid").val(response.d[0].UniversityId);
                        $("#ContentPlaceHolder1_hdfPid").val(response.d[0].Position);

                        //enableDisable();
                        //selectBoothDetail()
                        
                    }
                    var Uid = $("#ContentPlaceHolder1_hdfUid").val();
                    var Pid = $("#ContentPlaceHolder1_hdfPid").val();
                    next(Uid,Pid);
                },
                error: function (response) {
                    //showMsg("ERROR", "Something went wrong.!");
                }
                
            });
           
            return false;
        }
        //window.onload = NextRecords();
            function prev(Uid, Pid) {
                
            location.href = "BoothView.aspx?Uid=" + Uid + "&Pid=" + Pid;
            return false;
        }
        function PrevRecords() {
            var prevId = $("#ContentPlaceHolder1_hdfPid").val();
            var EventId = $("#ContentPlaceHolder1_hdfEventId").val();
            $.ajax({
                type: "POST",
                url: "BoothView.aspx/PrevBoothDetail",
                data: "{'EventId':'" + EventId +"','prevId':'" + prevId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    if (len > 0) {
                        $("#ContentPlaceHolder1_hdfBid").val(response.d[0].BoothId);
                        $("#ContentPlaceHolder1_hdfUid").val(response.d[0].UniversityId);
                        $("#ContentPlaceHolder1_hdfPid").val(response.d[0].Position);
                        //enableDisable();
                        //selectBoothDetail();
                    }
                   
                    var Uid = $("#ContentPlaceHolder1_hdfUid").val();
                    var Pid = $("#ContentPlaceHolder1_hdfPid").val();
                    prev(Uid, Pid);
                },
                error: function (response) {
                    //showMsg("ERROR", "Something went wrong.!");
                }
               
            });
           
            return false;
        }

        function selectBoothDetail() {
            var UniId = $("#ContentPlaceHolder1_hdfUid").val();
            var EventId = $("#ContentPlaceHolder1_hdfEventId").val();
            $.ajax({
                type: "POST",
                url: "BoothView.aspx/selectBoothDetail",
                data: "{'UniId':'" + UniId + "','EventId':'" + EventId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    if (len > 0) {

                        //$("#ContentPlaceHolder1_bigImg").attr("src", "img/" + response.d[0].BoothImage);
                        //$("#ContentPlaceHolder1_imgBrand1").attr("src","../UploadedBooth/" + response.d[0].BigImg);
                        //$("#ContentPlaceHolder1_imgBrand2").attr("src", "../UploadedBooth/" + response.d[0].SmallImg);
                        $("#ContentPlaceHolder1_universityName").text(response.d[0].UniversityName);
                        //$("#ContentPlaceHolder1_imgBrand1").attr("class", response.d[0].BigImgClass);
                        //$("#ContentPlaceHolder1_imgBrand2").attr("class", response.d[0].SmallImgClass);
                        $("#ContentPlaceHolder1_hdChat").val(response.d[0].ChatScript);
                        $('<style>.booth_bgbanner {background-image:  url("img/' + UniId + '.jpg");}</style>')
                           .appendTo('head');
                    }
                    //OpenChat($("#ContentPlaceHolder1_hdChat").val());
                    
                },
                error: function (response) {
                    //showMsg("ERROR", "Something went wrong.!");
                }
            });
            
            return false;
        }
        window.onload = selectBoothDetail();
        
        function GetAboutUs() {
            var UniversityId = $("#ContentPlaceHolder1_hdfUid").val();
            $("#pAboutUs").html('');
            $.ajax({
                type: "POST",
                url: "BoothView.aspx/GetAboutUs",
                data: "{'UniversityId':'" + UniversityId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "ER") {
                        $("#pAboutUs").html('Something went wrong. !');
                    }
                    else {
                        $("#pAboutUs").html(response.d);
                    }
                },
                error: function (response) {
                    $("#pAboutUs").html('Something went wrong. !');
                }
            });
            return false;
        }

        function ViewPhoto() {
            var UniversityId = $("#ContentPlaceHolder1_hdfUid").val();
            $("#container-carousel").html('');
            $("#MediaTitle").html('Photo');
            $.ajax({
                type: "POST",
                url: "BoothView.aspx/ViewPhoto",
                data: "{'UniversityId':'" + UniversityId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    var DisplayImageName = '', DownloadImageName = '';
                    var div = '',imgUrl='';
                    for (var k = 0; k < len; k++) {
                        DownloadImageName = response.d[k].DownloadImageName;
                        DisplayImageName = response.d[k].DisplayImageName;
                        imgUrl = "../../UploadedImage/" + response.d[k].DownloadImageName
                        if (k == 0)
                            div = "<div class='item active'><img src='" + imgUrl + "' alt='" + DisplayImageName + "'  class='imgSlide'/></div>";
                        else
                            div += "<div class='item'><img src='" + imgUrl + "' alt='" + DisplayImageName + "'  class='imgSlide'/></div>";
                    }
                    
                    $("#container-carousel").html(div);
                },
                error: function (response) {
                    $("#container-carousel").html('Something went wrong. !');
                }
            });
            return false;
        }

        function ViewBrochure() {
            var UniversityId = $("#ContentPlaceHolder1_hdfUid").val();
            $("#dicVrochure").html('');
            $.ajax({
                type: "POST",
                url: "BoothView.aspx/BindBrichureList",
                data: "{'UniversityId':'" + UniversityId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    var DisplayFileName = '', DownloadFileName = '', Id = '';
                    var div = '', FileUrl = '';
                    for (var k = 0; k < len; k++) {
                        DisplayFileName = response.d[k].DisplayFileName;
                        DownloadFileName = response.d[k].DownloadFileName;
                        Id = response.d[k].Id;
                        Id = "bc" + Id;
                        div += "<span class='spBrochuer' style='margin-right:15px;'> <input style='display:none' type='checkbox' id=" + Id + " name=" + Id + " value=" + Id + ">";
                        div += " <i class='fa fa-download' style='color: #09eaff;'></i> <label style='cursor:pointer' onclick='downloadBrochure(" + response.d[k].Id + ");' for=" + Id + ">" + DisplayFileName + "</label><br></span>";

                    }
                    $("#divVrochure").html(div);
                },
                error: function (response) {
                    $("#divVrochure").html('Something went wrong. !');
                }
            });
            return false;
        }

        function downloadBrochure(BroucherId) {
            var UniversityId = "";
            location.href = "../downloadBrochure.aspx?Id=" + BroucherId + "&sts=single" + "&UniversityId=" + UniversityId;
            return false;
        }
        function downloadAllBrochure() {
            var BroucherId = "";
            var UniversityId = $("#ContentPlaceHolder1_hdfUid").val();
            location.href = "../downloadBrochure.aspx?Id=" + BroucherId + "&sts=all" + "&UniversityId=" + UniversityId;
            return false;
        }

        function ViewVideo() {
            var UniversityId = $("#ContentPlaceHolder1_hdfUid").val();
            $("#container-carousel").html('');
            $("#MediaTitle").html('Videos');
            $.ajax({
                type: "POST",
                url: "BoothView.aspx/ViewVideo",
                data: "{'UniversityId':'" + UniversityId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    var div = '', VideoUrl = '';
                    for (var k = 0; k < len; k++) {
                        VideoUrl = response.d[k].Url;
                        const videoId = "//www.youtube.com/embed/" + getId(VideoUrl);
                        if (k == 0)
                            div = "<div class='item active'><iframe src='" + videoId + "' height='330' style='width:100%;' allowfullscreen='allowfullscreen'></iframe></div>";
                        else
                            div += "<div class='item'><iframe src='" + videoId + "' height='330' style='width:100%;' allowfullscreen='allowfullscreen'></iframe></div>";
                    }

                    $("#container-carousel").html(div);
                },
                error: function (response) {
                    $("#container-carousel").html('Something went wrong. !');
                }
            });
            return false;
        }
            function getId(url) {
                const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
                const match = url.match(regExp);

                return (match && match[2].length === 11)
                    ? match[2]
                    : null;
            }
            function videoCall() {
                var UniversityId = $("#ContentPlaceHolder1_hdfUid").val();
                //$("#divVideoCall").html('');
                $.ajax({
                    type: "POST",
                    url: "BoothView.aspx/CreateVideoChat",
                    data: "{'Uid':'" + UniversityId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var len = response.d.length;
                        var div = '';
                        var VideoUrl = response.d;
                        //div = "<iframe allow='camera; microphone; fullscreen; speaker; display-capture' ";
                        //div += " src='" + VideoUrl + "' style='height:50vh;width:100%'> ";
                        //div += " </iframe>";
                        //$("#divVideoCall").html(div);
                        $("#ifrmmodify").attr("src", VideoUrl);
                    },
                    error: function (response) {
                        $("#ifrmmodify").html('Something went wrong. !');
                    }
                });
                return false;
            }
            function videoCallMob() {
                var UniversityId = $("#ContentPlaceHolder1_hdfUid").val();
                // $("#divVideoCall").html('');
                $.ajax({
                    type: "POST",
                    url: "BoothView.aspx/CreateVideoChat",
                    data: "{'Uid':'" + UniversityId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var len = response.d.length;
                        var div = '';
                        var VideoUrl = response.d;
                        //div = "<iframe allow='camera; microphone; fullscreen; speaker; display-capture' ";
                        //div += " src='" + VideoUrl + "' style='height:50vh;width:100%'> ";
                        //div += " </iframe>";
                        //$("#divVideoCall").html(div);
                        //window.open(VideoUrl, '_blank');
                        let a = document.createElement('a');
                        a.target = '_blank';
                        a.href = VideoUrl;
                        a.click();

                    },
                    error: function (response) {
                        $("#ifrmmodify").html('Something went wrong. !');
                    }
                });
                return false;
            }
            
            function joinRoom() {
                $("#myModal5").show();
                var UniversityId = $("#ContentPlaceHolder1_hdfUid").val();
                $.ajax({
                    type: "POST",
                    url: "BoothView.aspx/JoinRoom",
                    data: "{'Uid':'" + UniversityId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var len = response.d.length;
                        var VideoUrl = response.d;
                        if (VideoUrl == "") {                            
                            $("#divJoinRoom").html('No Room Assigned To You !!');
                            $("#ifrmRoom").css("display", "none");
                        }
                        else {
                           
                            $("#ifrmRoom").css("display", "block");
                            $("#ifrmRoom").attr("src", VideoUrl);
                        }
                    },
                    error: function (response) {
                        $("#divJoinRoom").html('Something went wrong. !');
                    }
                });
                return false;
            }
        </script>

    <style>
        .navright_menu .next_booth{

        }
        .spBrochuer{
            display:inline-block;
            width:20%;
        }
    </style>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" Runat="Server">

    <!-- about us -->
<div class="booth_dock" style="margin-top:-4%;">
<button class="btn success about_box" id="myBtn" onclick="return GetAboutUs();">About Us</button>
<button class="btn info" id="myBtn1" onclick="return ViewBrochure();">Brochure</button>
<button class="btn warning" id="myBtn2" onclick="return ViewPhoto();">Photo</button>
<button class="btn danger" id="myBtn3" onclick="return ViewVideo();">Video</button>
<button class="btn info" id="myBtn4" onclick="return videoCall();">Speak To Us</button>
<button class="btn info" id="myBtn5" onclick="return videoCallMob();">Speak To Us</button>
<button class="btn success" id="myBtn6" onclick="return joinRoom();">Join Counselling Room</button>

</div>

<div class="about_popup" id="myModal">
     <span class="close closebtn">&times;</span>
     <div class="about_content">
     <%--<h2>hello</h2>--%>
     <p id="pAboutUs"></p>
 </div>
</div>
<!-- about us -->
<!-- brochure -->
   
<div class="about_popup1" id="myModal1">
     <span class="close1 closebtn">&times;</span>
     <div class="about_content">
     <h2>Brochure</h2>
     <div class="row">
        <div class="col-md-12" id="divVrochure">       
          

   </div>

        <button class="download_btn" onclick="return downloadAllBrochure();"> <i class="fa fa-download"></i>&nbsp;Download All</button>
  </div>

 </div>
</div>
<!-- brochure -->
<!-- photo -->


<div class="about_popup2" id="myModal2">
     <span class="close1 closebtn">&times;</span>
     <div class="about_content">
     <h2 id="MediaTitle">Photo</h2>
<div class="container">
 <%-- <div id="myCarouselp" class="carousel slide" data-ride="carousel" style="text-align:center">
    <!-- Wrapper for slides -->
    <div class="carousel-inner" id="imgPhotoBox">
      
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarouselp" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarouselp" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>--%>
  <div id="wrapper-carousel" style="text-align:center">
        <a class="left" href="#wrapper-carousel" style="font-size:100px;z-index:3000;" onclick="return leftClick()">&lsaquo;</a>
        <div id="imgPhoto" class="main-carousel">
            <div id="container-carousel">
            </div>
        </div>
        <a class="right" href="#wrapper-carousel"  style="font-size:100px;z-index:3000" onclick="return rightClick()">&rsaquo;</a> 
    </div>
</div>


     </div>
</div>
<!-- photo -->
<!-- video -->
    
 
<div class="about_popup3" id="myModal3">
     <span class="close1 closebtn">&times;</span>
     <div class="about_content">
     <h2>Videos</h2>
<div class="container">
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Wrapper for slides -->
    <div class="carousel-inner" id="divVideo" style="text-align: center;">
      
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>


     </div>
</div>
<!-- video -->
<!-- speak -->
<div class="about_popup4" id="myModal4">
     <span class="close closebtn1">&times;</span>
     <div class="about_content">
     <h2>speak to us</h2>
         <div id="divVideoCall" class="container">
        <iframe allow='camera; microphone; fullscreen; speaker; display-capture' style='height:50vh;width:100%'  id="ifrmmodify"> 
        </iframe>
         </div>
 </div>
</div>
<!-- speak -->
<!----Join Room---->
<div class="about_popup4" id="myModal5">
     <span class="close closebtn1">&times;</span>
     <div class="about_content">
     <h2>Join Room</h2>
         <div id="divJoinRoom" class="container" style="text-align:center;">
        <iframe allow='camera; microphone; fullscreen; speaker; display-capture' style='height:50vh;width:100%'  id="ifrmRoom"> 
        </iframe>
         </div>
 </div>
</div>
<!---Join Room------>
    
</asp:Content>


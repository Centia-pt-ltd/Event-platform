<%@ Page Title="" Language="C#" MasterPageFile="~/UniversityBooth/BoothMasterPage.master" AutoEventWireup="true" CodeFile="Booth.aspx.cs" Inherits="university_AllBooth_Booth" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:HiddenField ID="hdfUserId" runat="server" />
    <asp:HiddenField ID="hdfBid" runat="server" />
    <asp:HiddenField ID="hdfUid" runat="server" />

    <div id="dvUniName"> <h2 class="bootcuname" id="universityName" runat="server" ></h2> </div>
   <%-- <div class="university_booth_wrapper">
          
            <div class="col-md-12 col-lg-12" style="margin-top:8%;">
               <h2 class="bootcuname" id="universityName" runat="server" style="margin-top:-5%;"></h2> 
                <img src="#" alt="apu" id="bigImg" runat="server" />
                <div  id="divBrand1" style="text-align: center;" runat="server">
                    <img src="#" id="imgBrand1" runat="server" class="booth_brand"/>  </div>
                <div id="divBrand2" style="text-align: center;" runat="server" >
                    <img src="#" id="imgBrand2" runat="server" class="booth_name" />
                </div>


                
            </div>
      
    </div>--%>
     <!---Chat Code Start----->
       
     <%--   <script type="text/javascript">
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
    </script>

    <script type="text/javascript">      

        Tawk_API.onLoad = function () {
                  Tawk_API.maximize();
        };
    </script>--%>
    <script>
     function selectBoothDetail() {
            var UniId = $("#ContentPlaceHolder1_hdfUid").val();
            $.ajax({
                type: "POST",
                url: "Booth.aspx/selectBoothDetail",
                data: "{'UniId':'" + UniId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    if (len > 0) {

                        //$("#ContentPlaceHolder1_bigImg").attr("src", "../UniversityBooth/img/" + response.d[0].BoothImage);
                        //$("#ContentPlaceHolder1_imgBrand1").attr("src","../UploadedBooth/" + response.d[0].BigImg);
                        //$("#ContentPlaceHolder1_imgBrand2").attr("src", "../UploadedBooth/" + response.d[0].SmallImg);
                        $("#ContentPlaceHolder1_universityName").text(response.d[0].UniversityName);
                        //$("#ContentPlaceHolder1_imgBrand1").attr("class", response.d[0].BigImgClass);
                        //$("#ContentPlaceHolder1_imgBrand2").attr("class", response.d[0].SmallImgClass);
                        $('<style>.booth_bgbanner {background-image:  url("../UniversityBooth/img/' + UniId + '.jpg");}</style>')
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
                url: "Booth.aspx/GetAboutUs",
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
            $.ajax({
                type: "POST",
                url: "Booth.aspx/ViewPhoto",
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
                        imgUrl = "../UploadedImage/" + response.d[k].DownloadImageName
                        if (k == 0)
                            div = "<div class='item active'><img src='" + imgUrl + "' alt='" + DisplayImageName + "' class='imgSlide'></div>";
                        else
                            div += "<div class='item'><img src='" + imgUrl + "' alt='" + DisplayImageName + "'  class='imgSlide'></div>";
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
                url: "Booth.aspx/BindBrichureList",
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
                url: "Booth.aspx/ViewVideo",
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
                $("#divVideoCall").html('From here student can connect with the university through Video Call !!');
                //$.ajax({
                //    type: "POST",
                //    url: "Booth.aspx/CreateVideoChat",
                //    data: "{'Uid':'" + UniversityId + "'}",
                //    contentType: "application/json; charset=utf-8",
                //    dataType: "json",
                //    success: function (response) {
                //        var len = response.d.length;
                //        var div = '';
                //        var VideoUrl = response.d;
                //        div = "<iframe allow='camera; microphone; fullscreen; speaker; display-capture' ";
                //        div += " src='" + VideoUrl + "' style='height:50vh;width:100%'> ";
                //        div += " </iframe>";
                //        $("#divVideoCall").html(div);
                //    },
                //    error: function (response) {
                //        $("#divVideoCall").html('Something went wrong. !');
                //    }
                //});
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
        #doc{
            display:none;
        }
        .menu-container{
            display:none !important;
        }
        .chat-button{
             display:none !important;
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
<button class="btn info" id="myBtn4" onclick="return videoCall();">Speak To us</button>
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

        <button class="download_btn" onclick="downloadAllBrochure();"> <i class="fa fa-download"></i>&nbsp;Download All</button>
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
  <%--<div id="myCarouselp" class="carousel slide" data-ride="carousel" style="text-align:center">
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
    <div class="carousel-inner" id="divVideo">
      
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
         <div id="divVideoCall" class="container" style="text-align:center;">
       
         </div>
 </div>
</div>
<!-- speak -->
</asp:Content>


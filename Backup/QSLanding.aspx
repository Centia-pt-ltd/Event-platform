<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QSLanding.aspx.cs" Inherits="QSLanding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:100,200,300,400,500,600,700,800,900" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Pragati+Narrow:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css"/>
    <title>QStudy</title>
    
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min1.css" rel="stylesheet">

    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/style1.css">
    <link rel="stylesheet" href="assets/css/style2.css">
    <link rel="stylesheet" href="assets/css/style3.css">
    <link rel="stylesheet" href="assets/css/style4.css">

    <style>
       
        #formsubmit{
                margin-top: 10px !important;
    background-color: #f5a425 !important;
    color: #fff !important;
    font-size: 13px !important;
    text-transform: uppercase !important;
    letter-spacing: 0.5px !important;
    font-weight: 700 !important;
    padding: 12px 20px !important;
    display: inline-block !important;
    outline: none !important;
    box-shadow: none !important;
    border: none !important;
        }


       
    </style>
</head>
<body>
 
      
  <div id="full_page">
<!-- --------code for whatsapp icon---------- -->
   <a href="https://web.whatsapp.com/" class="float" target="_blank">
      <i class="fa fa-whatsapp my-float"></i>
      <span class="whatsapp_icon"><h6>Whatsapp Us</h6></span>
  </a>
<!-- --------end----------------------------- -->

  <!-- ***** Main Banner Area Start ***** -->
 <section class="section main-banner" id="top" data-section="section1">
      <video id="bg-video" autoplay="autoplay" muted="muted" loop="loop" playsinline>
          <source src="assets\images\video1.mp4" type="video/mp4" style="z-index: -1;object-fit: cover;"  />
      </video>
      <img src="assets\images\sablogo.png" />

  
          <div class="caption">
              
              <h2><em>Study</em> Abroad</h2>
              <div class="main-button">
                  <div class="scroll-to-section"><a href="#section2">Discover more</a></div>
              </div>
          </div>
  </section>
  <!-- ***** Main Banner Area End ***** -->

  <section class="section coming-soon" id="top1" data-section="section3">
    <h4>The Largest Study Abroad Expo is Starting in:</h4>
    <div class="container">
      <div class="row">
        <div class="col-md-8 col-xs-12">
          <div class="continer centerIt">
            <div>
              <div class="counter">
                <div class="days">
                  <div class="value">00</div>
                  <span>Days</span>
                </div>
                <div class="hours">
                  <div class="value">00</div>
                  <span>Hours</span>
                </div>
                <div class="minutes">
                  <div class="value">00</div>
                  <span>Minutes</span>
                </div>
                <div class="seconds">
                  <div class="value">00</div>
                  <span>Seconds</span>
                </div>
              </div>
            </div>
            <div class="container-fluid">
              <div class="row">
                <h2 class="choosevent">Choose Your Event:</h2>
                <div class="clickimg">
                  <div class="col-xs-3 col-sm-3 col-md-3">
                    <img src="assets\images\photo1.jpeg" alt="1" style="width: 100%;height: 78%;" class="img-responsive" />
                    <div class="form-check">
                      <input
                      class="form-check-input"
                      type="radio"
                      name="flexRadioDefault"
                      id="flexRadioDefault1"/>
                      <label style="color: white;" class="form-check-label" for="flexRadioDefault1"><b> Malaysian Government University Application Day </b></label>
                    </div>
                  </div>
                  <div class="col-xs-3 col-sm-3 col-md-3">
                    <img src="assets\images\photo2.jpeg" alt="1" style="width: 100%; height:78%;" class="img-responsive"/>
                    <div class="form-check">
                      <input
                      class="form-check-input"
                      type="radio"
                      name="flexRadioDefault"
                      id="flexRadioDefault1"
                      />
                      <label style="color: white;" class="form-check-label" for="flexRadioDefault1"> <b> Middle East & North Africa </b></label>
                    </div>
                  </div>
                  <div class="col-xs-3 col-sm-3 col-md-3">
                    <img src="assets\images\photo3.jpeg" alt="1" style="width: 100%;height: 78%;" class="img-responsive"/>
                    <div class="form-check">
                      <input
                      class="form-check-input"
                      type="radio"
                      name="flexRadioDefault"
                      id="flexRadioDefault1"
                      />
                      <label style="color: white;" class="form-check-label" for="flexRadioDefault1"> <b> South Asia & Central Asia </b></label>
                    </div>
                  </div>
            <div class="col-xs-3 col-sm-3 col-md-3">
              
                <img src="assets\images\photo4.jpeg" alt="1" style="width: 100%;height: 78%;" class="img-responsive"/>
                <div class="form-check">
                <input
                 class="form-check-input"
                 type="radio"
                 name="flexRadioDefault"
                 id="flexRadioDefault1"
                />
                <label style="color: white;" class="form-check-label" for="flexRadioDefault1"> <b> South East Asia & East Asia </b></label>
              </div>
                
                
            </div>
          </div>
          <div class="main-button1">
            <div class="scroll-to-section"><a href="http://qstudyabroad.com/registration.aspx">REGISTER FOR FREE EVENT PASS </a></div>
            </div>
        </div>
        </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="right-content">
            <div class="top-content">
              <h6 style="font-size: 19px; font-weight: 500;">Send Me More Info For Study Aboard</h6>
            </div>
            <form id="contact" runat="server" method="get">
                <asp:Label id="lblmsg" runat="server" Font-Bold="true"></asp:Label>
              <div class="row">
                <div class="col-md-12">
                  <fieldset>
                    <input name="name" type="text" runat="server" class="form-control" id="name" placeholder="Your Name" required="" maxlength="50" />
                  </fieldset>
                </div>
                <div class="col-md-12">
                  <fieldset>
                    <input name="email" type="text" runat="server" class="form-control" id="email" placeholder="Your Email" required="" maxlength="50" />
                  </fieldset>
                </div>
                  <div class="col-md-12"><fieldset>
                <table>
                    <tr>
                        <td><img id="imgflag" src="#" style="float:left;margin-bottom: 4vh;"/></td>
                        <td style="width: 27% !important;"> <input type="text" placeholder="+123" id="txtCountryNameFlag"  class="textboxAuto form-control" /></td>
                        <td><input name="phonenumber"  type="text" runat="server" class="form-control" onkeypress="return isNumberKey(event)" id="phonenumber" placeholder="Your Phone No" required="" maxlength="15" />
                            </td>
                    </tr>
                </table></fieldset> </div>
                <div class="col-md-12">
                  <fieldset>
                    <%--<button  type="submit" id="formsubmit" onclick="SaveRecord();" runat="server"  class="button">Register</button>--%>

                      <input  type="button" id="formsubmit"  onclick="SaveRecord();" runat="server"  class="button"  value="Submit"/>

                  </fieldset>
                </div>
              
               </div>
            </form>
         </div>
        </div>
     </div>
    </div>
  </section>
  
  
 <section class="section courses" data-section="section4">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">
          <div class="section-heading">
            <h2>Our Services</h2>
          </div>
        </div>
        <div class="owl-carousel owl-theme">
          <div class="item">
            <div class="down-content" style="height: 559px;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">Free Study </h4>
              <img src="assets\images\consult.png" style="width: 59%; height: 16%; margin: 0 auto;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">Abroad Consultation And Career Profiling</h4>
              <p style="text-align: center;">Save yourself the confusion. Our team of Admission Specialist will give you reliable recommendations. We can arrange a personal virtual counselling session for you with our partner universities. Course info, counselling and advisory, application service — enjoy our services all for free!</p>
            </div>
          </div>
          <div class="item">
            <div class="down-content1" style="height: 559px;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">Student</h4>
              <img src="assets\images\visa.png" style="width: 72%; height: 16%; margin: 0 auto;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">VISA APPLICATION</h4>
              <p style="text-align: center;"> All Student Visa applications have their own set of rules and process. Different country has different requirements as well and it can be quite complicated process altogether. Let us help you on this and save you from the complicated processes!</p>
            </div>
          </div>
          <div class="item">
            <div class="down-content2" style="height: 559px;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">University </h4>
              <img src="assets\images\placement.png" style="width: 48%; height: 16%; margin: 0 auto;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">Placement & Application Process</h4>
              <p style="text-align: center;">We provide assistance in applying for the institutions as well as the whole acceptance of offer process, making your application process hassle-free!. Placement and advisory, application service — enjoy our services all for free!</p>
            </div>
          </div>
          <div class="item">
            <div class="down-content3" style="height: 559px;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">English </h4>
              <img src="assets\images\englogo.png" style="width: 48%; height: 16%; margin: 0 auto;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">Language Proficiency Test (IELTS)</h4>
              <p style="text-align: center;">We provide assistance for international students from Non-English education background to register for IELTS test. Tutorial classes will be provided to guide the students for their test.</p>
            </div>
          </div>
          <div class="item">
            <div class="down-content4" style="height: 559px;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">Scholarship </h4>
              <img src="assets\images\schol.png" style="width: 69%; height: 16%; margin: 0 auto;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">& Bursaries</h4>
              <p style="text-align: center;">Financial Aid is available in some form for many study areas and institutions. We will guide you and help you easily find and apply for scholarships that are offered by the universities.</p>
            </div>
          </div>
          <div class="item">
            <div class="down-content5" style="height: 559px;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">Rewards</h4>
              <img src="assets\images\reward.png" style="width: 48%; height: 16%; margin: 0 auto;">
              <p style="text-align: center;">Exciting rewards are available for those who successfully enrol to universities through us! Redeem your Cashback up to USD 500*, FREE* IELTS/ TOEFL test or even FREE* flight ticket. Excited?</p>
            </div>
          </div>
          <div class="item">
            <div class="down-content6" style="height: 559px;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">Student </h4>
              <img src="assets\images\accomod.png" style="width: 79%; height: 16%; margin: 0 auto;">
              <h4 style="text-align: center; font-family: sans-serif; font-weight: 800;">Accomodation & Transportation & Bank Account</h4>
              <p style="text-align: center;">Our advisors can help sort out your accommodation & getting around the city. We have a partnership with different student accommodation providers. Having hardships to get travel around the city, we can help on getting the rental car & assistance on opening a local bank account.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

   
   
  
  <!------What You Can Do In Expo Section Start----------  -->
  <div class="fcr" id="top2" style="width: 100%; height: 371px;">
    <div class="fcr1">
      <h2 style="text-shadow: -4px -1px 2px #f4c430 !important">What You Can Do In Expo</h2>
    </div>
  </div>
  <section class="features">
    <div class="container">
      <div class="row">
        <div class="col-lg-4 col-12">
          <div class="features-post">
            <div class="features-content">
              <div class="content-show">
                <h4><i class="fa fa-pencil"></i>Live Chat & Counselling</h4>
              </div>
              <div class="content-hide">
                <p>One-to-one chat sessions with our university representatives</p>
                <p class="hidden-sm">One-to-one chat sessions with our university representatives.</p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-12">
          <div class="features-post second-features">
            <div class="features-content">
              <div class="content-show">
                <h4><i class="fa fa-graduation-cap"></i>Free Webinars & Live Talk Session</h4>
              </div>
              <div class="content-hide">
                <p>Attend live presentations and get info about different fields of studies including Medical, Engineering, IT, Business, Sciences, Arts and Designs.</p>
                <p class="hidden-sm">Attend live presentations and get info about different fields of studies including Medical, Engineering, IT, Business, Sciences, Arts and Designs.</p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-12">
          <div class="features-post third-features">
            <div class="features-content">
              <div class="content-show">
                <h4><i class="fa fa-book"></i>Scholarship & Fee Waiver Opportunity </h4>
              </div>
              <div class="content-hide">
                <p>Discuss with university representatives to get details on financing your study</p>
                <p class="hidden-sm">Discuss with university representatives to get details on financing your study.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
<!-- --------------What You Can Do In Expo Section End------------------ -->

<!-- --------------Lets Keep In Touch Section Start--------------------- -->
  <section class="section contact" id="top3" data-section="section6">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="section-heading">
            <h2>Let’s Keep In Touch</h2>
          </div>
        </div>
        <div class="col-md-6">
          <div class="w3-content w3-display-container">
            <div class="video-1">
              <video width="100%" height="100%" controls="controls" autoplay="autoplay" muted="muted" playsiline>
                <source src="assets\images\video2.mp4" type="video/mp4" style="z-index: -1;object-fit: cover;" autobuffer autoplay loop muted>
              </video>
            </div>
            <div class="video-2">
              <video width="100%" height="100%" controls="controls" autoplay="autoplay" muted="muted" playsinline>
                <source src="assets\images\video3.mp4" type="video/mp4" style="z-index: -1;object-fit: cover;" autobuffer autoplay loop muted>
              </video>
            </div>
            <button class="w3-button w3-black w3-display-left" id="hide" onclick="plusDivs(-1)">&#10094;</button>
            <button class="w3-button w3-black w3-display-right" id="show" onclick="plusDivs(1)">&#10095;</button>
          </div>
        </div>
        <div class="col-md-6">
          <div class="footer1">
            <h2> Get In Touch</h2>
            <a href="mailto:info@qstudy.co"> info@qstudy.co</a>
          </div>
          <div class="footer2">
            <h2> Our Office Location</h2>
          </div>
          <div class="smflag">
            <img src="assets\images\flag-malaysia.png" >
            <img src="assets\images\flag-india.png" style="">
            <img src="assets\images\flag-indonesia.png" style="">
            <img src="assets\images\flag-maldives.png" style="">
            <img src="assets\images\flag-sri-lanka.png" style="">
            <img src="assets\images\flag-dubai.png" style="">
         </div>
        </div>
      </div>
    </div>
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="footer3">
            <h2> Speak To Our Counsellors From</h2>
          </div>
          <div class="smflag1">
            <img src="assets\images\flag-of-India.png">
            <img src="assets\images\flag-of-china.png">
            <img src="assets\images\flag-of-Egypt.png">
            <img src="assets\images\flag-of-Indonesia.png">
            <img src="assets\images\flag-of-Kenya.png">
            <img src="assets\images\flag-of-Malaysia.png">
            <img src="assets\images\flag-of-Maldives.png">
            <img src="assets\images\flag-of-Morocco.png">
            <img src="assets\images\flag-of-Pakistan.png">
            <img src="assets\images\flag-of-Saudi-Arabia.png">
            <img src="assets\images\flag-of-Sri-Lanka.png">
            <img src="assets\images\flag-of-Thailand.png">
            <img src="assets\images\flag-of-Uzbekistan.png">
          </div>
        </div>
      </div>
    </div>
  </section>
<!-- ------------------Lets Keep In Touch Section End--------------- -->

<!-- ------------------Copyright Section Start---------------------- -->
  <footer>
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <p><i class="fa fa-copyright"></i> Copyrights © 2020 Q Study. All rights reserved. 
            <a href="https://www.qstudy.co/privacy-policy.html" rel="sponsored" target="_parent">Privacy Policy</a>
          </p>
        </div>
      </div>
    </div>
  </footer>
<!----------------------Copyright Section End ---------------------  -->

</div>
     <!-- Scripts -->
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <script src="assets/js/isotope.min.js"></script>
    <script src="assets/js/owl-carousel.js"></script>
    <script src="assets/js/lightbox.js"></script>
    <script src="assets/js/tabs.js"></script>
    <script src="assets/js/video.js"></script>
    <script src="assets/js/slick-slider.js"></script>
    <script src="assets/js/custom.js"></script>


<script type="text/javascript">
    $("#show").click(function () {
        $(".video-1").hide();
    });

    $("#show").click(function () {
        $(".video-2").show();
    });
    $("#hide").click(function () {
        $(".video-1").show();
    });
    $("#hide").click(function () {
        $(".video-2").hide();
    });

////Save User Information Start---->
    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;

        return true;
    }

    function SaveRecord() {
        var name = $("#name").val();
        var email = $("#email").val();
        var phoneNo = $("#phonenumber").val();
        var atpos = email.indexOf("@");
        var dotpos = email.lastIndexOf(".");
        var countryCode = $('#txtCountryNameFlag').val();

        if (name == "") {
            alert("Please Enter Name. !");
            $("#name").focus();
            return false;
        }
        else if (email == "") {
            alert('Please Enter Email Address !');
            $('#email').focus();
            return false;
        }
        else if (countryCode == "") {
            alert('Please Enter Country Code !');
            $('#txtCountryNameFlag').focus();
            return false;
        }
        else if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
            alert('Please Enter Valid Email Address !');
            $('#email').focus();
            return false;
        }
        else if (phoneNo == "") {
            alert("Please Enter Phone No. !");
            $("#phonenumber").focus();
            return false;
        }
        document.getElementById("formsubmit").disabled = true;
        document.getElementById("formsubmit").value = 'Please wait..';
        $.ajax({
            type: "POST",
            url: "QSLanding.aspx/SaveRecord",
            data: "{'name':'" + name + "', 'email':'" + email + "','countryCode':'" + countryCode+"', 'phoneNo':'" + phoneNo + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var result = response.d;
                if (result == "S") {
                    alert("Record Save Successfully !!");
                    document.getElementById("formsubmit").disabled = false;
                    document.getElementById("formsubmit").value = 'REGISTER';
                    return false;
                }
                else if (result == "D") {
                    alert('This EmailID is already Exist !!!');
                    document.getElementById("formsubmit").disabled = false;
                    document.getElementById("formsubmit").value = 'REGISTER';
                    return false;
                }
                else {
                    alert('Something Went Wrong !!!');
                    document.getElementById("formsubmit").disabled = false;
                    document.getElementById("formsubmit").value = 'REGISTER';
                    return false;
                }
            },
            error: function (data) {
                alert('Something Went Wrong !!!');
                document.getElementById("formsubmit").disabled = false;
                document.getElementById("formsubmit").value = 'REGISTER';
                return false;
            }
        });
    }


////End----->
</script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/> 
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.js"></script>
   <%-- <style>
         .ui-menu-item{
    -webkit-box-shadow:0 0 0 50px gray inset !important; /* Change the color to your own background color */
    -webkit-text-fill-color: #fff !important;
}
    </style>--%>
    <script lang="javascript" type="text/javascript">

        $(function () {

            $('#txtCountryNameFlag').autocomplete({

                source: function (request, response) {
                    $.ajax({
                        url: "QSLanding.aspx/bindCountryFlag",
                        data: "{'pre' :'" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {

                                return {
                                    CountryName: item.CountryName,
                                    CountryFlag: item.CountryFlag,
                                    CountryMobCode: item.CountryMobCode,
                                    MobileNoLength: item.MobileNoLength,
                                    json: item
                                }

                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert(textStatus);
                        }
                    });
                },
                focus: function (event, ui) {
                    // this is for when focus of autocomplete item 
                    $('#txtCountryNameFlag').val(ui.item.CountryName);
                    return false;
                },
                select: function (event, ui) {
                    // this is for when select autocomplete item
                    $('#txtCountryNameFlag').val(ui.item.CountryMobCode),
                        $('#imgflag').css("display", "block")
                    $('#imgflag').attr('src', '/imgCountryFlag/' + ui.item.CountryFlag),
                        $('#txtcountry').val(ui.item.CountryName),
                        $("#phonenumber").val(""),
                        $("#phonenumber").attr('maxlength', ui.item.MobileNoLength),
                        $('#txtCountryNameFlag').attr('autocomplete', 'off');
                    return false;
                },
                minLength: 1

            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                // here return item for autocomplete text box, Here is the place 
                // where we can modify data as we want to show as autocomplete item
                return $("<li>")
                    .append("<a style='padding-left:40px; background-image:url(/imgCountryFlag/" + item.CountryFlag + ");" +
                        "background-repeat:no-repeat;background-position:left center;' >" + item.CountryName + "</a>").appendTo(ul);
            };
        });

        function BindCurrentCountryCode() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "QSLanding.aspx/GetCountryName",
                data: "{}",
                cache: false,
                async: false,
                dataType: "json",
                success: function (data) {
                    var myData = data.d;
                    $("#txtCountryNameFlag").val(myData[0]["CountryMobCode"]),
                        $('#imgflag').css("display", "block"),
                        $('#imgflag').attr('src', '/imgCountryFlag/' + myData[0]["CountryFlag"]),
                        $('#txtcountry').val(myData[0]["CountryName"]),
                        $("#phonenumber").val(""),
                        $("#phonenumber").attr('maxlength', myData[0]["MobileNoLength"]);
                },

                error: function (result) {
                    alert("Error");
                }
            });
        }
        $(document).ready(function () {
            BindCurrentCountryCode();
        });

        function clearImage() {
            $('#imgflag').css("display", "none");
            $('#txtCountryNameFlag').val("");

        }
    </script>
</body>
</html>

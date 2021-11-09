<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ASIA.aspx.cs" Inherits="ASIA" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <meta charset="utf-8">
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'/>
    
    <title>QStudy</title>
     
<!-- Latest compiled and minified CSS -->
<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Optional theme -->

<!-- Libraries CSS -->
<link href="css/style.css" type="text/css" rel="stylesheet">
<link href="css/all.css" type="text/css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Pragati+Narrow:wght@400;700&display=swap" rel="stylesheet">


        <!-- 2nd code-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"></script>
    <!--end -->

    

</head>
<body>
 <%--   <form id="form1" runat="server">--%>
   <header>
    <div class="container-fluid">
        <div class="main_header" id="registrationHeader">
            <div class="main_header_left">
               <!-- <a href="#" class="logo"><img src="img/logo2.png" alt="logo"></a>-->
                 <a href="#" class="logo2"><img src="img/new_logo.png" alt="logo"></a>
            </div>
             <div class="main_header_right">
                 <h3>Expo Registration</h3>
                 <h3>Free Admission</h3>              
                 <p>Event Time:27th</p>
             </div>
        </div>
    </div>
</header>
<section class="regis_section">
        <div class="container-fluid">
        <div class="row">
            <div class=" col-md-6 col-lg-6">
                <div id="demo" class="carousel slide" data-ride="carousel">

  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
    <li data-target="#demo" data-slide-to="3"></li>
  </ul>
  
  <!-- The slideshow -->
  <div class="carousel-inner regis_slider">
          
      <div class="carousel-item active">
      <img src="img/Rectangle3.jpg" alt="banner" />
    </div>
    <div class="carousel-item">
      <img src="img/Rectangle0.jpg" alt="banner" />
    </div>
    <div class="carousel-item">
      <img src="img/Rectangle1.jpg" alt="banner" />
    </div>
    <div class="carousel-item">
      <img src="img/Rectangle2.jpg" alt="banner" />
    </div>
      
  </div>
  
  <!-- Left and right controls -->
  <!--
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>-->
</div>

            </div>
            <div class=" col-md-6 col-lg-6">
                 <div class="regis_form">
                    <div class="" id="form2">
                        <label for="name">full name</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                        <input type="text" class="form-control" id="txtname" placeholder="Enter your full name here" name="neme">
                        <label for="email">Gender</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                        <div class="hhh">
                        <div class="select_box">
                         <select class="slect_item" id="gn">
                               <option>Select</option>
                               <option>Male</option>
                               <option>Female</option>
                              <%-- <option>Other</option>--%>
                           </select>
                       </div>
                   </div>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                            <label for="country code">country code</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                             <div class="hhh">
                        <div class="select_box  custom-border">
                            <!-- <select class="slect_item" id="ccode">                              
                           </select> -->
                            
                            <input name="phone" type="text" class="form-control mb-2 inptFielsd" id="phone"
               placeholder="Phone Number" style="display:none" />
                            
                                                  
                       </div>
                       </div>
                        </div>
                        <div class="col-md-8 col-sm-8">
                           <label for="number">mobile number</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                           <input class="form-control m_num numeric" id="txtno" placeholder="000 000 000 0000" maxlength="13"/>
                        </div>
                        </div>
                         <label for="messeging">select platform you use</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                          <div class="hhh">
                        <div class="select_box">
                            <select class="slect_item" id="msgplate" multiple="multiple" >                              
                           </select>
                       </div>
                   </div>
                         <label for="email">Email address</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                        <input type="email" class="form-control" id="txtemail" placeholder="Enteryouremail@mail.com" name="email">
                        <div class="row">
                        <div class="col-sm-6">
                         <label for="name">country</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                        <input type="text" class="form-control" id="txtcountry" placeholder="country" name="neme">
                    </div>
                    <div class="col-sm-6">
                         <label for="name">city</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                    <input type="text" class="form-control" id="txtst" placeholder="city" name="neme">
                </div>
            </div>
                       <a href="javascript:void()" class="registration_btn"> <button type="button" class="btnn btnblue btn-block" 
                        onclick="gotoNextStep()">next</button></a>
                      </div>


                       <div class="" id="form3" style="display:none;">
                        <label for="email">current highest qualification</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                         <div class="hhh">
                        <div class="select_box">
                             <select class="slect_item" id="hq" multiple="multiple" >                              
                           </select>                       
                       </div>
                   </div>
                         <label for="messeging">what course are you looking for</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                          <div class="hhh">
                        <div class="select_box">
                             <select class="slect_item" id="ddcourse" multiple="multiple" >                              
                           </select>                         
                       </div>
                   </div>
                           <div class="hhh">
                               <div class="select_box">
                        <input type="text" class="form-control" id="txtOtherCourse" style="display:none" placeholder="Other course" name="neme" />
                               </div>
                           </div>
                         <label for="text">IELTS/TOEFL</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                         <div class="radio_buttons">
                             <input type="radio" name="status" checked="checked" id="RdbIeltsYes" onclick="CheckIelts();" value="Yes" class="radio_registration"/>
                                            Yes
                                            <input type="radio" id="RdbIeltsNo" onclick="CheckIelts();" name="status" value="No" class="radio_registration"/>
                                            No                          
                      </div>
                           <input type="text" class="form-control" id="txtscore" placeholder="Enter your score here" name="" />
                             <label for="text">Are you planning to study abroad?</label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                         <div class="radio_buttons">
                             <input type="radio" name="Abroad" id="RdbAbYes" checked="checked" value="Yes" class="radio_registration"/>
                                            Yes
                                            <input type="radio" id="RdbAbNo" name="Abroad" value="No" class="radio_registration"/>
                                            No                          
                      </div>
                      <label for="email">What fee range are you looking at? </label><sup><i class="fas fa-star-of-life mendet"></i></sup>
                        <div class="hhh">
                        <div class="select_box">
                         <select class="slect_item" id="ddlFee">       
                             <option value="0"> Select</option>                        
                               <option value="USD 2,000 to USD 3,000 per year"> USD 2,000 to USD 3,000 per year</option>
                               <option value="USD 3,000 to USD 4,000 per year"> USD 3,000 to USD 4,000 per year</option>
                             <option value="USD 4,000 to USD 5,000 per year"> USD 4,000 to USD 5,000 per year</option>
                               <option value="USD 5,000 to USD 6,000 per year"> USD 5,000 to USD 6,000 per year</option>
                             <option value="I am ok with any fee/ any fee is fine">I am ok with any fee/ any fee is fine</option>
                              
                           </select>
                       </div>
                   </div>
                        
                        <a href="javascript:void()" class="registration_btn">  <button type="button" id="btnsave" class="btnn btnblue btn-block">
                                                    SUBMIT
                                                </button> <%--<button type="button" class="btnn btnblue btn-block" 
                        onclick="gotoNextStep()">SUBMIT</button>--%></a>
                        <button type="button" class="btnn back_button"  onclick="onbackclick()">BACK</button>



                       <!-- <a href="#" class="registration_btn"> 
                        <button type="button" class="btn btn-block" onclick="gotoNextStep()">BACK</button></a> -->
                      </div>
                </div>

            </div>
        </div>
    </div>
</section>

        <!-- JAVASCRIPT CODE REQUIRED -->
        <script>
            var input = document.querySelector("#phone");
            window.intlTelInput(input, {
                separateDialCode: true,
                customPlaceholder: function (
                    selectedCountryPlaceholder,
                    selectedCountryData
                ) {
                    return "e.g. " + selectedCountryPlaceholder;
                },
            });
        </script>

        <script src="js/jquery-1.11.1.js"></script>
<script type="text/javascript">

    function CheckIelts() {
        if (document.getElementById('RdbIeltsYes').checked == true) {
            document.getElementById("txtscore").style.display = 'block';
        }
        if (document.getElementById('RdbIeltsNo').checked == true) {
            document.getElementById("txtscore").style.display = 'none';
        }
    }


    function gotoNextStep() {

        var name = $('#txtname').val();
        var phoneno = $('#txtno').val();
        var emailid = $('#txtemail').val();
        var atpos = emailid.indexOf("@");
        var dotpos = emailid.lastIndexOf(".");


        var msgplateCount = 0;
        var x = document.getElementById("msgplate");
        for (var i = 0; i < x.options.length; i++) {
            if (x.options[i].selected == true) {
                msgplateCount = Number(msgplateCount) + Number(1);
            }
        }

        if (name == "") {
            alert('Please Fill Full Name !!!');
            $('#txtname').focus();
            return false;
        }
        else if ($("#gn").val() == "Select") {
            alert('Please Select Gender !!!');
            $('#gn').focus();
            return false;
        }
        else if (phoneno == "") {
            alert('Please Fill Mobile No. !!!');
            $('#txtno').focus();
            return false;
        }
        else if (msgplateCount == 0) {
            alert('Please Select Platform You Use !!!');
            return false;
        }

        else if (emailid == "") {
            alert('Please Fill Email Address !!!');
            $('#txtemail').focus();
            return false;
        }
        else if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= emailid.length) {
            alert('Please Fill Valid Email Address !!!');
            $('#txtemail').focus();
            return false;
        }
        else if ($('#txtcountry').val() == "") {
            alert('Please Fill Country !!!');
            $('#txtcountry').focus();
            return false;
        }
        else if ($('#txtst').val() == "") {
            alert('Please Fill City !!!');
            $('#txtst').focus();
            return false;
        }

        $('#registrationHeader').addClass('step2')
        $('#form2').fadeOut('slow');
        $('#form3').fadeIn('slow');
    }

    function onbackclick() {
        $('#registrationHeader').removeClass('step2')
        $('#form2').fadeIn('slow');
        $('#form3').fadeOut('slow');
    }

</script>
<%--      <link href="css/jquery.multiselect.css" rel="stylesheet" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> 
<script src="js/multiselect-checkbox/jquery.multiselect.js"></script>
<script>
$('select[multiple]').multiselect({
    //columns: 2,
    placeholder: 'Select options'
});
</script>--%>

    <script type="text/javascript">
        $(document).ready(function () {
            msgplate();
            hql();
            dcourse();
           // dcode();
            $('.numeric').keypress(function (e) {
                return numeric(e);
            });

            function numeric(e) {
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {

                    //                        $("#error").html("Digits Only").show().fadeOut("50000");
                    return false;
                }
            }
        });

        function msgplate() {
            //$("#msgplate").empty();
            //$('#msgplate option').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "registration.aspx/c_bindmsg",
                data: "{}",
                cache: false,
                async: false,
                dataType: "json",
                success: function (data) {
                    //$("#msgplate").append($("<option></option>").val('0').html('--- Select ---'));
                    $.each(data.d, function (key, value) {
                        $("#msgplate").append($("<option></option>").val(value.msgid).html(value.msgname));
                    });
                    //$('#msgplate').val(cid).attr('checked', 'checked');
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }

        function hql() {
            //$("#hq").empty();
            //$("#hq")[0].selectedIndex = -1;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "registration.aspx/c_bindhq",
                data: "{}",
                cache: false,
                async: false,
                dataType: "json",
                success: function (data) {
                    //$("#msgplate").append($("<option></option>").val('0').html('--- Select ---'));
                    $.each(data.d, function (key, value) {
                        $("#hq").append($("<option></option>").val(value.hid).html(value.hname));
                    });
                    //$('#msgplate').val(cid).attr('checked', 'checked');
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }
        function dcourse() {
            //$("#ddcourse").empty();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "registration.aspx/c_binddcourse",
                data: "{}",
                cache: false,
                async: false,
                dataType: "json",
                success: function (data) {
                    //$("#msgplate").append($("<option></option>").val('0').html('--- Select ---'));
                    $.each(data.d, function (key, value) {
                        $("#ddcourse").append($("<option></option>").val(value.cid).html(value.cname));
                    });
                    //$('#msgplate').val(cid).attr('checked', 'checked');
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }

      /*  function dcode() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "registration.aspx/c_binddcode",
                data: "{}",
                cache: false,
                async: false,
                dataType: "json",
                success: function (data) {
                    $("#ccode").append($("<option></option>").val('0').html('--- Select ---'));
                    $.each(data.d, function (key, value) {
                        $("#ccode").append($("<option></option>").val(value.codeid).html(value.countryname));
                    });
                    //$('#msgplate').val(cid).attr('checked', 'checked');
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }*/

    </script>
 <%--       <link href="multiselectcssjs/bootstrap.min.css" rel="stylesheet" />--%>
    <script src="multiselectcssjs/bootstrap.min.js"></script>
    <link href="multiselectcssjs/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="multiselectcssjs/bootstrap-multiselect.js"></script>
         <script type="text/javascript">
           function BindControlEvents() {
               $('[id*=msgplate]').multiselect({
                   includeSelectAllOption: false,
                   nonSelectedText: 'Select Messaging'
               });
             
           }

           function BindControlEvents12() {
               $('[id*=hq]').multiselect({
                   //columns: 2,
                   includeSelectAllOption: false,
                   nonSelectedText: 'Select Qualification'
               });

           }
           function BindControlEvents13() {
               $('[id*=ddcourse]').multiselect({
                   column: 2,
                   includeSelectAllOption: false,
                   nonSelectedText: 'Select Course',
                   onChange: function (option, checked, select) {
                       console.log(option);
                       console.log(checked);
                       console.log(select);
                       // alert('Changed option ' + $(option).val() + '.');
                       // alert('Changed option ' + $(option).length + '.');
                       //alert($("#ddcourse option:selected").length);

                   }
               });

           }
           $(document).ready(function () {
               BindControlEvents();
               BindControlEvents12();
               BindControlEvents13();
               Sys.WebForms.PageRequestManager.getInstance().add_endRequest(BindControlEvents);
               Sys.WebForms.PageRequestManager.getInstance().add_endRequest(BindControlEvents12);
               Sys.WebForms.PageRequestManager.getInstance().add_endRequest(BindControlEvents13);
           });
          

           $('#btnsave').click(function () {
               
               var name = $('#txtname').val();
               var gender = $('#gn').val();
               //var ccode = $('#ccode').val();

               let elements = document.getElementsByClassName('iti__selected-dial-code');
               var ccode = '';
               for (let i = 0; i < elements.length; i++) {
                   ccode = elements[i].innerHTML;
               }

               var phoneno = $('#txtno').val();
               var emailid = $('#txtemail').val();
               var country = $('#txtcountry').val();
               var state = $('#txtst').val();

               if (name == "") {
                   alert('Please Fill Full Name !!!');
                   onbackclick();
                   $('#txtname').focus();
                   return false;
               }
               if (gender == 'Select') {
                   gender = '';
               }
               if (ccode == '0') {
                   ccode = '';
               }
               if (phoneno == "") {
                   alert('Please Fill Mobile No. !!!');
                   onbackclick();
                   $('#txtno').focus();
                   return false;
               }
               if (emailid == "") {
                   alert('Please Fill Email Address !!!');
                   onbackclick();
                   $('#txtemail').focus();
                   return false;
               }


               var hqCount = 0;
               var x = document.getElementById("hq");
               for (var i = 0; i < x.options.length; i++) {
                   if (x.options[i].selected == true) {
                       hqCount = Number(hqCount) + Number(1);
                   }
               }
               var CourseCount = 0;
               var x = document.getElementById("ddcourse");
               for (var i = 0; i < x.options.length; i++) {
                   if (x.options[i].selected == true) {
                       CourseCount = Number(CourseCount) + Number(1);
                   }
               }
               if (hqCount == 0) {
                   alert('Please Select Current Highest Qualification !!!');
                   return false;
               }
               if (CourseCount == 0) {
                   alert('Please Select What Course Are You Looking For !!!');
                   return false;
               }



               var txtscore = $('#txtscore').val();
               var status = $('input[name=status]:checked').val();
               if (status == 'undefined') {
                   status = '';
               }
               else if (status == 'Yes') {
                   if (txtscore == "") {
                       alert('Please Fill Your Score !!!');
                       $('#txtscore').focus();
                       return false;
                   }
               }
               debugger;
               var msg = ''; var msgid = '';
               var x = document.getElementById("msgplate");
               for (var i = 0; i < x.options.length; i++) {
                   if (x.options[i].selected == true) {
                       msg += x.options[i].text + ",";
                       msgid += x.options[i].value + ",";
                   }
               }

               var hq = ''; var hqid = '';
               var xx = document.getElementById("hq");
               for (var i = 0; i < xx.options.length; i++) {
                   if (xx.options[i].selected == true) {
                       hq += xx.options[i].text + ",";
                       hqid += xx.options[i].value + ",";
                   }
               }

               var course = ''; var courseid = '';
               var xxx = document.getElementById("ddcourse");
               for (var i = 0; i < xxx.options.length; i++) {
                   if (xxx.options[i].selected == true) {
                       course += xxx.options[i].text + ",";
                       courseid += xxx.options[i].value + ",";
                   }
               }

               var xxx = document.getElementById("ddcourse");
               for (var i = 0; i < xxx.options.length; i++) {
                   if (xxx.options[i].selected == true && xxx.options[i].text.trim().toUpperCase() == "OTHER COURSES") {
                       course = document.getElementById("txtOtherCourse").value;
                       courseid = "";
                   }
               }


               if ($("#ddcourse option:selected").length > 3) {
                   alert('You can select upto 3 courses only');
                   return false;
               }





               var Abroad = '';
               if (document.getElementById('RdbAbYes').checked == true)
                   Abroad = "Yes";
               else if (document.getElementById('RdbAbNo').checked == true)
                   Abroad = "No";

               var Fee = $("#ddlFee").val();

               if (Fee == '0') {
                   alert('What Fee Range Are You Looking At?');
                   return false;
               }


               document.getElementById("btnsave").disabled = true;
               document.getElementById("btnsave").innerHTML = 'Please wait..';
               $.ajax({
                   type: "POST",
                   url: "ASIA.aspx/insertion",
                   data: "{'name':'" + name + "','gender':'" + gender + "','ccode':'" + ccode + "','phoneno':'" + phoneno + "','emailid':'" + emailid + "','country':'" + country + "','state':'" + state + "','txtscore':'" + txtscore + "','msg':'" + msg + "','msgid':'" + msgid + "','hq':'" + hq + "','hqid':'" + hqid + "','course':'" + course + "','courseid':'" + courseid + "','Abroad':'" + Abroad + "','Fee':'" + Fee + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (response) {
                       var sts = response.d;                      
                       if (sts == "S") {
                           window.location.href = "thanks.html";
                           //alert('Registration Successfully !!!');

                           $('#msgplate').multiselect('deselectAll', false);
                           $('#msgplate').multiselect('updateButtonText');

                           $('#hq').multiselect('deselectAll', false);
                           $('#hq').multiselect('updateButtonText');

                           $('#ddcourse').multiselect('deselectAll', false);
                           $('#ddcourse').multiselect('updateButtonText');
                           reset();
                           document.getElementById("btnsave").disabled = false;
                           document.getElementById("btnsave").innerHTML = 'SUBMIT';
                           msgplate();
                           hql();
                           dcourse();
                           onbackclick();

                       }
                       else {
                           alert(response.d);
                       }
                   },
                   failure: function (xhr, errorType, exception) {
                       alert(jQuery.parseJSON(xhr.responseText));
                   }
               });

               //PageMethods.insertion(name, gender, ccode, phoneno, emailid, country, state, txtscore, msg, msgid, hq, hqid, course, courseid, OnSucces, OnError);
               //function OnSucces(response) {
               //    if (response == 1) {
               //        alert('Registration Successfully !!!');
               //        reset();
               //    }
               //    else {
               //        alert(response);
               //    }
               //}
               //function OnError(response) {
               //    alert(response);
               //}

           });

           function reset() {
               $('#txtname').val("");
               $('#txtcountry').val("");
               $('#txtemail').val("");
               $('#txtst').val("");
               $('#txtno').val("");
               $('#txtscore').val("");
               $('#gn').val(0);
              // $('#ccode').val(0);
               $('input:radio[name=status]')[0].checked = false;
               $('input:radio[name=status]')[1].checked = false;              
           }

         

           $("#ddcourse").change(function () {

               var count = $("#ddcourse option:selected").length;

               if (count >= 3) {
                   for (var i = 0; i < this.options.length; i++) {
                       var option = this.options[i];
                       if (option.selected) {

                           //msg.html("Please select only two options.");
                       } else {
                           option.selected = false;
                           option.disabled = true;
                       }
                   }
               }
               else {
                   for (var i = 0; i < this.options.length; i++) {
                       var option = this.options[i];
                       if (option.selected) {
                           //msg.html("Please select only two options.");
                       } else {
                           //option.selected = true;
                           option.disabled = false
                       }
                   }
               }

               $('#ddcourse').multiselect('refresh');

             /*  if ($("#ddcourse option:selected").length > 3) {
                   alert('You can select upto 3 courses only');
                   return false;
               }*/

              var xxx = document.getElementById("ddcourse");
               for (var i = 0; i < xxx.options.length; i++) {
                   if (xxx.options[i].selected == true) {
                       var OtherCorse = xxx.options[i].text;
                       if (OtherCorse.trim().toUpperCase() == "OTHER COURSES") {
                           document.getElementById('txtOtherCourse').style.display = 'block';

                           for (var i = 0; i < this.options.length-1; i++) {
                               var option = this.options[i];
                               if (option.selected) {
                                   option.selected = false;
                                   $('#ddcourse').multiselect('refresh');
                                   //msg.html("Please select only two options.");
                               }
                           }

                       }
                       else {
                           document.getElementById('txtOtherCourse').style.display = 'none';
                       }
                   }
               }

           });

          

             // ddcourse






    </script>
    <style>

        .select_box:after {
            border-top: 0px solid #003F88 !important;
        }
        .btn {
            display: inline-block;
            font-weight: 400;
            color: #212529;
            text-align: left !important;
            vertical-align: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            background-color: transparent;
            /* border: 1px solid transparent; */
            padding: -0.625rem .75rem;
            font-size: 1rem;
            line-height: 1.1 !important;
            border-radius: 0.25rem;
            transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
            width: 100% !important;
            border: 1px solid;
        }
        .multiselect-container > li {
            padding: 0px;
            margin-left: -27px !important;
        }
       .dropdown-menu.show {
    display: block;
    width: 100% !important;
    overflow:auto !important;
    height:230px !important;
}
       .regis_form input {
   /* height: 12px !important;*/
}
       .btnn{text-align: center;
    vertical-align: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-color: transparent;
    border: 1px solid transparent;
    padding: .375rem .75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: .25rem;font-size: 20px !important;}

        .custom-border{
    box-shadow: 0 1px 0px #003f88;
    padding-bottom: 3px;
    border-radius: 4px;
       }
    </style>
   <%-- </form>--%>
</body>
</html>

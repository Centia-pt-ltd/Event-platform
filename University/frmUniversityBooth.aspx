<%@ Page Title="" Language="C#" MasterPageFile="~/university/MasterPageUniversity.master" AutoEventWireup="true" CodeFile="frmUniversityBooth.aspx.cs" Inherits="university_frmUniversityBooth" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<%--<link href="css/style.css" type="text/css" rel="stylesheet" />--%>
<link href="css/styleBooth.css" type="text/css" rel="stylesheet"/>
<link href="css/all.css" type="text/css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Pragati+Narrow:wght@400;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

    <asp:HiddenField ID="hdfUserId" runat="server" />
    <asp:HiddenField ID="hdfBid" runat="server" />
    <asp:HiddenField ID="hdfUid" runat="server" />
    <div class="container-fluid">
     
  <div>
      <div>
        <%--  <audio src="img/Wavecont-Inspire-2-Full-Lenght.mp3" typeof="audio/mpeg" preload="auto"  autoplay="autoplay" loop="loop">
            </audio>--%>
    
      </div>
    <select class="form-control col-md-4" id="ddlSearch" name="category" style="display:none;">
        <option value="">All Booths</option>
        <option>No Categories</option>

    </select>
  </div>
     <div class="booth_icon" id="allBooth" >
    
  </div>


</div>



       <script type="text/javascript">

           function BindGrid(Uid) {
               //$("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');

               $.ajax({
                   type: "POST",
                   url: "frmUniversityBooth.aspx/GetAllBooth",
                   data: "{'Uid':'" + Uid + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (data) {
                       var len = data.d.length;
                       $("#allBooth").empty();
                       var item = '';
                       if (len > 0) {
                           var id = '';
                           var uniId = '0';
                           var count = 0;
                           var mod = len % 3;
                           var did = 0;
                           for (var i = 0; i < len; i++) {
                               uniId=data.d[i].UniversityId
                               did = did + 1;
                               if (count==0) {
                                   item += "<div class='row boothrow'>";
                               }
                               if (count < 3) {
                                   item += "<div class='col-md-4 col-lg-4 booth-item'>";
                               }
                              
                              
                               id = data.d[i].Id;
                               if (uniId == $("#ContentPlaceHolder1_hdfUid").val())  {
                                   item += "<a href='javascript:void(0);'data-toggle='modal' onclick='return GetEditData(" + id + "," + $("#ContentPlaceHolder1_hdfUid").val()+");'>";
                                   item += "<img src='AllBooth/img/" + data.d[i].BoothImage + "' alt='apu'/>";
                                   item += "<div class='booth_img_box" + did + "'></div>";
                                   item += "</a>";
                                   item += "<label for='info' class='manag_label'>Your Booth</label>";
                               }
                               else {
                                   item += "<a href='javascript:void(0);'data-toggle='modal' onclick='return GetEditData(" + id + "," + $("#ContentPlaceHolder1_hdfUid").val() +");'>";
                                   item += "<img src='AllBooth/img/" + data.d[i].BoothImage + "' alt='apu'/>";
                                   item += "<div class='booth_img_box" + did + "'></div>";
                                   item += "</a>";
                                   
                               }
                               //else {
                               //    item += "<a href='#'>";
                               //    item += "<img src='AllBooth/img/" + data.d[i].BoothImage + "' alt='apu'/>";
                               //    item += "<div class='booth_img_box" + did + "'></div>";
                               //    item += "</a>";
                               //    //item += "<label for='info' style='color:red;' class='manag_label'>BOOKED !!</label>";
                               //}
                                   
                               if(count < 3) {
                                   item += "</div>";

                                   if (i == len - 1 &&  mod > 0) {
                                       for (var j = 1; j < mod; j++) {
                                           item += "<div class='col-md-4 col-lg-4 booth-item'>";
                                           item += "</div>";
                                       }
                                   }
                               }
                               count = count + 1;
                               if (count == 3) {
                                   item += "</div>";
                                   count = 0;
                               }
                               
                           }
                           $("#allBooth").append(item);
                       }
                       else {

                       }
                   },
                   error: function (response) {
                       showMsg("ERROR", "Something went wrong.!");
                       return false;
                   }
               });
           }
           window.onload = BindGrid($("#ContentPlaceHolder1_hdfUid").val());

           function GetEditData(BoothId, UniId) {

               $("#ddlEventName").val('0');
               $("#imgLogo").val('');
               $("#imgBigImage").val('');
               document.getElementById("imgPrevie").src = "img/logo.png";
               document.getElementById("imgPrevimgBigImage").src = "img/logo.png";
               $("#ContentPlaceHolder1_hdfBid").val('');
               document.getElementById("chkActive").checked = false;

               $.ajax({
                   type: "POST",
                   url: "frmUniversityBooth.aspx/GetBoothEditData",
                   data: "{'BoothId':'" + BoothId + "','UniId':'"+UniId+"'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (response) {
                       $("#ddlEventName").val('0');

                       if (response.d[0].SmallImg != '') {
                           document.getElementById("imgPrevie").src = "../UploadedBooth/" + response.d[0].SmallImg;
                       }
                       if (response.d[0].BigImg != '') {
                           document.getElementById("imgPrevimgBigImage").src = "../UploadedBooth/" + response.d[0].BigImg;
                       }

                       if (response.d[0].UniversityId != '0')
                           document.getElementById("chkActive").checked = true;
                       else
                           document.getElementById("chkActive").checked = false;
                       
                       $("#ContentPlaceHolder1_hdfBid").val(response.d[0].Id);
                       $("#myModal").modal("show");
                   },
                   error: function (response) {
                       showMsg("ERROR", "Something went wrong.!");
                   }
               });
               return false;
           }
           function AddUpdateBooth() {

               var EventId = $("#ddlEventName").val();
               var UniversityId = $("#ContentPlaceHolder1_hdfUid").val();
               var BoothId = $("#ContentPlaceHolder1_hdfBid").val();
               var sts = '';

               //if (EventId.trim() == '0') {
               //    showMsg("ERROR", "Please Select Event Name.!");
               //    $("#ddlEventName").focus();
               //    return false;
               //}

               if (document.getElementById('chkActive').checked == true) { sts = "Yes"; }
               else {
                   sts = "No";
                   showMsg("ERROR", "Please Select Checkbox to select booth!");
                   return false;
               }
               document.getElementById("btnSave").disabled = true;
               document.getElementById("btnSave").innerHTML = 'Please wait..';

               $.ajax({
                   type: "POST",
                   url: "frmUniversityBooth.aspx/SaveUpdateBooth",
                   data: "{'EventId':'" + EventId + "','UniversityId':'" + UniversityId + "','sts':'" + sts + "','BoothId':'" + BoothId + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (data) {
                       var sts = data.d;
                       if (sts == "ER") {
                           document.getElementById("btnSave").disabled = false;
                           document.getElementById("btnSave").innerHTML = 'Update';
                           showMsg("ERROR", "Something went wrong.!");
                           $('#myModal').modal('toggle');
                           return false;
                       }
                       
                       else {
                           var ImgSize = "SMALL";
                           // uplaod small img
                           if ($('#imgLogo').val() != '') {
                               var formData = new FormData();
                               formData.append('file', $('#imgLogo')[0].files[0]);
                               $.ajax({
                                   type: 'post',
                                   url: "../SuperAdmin/BoothHandler.ashx?UniversityId=" + UniversityId + "&ImgSize=" + ImgSize,
                                   data: formData,
                                   success: function (status) {
                                   },
                                   processData: false,
                                   contentType: false,
                                   error: function (status) {
                                       document.getElementById("btnSave").disabled = false;
                                       document.getElementById("btnSave").innerHTML = 'Update';
                                       showMsg("ERROR", "Something went wrong, while upload Small image. !");
                                       return false;
                                   }
                               });
                           }
                           // end small img

                           // uplaod big img
                           if ($('#imgBigImage').val() != '') {
                               ImgSize = "BIG";
                               var formData = new FormData();
                               formData.append('file', $('#imgBigImage')[0].files[0]);
                               $.ajax({
                                   type: 'post',
                                   url: "../SuperAdmin/BoothHandler.ashx?UniversityId=" + UniversityId + "&ImgSize=" + ImgSize,
                                   data: formData,
                                   success: function (status) {

                                       document.getElementById("btnSave").disabled = false;
                                       document.getElementById("btnSave").innerHTML = 'Update';
                                       showMsg("SUCCESS", "Data saved successfully.!");
                                       $("#ddlEventName").val('0');
                                       $('#imgLogo').val('');
                                       $("#imgBigImage").val('');
                                       $("#ContentPlaceHolder1_hdfBid").val('');
                                       document.getElementById('imgPrevie').src = 'img/logo.png';
                                       document.getElementById('imgPrevimgBigImage').src = 'img/logo.png';
                                       $('#myModal').modal('toggle');
                                   },
                                   processData: false,
                                   contentType: false,
                                   error: function (status) {
                                       document.getElementById("btnSave").disabled = false;
                                       document.getElementById("btnSave").innerHTML = 'Update';
                                       showMsg("ERROR", "Something went wrong, while upload Big image. !");
                                       $('#myModal').modal('toggle');
                                       return false;
                                   }
                               });
                           }
                           // end big img

                           // update list

                           document.getElementById("btnSave").disabled = false;
                           document.getElementById("btnSave").innerHTML = 'Update';
                           showMsg("SUCCESS", "Data saved successfully.!");
                            $('#myModal').modal('toggle');
                           BindGrid($("#ContentPlaceHolder1_hdfUid").val());
                           $("#ddlEventName").val('0');
                           $('#imgLogo').val('');
                           $("#imgBigImage").val('');
                           $("#ContentPlaceHolder1_hdfBid").val('');
                           document.getElementById('imgPrevie').src = 'img/logo.png';
                           document.getElementById('imgPrevimgBigImage').src = 'img/logo.png';
                           

                           return false;

                           // end update list
                       }
                   },
                   error: function (data) {
                       document.getElementById("btnSave").disabled = false;
                       document.getElementById("btnSave").innerHTML = 'Update';
                       $('#myModal').modal('toggle');
                       showMsg("ERROR", "Something went wrong.!");
                       return false;
                   }
               });
           }
           function ValidateFileUpload(eleId) {
               var fuData = document.getElementById(eleId);
               var FileUploadPath = fuData.value;

               //To check if user upload any file
               if (FileUploadPath == '') {
                   showMsg("ERROR", "Please upload an image");

               } else {
                   var Extension = FileUploadPath.substring(
                       FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

                   //The file uploaded is an image

                   if (Extension == "gif" || Extension == "png" || Extension == "bmp"
                       || Extension == "jpeg" || Extension == "jpg" || Extension == "jfif") {

                       // To Display
                       if (fuData.files && fuData.files[0]) {
                           var reader = new FileReader();
                           reader.onload = function (e) {
                               if (eleId == 'imgLogo')
                                   $('#imgPrevie').attr('src', e.target.result);
                               else if (eleId == 'imgBigImage')
                                   $('#imgPrevimgBigImage').attr('src', e.target.result);
                           }
                           reader.readAsDataURL(fuData.files[0]);
                       }

                   }

                   //The file upload is NOT an image
                   else {
                       showMsg("ERROR", "Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. ");
                       document.getElementById(eleId).value = '';
                   }
               }
           }  
           function BindEvent() {

               $.ajax({
                   type: "POST",
                   url: "frmUniversityBooth.aspx/BindEvent",
                   data: "{}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (response) {
                       if (response.d == "ER") {
                           showMsg("ERROR", "Something went wrong.!");
                       }
                       else {
                           $("#ddlEventName").html(response.d);
                       }
                   },
                   error: function (response) {
                       showMsg("ERROR", "Something went wrong.!");
                   }
               });
               return false;
           }
           window.onload = BindEvent();
       </script>
    <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
            <h4>Booth Details</h4>
          <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
          
        </div>
        
        <div class="modal-body">
  <%--  <div class="mform">--%>
                        <div class="form-group" style="display:none;">
                             <label for="txtEventName" class="manag_label">Event Name</label>
                            <select id="ddlEventName" class="form-control"></select>
                          </div>
                    <div class="form-group">
                             <label for="imgLogo" class="manag_label">Logo(200W X 130H) </label>
                              <input type="file" id="imgLogo" onchange="ValidateFileUpload(this.id);" />
                        <img src="img/logo.png" height="100" id="imgPrevie" alt="prvw" />
                          </div>
                    <div class="form-group">
                             <label for="imgLogo" class="manag_label">Banner(300W X 150H)</label>
                              <input type="file" id="imgBigImage" onchange="ValidateFileUpload(this.id);" />
                        <img src="img/logo.png" height="100" id="imgPrevimgBigImage" alt="prvw" />
                          </div>
                    
                    <div class="form-group">
                        <input type="checkbox" id="chkActive" checked="checked" />
                             <label for="chkActive" class="manag_label">Assign To My University</label>
                              
                          </div>
            </div>
                <%-- </div>--%>
        <div class="modal-footer">
           <a href="javascript:void();" id="btnSave" onclick="return AddUpdateBooth();" class="btn btn-success" style="margin: 0;">Update</a>

          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
</asp:Content>


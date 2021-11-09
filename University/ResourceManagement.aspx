<%@ Page Title="" Language="C#" MasterPageFile="~/University/MasterPageUniversity.master" AutoEventWireup="true" CodeFile="ResourceManagement.aspx.cs" Inherits="University_ResourceManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <style>
/* Style the tab */
.tab {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField ID="hdfUserId" runat="server" />
    <asp:HiddenField ID="hdfUniversityId" runat="server" />
      <div style="overflow:auto;max-width:100%;max-height:calc(100vh - 100px);">   
    <div class="rows d-flex"> 
                <div class="col-sm-3 aboutus upload">
                    <h2>About us <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></h2><span style="color:red">(Maximum 2500 Characters)</span><br /><br />
                    
                    <textarea id="txtAboutDetails" style="text-align:left" name="txtAboutDetails" rows="8" cols="35" maxlength="2500" onkeypress="CountRemain()">
                     
                    </textarea><br />
                    <span>Remaining characters: <span id="lbldisplay"></span></span><br />
                    <button type="button" id="btnSaveAbout" class="btn btn-succes" onclick="return SaveAbout();">Save</button><br />
                    <button type="button" class="btn btn-success" onclick="return ShowEditResourse();">Go To Uploaded Data</button><br />
                    
                </div>
                <div class="col-sm-3 uploadphoto upload">
                    <h2>upload photo <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></h2>
                    <span style="color:red">(File type .GIF, .PNG, .JPG, .JPEG and .BMP only)</span><br />
                    <span style="color:red">(Maximum size 1MB/image.)<br /> (Dimensions width=600px and height=300px)</span> <br />
                    <span><input type="file" name="" id="imgUpload1" onchange="return ValidateFileUpload(this.id)" /></span>
                    <input type="submit" value="upload" class="btn btn-succes" id="btnImageUpload" onclick="return UploadImage();" />
                </div>
                <div class="col-sm-3 uploadbrochar upload">
                    <h2>upload brochure <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></h2>
                    <span style="color:red">(File type .PDF only)</span><br />
                    <span style="color:red">(Maximum size 5MB/file. )</span> <br />
                    <br />
                    <span><span id="spnBr1"><input maxlength="100" onchange="CheckBrochureDuplicate('brochure1','brTitle1');" type="text" id="brTitle1" placeholder="Title/Name max(100 characters)" /></span><input type="file" id="brochure1" onchange="return ValidatePDFUpload(this.id)" /></span>
                    
                    <input type="submit" value="upload" class="btn btn-succes"  id="btnUploadBrochure" onclick="return UploadBrochure();"/>
                </div>
                <div class="col-sm-3 uploadvideo upload">
                    <h2>upload video <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></h2>
                    <span style="color:red">(youtube video url only)</span><br /><br />
                    <input maxlength="100" type="text" id="YtvTitle1" placeholder="Title/Name max(100 characters)" />
                    <input type="text" placeholder="Enter url1" id="txtVideoUrl1" style="width:auto" /> 
                    <button type="button" id="btnUploadVideos" class="btn btn-succes" onclick="return SaveVideoUrl();" >Save</button>
                    
                </div>
            </div>
</div>
    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      
      <div class="modal-content">
        <div class="modal-header">
            <h4 id="hTitle">Resource List</h4>
          <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
          
        </div>
        
        <div class="modal-body">

            <!--Tab -->
        <div class="tab">
          <button class="tablinks active" onclick="return openCity(event, 'Photo');">Photo</button>
          <button class="tablinks" onclick="return openCity(event, 'Brochure');">Brochure</button>
          <button class="tablinks" onclick="return openCity(event, 'Video');">Video</button>
        </div>

       <div id="Photo" class="tabcontent" style="display:block">          
           
        </div>

        <div id="Brochure" class="tabcontent">
         
        </div>

        <div id="Video" class="tabcontent">
          
        </div>
            
            <!---->
         </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

    <input type="hidden" id="hdfPhotoStatus" />
    <input type="hidden" id="hdfBrochureStatus" />
    <input type="hidden" id="hdfVideoStatus" />

    <script type="text/javascript">

        function ShowEditResourse(){
            $("#Photo").html('');
            $("#Brochure").html('');
            $("#Video").html('');

            $("#Photo").empty();
            $("#Photo").html("<img src='img/loader.gif' alt='loader' height='120'><span style='margin-left:-65px; position:absolute; margin-top:53px'>Please wait...</span>");

            $("#Brochure").empty();
            $("#Brochure").html("<img src='img/loader.gif' alt='loader' height='120'><span style='margin-left:-65px; position:absolute; margin-top:53px'>Please wait...</span>");

            $("#Video").empty();
            $("#Video").html("<img src='img/loader.gif' alt='loader' height='120'><span style='margin-left:-65px; position:absolute; margin-top:53px'>Please wait...</span>");


            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/FillResoucresForDelete",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    
                    $("#Photo").empty();
                    $("#Photo").html("");

                    $("#Brochure").empty();
                    $("#Brochure").html("");

                    $("#Video").empty();
                    $("#Video").html("");

                    var sts = response.d;
                    if(response.d=="ER"){
                        showMsg("ERROR", "Something went wrong.!");
                    }
                    else{
                        var tmpArray=sts.split('^');
                        $("#Photo").html(tmpArray[0]);
                        $("#Brochure").html(tmpArray[1]);
                        $("#Video").html(tmpArray[2]);
                        $("#myModal").modal("show");
                    }
                },
                error: function (response) {                   
                    showMsg("ERROR", "Something went wrong.!");
                    return false;
                }
            });
        }

        function FillAbout() {
            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/FillAboutUs",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if (sts == "ER") {
                        window.location.href = 'login.aspx';
                    }
                    else {
                        $("#txtAboutDetails").val(sts);
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        window.onload = FillAbout();

        function FillUploadedYoutube() {
            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/FillUploadedYoutube",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    var TotalRows=0;
                    if(len>0){
                        TotalRows=response.d[0].TotalRows;
                        for(var k=0;k<len;k++){
                            if(k==0){
                                $("#txtVideoUrl1").val(response.d[k].Url);
                                $("#Title1").val(response.d[k].Title);
                                
                            }
                            else if(k==1){
                                $("#txtVideoUrl2").val(response.d[k].Url);
                                $("#Title2").val(response.d[k].Title);
                            }
                            else if(k==2){
                                $("#txtVideoUrl3").val(response.d[k].Url);
                                $("#Title3").val(response.d[k].Title);
                            }
                        }
                    }
                    /*  if(Number(TotalRows)==3){
                          $("#btnUploadVideos").attr("disabled",true);
                      }
                      else if(Number(TotalRows)<3){
                          $("#btnUploadVideos").attr("disabled",false);
                      }
                      */
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        //window.onload = FillUploadedYoutube();

        function FillUploadedPhoto() {
            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/FillUploadedPhoto",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    var TotalRows=0;
                    var tmp=0;
                    if(len>0){
                        TotalRows=response.d[0].TotalRows;
                        
                        for(var k=0;k<len;k++){
                            tmp=Number(k)+Number(1);
                            $("#spn"+tmp).html(response.d[k].DisplayName);
                        }
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        //window.onload = FillUploadedPhoto();

        function FillUploadedBroucher() {
            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/FillUploadedBroucher",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    var TotalRows=0;
                    var tmp=0;
                    if(len>0){
                        TotalRows=response.d[0].TotalRows;
                        
                        /*for(var k=0;k<len;k++){
                            tmp=Number(k)+Number(1);
                            $("#spnBr"+tmp).html(response.d[k].DisplayName);
                        }*/
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        //window.onload = FillUploadedBroucher();

        function SaveAbout() {

            var details = $("#txtAboutDetails").val();

            if (details.trim() == '') {
                showMsg("ERROR", "Detail must not be blank. !");
                return false;
            }

            details = details.replace('\'', "^");

            document.getElementById("btnSaveAbout").disabled = true;
            document.getElementById("btnSaveAbout").innerHTML = 'Please wait..';
            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/SaveAboutUs",
                data: "{'details':'" + details + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if (sts == "S") {
                        document.getElementById("btnSaveAbout").disabled = false;
                        document.getElementById("btnSaveAbout").innerHTML = 'Save';
                        showMsg("SUCCESS", "Data saved successfully.!");
                        return false;
                    }
                    else if (sts == "ER") {
                        document.getElementById("btnSaveAbout").disabled = false;
                        document.getElementById("btnSaveAbout").innerHTML = 'Save';
                        showMsg("ERROR", "Something went wrong.!");
                        return false;
                    }
                },
                error: function (response) {
                    document.getElementById("btnSaveAbout").disabled = false;
                    document.getElementById("btnSaveAbout").innerHTML = 'Save';
                    showMsg("ERROR", "Something went wrong.!");
                    return false;
                }
            });
        }

        function CheckLimit(){
            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/CheckUniversityUploadLimit",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if(response.d=="ER"){
                        showMsg("ERROR", "Something went wrong.!");
                    }
                    else{
                        var tmpArray=sts.split(',');
                        if(Number(tmpArray[0])>=Number(10)){
                            document.getElementById("btnImageUpload").disabled = true;
                        }
                        if(Number(tmpArray[1])>=Number(15)){
                            document.getElementById("btnUploadBrochure").disabled = true;
                        }
                        if(Number(tmpArray[2])>=Number(3)){
                            document.getElementById("btnUploadVideos").disabled = true;
                        }
                    }
                },
                error: function (response) {                   
                    showMsg("ERROR", "Something went wrong.!");
                    return false;
                }
            });
        }
        //window.onload=CheckLimit();

        function UploadImage() {

            if($('#imgUpload1').val()==''){
                showMsg("ERROR", "Please Select images. !");
                return false;
            }

            var UploadedBy = $("#ContentPlaceHolder1_hdfUserId").val();
            var UniversityId = $("#ContentPlaceHolder1_hdfUniversityId").val();
            document.getElementById("btnImageUpload").disabled = true;
            document.getElementById("btnImageUpload").value = 'Processing..';
          
            if($('#imgUpload1').val()!=""){                
                var formData = new FormData();                
                formData.append('file', $('#imgUpload1')[0].files[0]);
               
                $.ajax({
                    type: 'post',
                    url: "../University/UniversityImageUpload.ashx?UploadedBy=" + UploadedBy+"&University="+UniversityId,
                    data: formData,
                    success: function (status) {
                        if(status=='S'){
                            document.getElementById("btnImageUpload").disabled = false;
                            document.getElementById("btnImageUpload").value = 'Upload';
                            FillUploadedPhoto();
                            showMsg("SUCCESS", "Image has been uploaded successfully.!");
                        }
                        else if(status=='L'){
                            document.getElementById("btnImageUpload").disabled = false;
                            document.getElementById("btnImageUpload").value = 'Upload';                            
                            showMsg("ERROR", "Photo Limit (10) have been uploaded. You can't uploade more than 10 photos. !");
                        }
                    },
                    processData: false,
                    contentType: false,
                    error: function () {
                        document.getElementById("btnImageUpload").disabled = false;
                        document.getElementById("btnImageUpload").value = 'Upload';
                        showMsg("ERROR", "Something went wrong.!");
                    }
                });
            }                  
            return false;
        }

        function UploadBrochure() {

            if($('#brTitle1').val()==""){
                showMsg("ERROR", "Please Enter title. !");
                return false;
            }
            if($('#brochure1').val()==""){
                showMsg("ERROR", "Please Select PDF Files. !");
                return false;
            }

            var UploadedBy = $("#ContentPlaceHolder1_hdfUserId").val();
            var UniversityId = $("#ContentPlaceHolder1_hdfUniversityId").val();
            document.getElementById("btnUploadBrochure").disabled = true;
            document.getElementById("btnUploadBrochure").value = 'Processing..';
            
            if($('#brochure1').val()!=""){                    
                var formData = new FormData();
                formData.append('file', $('#brochure1')[0].files[0]);
                formData.append('Title', $('#brTitle1').val());

                $.ajax({
                    type: 'post',
                    url: "../University/UniversityBrochureUpload.ashx?UploadedBy=" + UploadedBy+"&University="+UniversityId,
                    data: formData,
                    success: function (status) {
                        if(status=='S'){
                            document.getElementById("btnUploadBrochure").disabled = false;
                            document.getElementById("btnUploadBrochure").value = 'Upload';
                            FillUploadedBroucher();
                            $('#brTitle1').val('');
                            $('#brochure1').val('');
                            showMsg("SUCCESS", "Brochure has been uploaded successfully.");
                        }
                        else if(status=='L'){
                            document.getElementById("btnUploadBrochure").disabled = false;
                            document.getElementById("btnUploadBrochure").value = 'Upload';                            
                            showMsg("ERROR", "Brochure limit (15) are already uploaded. You can't upload more than 15 Brochures. !");
                        }
                        else if(status=='EX'){
                            document.getElementById("btnUploadBrochure").disabled = false;
                            document.getElementById("btnUploadBrochure").value = 'Upload';                            
                            showMsg("ERROR", "Title already Exists. !");
                        }
                    },
                    processData: false,
                    contentType: false,
                    error: function () {
                        document.getElementById("btnUploadBrochure").disabled = false;
                        document.getElementById("btnUploadBrochure").value = 'Upload';
                        showMsg("ERROR", "Something went wrong.!");
                    }
                });
            }
            return false;
        }

        function SaveVideoUrl() {
            
            if($('#YtvTitle1').val()==""){
                showMsg("ERROR", "Please Enter Title.!");
                return false;
            }

            if($('#txtVideoUrl1').val()==""){
                showMsg("ERROR", "Please Enter URL.!");
                return false;
            }
            var UniversityId = $("#ContentPlaceHolder1_hdfUserId").val();

            document.getElementById("btnUploadVideos").disabled = true;
            document.getElementById("btnUploadVideos").innerHTML = 'Please wait..';
            var Url='';
            var Title='';
            if($('#txtVideoUrl1').val()!=""){
                Url=$('#txtVideoUrl1').val();
                Title=$('#YtvTitle1').val();
                $.ajax({
                    type: "POST",
                    url: "ResourceManagement.aspx/SaveVideo",
                    data: "{'Url':'" + Url + "','Title':'" + Title + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var sts = response.d;
                        if(sts=="S"){
                            document.getElementById("btnUploadVideos").disabled = false;
                            document.getElementById("btnUploadVideos").innerHTML = 'Save';
                            showMsg("SUCCESS", "Data saved successfully.!");
                            $('#YtvTitle1').val('');
                            $('#txtVideoUrl1').val('');
                        }
                        else if(sts=='L'){
                            document.getElementById("btnUploadVideos").disabled = false;
                            document.getElementById("btnUploadVideos").innerHTML = 'Save';                         
                            showMsg("ERROR", "Video limit (3) are already uploaded. You can't upload more than 3 Videos. !");
                        }
                        else if (sts == "ER") {
                            document.getElementById("btnUploadVideos").disabled = false;
                            document.getElementById("btnUploadVideos").innerHTML = 'Save';
                            showMsg("ERROR", "Something went wrong.!");
                            return false;
                        }
                        else if (sts == "EX") {
                            document.getElementById("btnUploadVideos").disabled = false;
                            document.getElementById("btnUploadVideos").innerHTML = 'Save';
                            showMsg("ERROR", "Title already Exists.!");
                            return false;
                        }
                    },
                    error: function (response) {
                        document.getElementById("btnUploadVideos").disabled = false;
                        document.getElementById("btnUploadVideos").innerHTML = 'Save';
                        showMsg("ERROR", "Something went wrong.!");
                        return false;
                    }
                });
            }
            return false;
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



                    // check file name

                    var ImageName=fuData.files[0].name;                   

                    $.ajax({
                        type: "POST",
                        url: "ResourceManagement.aspx/CheckDuplicateImageName",
                        data: "{'ImageName':'" + ImageName + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var sts = response.d;
                            if (sts == "EX") {
                                $("#hdfPhotoStatus").val('EX');                               
                               // $("#"+eleId).css("color","red");
                                document.getElementById(eleId).value = '';
                                //document.getElementById(eleId).value = 'Already uploaded. !';
                                showMsg("ERROR", "Image Name already Exists.!");
                                return false;
                            }
                        },
                        error: function (response) {
                            showMsg("ERROR", "Something went wrong.!");
                            return false;
                        }
                    });

                    // end file name

                    const fi = document.getElementById(eleId);
                    // Check if any file is selected.
                    if (fi.files.length > 0) {
                        for (const i = 0; i <= fi.files.length - 1; i++) {
  
                            const fsize = fi.files.item(i).size;
                            const file = Math.round((fsize / 1024));
                            // The size of the file.
                            if (file > 1024) {
                                showMsg("ERROR", "File too Big, please select a file size of 1mb");
                                document.getElementById(eleId).value = '';
                                return false;
                            }
                            /*else if (file < 1024) {
                                alert(
                                  "File too small, please select a file greater than 2mb");
                            } else {
                                document.getElementById('size').innerHTML = '<b>'
                                + file + '</b> KB';
                            }*/
                        }
                    }




                    // To Display
                    /* if (fuData.files && fuData.files[0]) {
                         var reader = new FileReader();
 
                         reader.onload = function (e) {
                             $('#blah').attr('src', e.target.result);
                         }
 
                         reader.readAsDataURL(fuData.files[0]);
                     }*/                  



                }

                    //The file upload is NOT an image
                else {
                    showMsg("ERROR", "Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. ");
                    document.getElementById(eleId).value = '';
                }
            }
        }


        function ValidatePDFUpload(eleId) {
            var fuData = document.getElementById(eleId);
            var FileUploadPath = fuData.value;

            //To check if user upload any file
            if (FileUploadPath == '') {
                showMsg("ERROR", "Please upload PDF File");

            } else {
                var Extension = FileUploadPath.substring(
                        FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

                //The file uploaded is an image

                if (Extension == "pdf") {

                    const fi = document.getElementById(eleId);
                    // Check if any file is selected.
                    if (fi.files.length > 0) {
                        for (const i = 0; i <= fi.files.length - 1; i++) {  
                            const fsize = fi.files.item(i).size;
                            const file = Math.round((fsize / 1024));
                            // The size of the file.
                            if (file > 5120) {
                                showMsg("ERROR", "File too Big, please select a file size of 5mb");
                                document.getElementById(eleId).value = '';
                                return false;
                            }
                        }
                    }

                    // check duplicate
                    //var tmpid=eleId.replace("brochure","");
                    //var Title= "brTitle"+tmpid;
                    //CheckBrochureDuplicate(eleId,Title);
                    // end duplicate
                }
                    //The file upload is NOT an image
                else {
                    showMsg("ERROR", "Only PDF File Allowed.");
                    document.getElementById(eleId).value = '';
                }
            }
        }

        function CountRemain() {               
            var i = document.getElementById("txtAboutDetails").value.length;
            document.getElementById("lbldisplay").innerHTML = Number(2500) - Number(i); 
        }
        window.onload=CountRemain();
</script>
    <script>
        function openCity(evt, cityName) {
            ShowEditResourse();
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " active";
           
            return false;
        }

        function DeleteResource(tmpId,tmpSts){
            var FileName='';
            if(tmpSts=='photo'){                
                tmpId=tmpId.replace('trp','');
                FileName=$("#trp"+tmpId).attr("data-fileName");
            }
            else if(tmpSts=='brochure'){
                tmpId=tmpId.replace('trb','');
                FileName=$("#trb"+tmpId).attr("data-fileName");
            }
            else if(tmpSts=='youtube'){
                tmpId=tmpId.replace('trv','');
                FileName='';
            }

            var cnf = confirm('Are you sure to Delete ???');
            if (cnf == false)
                return false;

            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/DeleteResources",
                data: "{'Id':'" + tmpId + "','Source':'" + tmpSts + "','FileName':'" + FileName + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if (sts == "ER") {                        
                        showMsg("ERROR", "Something went wrong.!");
                    }
                    else if (sts == "D") {                        
                        showMsg("SUCCESS", "Record has been Delete Successfully.!");
                        
                        if(tmpSts=='photo'){                
                            $("#trPhoto"+tmpId).hide();
                        }
                        else if(tmpSts=='brochure'){
                            $("#trBr"+tmpId).hide();
                        }
                        else if(tmpSts=='youtube'){
                            $("#trYtb"+tmpId).hide();
                        }
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }

        function CheckBrochureDuplicate(eleId,Title){
            var fuData = document.getElementById(eleId);
            var ImageName=fuData.files[0].name;                   
            var TitleValue=$("#"+Title).val();

            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/DuplicateBrochureName",
                data: "{'ImageName':'" + ImageName + "','Title':'" + TitleValue + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if (sts == "EX") {
                        $("#hdfBrochureStatus").val('EX');                               
                        $("#"+eleId).css("color","red");
                        document.getElementById(eleId).value = '';
                        //document.getElementById(eleId).value = 'Already uploaded. !';
                        showMsg("ERROR", "Title or File Name already Exists.!");
                        return false;
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                    return false;
                }
            });
        }

        function CheckVideoDuplicate(Title,Url){
                            
            var TitleValue=$("#"+Title).val();
            var UrlValue=$("#"+Url).val();

            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/DuplicateVideo",
                data: "{'Url':'" + UrlValue + "','Title':'" + TitleValue + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if (sts == "EX") {
                        $("#hdfVideoStatus").val('EX');
                        document.getElementById("btnUploadVideos").disabled = false;
                        document.getElementById("btnUploadVideos").innerHTML = 'Save';
                        showMsg("ERROR", "Title or URL already Exists.!");
                        return false;
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                    return false;
                }
            });
        }
</script>
</asp:Content>


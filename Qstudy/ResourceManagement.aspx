<%@ Page Title="" Language="C#" MasterPageFile="~/Qstudy/MasterPageQstudy.master" AutoEventWireup="true" CodeFile="ResourceManagement.aspx.cs" Inherits="Qstudy_ResourceManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField ID="hdfUserId" runat="server" />
    
    <div class="rows d-flex"> 
                <div class="col-sm-3 aboutus upload">
                    <h2>About us <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></h2>
                    <textarea id="txtAboutDetails" name="txtAboutDetails" rows="8" cols="40">
                     
                    </textarea>
                    <button type="button" id="btnSaveAbout" class="btn btn-succes" onclick="return SaveAbout();">Save</button>
                </div>
                <div class="col-sm-3 uploadphoto upload">
                    <h2>upload photo <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></h2>
                    <input type="file" name="" id="imgUpload1" onchange="return ValidateFileUpload(this.id)" />
                    <input type="file" name="" id="imgUpload2" onchange="return ValidateFileUpload(this.id)" />
                    <input type="file" name="" id="imgUpload3" onchange="return ValidateFileUpload(this.id)" />
                    <input type="file" name="" id="imgUpload4" onchange="return ValidateFileUpload(this.id)" />
                    <input type="file" name="" id="imgUpload5" onchange="return ValidateFileUpload(this.id)" />
                    <input type="submit" value="upload" class="btn btn-succes" id="btnImageUpload" onclick="return UploadImage();" />
                </div>
                <div class="col-sm-3 uploadbrochar upload">
                    <h2>upload brochure <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></h2>
                    <input type="file" id="brochure1" onchange="return ValidatePDFUpload(this.id)" />
                    <input type="file" id="brochure2" onchange="return ValidatePDFUpload(this.id)" />
                    <input type="submit" value="upload" class="btn btn-succes"  id="btnUploadBrochure" onclick="return UploadBrochure();"/>
                </div>
                <div class="col-sm-3 uploadvideo upload">
                    <h2>upload video <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></h2>
                    <input type="text" placeholder="Enter url" id="txtVideoUrl" />
                    <button type="button" id="btnUploadVideos" class="btn btn-succes" onclick="return SaveVideoUrl();" >Save</button>

                </div>
            </div>
    <script type="text/javascript">


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

        function SaveAbout() {

            var details = $("#txtAboutDetails").val();

            if (details.trim() == '') {
                alert('Detail must not be blank. !!!');
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
                        showMsg("SUCCESS", "Data saved successfully");
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

        function UploadImage() {
            if ($('#imgUpload1').val() == "" && $('#imgUpload2').val() == "" && $('#imgUpload3').val() == "" && $('#imgUpload4').val() == "") {
                showMsg("ERROR", "Please Select image. !");
                return false;
            }
            if ($('#imgUpload1').val() == "" && ($('#imgUpload2').val() != "" || $('#imgUpload3').val() != "" || $('#imgUpload4').val() != "")) {
                showMsg("ERROR", "Please select first image. !");
                return false;
            }

            var UploadedBy = $("#ContentPlaceHolder1_hdfUserId").val();
            document.getElementById("btnImageUpload").disabled = true;
            document.getElementById("btnImageUpload").value = 'Processing..';

            for (var k = 1; k <= 5; k++) {
                var formData = new FormData();                
                formData.append('file', $('#imgUpload' + k)[0].files[0]);
               
                $.ajax({
                    type: 'post',
                    url: "../Qstudy/QstudyImageUpload.ashx?UploadedBy=" + UploadedBy,
                    data: formData,
                    success: function (status) {
                    },
                    processData: false,
                    contentType: false,
                    error: function () {
                        document.getElementById("btnImageUpload").disabled = false;
                        document.getElementById("btnImageUpload").value = 'Upload';
                        showMsg("ERROR", "Something went wrong.!");
                    }
                });
                if (k == 5) {
                    document.getElementById("btnImageUpload").disabled = false;
                    document.getElementById("btnImageUpload").value = 'Upload';
                    showMsg("SUCCESS", "Image has been uploaded successfully.!");
                }
            }
            return false;
        }

        function UploadBrochure() {
            if ($('#brochure1').val() == "" && $('#brochure2').val() == "") {
                showMsg("ERROR", "Please Select PDF File. !");
                return false;
            }
            if ($('#brochure1').val() == "" && ($('#brochure2').val() != "" )) {
                showMsg("ERROR", "Please select first PDF File. !");
                return false;
            }

            var UploadedBy = $("#ContentPlaceHolder1_hdfUserId").val();
            document.getElementById("btnUploadBrochure").disabled = true;
            document.getElementById("btnUploadBrochure").value = 'Processing..';

            for (var k = 1; k <= 2; k++) {
                var formData = new FormData();
                formData.append('file', $('#brochure' + k)[0].files[0]);

                $.ajax({
                    type: 'post',
                    url: "../Qstudy/QstudyBrochureUpload.ashx?UploadedBy=" + UploadedBy,
                    data: formData,
                    success: function (status) {
                        //showMsg("SUCCESS", "Brochure uploaded successfully.!");
                    },
                    processData: false,
                    contentType: false,
                    error: function () {
                        document.getElementById("btnUploadBrochure").disabled = false;
                        document.getElementById("btnUploadBrochure").value = 'Upload';
                        showMsg("ERROR", "Something went wrong.!");
                    }
                });
                if (k == 2) {
                    document.getElementById("btnUploadBrochure").disabled = false;
                    document.getElementById("btnUploadBrochure").value = 'Upload';
                    showMsg("SUCCESS", "Brochure has been uploaded successfully.!");
                }
            }
            return false;
        }

        function SaveVideoUrl() {
            var Url = $("#txtVideoUrl").val();
            
            if (Url.trim() == "") {
                showMsg("ERROR", "Please Enter URL.!");
                return false;
            }

            document.getElementById("btnUploadVideos").disabled = true;
            document.getElementById("btnUploadVideos").innerHTML = 'Please wait..';
            $.ajax({
                type: "POST",
                url: "ResourceManagement.aspx/SaveVideo",
                data: "{'Url':'" + Url + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if (sts == "S") {
                        $("#txtVideoUrl").val('');
                        document.getElementById("btnUploadVideos").disabled = false;
                        document.getElementById("btnUploadVideos").innerHTML = 'Save';
                        showMsg("SUCCESS", "Data saved successfully.!");
                        return false;
                    }
                    else if (sts == "ER") {
                        document.getElementById("btnUploadVideos").disabled = false;
                        document.getElementById("btnUploadVideos").innerHTML = 'Save';
                        showMsg("ERROR", "Something went wrong.!");
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

                }
                    //The file upload is NOT an image
                else {
                    showMsg("ERROR", "Only PDF File Allowed.");
                    document.getElementById(eleId).value = '';
                }
            }
        }
</script>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/MasterPageSuperAdmin.master" AutoEventWireup="true" CodeFile="UniversityManagement.aspx.cs" Inherits="SuperAdmin_UniversityManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
                .multipleSelection {
            width: 300px;
            background-color: #bcc2c12b;
        }
  
        .selectBox {
            position: relative;
        }
  
        .selectBox select {
            width: 100%;
            /*font-weight: bold;*/
        }
  
        .overSelect {
            position: absolute;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
        }
        #checkPlateform {
            display: none;
            border: 1px #8DF5E4 solid;
            padding-left:5px;
            margin-top:-24px
        }
  
        #checkPlateform label {
            display: block;
        }
  
        #checkPlateform label:hover {
            background-color: lightblue;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField ID="hdfUserId" runat="server" />
    <asp:HiddenField ID="hdfUid" runat="server" />
    <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
    <div style="overflow:auto;max-width:100%;max-height:calc(100vh - 100px);">
     <div class="rowse"> 
                <div class="management">
                <div class="mform">
                        <div class="form-group">
                             <label for="txtUserName" class="manag_label">University Name <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <input type="text" class="form-control" id="txtUserName" placeholder="University name" />
                          </div>
                          
                     <div class="form-group">
                             <label for="txtEmail" class="manag_label">Primary Email<sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <input type="email" class="form-control" id="txtEmail" placeholder="enter Primary Email" />
                          </div>
                     <div class="form-group" style="display:none">
                             <label for="ddlRegion" class="manag_label">Region <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <div class="multipleSelection">
                            <div class="selectBox" 
                                onclick="showPlateform()">
                                <select class="form-control">
                                    <option>Select Region</option>
                                </select>
                                <div class="overSelect"></div>
                            </div>
  
                            <div id="checkPlateform">
                               <%=_sbMsg %>
                            </div>
                            </div>
                         </div>
                    <div class="form-group">
                             <label for="imgLogo" class="manag_label">Logo</label>
                              <input type="file" id="imgLogo" onchange="ValidateFileUpload(this.id);" />
                        <img src="img/logo.png" height="100" id="imgPrevie" alt="prvw" />
                          </div>
                    <div class="form-group">
                             <label for="chkActive" class="manag_label">Active</label>
                              <input type="checkbox" id="chkActive" checked="checked" />
                          </div>
                       <a href="javascript:void();" id="btnSave" onclick="return AddUpdateUser();" class="btn btn-success" style="margin: 0;">create</a>
            </div>
        </div>
            </div>

            <div class="tabel_wrapper">
                <div class="search_wrapper" style="border:1px solid lightgray;border: 1px solid lightgray;width: 300px;margin-left: 9px;display:inline;">
                    <span class="fa fa-search" style="color:lightgray;margin-left:5px;"></span>
                <input type="text" id="txtSearch" onkeyup="return Search();" placeholder="search by university name, email, active" style="margin-left:15px;width:240px;border:none" />
                </div>
                <div class="icon_exel">
                <img src="img/refresh.png" height="30" style="cursor:pointer" data-toggle="tooltip" data-placement="bottom" title="Reload Data" id="imgRefresh" alt="refresh" onclick="RefreshGrid();" />
                <a href="javascript:void();" data-toggle="tooltip" data-placement="bottom" title="Excel Download" onclick="ExcelDownload();">
                    <img src="img/excel.png" height="35" />
                </a>
                </div>
                <table style="overflow-y:scroll" >
                    <thead>
                    <th>SNo.</th>
                    <th>Action</th>
                    <th>University Name</th>
                    <th>Email</th>
                    <th>Active</th>
                     <th>CreatedDateTime</th>
                  </thead>
                    <tbody id="gridUniversity">

                    </tbody>
                </table>

                <div class="row" style="width:95%;">
    <div class="col-md-6 " style="margin-top:5px;">
        <div class="pagination">

            <div class="dataTables_paginate paging_simple_numbers" id="sampleTable_paginate">
                                <ul class="pagination pagination-sm">
                                    <li class='paginate_button page-item previous disabled' id='sampleTable_previous'>
                                        <a href='javascript:void();' aria-controls='sampleTable' data-dt-idx='0' tabindex='0' class='page-link' onclick="PrevRecords();">Previous</a>
                                    </li>
                                    <li class='paginate_button page-item active'>
                                        <a href='javascript:void();' aria-controls='sampleTable' data-dt-idx='1' tabindex='0' class='page-link' id="curIndex">0</a>
                                    </li>

                                    <li class='paginate_button page-item next disabled' id='sampleTable_next'>
                                        <a href='javascript:void();' aria-controls='sampleTable' data-dt-idx='2' tabindex='0' class='page-link' onclick="NextRecords();">Next</a>
                                    </li>
                                </ul>
                            </div>



  <br />
  <span id="sampleTable_info"></span>
</div>
    </div>
    <div class="col-md-6 size-drop">
        <span>page size:</span>
        <select class="form-select" id="ddlPageSize" onchange="PageSize();">
            <option value="10">10</option>
            <option value="50">50</option>
            <option value="100">100</option>
            <option value="500">500</option>
        </select>
    </div>
</div>
   
            </div>
</div>

    <script type="text/javascript">

        function BindGrid(SearchValue, RowPerPage, PageNumber) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');

            $.ajax({
                type: "POST",
                url: "UniversityManagement.aspx/BindList",
                data: "{'SearchValue':'" + SearchValue + "','RowPerPage':'" + RowPerPage + "','PageNumber':'" + PageNumber + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var len = data.d.length;
                    $("#gridUniversity").empty();
                    var item = '';
                    if (len > 0) {
                        $("#curIndex").html($("#hdfCurrentPageIndex").val());
                        if (Number(data.d[len - 1].SNo) < Number(data.d[0].TotalRows)) {
                            $("#sampleTable_next").removeClass("disabled")
                            $("#sampleTable_next").addClass("enabled");
                        }
                        else {
                            $("#sampleTable_next").removeClass("enabled")
                            $("#sampleTable_next").addClass("disabled");
                        }
                        if ($("#hdfCurrentPageIndex").val() > 1) {
                            $("#sampleTable_previous").removeClass("disabled")
                            $("#sampleTable_previous").addClass("enabled");
                        }
                        else {
                            $("#sampleTable_previous").removeClass("enabled")
                            $("#sampleTable_previous").addClass("disabled");
                        }
                        var id = '';
                        var redirect = '';
                        $("#sampleTable_info").html('&nbsp;Showing ' + data.d[0].SNo + ' to ' + data.d[len - 1].SNo + ' of ' + data.d[0].TotalRows + ' records');
                        for (var k = 0; k < len; k++) {
                            id = data.d[k].Id;
                            item += "<tr>";
                            item += "<td>" + data.d[k].SNo + "</td>";
                            item += "<td><a href='javascript:void();' onclick='return GetEditData(" + id + ");'>Edit</a><a href='javascript:void();' onclick='return Delete(" + id + ");' class='btn-danger' style='background-color:#dc3545!important'>Delete</a></td>";
                            item += "<td>" + data.d[k].Name + "</td>";
                            item += "<td>" + data.d[k].Email + "</td>";
                            item += "<td>" + data.d[k].Active + "</td>";                            
                            item += "<td>" + data.d[k].CreatedDateTime + "</td>";
                            item += "</tr>";
                        }
                        $("#gridUniversity").append(item);
                    }
                    else {
                        $("#hdfCurrentPageIndex").val(1);
                        $("#curIndex").html($("#hdfCurrentPageIndex").val());
                        $("#sampleTable_previous").removeClass("enabled")
                        $("#sampleTable_next").removeClass("enabled");
                        $("#sampleTable_previous").addClass("disabled");
                        $("#sampleTable_next").addClass("disabled");
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                    return false;
                }
            });
        }
        window.onload = BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
       

        function Search() {
            $("#hdfCurrentPageIndex").val(1);
            BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
        }

        function NextRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) + 1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
        }

        function PrevRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) - 1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
        }

        function PageSize() {
            $("#hdfCurrentPageIndex").val(1);            
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
        }
        
        function RefreshGrid() {
            $("#hdfCurrentPageIndex").val(1);
            $("#txtSearch").val('');
            $("#ddlPageSize").val(10);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
        }

        function ExcelDownload() {
            var SearchValue = $("#txtSearch").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Status = "University";
            window.location.href = "download.aspx?Status=" + Status + "&SearchValue=" + SearchValue + "&RowPerPage=" + RowPerPage + "&PageNumber=" + PageNumber;
        }


        function AddUpdateUser() {

            var Name = $("#txtUserName").val();
            var mail = $("#txtEmail").val();
            var Uid = $("#ContentPlaceHolder1_hdfUid").val();
            var UserId = $("#ContentPlaceHolder1_hdfUserId").val();
            var atpos = mail.indexOf("@");
            var dotpos = mail.lastIndexOf(".");
            var sts = '';

            if (Name.trim() == '') {
                showMsg("ERROR", "Please Enter Name.!");
                $("#txtUserName").focus();
                return false;
            }
            else if (mail.trim() == '') {
                showMsg("ERROR", "Please Enter E-Mail. !");
                $("#txtEmail").focus();
                return false;
            }
            else if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= mail.length) {
                showMsg("ERROR", "Please Fill Valid Email Address. !");
                $('#txtEmail').focus();
                return false;
            }

            var Mc = 0;
            var RegGrid = document.getElementById('checkPlateform');
            var chk = RegGrid.getElementsByTagName('input');
            var len = chk.length;
            var Region = '', MsgText = '';
            for (var k = 0; k < len; k++) {
                if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                    Mc = Number(Mc) + 1;
                    if (k == 0) {
                        Region = (chk[k].id).replace("m", "");
                    }
                    else {
                        Region = Region + ',' + (chk[k].id).replace("m", "");
                    }
                }
            }
            if (Mc == 0) {
                Region = "0";
                //showMsg("ERROR", "Please Select Region. !");
                //return false;
            }

            if (document.getElementById('chkActive').checked == true)
                sts = "Yes";
            else
                sts = "No";

            document.getElementById("btnSave").disabled = true;
            document.getElementById("btnSave").innerHTML = 'Please wait..';


            var formData = new FormData();
            formData.append('file', $('#imgLogo')[0].files[0]);

            $.ajax({
                type: 'post',
                url: "../SuperAdmin/UniversityHandler.ashx?Uid=" + Uid + "&Name=" + Name + "&Email=" + mail + "&sts=" + sts + "&UserId=" + UserId + "&Region=" + Region,
                data: formData,
                success: function (status) {
                    if (sts == "N") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("ERROR", "Name Already Exists.!");
                        return false;
                    }
                    else if (sts == "E") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("ERROR", "E-mail Already Exists.!");
                        return false;
                    }
                    else if (sts == "ER") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("ERROR", "Something went wrong.!");
                        return false;
                    }
                    else {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("SUCCESS", "Data saved successfully.!");
                        $("#txtUserName").val('');
                        $("#txtEmail").val('');
                        $("#ContentPlaceHolder1_hdfUid").val('');
                        $('#imgLogo').val('');
                        document.getElementById('imgPrevie').src = 'img/logo.png';

                        var RegGrid = document.getElementById('checkPlateform');
                        var chk = RegGrid.getElementsByTagName('input');
                        var len = chk.length;
                        var Msg = '', MsgText = '';
                        for (var k = 0; k < len; k++) {
                            if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                                document.getElementById(chk[k].id).checked = false;
                            }
                        }
                        document.getElementById("checkPlateform").style.display = 'none';
                        RefreshGrid();
                        return false;
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    document.getElementById("btnSave").disabled = false;
                    document.getElementById("btnSave").value = 'create';
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }

        function GetEditData(Uid) {

            $("#txtUserName").val('');
            $("#txtEmail").val('');
            $("#imgLogo").val('');
            document.getElementById("imgPrevie").src = "img/logo.png";
            $("#ContentPlaceHolder1_hdfUid").val('');
            document.getElementById("chkActive").checked = false;

            var RegGrid = document.getElementById('checkPlateform');
            var chk = RegGrid.getElementsByTagName('input');
            var len = chk.length;
            var Msg = '', MsgText = '';
            for (var k = 0; k < len; k++) {
                if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                    document.getElementById(chk[k].id).checked = false;
                }
            }
            document.getElementById("checkPlateform").style.display = 'none';

            $.ajax({
                type: "POST",
                url: "UniversityManagement.aspx/GetEditData",
                data: "{'Uid':'" + Uid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#txtUserName").val(response.d[0].Name);
                    $("#txtEmail").val(response.d[0].Email);
                    if (response.d[0].Logo != '') {
                        document.getElementById("imgPrevie").src = "../UploadedLogo/" + response.d[0].Logo;
                    }

                    if (response.d[0].Active == 'Yes')
                        document.getElementById("chkActive").checked = true;
                    else
                        document.getElementById("chkActive").checked = false;

                    $("#ContentPlaceHolder1_hdfUid").val(response.d[0].Id);

                    var MappedRegion = response.d[0].MapRegion;
                    var MapArray = MappedRegion.split(',');
                    var len = MapArray.length;
                    var tmpid = '', mapRId = '';
                    for (var k = 0; k < len; k++) {
                        if (MapArray[k] != '') {
                            tmpid = "m" + MapArray[k];
                            if (document.getElementById(tmpid))
                                document.getElementById(tmpid).checked = true;
                        }
                    }
                    document.getElementById("checkPlateform").style.display = 'block';

                    document.getElementById("btnSave").innerHTML = 'Update';
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }

        function Delete(Uid) {

            var cnf = confirm('Are you sure to Delete ?');
            if (cnf == false)
                return false;

            $.ajax({
                type: "POST",
                url: "UniversityManagement.aspx/DeleteUsers",
                data: "{'Uid':'" + Uid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "D") {
                        showMsg("SUCCESS", "Record Delete successfully.!");
                        RefreshGrid();
                    }
                    else if (response.d == "ER") {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
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

                    // To Display
                     if (fuData.files && fuData.files[0]) {
                         var reader = new FileReader(); 
                         reader.onload = function (e) {
                             $('#imgPrevie').attr('src', e.target.result);
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
        var show = true;
        function showPlateform() {
            var checkboxes =
                document.getElementById("checkPlateform");

            if (show) {
                checkboxes.style.display = "block";
                show = false;
            } else {
                checkboxes.style.display = "none";
                show = true;
            }
        }

        function CheckAll(ele) {
            
            var RegGrid = document.getElementById('checkPlateform');
            var chk = RegGrid.getElementsByTagName('input');
            var len = chk.length;
            if (document.getElementById(ele).checked == true) {
                for (var k = 0; k < len; k++) {
                    if (chk[k].type == 'checkbox') {
                        document.getElementById(chk[k].id).checked = true;
                    }
                }
            }
            else {
                for (var k = 0; k < len; k++) {
                    if (chk[k].type == 'checkbox') {
                        document.getElementById(chk[k].id).checked = false;
                    }
                }
            }
        }
        //
        function CheckSingle(ele) {
            
            var RegGrid = document.getElementById('checkPlateform');
            var chk = RegGrid.getElementsByTagName('input');
            var len = chk.length - 1;
            
            var c = 1;
            for (var k = 1; k < len; k++) {
                
                if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                    c = Number(c) + Number(1);
                }
            }

            if (c == len) {
                if (document.getElementById(ele).checked == true) {
                    document.getElementById('m0').checked = true;
                }
                else {
                    document.getElementById('m0').checked = false;
                }
            }
        }

        document.getElementById('txtUserName').onkeydown = function (event) {
            if (event.keyCode == 13) {
                AddUpdateUser();
                return false;
            }
        }
        document.getElementById('txtEmail').onkeydown = function (event) {
            if (event.keyCode == 13) {
                AddUpdateUser();
                return false;
            }
        }
        document.getElementById('txtSearch').onkeydown = function (event) {
            if (event.keyCode == 13) {
                Search();
                return false;
            }
        }
    </script>
</asp:Content>


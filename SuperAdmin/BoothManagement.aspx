<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/MasterPageSuperAdmin.master" AutoEventWireup="true" CodeFile="BoothManagement.aspx.cs" Inherits="SuperAdmin_BoothManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField ID="hdfUserId" runat="server" />
    <asp:HiddenField ID="hdfBid" runat="server" />
    
    <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
    <div style="overflow:auto;max-width:100%;max-height:calc(100vh - 100px);">
     <div class="rowse"> 
                <div class="management">
                <div class="mform">
                    <div class="form-group">
                             <label for="txtUserName" class="manag_label">University</label>
                             <select id="ddlUniversity" class="form-control"></select>
                          </div>
                        <div class="form-group">
                             <label for="txtUserName" class="manag_label">Booth Name</label>
                              <input type="text" class="form-control" readonly="true" id="txtName" placeholder="Booth name (max 200 characters)" maxlength="200" />
                          </div>
                    <div class="form-group">
                             <label for="imgLogo" class="manag_label">University logo</label>
                              <input type="file" id="imgLogo" onchange="ValidateFileUpload(this.id);" />
                        <img src="img/logo.png" height="100" id="imgPrevie" alt="prvw" />
                          </div>
                    <div class="form-group">
                             <label for="imgLogo" class="manag_label">Counsellor photo</label>
                              <input type="file" id="imgBigImage" onchange="ValidateFileUpload(this.id);" />
                        <img src="img/logo.png" height="100" id="imgPrevimgBigImage" alt="prvw" />
                          </div>
                    
                    <div class="form-group">
                        <input type="checkbox" id="chkActive" checked="checked" />
                             <label for="chkActive" class="manag_label">Active</label>
                              
                          </div>
                       <a href="javascript:void();" id="btnSave" onclick="return AddUpdateBooth();" class="btn btn-success" style="margin: 0;">create</a>
            </div>
        </div>
            </div>

            <div class="tabel_wrapper">
                <div class="search_wrapper" style="border:1px solid lightgray;border: 1px solid lightgray;width: 300px;margin-left: 9px;display:inline;">
                    <span class="fa fa-search" style="color:lightgray;margin-left:5px;"></span>
                <input type="text" id="txtSearch" onkeyup="return Search();" placeholder="search by university name, email, active" style="margin-left:15px;width:240px;border:none" />
                </div>
                <div class="icon_exel">
                <img src="img/refresh.png" height="30" style="cursor:pointer" id="imgRefresh" alt="refresh" onclick="RefreshGrid();" />
                <a href="javascript:void();" onclick="ExcelDownload();">
                    <img src="img/excel.png" height="35" />
                </a>
                </div>
                <table style="overflow-y:scroll" >
                    <thead>
                    <th>SNo.</th>
                    <th>Action</th>
                    <th>Booth Name</th>
<%--                    <th>Assigned University</th>--%>
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

        function selectNextBoothName() {
            $.ajax({
                type: "POST",
                url: "BoothManagement.aspx/selectNextBoothName",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $("#txtName").val(data.d);
                },
                 error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                    return false;
                }
            });
        
        }

        $(document).ready(function () {
            selectNextBoothName();
        });

        
       

        function BindGrid(SearchValue, RowPerPage, PageNumber) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');

            $.ajax({
                type: "POST",
                url: "BoothManagement.aspx/BindList",
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
                            item += "<td>" + data.d[k].BoothName + "</td>";
                            //item += "<td>" + data.d[k].UniversityName + "</td>";
                            item += "<td>" + data.d[k].Active + "</td>";                            
                            item += "<td>" + data.d[k].createdDateTime + "</td>";
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
            var Status = "Booth";
            window.location.href = "download.aspx?Status=" + Status + "&SearchValue=" + SearchValue + "&RowPerPage=" + RowPerPage + "&PageNumber=" + PageNumber;
        }


        function AddUpdateBooth() {

            var Name = $("#txtName").val();
            var UniversityId = $("#ddlUniversity").val();
            var BoothId = $("#ContentPlaceHolder1_hdfBid").val();
            
            var sts = '';

            if (Name.trim() == '') {
                showMsg("ERROR", "Please Enter Booth Name.!");
                $("#txtName").focus();
                return false;
            }

            if (document.getElementById('chkActive').checked == true)
                sts = "Yes";
            else
                sts = "No";
            //if (UniversityId == '0')
            //    UniversityId = null;

            document.getElementById("btnSave").disabled = true;
            document.getElementById("btnSave").innerHTML = 'Please wait..';

            $.ajax({
                type: "POST",
                url: "BoothManagement.aspx/SaveUpdateBooth",
                data: "{'Name':'" + Name + "','UniversityId':'" + UniversityId + "','sts':'" + sts + "','BoothId':'" + BoothId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var sts = data.d;
                    if (sts == "N") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("ERROR", "Booth Name Already Exists.!");
                        return false;
                    }
                    else if (sts == "U") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("ERROR", "University Already Assigned.!");
                        return false;
                    }
                    else if (sts == "ER") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("ERROR", "Something went wrong.!");
                        return false;
                    }
                    else {
                        $("#ContentPlaceHolder1_hdfBid").val(sts);
                        var BoothId = $("#ContentPlaceHolder1_hdfBid").val();
                        var ImgSize = "SMALL";
                        // uplaod small img
                        if ($('#imgLogo').val() != '') {
                            var formData = new FormData();
                            formData.append('file', $('#imgLogo')[0].files[0]);
                            $.ajax({
                                type: 'post',
                                url: "../SuperAdmin/BoothHandler.ashx?BoothId=" + BoothId + "&ImgSize=" + ImgSize,
                                data: formData,
                                success: function (status) {
                                },
                                processData: false,
                                contentType: false,
                                error: function (status) {
                                    document.getElementById("btnSave").disabled = false;
                                    document.getElementById("btnSave").innerHTML = 'Create';
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
                                url: "../SuperAdmin/BoothHandler.ashx?BoothId=" + BoothId + "&ImgSize=" + ImgSize,
                                data: formData,
                                success: function (status) {

                                    document.getElementById("btnSave").disabled = false;
                                    document.getElementById("btnSave").innerHTML = 'Create';
                                    showMsg("SUCCESS", "Data saved successfully.!");
                                   // $("#txtName").val('');
                                    $('#imgLogo').val('');
                                    $("#imgBigImage").val('');
                                    $("#ContentPlaceHolder1_hdfBid").val('');
                                    document.getElementById('imgPrevie').src = 'img/logo.png';
                                    document.getElementById('imgPrevimgBigImage').src = 'img/logo.png';
                                    BindUniversity();
                                    selectNextBoothName();
                                    RefreshGrid();
                                },
                                processData: false,
                                contentType: false,
                                error: function (status) {
                                    document.getElementById("btnSave").disabled = false;
                                    document.getElementById("btnSave").innerHTML = 'Create';
                                    showMsg("ERROR", "Something went wrong, while upload Big image. !");
                                    return false;
                                }
                            });
                        }
                        // end big img

                        // update list

                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("SUCCESS", "Data saved successfully.!");
                       // $("#txtName").val('');
                        $('#imgLogo').val('');
                        $("#imgBigImage").val('');
                        $("#ContentPlaceHolder1_hdfBid").val('');
                        document.getElementById('imgPrevie').src = 'img/logo.png';
                        document.getElementById('imgPrevimgBigImage').src = 'img/logo.png';
                        BindUniversity();
                        selectNextBoothName();
                        RefreshGrid();
                        return false;

                        // end update list
                    }
                },
                error: function (data) {
                    document.getElementById("btnSave").disabled = false;
                    document.getElementById("btnSave").innerHTML = 'Create';
                    showMsg("ERROR", "Something went wrong.!");
                    return false;
                }
            });
        }

        function GetEditData(BoothId) {

            //$("#txtName").val('');
            $("#imgLogo").val('');
            $("#imgBigImage").val('');
            document.getElementById("imgPrevie").src = "img/logo.png";
            document.getElementById("imgPrevimgBigImage").src = "img/logo.png";
            $("#ContentPlaceHolder1_hdfBid").val('');
            document.getElementById("chkActive").checked = false;

            $.ajax({
                type: "POST",
                url: "BoothManagement.aspx/GetBoothEditData",
                data: "{'BoothId':'" + BoothId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //selectNextBoothName();
                    $("#txtName").val(response.d[0].BoothName);

                    if (response.d[0].SmallImg != '') {
                        document.getElementById("imgPrevie").src = "../UploadedBooth/" + response.d[0].SmallImg;
                    }
                    if (response.d[0].BigImg != '') {
                        document.getElementById("imgPrevimgBigImage").src = "../UploadedBooth/" + response.d[0].BigImg;
                    }

                    if (response.d[0].Active == 'Yes')
                        document.getElementById("chkActive").checked = true;
                    else
                        document.getElementById("chkActive").checked = false;
                    BindUniversity();
                    if (response.d[0].UniversityId != '') {
                        $("#ddlUniversity").append("<option value=" + response.d[0].UniversityId + ">" + response.d[0].UniversityName + "</option>");
                        $("#ddlUniversity").val(response.d[0].UniversityId);
                    }
                    $("#ContentPlaceHolder1_hdfBid").val(response.d[0].Id);
                    document.getElementById("btnSave").innerHTML = 'Update';
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }

        function Delete(BoothId) {

            var cnf = confirm('Are you sure to Delete ?');
            if (cnf == false)
                return false;

            $.ajax({
                type: "POST",
                url: "BoothManagement.aspx/DeleteBooth",
                data: "{'BoothId':'" + BoothId + "'}",
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
        function BindUniversity() {

            $.ajax({
                type: "POST",
                url: "BoothManagement.aspx/FillUniversity",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "ER") {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                    else {
                        $("#ddlUniversity").html(response.d);
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }
        window.onload = BindUniversity();

    </script>
</asp:Content>


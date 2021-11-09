<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmStudentCouncil.aspx.cs" Inherits="Qstudy_frmStudentCouncil" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>QStudy</title>
   

   <script src="../WebJS/Ajax_jquery.min.js"></script>  
  <script src="../WebJS/popper.min.js"></script>
      <script src="../WebJS/bootstrap.min.js"></script>   
 

    <link href="../WebCSS/bootstrap.min.css" rel="stylesheet" />   
   <link href="css/style.css" type="text/css" rel="stylesheet" />
   <link href="../WebCSS/Fontfamily_Pragati.css" rel="stylesheet" />  
    <link  href="../WebCSS/font-awesome.min.css" rel="stylesheet" /> 
    <link href="../WebCSS/carousel.css" rel="stylesheet" /> 

    <style>
        .my-bordered-icon {
            text-shadow: -1px 0 #000, 0 1px #000, 1px 0 #000, 0 -1px #000;
        }
        .tabel_wrapper a{
            background-color:transparent;
        }
    
        .modalTable table{
            background-color:white;
            font-size:15px;
            /* border: 0px none #fff !important;*/

        }
        .modalTable td,th {
              /*  background-color: #b4e3ea4a;*/
            font-size: 15px;
           /* border: .1px solid #345860 !important;*/
        }
        .modalTable tr {
           
             border: 0px none #fff !important;
        }

    </style>
</head>
    <body>
    <form id="form1" runat="server">
          <div class="alert alertboxes alert-success d-none" id="divSuccess" role="alert"></div>
        <div class="alert alertboxes alert-danger d-none"  id="divError" role="alert"></div>

            <div class="container-fluid" onclick="ClearMsg();">
        <div class="row">
<header class="main-header dark">
    <div class="logo">
        <img src="img/trans_branding.png" alt="logo" />
    </div>
    <div class="nav">
        <div class="nav-right">
            <ul class="navright_menu">
                <li class="login_icon"><a href="javascript:void();" onclick="return SessionLogout();">LogOut<i class="fa fa-sign-out"></i></a></li>
                <div style="display:none"><asp:Button ID="btnLogOut" runat="server" OnClick="btnLogOut_Click" /></div>
                <script type="text/javascript">
                    function SessionLogout() {
                        var btn = document.getElementById("btnLogOut");
                        btn.click();
                    }
                </script>
            </ul>
        </div>
    </div>
</header>
</div>   
</div>
            <div class="page_wrapper">
                  <%-- <div class="all_pages_wrapper">--%>
     <asp:HiddenField ID="hdfUserId" runat="server" />
    <asp:HiddenField ID="hdfUid" runat="server" />
    <asp:HiddenField ID="hdfSid" runat="server" />

    <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
     <style>
        .mform {
            width: 90%!important;           
            padding: 6px!important;
        }
        .form-control{
             border-radius: 0px 0px 0px 0px !important;
             margin-bottom: 10px !important;
        }
        .form-control:focus{
             border-radius: 0px 0px 0px 0px !important;
             margin-bottom: 10px !important;
        }
    .has-search .form-control {
    padding-left: 2.375rem;
}
.form-group {
    margin-bottom: .1rem !important;
}
.has-search .form-control-feedback {
    position: absolute;
    z-index: 2;
    display: block;
    width: 2.375rem;
    height: 2.375rem;
    line-height: 2.375rem;
    text-align: center;
    pointer-events: none;
    color: #aaa;
}
  
      .MyTable {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
  max-height:400px;
  overflow:scroll;
  
  overflow-x:scroll;
}

.MyTable td, .MyTable th {
  border: 1px solid #ddd;
  padding: 4px;
  font-size: 12px;
}

.MyTable tr:nth-child(even){background-color: #f2f2f2;}

.MyTable tr:hover {background-color: #ddd;}

.MyTable th {
    padding: 3px 5px;
    text-align: center;
    color: white;
    font-size: 11px;
    background-color: #757575;
    position: sticky;
  top: 0px;
}
.MyTable tr td a{
    font-size: 11px;
    margin: 0 0 0 5px;
}
  </style>
    
    <div style="width:75%;height: calc(100vh - 150px);float:left;margin-left:2%;margin-right:2%;">
        <iframe allow="camera; microphone; fullscreen; speaker; display-capture"
         id="ifrmmodify" style="height:100%;width:100%">
        </iframe>
    </div>
            <div class="tabel_wrapper" style="float:right;">
                <div class="search_wrapper" style="border:1px solid lightgray;border: 1px solid lightgray;width: 300px;margin-left: 9px;display:none;">
                    <span class="fa fa-search" style="color:lightgray;margin-left:5px;"></span>
                <input type="text" id="txtSearch" onkeyup="return Search();" placeholder="search by name, Reg.No" style="margin-left:15px;width:240px;border:nonedisplay:none;" />
                </div>
                <div class="icon_exel" style="display:none;">
                <img src="img/refresh.png" height="30" style="cursor:pointer;display:none;" data-toggle="tooltip" data-placement="bottom" title="Reload Data" id="imgRefresh" alt="refresh" onclick="RefreshGrid();" />
                
                </div>
 
                
       <div>
                <div>    <table class="MyTable">     
                     <thead><tr><th style="background-color:green !important;color:white;">
                        Online Students
                        </th></tr></thead></table></div>
                   
                       <div class="select_box">
                        <select class="slect_item" id='ddlUniversity' multiple="multiple" > 

                        </select>  <%--class='university'--%>
                       </div>
                    
    <div  style="overflow-y:scroll;max-height:calc(100vh - 300px);">
     <table id="MyTable" class="MyTable">
                    <thead>
                        <tr>
                    <th>Select</th>
                    <th>Name(Reg.No)</th>
                    <th>Action</th>
                     </tr>
                  </thead>
                    
                    <tbody id="gridUniversity">

                    </tbody>

                    
                    
                </table>
                </div>
                <div>
                    <table class="MyTable">
                        <tr>
                    <td colspan="4">
                    <a href='javascript:void();' onclick='return MoveStudent();' class='btn-Success' style='background-color:Green!important'>Move Student</a>
                        </td></tr></table>
                </div>
                <div class="row" style="display:none;">
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
  <span id="sampleTable_info" style="display:none;"></span>
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
   
<br />
 <!-- Open Modal-->
    <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">

       <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Student Detail</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError3" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
<table id="tblDetails" class="modalTable">   
    
</table>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>

<!--- Second Modal -->
           <div class="modal fade" id="myModalEdit" role="dialog">
    <div class="modal-dialog modal-lg" style="max-width: 500px;">

       <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Reassign University</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError2" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
            <input type="hidden" runat="server" id="hdEditSId" />
            <input type="hidden" runat="server" id="hdEditId" />
<table id="tblEditDetails" class="modalTable">   
 <tr>
     <td>Name: </td>
     <td class="stName"></td>
 </tr>
    <tr>
     <td>Registration No: </td>
     <td class="stRegNo"></td>
 </tr>
   
    <tr>
     <td>University List: </td>
     <td>
         <div class="select_box">
           <select class="slect_item" id='ddlUniversityEdit' multiple="multiple" > 

           </select>
         </div>

     </td>
 </tr>

</table>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <div style="float:right">  <button type="button" class="btn btn-success" onclick="return UpdateAndMoveStudent();">Update & Move</button></div>
          <div style="float:right"><button type="button" class="btn btn-danger" data-dismiss="modal">Close</button></div>
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->

</div>
    <script>

        function BindGrid(SearchValue, RowPerPage, PageNumber) {
            var UserId = $("#hdfUserId").val();
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');

            $.ajax({
                type: "POST",
                url: "frmStudentCouncil.aspx/BindList",
                data: "{'SearchValue':'" + SearchValue + "','RowPerPage':'2000','PageNumber':'" + PageNumber + "','UserId':'" + UserId+"'}",
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
                        var chk = '';
                        $("#sampleTable_info").html('&nbsp;Showing ' + data.d[0].SNo + ' to ' + data.d[len - 1].SNo + ' of ' + data.d[0].TotalRows + ' records');
                        for (var k = 0; k < len; k++) {
                            id = data.d[k].SNo;
                            chk = "chk" + id;
                            item += "<tr id=trId" + data.d[k].SNo + ">";
                            if (data.d[k].Moved == 'No' && data.d[k].Active == 'No') {
                                item += "<td><input type='hidden' id='hdId" + data.d[k].SNo + "' value='" + data.d[k].StudentId + "'><input value='0' id=" + chk + " type='checkbox'  style='background-color:Green!important; display:none;'  />";
                            }
                            else {
                                item += "<td><input type='hidden' id='hdId" + data.d[k].SNo + "' value='" + data.d[k].StudentId + "'><input value='0' id=" + chk + " type='checkbox'  style='background-color:Green!important' />";
                            }
                            item += "<td>" + data.d[k].Name + "(" + data.d[k].RegNo + ")</td>";
                            item += "<td><a href='javascript:void();' onclick='return ViewStudent(" + data.d[k].StudentId + ");' class='btn-info' style='background-color:#17a2b8 !important;'>View</a>";
                            if (data.d[k].Moved == 'No' && data.d[k].Active == 'No') {
                                item += "<a href='javascript:void();' onclick='return Edit(" + data.d[k].Id + ");' class='btn-Update' style='background-color:#d68b17 !important;'>Edit</a>";
                            }
                            item += "</td></tr>";
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
        $(document).ready(function () {

            BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
            BindUniversity();
        });
        function Search() {
            $("#hdfCurrentPageIndex").val(1);
            BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
            //BindUniversity();
        }

        function NextRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) + 1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
            //BindUniversity();
        }

        function PrevRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) - 1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
            //BindUniversity();
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
            $('#ddlUniversity').multiselect('deselectAll', false);
            $('#ddlUniversity').multiselect('updateButtonText');
            //BindUniversity();
        }

        function BindUniversity() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmStudentCouncil.aspx/BindUniversity",
                data: "{}",
                cache: false,
                async: false,
                dataType: "json",               
                success: function (response) {

                    $.each(response.d, function (key, value) {
                        $("#ddlUniversity").append($("<option></option>").val(value.uid).html(value.uname));
                    });

                    $.each(response.d, function (key, value) {
                        $("#ddlUniversityEdit").append($("<option></option>").val(value.uid).html(value.uname));
                    });
                    
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }

        function ViewStudent(id) {
           
            $("#tblDetails").html('');
            $.ajax({
                type: "POST",
                url: "frmStudentCouncil.aspx/GetDetails",
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    $("#tblDetails").html(response.d);
                    $("#myModal").modal("show");
                },
                failure: function (xhr, errorType, exception) {
                    showMsg("ERROR", "Something went wrong.!");
                    $("#tblDetails").html('');
                },
                error: function (response) {
                    $("#tblDetails").html('');
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }

        function Edit(id) {

            $("#tblDetails").html('');
            $.ajax({
                type: "POST",
                url: "frmStudentCouncil.aspx/EditUniversity",
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var len = data.d.length;
                    $("td.stName").append(data.d[0]["Name"]);
                    $("td.stRegNo").append(data.d[0]["RegNo"]);
                    $("#hdEditSId").val(data.d[0]["StudentId"]);
                    $("#hdEditId").val(data.d[0]["Id"]);

                    var x = document.getElementById("ddlUniversityEdit");
                    var Uid = '';
                    
                    for (var i = 0; i < x.options.length; i++) {
                        for (var k = 0; k < len; k++) {
                            Uid = x.options[i].value;
                            UidS = data.d[k]["UniversityId"];
                            if (Uid == UidS) {
                                //x.options[i].checked = true;
                                $("#ddlUniversityEdit").find("option[value=" + Uid + "]").prop("selected", true);
                                $("#ddlUniversityEdit").multiselect("refresh");
                            }
                        }
                    }


                    $("#myModalEdit").modal("show");
                },
                failure: function (xhr, errorType, exception) {
                    showMsg("ERROR", "Something went wrong.!");
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }

        function MoveStudent() {
            var UserId = $("#hdfUserId").val();
            var msgplateCount = 0;
            var x = document.getElementById("ddlUniversity");
            for (var i = 0; i < x.options.length; i++) {
                if (x.options[i].selected == true) {
                    msgplateCount = Number(msgplateCount) + Number(1);
                }
            }      
            //var Uid = $("#ddlUniversity").val();
            if (msgplateCount == '0') {
                showMsg("ERROR", "Please Select University. !");
                $("#ddlUniversity").focus();
                return false;
            } else {
                debugger;
                var uni = ''; var Uid = '';
                var x = document.getElementById("ddlUniversity");
                for (var i = 0; i < x.options.length; i++) {
                    if (x.options[i].selected == true) {
                        uni += x.options[i].text + ",";
                        Uid += x.options[i].value + ",";
                    }
                }

                var tbody= document.getElementById('gridUniversity');
                var rows = tbody.rows.length;
                var EventModel = new Array();
                var counter = 0;
                for (var r = 1; r <= rows; r++) {
                    var service = {};
                    document.getElementById('trId' + r).style.backgroundColor = '';
                    if (document.getElementById('chk' + r).checked == true) {
                        service.Uid = Uid;
                        service.UserId = UserId;
                        //service.EventId = document.getElementById('chk' + r).value;
                        service.Sid = $("#hdId" + r).val();
                        EventModel.push(service);
                        counter = Number(counter) + Number(1);
                    }
                }
                $.ajax({
                    type: "POST",
                    url: "frmStudentCouncil.aspx/MoveToUniversity",
                   // data: "{'Uid':'" + Uid + "','Sid':'" + Sid + "','UserId':'" + UserId + "'}",
                    data: "{'_Events':" + JSON.stringify(EventModel) + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == "S") {
                            showMsg("SUCCESS", "User has been Moved successfully.!");
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
            }
            return false;
        }

        function UpdateAndMoveStudent() {
            var UserId = $("#hdfUserId").val();
            var msgplateCount = 0;
            var x = document.getElementById("ddlUniversityEdit");
            for (var i = 0; i < x.options.length; i++) {
                if (x.options[i].selected == true) {
                    msgplateCount = Number(msgplateCount) + Number(1);
                }
            }
            //var Uid = $("#ddlUniversity").val();
            if (msgplateCount == '0') {
                showMsg("ERROR", "Please Select University. !");
                $("#ddlUniversity").focus();
                return false;
            } else {
                debugger;
                var uni = ''; var Uid = '';
                var x = document.getElementById("ddlUniversityEdit");
                for (var i = 0; i < x.options.length; i++) {
                    if (x.options[i].selected == true) {
                        uni += x.options[i].text + ",";
                        Uid += x.options[i].value + ",";
                    }
                }
                var EventModel = new Array();
                var service = {};
                service.Uid = Uid;
                service.UserId = UserId;
                service.Sid = $("#hdEditSId").val();
                EventModel.push(service);
                $.ajax({
                    type: "POST",
                    url: "frmStudentCouncil.aspx/MoveToUniversity",
                    // data: "{'Uid':'" + Uid + "','Sid':'" + Sid + "','UserId':'" + UserId + "'}",
                    data: "{'_Events':" + JSON.stringify(EventModel) + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == "S") {
                            showMsg("SUCCESS", "Student has been Updated & Moved successfully.!");
                            RefreshGrid();
                            $("#myModalEdit").modal("hide");

                        }
                        else if (response.d == "ER") {
                            showMsg("ERROR", "Something went wrong.!");
                        }
                    },
                    error: function (response) {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                });
            }
            return false;
        }
       
            setInterval(function () {
                BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
                //BindUniversity();
            }, 30000);
       
        function SetIFrameSource() {
            $("#ifrmmodify").attr("src", "<%=strVideoAPI%>");
        }
        $(function () { SetIFrameSource(); });
        
    </script>
    
 </div> 

            </div>

  <script src="../js/comman.js"></script>
        <script type="text/javascript">


            function ClearMsg() {
                $("#divSuccess").html('');
                $("#divError").html('');

                if ($("#divSuccess").hasClass("d-none")) {

                }
                else {
                    $("#divSuccess").addClass('d-none');
                }
                if ($("#divError").hasClass("d-none")) {

                }
                else {
                    $("#divError").addClass('d-none');
                }
            }

            $(function () {
                $('[data-toggle="tooltip"]').tooltip()
            })


         </script>

<%-- <script src="../multiselectcssjs/bootstrap.min.js"></script>--%>
    <link href="../multiselectcssjs/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="../multiselectcssjs/bootstrap-multiselect.js"></script>
         <script type="text/javascript">
             function BindControlEvents() {
                 $('[id*=ddlUniversity]').multiselect({
                     includeSelectAllOption: false,
                     numberDisplayed:1,
                     nonSelectedText: 'Select University'
                 });

             }
             $(document).ready(function () {
                 BindControlEvents();
                 Sys.WebForms.PageRequestManager.getInstance().add_endRequest(BindControlEvents);
             });
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
            /*background-color: transparent;*/
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
       .btn-group{
           width:100% !important;
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
       

            
   </form>      </body>
    </html>


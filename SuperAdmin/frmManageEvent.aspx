<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/MasterPageSuperAdmin.master" AutoEventWireup="true" CodeFile="frmManageEvent.aspx.cs" Inherits="SuperAdmin_frmManageEvent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      
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
    
    </style>
    <asp:HiddenField ID="hdfUserId" runat="server" />
    <asp:HiddenField ID="hdfEid" runat="server" />
     <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
     <div class="rowse"> <%--management--%>
                <div class="management">
                   
                <div class="mform">
                    <div class="row">
                        <div class=" col-sm-4" >
                             <label for="lblEventName" class="manag_label">Event Name <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <input type="text" maxlength="100" class="form-control" id="txtEventName" placeholder="event name" />
                          </div>
                    <div class=" col-sm-4" >
                             <label for="lblEvDetail" class="manag_label">Event Detail <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <input type="text" maxlength="500" class="form-control" id="txtEventDetail" placeholder="event detail" />
                          </div>
                        <div class=" col-sm-4" >
                            <label for="lblEventDate" class="manag_label">Event Date <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <input type="datetime-local" class="form-control" id="dtEventDate" />
                            
                          </div>
                       </div>
                   
                    <div class="row">  
                        <div class=" col-sm-4">
                              <label for="txtEventURL" class="manag_label">Event URL <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <input type="url" class="form-control" id="txtEventURL" placeholder="event url" />
                        </div>
                   <div class="col-sm-4" >
                          <label for="lblRegion" class="manag_label">Region <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                             <select id="ddlRegion" class="form-control">
                           </select>
                            
                          </div>
                      
                           
                        <div class="col-sm-4">
                              <label for="txtStatus" class="manag_label">Status <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                               <select id="ddlStatus" class="form-control">
                                   <option value="0" selected="selected">-Select Status-</option>
                                   <option value="Yes">Active</option>
                                   <option value="No">Inactive</option>
                               </select>
                          </div>
                        </div>
                            <div class="row">
                       
                          <div class="col-sm-4">
                            
                          </div>
                                <div class="col-sm-4">
                                <a href="javascript:void();" id="btnSave" onclick="return AddUpdateEvent();" class="btn btn-success" style="margin: 0;">create</a>

                                    </div>

                                <div class="col-sm-4" style="vertical-align:bottom;text-align:center;margin-top:30px;">
                                    </div>

                                </div>
                       
                   </div>
        </div> 

 </div>
         
     
        <div>
                <div style="width:20%;float:left;" class="form-group has-search">
                <span class="fa fa-search form-control-feedback"></span>
      <input type="text" class="form-control" id="txtSearch" onkeyup="Search()" placeholder="Search for EventName" />

         
                    </div>
    <div style="float:right;">
              <table><tr><td><img src="img/refresh.png" height="30" style="cursor:pointer" id="imgRefresh" data-toggle="tooltip" data-placement="bottom" title="Reload Data" alt="refresh" onclick="RefreshGrid();" />

                         </td><td><a target="_blank" href="javascript:void();" data-toggle="tooltip" data-placement="bottom" title="Excel Download" onclick="ExcelDownload(); ">
                    <img src="img/excel.png" height="35" />
                </a></td></tr>
              </table>
                
                
                </div>
    </div>
            <div class="tabel_wrapper" id="divTable">

            </div>
            <div class="row">
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
<style>
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
       </style> 
    <script>
        function Search() {
            $("#hdfCurrentPageIndex").val(1);
            BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
        }

      
    </script>
    <script type="text/javascript">

       
        function BindRegion() {
            $.ajax({
                type: "POST",
                url: "frmManageEvent.aspx/BindRegion",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#ddlRegion").html(response.d);
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        $(document).ready(function () {
            BindRegion();
            RefreshGrid();
          
        });
        $(document).ready(function () {
            elem = document.getElementById("dtEventDate")
            var iso = new Date().toISOString();
            var minDate = iso.substring(0, iso.length - 1);
            elem.value = minDate
            elem.min = minDate
        });

        function ViewDetails(id) {
            $("#tblDetails").html('');
            $.ajax({
                type: "POST",
                url: "frmManageEvent.aspx/ViewEventData",
                data: "{'EventId':'" + id + "'}",
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
        ///Binnd table with paging Start

        function BindGrid(SearchValue,RowPerPage, PageNumber) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');
            $.ajax({
                type: "POST",
                url: "frmManageEvent.aspx/BindList",
                data: "{'SearchValue':'" + SearchValue+"','RowPerPage':'" + RowPerPage + "','PageNumber':'" + PageNumber + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    $("#MyTable").empty();
                    var Data = '';
                    Data = "<table id='MyTable'>";
                    Data += "<tr style='background-color:#d7d7f7;border:1px solid gray;'>";
                    Data += "<th style='width:60px;border:1px solid gray;'>S No-</th>";
                    Data += "<th style='width:75px; text-align:center;border:1px solid gray;'>Action</th>";
                    Data += "<th style='border:1px solid gray;'>Event Name</th>";
                    Data += "<th style='border:1px solid gray;'>Event Detail</th>";
                    Data += "<th style='border:1px solid gray;'>Event Date</th>";
                    Data += "<th style='border:1px solid gray;'>Event URL</th>";
                    Data += "<th style='border:1px solid gray;'>Region</th>";
                    Data += "<th style='border:1px solid gray;'>Status</th>";
                    Data += "<th style='border:1px solid gray;'>Created By</th>";
                    //Data += "<th style='border:1px solid gray;'>Created On</th>";
                    Data += "<th style='border:1px solid gray;'>Updated By</th>";
                    //Data += "<th style='border:1px solid gray;'>Updated On</th>";
                    Data += "</tr>";
                    if (len > 0) {
                        $("#curIndex").html($("#hdfCurrentPageIndex").val());
                        if (Number(response.d[len - 1].SNo) < Number(response.d[0].TotalRows)) {
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
                        var Id = '';
                        var redirect = '';
                        $("#sampleTable_info").html('&nbsp;Showing ' + response.d[0].SNo + ' to ' + response.d[len - 1].SNo + ' of ' + len + ' records');

                       // $("#divTable").html(response.d);
                        for (var i = 0; i < len; i++) {
                            Id = response.d[i].EventId;
                            Data += "<tr>";
                            Data += "<td>" + response.d[i].SNo + "</td>";
                            Data += "<td><a href='javascript:void();' onclick='return GetEditData(" + Id + ");'>Edit</a><a href='javascript:void();' onclick='return Delete(" + Id + ");' class='btn-danger' style='background-color:#dc3545!important'>Delete</a><a href='javascript:void(0); class='btn-sm btn-info viewData' style='display:inline;background-color:#17a2b8;' data-toggle='modal' onclick='return ViewDetails(" + Id + ");'>View</a></td>";
                            Data += "<td>" + response.d[i].EventName + "</td>";
                            Data += "<td>" + response.d[i].EventDetail + "</td>";
                            Data += "<td>" + response.d[i].EventDate + "</td>";
                            Data += "<td style='word-break: break-word;'>" + response.d[i].EventURL + "</td>";
                            Data += "<td>" + response.d[i].Region + "</td>";
                            Data += "<td>" + response.d[i].Status + "</td>";
                            Data += "<td>" + response.d[i].CreatedBy + "</td>";
                            //Data += "<td>" + response.d[i].CreatedOn + "</td>";
                            Data += "<td>" + response.d[i].UpdatedBy + "</td>";
                            //Data += "<td>" + response.d[i].UpdatedOn + "</td>";
                            Data += "</tr>";

                           
                        }
                        Data += "</table>";
                        $("#divTable").html(Data);
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
                }
            });
        }
          
        //window.onload = BindGrid($("#txtSearch").val(),$("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());

        function NextRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) + 1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtSearch").val(),RowPerPage, PageNumber);
        }

        function PrevRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) - 1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtSearch").val(),RowPerPage, PageNumber);
        }

        function PageSize() {
            $("#hdfCurrentPageIndex").val(1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtSearch").val(),RowPerPage, PageNumber);
            }
        ///bind table END
        function RefreshGrid() {
            $("#hdfCurrentPageIndex").val(1);
            $("#txtSearch").val('')
            $("#ddlPageSize").val(10);
            document.getElementById("btnSave").innerHTML = 'Create';
            $("#txtEventName").val('');
            $("#txtEventDetail").val('');
            $("#ddlRegion").val(0);
            $("#txtEventURL").val('');
            $("#ddlStatus").val(0);
            $("#dtEventDate").val('');
            $("#ContentPlaceHolder1_hdfEid").val('');
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtSearch").val(),RowPerPage,PageNumber);
        }

        function ExcelDownload() {
            var SearchValue = $("#txtSearch").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Status = "Event";
            window.location.href = "download.aspx?Status=" + Status + "&SearchValue=" + SearchValue + "&RowPerPage=" + RowPerPage + "&PageNumber=" + PageNumber;
        }

        function AddUpdateEvent() {
            var EventName = $("#txtEventName").val();
            var EventDetail = $("#txtEventDetail").val();
            var RegionId = $("#ddlRegion").val();
            var EventURL = $("#txtEventURL").val();
            var Status = $("#ddlStatus").val();
            var EventDate = $("#dtEventDate").val();
            var CreatedBy = $("#ContentPlaceHolder1_hdfUserId").val();
            var EventId = $("#ContentPlaceHolder1_hdfEid").val();
            //var atpos = EventURL.indexOf("@");
            var dotpos = EventURL.lastIndexOf(".");

             if (EventName.trim() == '') {
                showMsg("ERROR", "Please Enter Event Name.!");
                $("#txtEventName").focus();
                return false;
            }            
            else if (RegionId == '0') {
                showMsg("ERROR", "Please Select Region. !");
                $("#ddlRegion").focus();
                return false;
            }
            
            else if (Status == '0') {
                showMsg("ERROR", "Please Select Status. !");
                $("#ddlStatus").focus();
                return false;
            }
            else if (EventDate.trim() == '') {
                showMsg("ERROR", "Please Enter EventDate. !");
                $("#dtEventDate").focus();
                return false;
             }
             else if (EventURL.trim() == '') {
                 showMsg("ERROR", "Please Enter EventURL. !");
                 $("#txtEventURL").focus();
                 return false;
             }
            //else if (dotpos < atpos + 2 || dotpos + 2 >= EventURL.length) {
            //    showMsg("ERROR", "Please Fill Valid URL. !");
            //     $('#txtEventURL').focus();
            //    return false;
            //}

            document.getElementById("btnSave").disabled = true;
            document.getElementById("btnSave").innerHTML = 'Please wait..';
            $.ajax({
                type: "POST",
                url: "frmManageEvent.aspx/AddUpdateEvent",
                data: "{'EventId':'" + EventId + "','EventName':'" + EventName + "','EventDetail':'" + EventDetail + "','EventURL': '" + EventURL + "','Status': '" + Status + "', 'EventDate': '" + EventDate + "', 'RegionId':'" + RegionId + "', 'CreatedBy':'" + CreatedBy + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if (sts == "1") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("ERROR", "Event Name Already Exists.!");
                        return false;
                    }
                    else if (sts == "4") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("SUCCESS", "Data updated successfully.!");
                        $("#txtEventName").val('');
                        $("#txtEventDetail").val('');
                        $("#ddlRegion").val(0);
                        $("#txtEventURL").val('');
                        $("#ddlStatus").val(0);
                        $("#dtEventDate").val('');
                        $("#ContentPlaceHolder1_hdfEid").val('');
                        RefreshGrid();
                        return false;
                    }
                    else if (sts == "5") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("SUCCESS", "Data saved successfully.!");
                        $("#txtEventName").val('');
                        $("#txtEventDetail").val('');
                        $("#ddlRegion").val(0);
                        $("#txtEventURL").val('');
                        $("#ddlStatus").val(0);
                        $("#dtEventDate").val('');
                        $("#ContentPlaceHolder1_hdfEid").val('');
                        RefreshGrid();
                        return false;
                    }
                    else if (sts == "ER") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("ERROR", "Something went wrong.!");
                        return false;
                    }
                },
                error: function (response) {
                    document.getElementById("btnSave").disabled = false;
                    document.getElementById("btnSave").innerHTML = 'Create';
                    showMsg("ERROR", "Something went wrong.!");
                    return false;
                }
            });
        }

        function GetEditData(EventId) {
            $("#txtEventName").val('');
            $("#txtEventDetail").val('');
            $("#ddlRegion").val(0);
            $("#txtEventURL").val('');            
            $("#dtEventDate").val('');
            $("#ddlStatus").val(0);
            $("#ContentPlaceHolder1_hdfEid").val('');
            
           

            $.ajax({
                type: "POST",
                url: "frmManageEvent.aspx/GetEditEventData",
                data: "{'EventId':'" + EventId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#txtEventName").val(response.d[0].EventName);
                    $("#txtEventDetail").val(response.d[0].EventDetail);
                    $("#ddlRegion").val(response.d[0].Region);
                    $("#txtEventURL").val(response.d[0].EventURL);
                    $("#dtEventDate").val(response.d[0].EventDate);
                    $("#ddlStatus").val(response.d[0].Status);
                    $("#ContentPlaceHolder1_hdfEid").val(response.d[0].EventId);
                    document.getElementById("btnSave").innerHTML = 'Update';
                  
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            
            return false;
        }

        function Delete(EventId) {

            var cnf = confirm('Are you sure to Delete ?');
            if (cnf == false)
                return false;

            $.ajax({
                type: "POST",
                url: "frmManageEvent.aspx/DeleteEvent",
                data: "{'EventId':'" + EventId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "D") {
                        showMsg("SUCCESS", "Record Delete successfully.!");
                        RefreshGrid();
                    }
                    else if (response.d == "ER") {
                        showMsg("ERROR", "Something went wrong.!");
                        RefreshGrid();
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }

    </script>
        <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
            <h4>Event Details</h4>
          <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
          
        </div>
        
        <div class="modal-body">
<table id="tblDetails">   
    
</table>
                 </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

</asp:Content>


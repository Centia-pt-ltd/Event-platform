<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/MasterPageSuperAdmin.master" AutoEventWireup="true" CodeFile="EventManagement.aspx.cs" Inherits="SuperAdmin_EventManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        #tbodyUniversity tr:hover{ background-color:azure}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField ID="hdfUserId" runat="server" />  
    <input type="hidden" id="hdfEventId" value="0" />  
    <input type="hidden" id="hdfStatus" value="No" /> <%-- Nidhi--%>
    <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
    <div style="overflow:auto;max-width:100%;max-height:calc(100vh - 100px);">
            <div class="tabel_wrapper">
                <div class="form-inline" style="margin-top:10px; margin-bottom:10px">
                <div class="form-group">
                    &nbsp;<label for="email">Event Name  <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></label>
                    &nbsp;<input type="text" class="form-control" id="txtEventName" style="width:400px" maxlength="200" placeholder="max(200) characters" />
                  </div>
                  <div class="form-group">
                    &nbsp;<label for="pwd">Event Date  <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></label>
                    &nbsp;<input type="datetime-local" class="form-control" id="txtEventDateTime" />
                  </div>
                    <div class="form-group">
                        &nbsp;<input type="button" class="form-control btn btn-primary" value="Save" id="btnSave" onclick="return AddUpdateEvent();" />
                        &nbsp;<input type="button" class="form-control btn btn-success" value="Add New" id="btnReload" onclick="return ReloadPage();" />

                    </div>
 
                </div>
                <div style="max-height:400px; overflow-y:scroll">
                <table>                    
                    <thead><tr><th>SNo</th><th style='text-align:center'>Select</th><th>University</th><th>Booth</th><th>Position</th></tr></thead>
                    <tbody id="tbodyUniversity">
                        <%=_sbHtml %>
                    </tbody>
                </table>
                    
                </div>
                <hr style="border-top: 3px double #8c8b8b;margin-right:5px;" />
                <div class="search_wrapper" style="border:1px solid lightgray;border: 1px solid lightgray;width: 300px;margin-left: 1px;display:inline;">
                    <span class="fa fa-search" style="color:lightgray;margin-left:5px;"></span>
                <input type="text" id="txtSearch" onkeyup="return Search();" placeholder="search by name, email, logintype" style="margin-left:15px;width:240px;border:none; margin-top:27px" />
                </div>
                <div class="icon_exel">
                <img src="img/refresh.png" height="30" style="cursor:pointer; margin-top:22px" data-toggle="tooltip" data-placement="bottom" title="Reload Data" id="imgRefresh" alt="refresh" onclick="RefreshGrid();" />
                
                </div>
                <table style="overflow-y:scroll" >
                    <thead>
                    <th>SNo.</th>
                    <th>Action</th>
                    <th>Event Name</th>
                    <th>EventDateTime</th>
                    <th>Active</th>
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
                <!-- Model upload-->
    <div class="modal fade" id="modelChangeStatus" role="dialog">
    <div class="modal-dialog modal-lg">
          <div class="modal-content">
        <div class="modal-header">
            <h4>Change Status</h4>
            
          <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
          
        </div>
        
        <div class="modal-body">
            <table>
                <tr>
                    <td><span>Message <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><textarea id="txtMsg" maxlength="300" placeholder="max (300) characters" cols="75"></textarea><br /></td>
                </tr>
                <tr>
                    <td><span>Active </span></td>
                    <td><input type="checkbox" id="chkEventSts" value="" /></td>
                </tr>
            </table>    
            
         
         </div>
        <div class="modal-footer">
            <input type="hidden" id="hdfStatusId" />
            <input type="button" id="btnChangeStatus" onclick="return ChangeStatus();" class="btn btn-primary" value="Save" />
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </div>
        </div>
     
    <!-- End Model Upload-->

    <script type="text/javascript">

        function OpenStatusPopup(EventId) {
            $("#hdfStatusId").val(EventId);
            $("#txtMsg").val('');
            document.getElementById('chkEventSts').checked = false;
            $.ajax({
                type: "POST",
                url: "EventManagement.aspx/GetStatusMsg",
                data: "{'EventId':'" + EventId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var msg = data.d.split('||')[0];
                    var sts = data.d.split('||')[1];
                    $("#txtMsg").val(msg);
                    if (sts.trim().toUpperCase() == "YES")
                        document.getElementById('chkEventSts').checked = true;
                    else
                        document.getElementById('chkEventSts').checked = false;

                    $("#modelChangeStatus").modal("show");
                },
                error: function (data) {
                    $("#modelChangeStatus").modal("hide");
                    showMsg("ERROR", 'Something went wrong. !');
                }
            });
        }

        function ChangeStatus() {

            var EventId = $("#hdfStatusId").val();
            var Msg = $("#txtMsg").val();
            if (Msg.trim() == '') {
                showMsg("ERROR", 'Please Enter Message. !');
                $("#txtMsg").focus();
                return false;
            }
            var sts = '';
            if (document.getElementById('chkEventSts').checked == true)
                sts = 'Yes';
            else
                sts = 'No';

            document.getElementById("btnChangeStatus").disabled = true;
            document.getElementById("btnChangeStatus").value = 'Please wait..';

            $.ajax({
                type: "POST",
                url: "EventManagement.aspx/ChangeEventStatus",
                data: "{'EventId':'" + EventId + "','Msg':'" + Msg + "','sts':'" + sts + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    document.getElementById("btnChangeStatus").disabled = false;
                    document.getElementById("btnChangeStatus").value = 'Save';
                    if (data.d == "S") {
                        showMsg("SUCCESS", 'Status has been changed successfully. !');
                        RefreshGrid();
                        $("#txtMsg").val();
                        $("#hdfStatusId").val('');
                        $("#modelChangeStatus").modal("hide");
                    }
                    else if (data.d == "ER") {
                        showMsg("ERROR", 'Something went wrong. !');
                    }
                },
                error: function (data) {
                    document.getElementById("btnChangeStatus").disabled = false;
                    document.getElementById("btnChangeStatus").value = 'Save';
                    showMsg("ERROR", 'Something went wrong. !');
                }
            });
            return false;
        }

        $(document).ready(function () {
            elem = document.getElementById("txtEventDateTime")
            var iso = new Date().toISOString();
            var minDate = iso.substring(0, iso.length - 1);
            elem.value = minDate
            elem.min = minDate
        });

        function BindGrid(SearchValue, RowPerPage, PageNumber) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');

            $.ajax({
                type: "POST",
                url: "EventManagement.aspx/BindList",
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
                        var chk = '';
                        $("#sampleTable_info").html('&nbsp;Showing ' + data.d[0].SNo + ' to ' + data.d[len - 1].SNo + ' of ' + data.d[0].TotalRows + ' records');
                        for (var k = 0; k < len; k++) {
                            id = data.d[k].EventId;
                            chk = "chk" + id;
                            item += "<tr>";
                            item += "<td>" + data.d[k].SNo + "</td>";
                            item += "<td><a href='javascript:void(0);' onclick='return ShowEditReg(" + id + ");' class='btn-sm btn-success'>Edit</a>&nbsp;<a href='javascript:void(0);' onclick='return OpenStatusPopup(" + id + ");' class='btn-sm btn-info' style='background-color:#17a2b8 !important'>Status</a>&nbsp;<a href='javascript:void();' onclick='return DeleteEvent(" + id + ");' class='btn-danger' style='background-color:#dc3545!important'>Delete</a></td>";
                            item += "<td>" + data.d[k].EventName + "</td>";
                            item += "<td>" + data.d[k].EventDate + "</td>";
                            item += "<td>" + data.d[k].Status + "</td>";
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

        function AddUpdateEvent() {

            var tbody = document.getElementById('tbodyUniversity');
            var rows = tbody.rows.length;
            if (document.getElementById('txtEventName').value.trim() == '') {
                showMsg("ERROR", 'Please Enter Event Name. !');
                return false;
            }
            else if (document.getElementById('txtEventDateTime').value.trim() == '') {
                showMsg("ERROR", 'Please Enter Event Date. !');
                return false;
            }
            var EventModel = new Array();
            var counter = 0;
            for (var r = 1; r <= rows; r++) {
                var service = {};
                document.getElementById('trId' + r).style.backgroundColor = '';
                if (document.getElementById('chk' + r).checked == true) {
                    service.EventName = document.getElementById('txtEventName').value;
                    service.EventDate = document.getElementById('txtEventDateTime').value;
                    //service.EventId = document.getElementById('chk' + r).value;
                    service.EventId = document.getElementById('hdfEventId').value;
                    service.Universityid = document.getElementById('tdUId' + r).getAttribute("data-id");
                    service.BoothId = $('#DdlBoothId' + r).val();
                    service.Position = $('#DdlPos' + r).val();
                    service.LineNo = r;
                    service.Status = document.getElementById('hdfStatus').value; //Nidhi
                    EventModel.push(service);
                    counter = Number(counter) + Number(1);
                }
                if (document.getElementById('chk' + r).checked == true && $('#DdlPos' + r).val() == "0") {
                    document.getElementById('chk' + r).focus();
                    document.getElementById('trId' + r).style.backgroundColor = '#f8d7da';
                    showMsg("ERROR", "Please select Position. !");
                    return false;
                }
            }

            if (counter == 0) {
                showMsg("ERROR", "Please select University. !");
                return false;
            }

            document.getElementById("btnSave").disabled = true;
            document.getElementById("btnSave").value = 'Please wait..';

            $.ajax({
                type: "POST",
                url: "EventManagement.aspx/AddUpdateEvent",
                data: "{'_Events':" + JSON.stringify(EventModel) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    document.getElementById("btnSave").disabled = false;
                    document.getElementById("btnSave").value = 'Save';
                    if (response.d == "S" || response.d == "U") {
                        document.getElementById('hdfEventId').value = '0';
                        RefreshGrid();
                        BindHtmlUniversity();
                        document.getElementById('txtEventName').value=''
                        document.getElementById('txtEventDateTime').value = '';
                        $("#hdfStatus").val('No');     //Nidhi
                        showMsg("SUCCESS", "Records have been saved successfully. !");                        
                    }
                    else if (response.d == "EX") {
                        showMsg("ERROR", "Event Name already Exists.!");
                    }
                    else if (response.d == "ER") {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                },
                error: function (response) {
                    document.getElementById("btnSave").disabled = false;
                    document.getElementById("btnSave").value = 'Save';
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }

        function ShowEditReg(EventId) {
            $("#tbodyUniversity").empty();
            $("#tbodyUniversity").html("<img src='img/loader.gif' alt='loader' height='120'><span style='margin-left:-65px; position:absolute; margin-top:53px'>Please wait...</span>");
            document.getElementById('hdfEventId').value = EventId;
            $.ajax({
                type: "POST",
                url: "EventManagement.aspx/GetEditEventTable",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    setTimeout(function () {

                        $("#tbodyUniversity").empty();
                        $("#tbodyUniversity").append(response.d);

                        $.ajax({
                            type: "POST",
                            url: "EventManagement.aspx/FillEditData",
                            data: "{'EventId':'" + EventId + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {                           

                                var len = data.d.length;
                                var MappedLineNo = '';
                                var tbody = document.getElementById('tbodyUniversity');
                                var rows = tbody.rows.length;

                                $("#txtEventName").val(data.d[0].EventName);
                                $("#txtEventDateTime").val(data.d[0].EventDate); 
                                $("#hdfStatus").val(data.d[0].Status); //Nidhi
                                var CRowsUniversityId = '', MRowsUniversityId = '';
                                for (var i = 0; i < len; i++) {
                                    for (var j = 1; j <= rows; j++) {
                                        MappedLineNo = data.d[i].LineNo;
                                        CRowsUniversityId = data.d[i].Universityid;
                                        MRowsUniversityId = $("#tdUId" + j).attr("data-id");
                                        if (CRowsUniversityId == MRowsUniversityId) {
                                            document.getElementById('chk' + j).checked = true;
                                            document.getElementById('chk' + j).value = data.d[i].EventId;
                                            $('#tdUId' + j).attr('data-id', data.d[i].Universityid);
                                            $('#DdlBoothId' + j).val(data.d[i].BoothId);
                                            $('#DdlPos' + j).val(data.d[i].Position);
                                            setPos(data.d[i].Position, "DdlPos" + j); //Nidhi
                                        }
                                    }
                                }                            

                                return false;

                            },
                            error: function (response) {
                                $("#tbodyUniversity").empty();
                                showMsg("ERROR", "Something went wrong.!");
                            }
                        });
                    }, 2000);
                    // end                                     
                },
                error: function (response) {
                    $("#tbodyUniversity").empty();
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }

        function DeleteEvent(EventId) {
            var cnf = confirm('Are you sure to Delete ?');
            if (cnf == false)
                return false;

            $.ajax({
                type: "POST",
                url: "EventManagement.aspx/DeleteEvent",
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
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }


        function BindHtmlUniversity() {
            $("#tbodyUniversity").empty();
            $("#tbodyUniversity").html("<img src='img/loader.gif' alt='loader' height='120'><span style='margin-left:-65px; position:absolute; margin-top:53px'>Please wait...</span>");

            $.ajax({
                type: "POST",
                url: "EventManagement.aspx/GetEditEventTable",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    setTimeout(function () {
                        $("#tbodyUniversity").empty();
                        $("#tbodyUniversity").append(response.d);
                    }, 2000);
                    // end                                     
                },
                error: function (response) {
                    $("#tbodyUniversity").empty();
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }

        function ReloadPage() {
            location.href = 'EventManagement.aspx';
        }


        //Nidhi Start
       // $(document).ready(function () {

            $(".position").change(function () {
                var selected = $("option:selected", $(this)).val();
                var thisID = $(this).prop("id");
                if (selected != 0) {
                    $(".position").each(function () {
                        if ($(this).prop("id") != thisID) {
                            if (selected == $(this).val()) {
                                //$("option[value='" + selected + "']", $(this)).remove();
                                alert("Warning!! \nThis Position is already assigned, Choose different position !!")
                                $("#" + thisID).val(0);
                            }
                        }
                   
                });
 }
            });

        function setPos(selected, thisID) {
            $(".position").each(function () {
                if ($(this).prop("id") != thisID) {
                    $("option[value='" + selected + "']", $(this)).remove();
                }
            });
        }
       // });

document.getElementById('txtEventName').onkeydown = function (event) {
                if (event.keyCode == 13) {
                    AddUpdateEvent();
                    return false;
                }
            }
            document.getElementById('txtEventDateTime').onkeydown = function (event) {
                if (event.keyCode == 13) {
                    AddUpdateEvent();
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
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>--%>

</asp:Content>


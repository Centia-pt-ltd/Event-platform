<%@ Page Title="" Language="C#" MasterPageFile="~/University/MasterPageUniversity.master" AutoEventWireup="true" CodeFile="frmAssignRoom.aspx.cs" Inherits="University_frmAssignRoom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .modalTable table{
            background-color:white;
            font-size:15px;
             border: 0px none #fff !important;
        }
        .modalTable td,th {
            background-color:white;
             font-size:15px;
             border: 0px none #fff !important;
        }
        .modalTable tr {
           
             border: 0px none #fff !important;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
    <asp:HiddenField ID="hdfUserId" runat="server" />
   <div>
    <div class="row" style="width:100%;">
            
        
        <div class="filter" style="margin-bottom:10px">
                <asp:Button ID="btnAdd" runat="server" OnClientClick="return AssignRoom();" Text="+ Assign Room" CssClass="form-control btn btn-primary" style="font-size:18px; font-weight:bold; height:39px" />
        </div>
</div>
  <div style="overflow:auto;max-width:100%;max-height:calc(100vh - 210px);">    
            <table id="customers" style="overflow-y:scroll;font-size:14px !important;">
                <thead>
                    <tr><th>S.No</th>
                    <th style="width:150px;">Action</th>                    
                    <th>Room Name</th>                    
                    <th>User Name</th>
                </tr></thead>
                <tbody id="gridRoom">

                </tbody>

            </table>
</div>
<div class="row" style="width:95%">
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
  

    

    <!-- Modify Notes-->
    <div class="modal" id="modelNotes">
    <div class="modal-dialog">
      <div class="modal-content" style="width:450px;">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Assign Room</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError3" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">

             <table class="modalTable" style=" border: 0px none #fff !important;">
               
                 <tr>
                     <td><span>Room Name : <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></span> </td>
                     <td><div class="select_box">
                        <select class="slect_item" id='ddlRoom' style="width:100%;"> 
                          
                        </select>  <%--class='university'--%>
                       </div></td>
                 </tr>
                  <tr>
                    <td><span>User Name : <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><div class="select_box">
                        <select class="slect_item" id='ddlUser' style="width:100%;"> 
                           
                        </select>  <%--class='university'--%>
                       </div></td>
                </tr>
                 </table>
            
          
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
            <input type="hidden" id="hdfRoomId" />
            <asp:Button ID="btnNotes" runat="server" CssClass="btn btn-success" Text="Save" OnClientClick="return AddUpdateRoom();" />
            
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->

       

          

    <script type="text/javascript">
        function BindGrid(RowPerPage, PageNumber) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');
            
            $.ajax({
                type: "POST",
                url: "frmAssignRoom.aspx/BindList",
                data: "{'RowPerPage':'" + RowPerPage + "','PageNumber':'" + PageNumber + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var len = data.d.length;
                    $("#gridRoom").empty();
                    var item = '';
                    if (len > 0) {

                        var id = '';
                        var redirect = '';
                        var chk = '';
                        for (var k = 0; k < len; k++) {
                            id = data.d[k].Id;
                            item += "<tr>";
                            item += "<td>" + data.d[k].SNo + "</td>";
                            item += "<td><a href='javascript:void(0);' id=btnE" + id + " class='btn-sm btn-info' onclick='return Edit(" + id + ");' >Edit</a>&nbsp;<a href='javascript:void(0);' id=btnD" + id + " onclick='return Delete(" + id + ");' class='btn-sm btn-danger'>Delete</a></td>";
                            item += "<td>" + data.d[k].RoomName + "</td>";
                            item += "<td>" + data.d[k].Name + "</td>";

                            item += "</tr>";
                        }
                        $("#gridRoom").append(item);
                   
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
                        $("#sampleTable_info").html('&nbsp;Showing ' + data.d[0].SNo + ' to ' + data.d[len - 1].SNo + ' of ' + data.d[0].TotalRows + ' records');
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
            BindGrid($("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
            BindUniversityUser();
            BindRoom();
        });

        function NextRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) + 1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var UserId = $("#ContentPlaceHolder1_hdfUserId").val();
            BindGrid(Region, RowPerPage);
        }

        function PrevRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) - 1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var UserId = $("#ContentPlaceHolder1_hdfUserId").val();
            BindGrid(Region, RowPerPage);
        }

        function PageSize() {
            $("#hdfCurrentPageIndex").val(1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var UserId = $("#ContentPlaceHolder1_hdfUserId").val();
            BindGrid(Region, RowPerPage);
        }

        function RefreshGrid() {
            $("#hdfCurrentPageIndex").val(1);
            $("#ddlPageSize").val(10);

          
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid(RowPerPage, PageNumber);
            return false;
        }

        function BindUniversityUser() {
            $("#ddlUser option").remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmAssignRoom.aspx/BindUniversityUser",
                data: "{}",
                cache: false,
                async: false,
                dataType: "json",
                success: function (response) {

                    $.each(response.d, function (key, value) {
                        $("#ddlUser").append($("<option></option>").val(value.uid).html(value.uname));
                    });
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        function BindRoom() {
            $("#ddlRoom option").remove();
            $.ajax({
                
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmAssignRoom.aspx/BindRoom",
                data: "{}",
                cache: false,
                async: false,
                dataType: "json",
                success: function (response) {

                    $.each(response.d, function (key, value) {
                        $("#ddlRoom").append($("<option></option>").val(value.rid).html(value.rname));
                    });
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        function BindAssignedRoom() {
            $("#ddlRoom option").remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmAssignRoom.aspx/BindAssignedRoom",
                data: "{}",
                cache: false,
                async: false,
                dataType: "json",
                success: function (response) {

                    $.each(response.d, function (key, value) {
                        $("#ddlRoom").append($("<option></option>").val(value.rid).html(value.rname));
                    });
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }

        function AssignRoom() {
            $("#hdfRoomId").val('0');
            $("#ddlRoom").attr("disabled", false);
            BindRoom();
            BindUniversityUser();
            $("#modelNotes").modal("show");
            return false;
        }

        function Edit(id) {           
            $("#hdfRoomId").val(id);
            BindAssignedRoom();
            BindUniversityUser();
            $.ajax({
                type: "POST",
                url: "frmAssignRoom.aspx/Edit",
                data: "{'RId':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                   $("#ddlUser").append($("<option></option>").val(data.d[0].uid).html(data.d[0].uname));
                   
                    $("#ddlUser").val(data.d[0].uid);
                    $("#ddlRoom").val(id);
                    $("#ddlRoom").attr("disabled", true);
                    $("#modelNotes").modal("show");
                    return false;
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong. !");
                }
            });
            return false;
        }
        function Delete(id) {
            $.ajax({
                type: "POST",
                url: "frmAssignRoom.aspx/Delete",
                data: "{'RId':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "S") {
                        BindGrid($("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
                        showMsg("SUCCESS", "Record Deleted successfully. !");                       
                        return false;
                    }
                    else {
                        showMsg("ERROR", "Something went wrong. !");
                        return false;
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong. !");
                }
            });
            return false;
        }

        function AddUpdateRoom() {
            var Id = $("#hdfRoomId").val();
            var UserId = $("#hdfUserId").val();
            var UniUserId = $("#ddlUser").val();
            var RoomId = $("#ddlRoom").val();

            if (UniUserId == '0') {
                showMsg("ERROR", "Please Select User. !");
                $("#ddlUser").focus();
                return false;
            }
            else if (RoomId == '0') {
                showMsg("ERROR", "Please Select Room. !");
                $("#ddlRoom").focus();
                return false;
            }
            $("#ContentPlaceHolder1_btnNotes").attr("disabled", true);
            $("#ContentPlaceHolder1_btnNotes").val("Please Wait..");
            $.ajax({
                type: "POST",
                url: "frmAssignRoom.aspx/AddUpdate",
                data: "{'UniUserId':'" + UniUserId + "','RoomId':'" + RoomId +"'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "ER") {
                        showMsg("ERROR", "Something went wrong. !")
                        $("#ContentPlaceHolder1_btnNotes").attr("disabled", false);
                        $("#ContentPlaceHolder1_btnNotes").val("Save");
                        $("#ddlRoom").attr("disabled", false);
                        return false;
                    }
                    $("#modelNotes").modal("hide");
                    showMsg("SUCCESS", "User has been saved successfully. !");
                    $("#ddlRoom").attr("disabled", false);
                    $("#hdfRegId").val('');
                    $("#ddlUser").val('0');
                    $("#ddlRoom").val('0');
                    $("#ContentPlaceHolder1_btnNotes").attr("disabled", false);
                    $("#ContentPlaceHolder1_btnNotes").val("Save");
                    BindGrid($("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
                    BindRoom();
                    BindUniversityUser();

                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong. !");
                    $("#ddlRoom").attr("disabled", false);
                    $("#ContentPlaceHolder1_btnNotes").attr("disabled", false);
                    $("#ContentPlaceHolder1_btnNotes").val("Save");
                }
            });
            return false;
        }

        
    </script>
</asp:Content>


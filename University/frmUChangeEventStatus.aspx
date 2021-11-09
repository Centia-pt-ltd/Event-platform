<%@ Page Title="" Language="C#" MasterPageFile="~/university/MasterPageUniversity.master" AutoEventWireup="true" CodeFile="frmUChangeEventStatus.aspx.cs" Inherits="university_frmUChangeEventStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
             <style type="text/css">
      #MyTable {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#MyTable td, #MyTable th {
  border: 1px solid #ddd;
  padding: 4px;
  font-size: 12px;
}

#MyTable tr:nth-child(even){background-color: #f2f2f2;}

#MyTable tr:hover {background-color: #ddd;}

#MyTable th {
    padding: 3px 5px;
    text-align: center;
    color: white;
    font-size: 11px;
    background-color: #757575;
}
#MyTable tr td a{
    font-size: 11px;
    margin: 0 0 0 5px;
}
  </style>

     <asp:HiddenField ID="hdfUserId" runat="server" />
    <asp:HiddenField ID="hdfEid" runat="server" />
       <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
            <div>
                <div style="width:20%;float:left;" class="form-group has-search">
                <span class="fa fa-search form-control-feedback"></span>
      <input type="text" class="form-control" id="txtSearch" onkeyup="Search()" placeholder="Search for EventName" />

         
                    </div>
    <div style="float:right;">
              <table><tr><td><img src="img/refresh.png" height="30" style="cursor:pointer" id="imgRefresh" alt="refresh" onclick="RefreshGrid();" />

                         </td><td><a target="_blank" href="javascript:void();" onclick="ExcelDownload(); ">
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
     function BindGrid(SearchValue,RowPerPage, PageNumber) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');
            $.ajax({
                type: "POST",
                url: "frmUChangeEventStatus.aspx/BindList",
                data: "{'SearchValue':'" + SearchValue+"','RowPerPage':'" + RowPerPage + "','PageNumber':'" + PageNumber + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    $("#MyTable").empty();
                    var Data = '';
                    Data = "<table id='MyTable' style='overflow - y: scroll'>";
                    Data += "<tr>";
                    Data += "<th>S No</th>";
                    Data += "<th>Status</th>";
                    Data += "<th>Event Name</th>";
                    Data += "<th>Event Detail</th>";
                    Data += "<th>Event Date</th>";
                    Data += "<th>Event URL</th>";
                    Data += "<th>Region</th>";
                   // Data += "<th>Status</th>";
                    Data += "<th>Created By</th>";
                    //Data += "<th>Created On</th>";
                    Data += "<th>Updated By</th>";
                    //Data += "<th>Updated On</th>";
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
                        var status = '';
                        var redirect = '';
                        $("#sampleTable_info").html('&nbsp;Showing ' + response.d[0].SNo + ' to ' + response.d[len - 1].SNo + ' of ' + len + ' records');

                       // $("#divTable").html(response.d);
                        for (var i = 0; i < len; i++) {
                            Id = response.d[i].EventId;
                            status = response.d[i].Status;
                            Data += "<tr>";
                            Data += "<td>" + response.d[i].SNo + "</td>";
                            if (response.d[i].Status == "Active") {
                                Data += "<td><a href='javascript:void();' onclick='return GetEditData(" + Id + ");' title='Click here to change status !' style='Background-color:green;color:white'>Active</a></td>";
                            }
                            else {
                                Data += "<td><a href='javascript:void();' onclick='return GetEditData(" + Id + ");' title='Click here to change status !' style='Background-color:red;color:white'>Inactive</a></td>";
                            }
                            Data += "<td>" + response.d[i].EventName + "</td>";
                            Data += "<td>" + response.d[i].EventDetail + "</td>";
                            Data += "<td>" + response.d[i].EventDate + "</td>";
                            Data += "<td style='word-break: break-word;'>" + response.d[i].EventURL + "</td>";
                            Data += "<td>" + response.d[i].Region + "</td>";
                            //Data += "<td>" + response.d[i].Status + "</td>";
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
          
        window.onload = BindGrid($("#txtSearch").val(),$("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());

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
            window.location.href = "../SuperAdmin/download.aspx?Status=" + Status + "&SearchValue=" + SearchValue + "&RowPerPage=" + RowPerPage + "&PageNumber=" + PageNumber;
        }
        function GetEditData(EventId) {
            $("#ContentPlaceHolder1_hdfEid").val('');
            var Uid = $("#ContentPlaceHolder1_hdfUserId").val();
            $.ajax({
                type: "POST",
                url: "frmUChangeEventStatus.aspx/GetEditEventData",
                data: "{'EventId':'" + EventId + "','UpdatedBy':'" + Uid+"'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#ContentPlaceHolder1_hdfEid").val(response.d[0].EventId);
                    var sts = response.d;
                    if (sts == "1") {
                        showMsg("SUCCESS", "Data updated successfully.!");
                        BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
                    }
                    else {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                  
                    

                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });

            return false;
        }
    </script>
</asp:Content>


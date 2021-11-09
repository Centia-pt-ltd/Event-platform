<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/MasterPageSuperAdmin.master" AutoEventWireup="true" CodeFile="LogedInUsers.aspx.cs" Inherits="SuperAdmin_LogedInUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField ID="hdfUserId" runat="server" />
    <asp:HiddenField ID="hdfUid" runat="server" />
    <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
      <div style="overflow:auto;max-width:100%;max-height:calc(100vh - 100px);">
            <div class="tabel_wrapper" style="margin-top:5px!important;">
                <div class="search_wrapper" style="border:1px solid lightgray;border: 1px solid lightgray;width: 300px;margin-left: 9px; display:inline;">
                    <span class="fa fa-search" style="color:lightgray;margin-left:5px;"></span>
                <input type="text" id="txtSearch" onkeyup="return Search();" placeholder="search by name, email, logintype" style="margin-left:15px;width:240px;border:none" />
                </div>
                <div class="icon_exel">
                <img src="img/refresh.png" height="30" style="cursor:pointer" data-toggle="tooltip" data-placement="bottom" title="Reload Data" id="imgRefresh" alt="refresh" onclick="RefreshGrid();" />
                
                </div>
                <table style="overflow-y:scroll" >
                    <thead><tr>
                    <th>SNo.</th>
                    <th>Action</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>LoginType</th>
                    <th>Login</th>
                    <th>Login DateTime</th></tr>
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
                url: "LogedInUsers.aspx/BindList",
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
                            id = data.d[k].UserId;
                            chk = "chk" + id;
                            item += "<tr>";
                            item += "<td>" + data.d[k].SNo + "</td>";
                            item += "<td><a href='javascript:void();' onclick='return MakeLogOut(" + id + ");' class='btn-danger' style='background-color:#dc3545!important'>Make Logout</a></td>";
                            item += "<td>" + data.d[k].Name + "</td>";
                            item += "<td>" + data.d[k].UserName + "</td>";
                            if (data.d[k].LoginType.trim().toUpperCase() == 'SUPERADMIN')
                                item += "<td style='color:red'>" + data.d[k].LoginType + "</td>";
                            if (data.d[k].LoginType.trim().toUpperCase() == 'QSTUDY')
                                item += "<td style='color:green'>" + data.d[k].LoginType + "</td>";
                            if (data.d[k].LoginType.trim().toUpperCase() == 'UNIVERSITY')
                                item += "<td style='color:orange'>" + data.d[k].LoginType + "</td>";
                            item += "<td><img src='img/online.png' height='30' alt='status'/></td>";
                            item += "<td>" + data.d[k].LoginDateTime + "</td>";
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

       
        function MakeLogOut(Uid) {

            var cnf = confirm('Are you sure to Logout ?');
            if (cnf == false)
                return false;

            $.ajax({
                type: "POST",
                url: "LogedInUsers.aspx/Logout",
                data: "{'Uid':'" + Uid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "S") {
                        showMsg("SUCCESS", "User has been Logout successfully.!");
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
        function RefreshList() {
            setInterval(function () {
                BindGrid($("#txtSearch").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
            }, 30000);
        }
        window.onload = RefreshList();

        document.getElementById('txtSearch').onkeydown = function (event) {
            if (event.keyCode == 13) {
                Search();
                return false;
            }
        }
    </script>
</asp:Content>


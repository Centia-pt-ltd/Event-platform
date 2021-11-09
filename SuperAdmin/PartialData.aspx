<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/MasterPageSuperAdmin.master" AutoEventWireup="true" CodeFile="PartialData.aspx.cs" Inherits="SuperAdmin_PartialData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">

   
table tr{
    background-color:#eaf3f3 !important;
    font-size:13px !important;
}
.height_font_custom{
    height: calc(1.5rem + 2px)!important;
    font-size: 13px;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
    <asp:HiddenField ID="hdfUserId" runat="server" />
    <div class="" id="bdy">
            <div class="filter" style="margin-left: 1%; width:100%">
                <div class="form-inline" style="width: 100%;">   
                     <div class="form-group" style="width: 8%;">
                     <label for="email" style="font-weight:600;margin-right:1%;">Filter By: </label>
                         </div>
                    <div class="form-group">
                    &nbsp;<label for="email">Region</label>
                    &nbsp;<asp:DropDownList ID="ddlRegion" runat="server" CssClass="form-control"></asp:DropDownList>
                  </div>
                
                    <div class="form-group">
                    &nbsp;<label for="email">From Date</label>
                    &nbsp; <input type="date" style="margin-top: 0;text-align:left" id="txtFDate" class="datepicker form-control"  placeholder="DD/MM/YYYY" />
                  </div>

                     <div class="form-group">
                    &nbsp;<label for="email">To Date</label>
                    &nbsp; <input type="date" style="margin-top: 0;text-align:left" id="txtTDate" class="datepicker form-control" placeholder="DD/MM/YYYY" />
                  </div>
                <div class="form-group">  
             <asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="return Search();" CssClass="form-control btn btn-secondary" style="font-size:18px; font-weight:bold;margin-top: 0;" />
                <asp:Button ID="btnRefresh" runat="server" OnClientClick="return RefreshGrid();" Text="All Data" CssClass="form-control btn btn-primary" style="font-size:18px; font-weight:bold;margin-top: 0;" />
               <a href="javascript:void();" data-toggle="tooltip" data-placement="bottom" title="Excel Download" onclick="ExcelDownload();"style="display:inline;width:40px;">
                    <img src="img/excel.png" height="25" />
                </a>      
                </div>
                    <div style="float:right">
                       <asp:Button ID="btnDelete" runat="server" OnClientClick="return DeleteAll();" Text="Delete All" CssClass="form-control btn btn-danger" style="font-size:18px; font-weight:bold;margin-top: 0;" />

                    </div>

</div>

               
            </div>

        
        <div class="row" style="overflow:auto;max-width:100%;max-height:calc(100vh - 270px);">
         <div style="width:1800px;">  
            <table id="customers" class="fixed_header1">
                <thead style="position: sticky;top: 0;">
                    <tr>
                    <th style='width:100px!important'>&nbsp;S.No</th>
                    <th>Gender</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Country</th>
                    <th style="display:none">Code</th>
                    <th >Phone</th>
                    <th>Message Plateform</th>                    
                    <th>Created DateTime</th>
                        </tr>
                </thead>
                <tbody id="gridReg">
                    
                </tbody>

            </table>
        </div></div>
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
            <option value="50" selected="selected">50</option>
            <option value="100">100</option>
             <option value="250">250</option>
            <option value="500">500</option>
        </select>
        
    </div>
</div>
 
</div>
    <script type="text/javascript">
        function BindGrid(RegionId, RowPerPage, PageNumber, FDate, TDate) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');

            $.ajax({
                type: "POST",
                url: "PartialData.aspx/BindPartialData",
                data: "{'RegionId':'" + RegionId + "','RowPerPage':'" + RowPerPage + "','PageNumber':'" + PageNumber + "','FDate':'" + FDate + "','TDate':'" + TDate + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var len = data.d.length;
                    $("#gridReg").empty();
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
                        var redirect = ''; var Flag = '', FlagSts = '', PhoneNumbWithPlus = '', PhoneNumbWithoutPlus = '';

                        $("#sampleTable_info").html('&nbsp;Showing ' + data.d[0].SNo + ' to ' + data.d[len - 1].SNo + ' of ' + data.d[0].TotalRows + ' records');
                        for (var k = 0; k < len; k++) {
                            id = data.d[k].Reg_Id;
                            FlagSts = data.d[k].Flag;

                            item += "<tr>";
                            item += "<td style='text-align:center;width:100px!important'>&nbsp;" + data.d[k].SNo + "</td>";
                            
                            item += "<td>" + data.d[k].Gender + "</td>";
                            item += "<td>" + data.d[k].Name + "</td>";
                            item += "<td>" + data.d[k].EMail + "</td>";
                            item += "<td>" + data.d[k].Country + "</td>";
                            item += "<td>" + data.d[k].Phone + "</td>";

                            PhoneNumbWithPlus = data.d[k].Phone
                            if (data.d[k].Phone.includes("+") == true)
                                PhoneNumbWithoutPlus = data.d[k].Phone.replace('+', '');
                            else
                                PhoneNumbWithoutPlus = data.d[k].Phone;

                            var strLen = PhoneNumbWithoutPlus.length;
                            for (var tt = 0; tt <= 0; tt++) {
                                if (PhoneNumbWithoutPlus[tt] == "0")
                                    PhoneNumbWithoutPlus = PhoneNumbWithoutPlus.substring(1, PhoneNumbWithoutPlus.length);
                            }

                            var Plateform = '';
                            Plateform = data.d[k].msg;
                            var PlateformArray = Plateform.split(',');
                            var SmLen = PlateformArray.length;

                            item += "<td>";
                            for (var s = 0; s < SmLen; s++) {
                                if (PlateformArray[s].trim().toUpperCase() == "WHATSAPP") {
                                    //item += "&nbsp;<img src='../img/WhatsApp.png' height='30'/>&nbsp;";
                                    item += "<a href=https://web.whatsapp.com/send?phone=" + data.d[k].WhatsApp + "&amp;text=Hi target='_blank'>&nbsp;<img src='../img/WhatsApp.png' height='20'/>&nbsp;</a>";
                                }
                                else if (PlateformArray[s].trim().toUpperCase() == "VIBER") {
                                    //item += "&nbsp;<img src='../img/Viber.png' height='30' />&nbsp;";
                                    // for mobile view
                                   // item += "<a href='https://viber.chat?number=" + PhoneNumbWithoutPlus + "' class='d-lg-none' target='_blank'>&nbsp;<img src='../img/Viber.png' height='30' />&nbsp;</a>";
                                    // for web view
                                    item += "<a href='viber://keypad?number=%2B" + PhoneNumbWithoutPlus + "' target='_blank'>&nbsp;<img src='../img/Viber.png' height='20' />&nbsp;</a>";
                                }
                                else if (PlateformArray[s].trim().toUpperCase() == "IMO") {
                                    // item += "&nbsp;<img src='../img/imo.png' height='30' />&nbsp;";
                                    item += "<a href='https://imo.onelink.me/nbj0/df13cbc#' target='_blank'>&nbsp;<img src='../img/imo.png' height='20' />&nbsp;</a>&nbsp;</a>";
                                }
                                else if (PlateformArray[s].trim().toUpperCase() == "TELEGRAM") {
                                    // item += "&nbsp;<img src='../img/imo.png' height='30' />&nbsp;";
                                    item += "<a href='https://web.telegram.org' target='_blank'>&nbsp;<img src='../img/telegram.png' height='20' />&nbsp;</a>&nbsp;</a>";
                                }
                            }
                            item += "</td>";
                            item += "<td>" + data.d[k].CreatedOn + "</td>";
                            item += "</tr>";
                        }
                        $("#gridReg").append(item);
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
        window.onload = BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#txtFDate").val(), $("#txtTDate").val());

        function NextRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) + 1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var FDate = $("#txtFDate").val();
            var TDate = $("#txtTDate").val();

            if (FDate.length == 10) {
                FDate = $("#txtFDate").val().split('/')[2] + "-" + $("#txtFDate").val().split('/')[0] + "-" + $("#txtFDate").val().split('/')[1];
            }
            if (TDate.length == 10) {
                TDate = $("#txtTDate").val().split('/')[2] + "-" + $("#txtTDate").val().split('/')[0] + "-" + $("#txtTDate").val().split('/')[1];
            }

            BindGrid(Region, RowPerPage, PageNumber, FDate, TDate);
        }

        function PrevRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) - 1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var FDate = $("#txtFDate").val();
            var TDate = $("#txtTDate").val();
            if (FDate.length == 10) {
                FDate = $("#txtFDate").val().split('/')[2] + "-" + $("#txtFDate").val().split('/')[0] + "-" + $("#txtFDate").val().split('/')[1];
            }
            if (TDate.length == 10) {
                TDate = $("#txtTDate").val().split('/')[2] + "-" + $("#txtTDate").val().split('/')[0] + "-" + $("#txtTDate").val().split('/')[1];
            }
            BindGrid(Region, RowPerPage, PageNumber, FDate, TDate);
        }

        function PageSize() {
            $("#hdfCurrentPageIndex").val(1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var FDate = $("#txtFDate").val();
            var TDate = $("#txtTDate").val();
            if (FDate.length == 10) {
                FDate = $("#txtFDate").val().split('/')[2] + "-" + $("#txtFDate").val().split('/')[0] + "-" + $("#txtFDate").val().split('/')[1];
            }
            if (TDate.length == 10) {
                TDate = $("#txtTDate").val().split('/')[2] + "-" + $("#txtTDate").val().split('/')[0] + "-" + $("#txtTDate").val().split('/')[1];
            }
            BindGrid(Region, RowPerPage, PageNumber, FDate, TDate);
        }
        
        function RefreshGrid() {
            $("#hdfCurrentPageIndex").val(1);
            $("#ContentPlaceHolder1_ddlRegion").val('-All Region-');
            $("#ddlPageSize").val(50);
            $("#txtFDate").val('');
            $("#txtTDate").val('');
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var FDate = $("#txtFDate").val();
            var TDate = $("#txtTDate").val();
            if (FDate.length == 10) {
                FDate = $("#txtFDate").val().split('/')[2] + "-" + $("#txtFDate").val().split('/')[0] + "-" + $("#txtFDate").val().split('/')[1];
            }
            if (TDate.length == 10) {
                TDate = $("#txtTDate").val().split('/')[2] + "-" + $("#txtTDate").val().split('/')[0] + "-" + $("#txtTDate").val().split('/')[1];
            }
            BindGrid(Region, RowPerPage, PageNumber, FDate, TDate);
            return false;
        }

        function Search() {
            $("#hdfCurrentPageIndex").val(1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var FDate = $("#txtFDate").val();
            var TDate = $("#txtTDate").val();

            
           /* if (FDate.length == 10) {
                FDate = $("#txtFDate").val().split('/')[2] + "-" + $("#txtFDate").val().split('/')[0] + "-" + $("#txtFDate").val().split('/')[1];
            }
            if (TDate.length == 10) {
                TDate = $("#txtTDate").val().split('/')[2] + "-" + $("#txtTDate").val().split('/')[0] + "-" + $("#txtTDate").val().split('/')[1];
            }*/
           
            BindGrid(Region, RowPerPage, PageNumber, FDate, TDate);
            return false;
        }        
        
        function ExcelDownload() {
            var RegionId = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var FDate = $("#txtFDate").val();
            var TDate = $("#txtTDate").val();
            var Status = "PARTIAL";
            window.location.href = "download.aspx?Status=" + Status + "&RegionId=" + RegionId + "&RowPerPage=" + RowPerPage + "&PageNumber=" + PageNumber + "&FDate=" + FDate + "&TDate=" + TDate;
        }

        function DeleteAll() {
            if (confirm('Are you sure you want to delete all record?')) {
                $.ajax({
                    type: "POST",
                    url: "PartialData.aspx/DeleteAll",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d = "ER") {
                            showMsg("ERROR", "Something went wrong.!");
                            return false;
                        }
                        else {
                            showMsg("SUCCESS", "Record Deleted Successfully !!");
                            RefreshGrid();
                            return false;
                        }
                    },
                    error: function (response) {
                        showMsg("ERROR", "Something went wrong.!");
                        return false;
                    }
                });
            }
        }
        
        $('.datepicker').datepicker({
            format: "dd/mm/yyyy"
        });


    </script>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/University/MasterPageUniversity.master" AutoEventWireup="true" CodeFile="RegistrationList.aspx.cs" Inherits="University_RegistrationList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
      table tr{
    background-color:#eaf3f3 !important;
    font-size:13px !important;
}

#tblHighLights td,th{border:none!important}

.my-bordered-icon {
            text-shadow: -1px 0 #000, 0 1px #000, 1px 0 #000, 0 -1px #000;
        }

  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
    <asp:HiddenField ID="hdfUserId" runat="server" />
     <div id="bdy">
    <div class="row">
            <div class="filter" style="width:90%!important">
                <span>Filter By: </span>
                <asp:DropDownList ID="ddlRegion" runat="server" CssClass="form-control"></asp:DropDownList>

                <asp:DropDownList ID="ddlCourse" CssClass="form-control" runat="server"></asp:DropDownList>
                <asp:DropDownList ID="ddlQualification" CssClass="form-control" runat="server"></asp:DropDownList>
                <asp:TextBox ID="txtStudentName" placeholder="Name/Reg No" CssClass="form-control" Height="38" runat="server"></asp:TextBox>
                <asp:TextBox ID="txtCountry" placeholder="Country Name" CssClass="form-control" Height="38" runat="server"></asp:TextBox>
                <div class="dropdown">
                  <button style="width:100px" class="form-control dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">All Flag</button>
                  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="divFlg">                 
                  
                  <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlagFilter(this.id);" id="f9" data-value="InActive"><i class="fa fa-flag my-bordered-icon" aria-hidden="true" style="color:white; font-weight:bold"></i> InActive</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlagFilter(this.id);" id="f10" data-value="Active"><i class="fa fa-flag" aria-hidden="true" style="font-weight:bold; color:gray"></i> Active</a>         
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlagFilter(this.id);" id="f11" data-value="Counsellor Spoken"><i class="fa fa-flag" aria-hidden="true" style="color:yellow; font-weight:bold"></i> Counsellor Spoken</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlagFilter(this.id);" id="f12" data-value="Potential"><i class="fa fa-flag" aria-hidden="true" style="color:green; font-weight:bold"></i> Potential</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlagFilter(this.id);" id="f13" data-value="Signed Up/ Lock"><i class="fa fa-flag" aria-hidden="true" style="color:blue; font-weight:bold"></i> Signed Up/ Lock</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlagFilter(this.id);" id="f14" data-value="University Spoken"><i class="fa fa-flag" aria-hidden="true" style="color:pink; font-weight:bold"></i> University Spoken</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlagFilter(this.id);" id="f15" data-value="Lost"><i class="fa fa-flag" aria-hidden="true" style="color:red; font-weight:bold"></i> Lost</a>             
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlagFilter(this.id);" id="f16" data-value="Blocked"><i class="fa fa-flag" aria-hidden="true" style="color:black; font-weight:bold"></i> Blocked</a> 
                  
                  
                  
                  </div>
                </div>
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="return Search();" CssClass="form-control btn btn-secondary" style="font-size:18px; font-weight:bold; height:39px" />
                <asp:Button ID="btnRefresh" runat="server" OnClientClick="return RefreshGrid();" Text="All Data" CssClass="form-conthrol btn btn-primary" style="font-size:18px; font-weight:bold; height:39px; margin-top:15px; margin-left:3px" />
                
            </div>
     </div>       
       <div class="row" style="overflow:auto;max-width:100%;max-height:calc(100vh - 210px);margin-left:-5px;">
         <div style="width:100%;">  
            <table id="customers" style="width:180% !important">
                <thead><tr>
                    <th><div>S.No</div></th>
                    <th><div>FLG</div></th>
                    <th style="width:61px;"><div>Action</div></th>                    
                    <th><div>Registration No.</div></th>
                    <th><div>Country</div></th>
                    <th><div>Full Name</div></th>
                    <th><div>Email</div></th>
                    <th><div>Code</div></th>
                    <th><div>Phone</div></th>
                    <th><div>Message Plateform</div></th>
                    <th><div>Highest Qualification</div></th>
                    <th><div>Course</div></th>
                    <th><div>Handled By</div></th>
                    <th><div>Last UpdatedOn</div></th>
                </tr></thead>
                <tbody id="gridReg">
                    
                </tbody>

            </table>
            </div>
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
            <option value="50" selected="selected">100</option>
            <option value="100">300</option>
            <option value="250">500</option>
            <option value="500">1000</option>
        </select>
    </div>
</div>

      
         </div>
    <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
            <h4>Registration Details</h4>
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

    

    <!-- Modify Notes-->
    <div class="modal" id="modelNotes">
    <div class="modal-dialog">
      <div class="modal-content" style="width:900px">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Add/Update Notes</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError3" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">

              <table>
                  <tr>
                      <td><span>Flag <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span></td>
                      <td>
                          <div class="dropdown">
                  <button style="width:185px; height:40px" class="form-control dropdown-toggle" type="button" id="dropdownMenuButtonNote" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Flag
                  </button>
                  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="divFlgNote">                    
                                        
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f4" data-value="Potential"><i class="fa fa-flag" aria-hidden="true" style="color:green; font-weight:bold"></i> Potential</a>
                    <!--<a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f5" data-value="Signed Up/ Lock"><i class="fa fa-flag" aria-hidden="true" style="color:blue; font-weight:bold"></i> Signed Up/ Lock</a>-->
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f6" data-value="University Spoken"><i class="fa fa-flag" aria-hidden="true" style="color:pink; font-weight:bold"></i> University Spoken</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f7" data-value="Lost"><i class="fa fa-flag" aria-hidden="true" style="color:red; font-weight:bold"></i> Lost</a> 
                  </div>
                </div>

                      </td>
                  </tr>
                   <tr id="trLockUniversity" style="display:none">
                    <td><span>University <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><asp:DropDownList ID="ddlUniversity" CssClass="form-control" runat="server" style="height:35px; width:619px"></asp:DropDownList></td>
                    </tr>
                <tr>
                    <td><span>Note <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><textarea id="txtStudentNote" cols="71" rows="2"></textarea><br /></td>                                        
                </tr>
              </table>
            <table style="font-size:12px">
                <thead>
                    <tr><th><input type="hidden" id="hdfNoteEditId" /></th><th style="width:388px">Note</th><th>CreatedBy</th><th style="width:130px">CreatedDateTime</th><th>ModifyBy</th><th style="width:130px">ModifyDateTime</th></tr>
                </thead>
                <tbody id="tbodyNoteDetails">
                    
                </tbody>
            </table>
          
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
            <input type="hidden" id="hdfRegId" />
            <asp:Button ID="btnNotes" runat="server" CssClass="btn btn-success" Text="Save" OnClientClick="return SaveNotes();" />
            
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->


    <script type="text/javascript">
        function BindGrid(RegionId, RowPerPage, PageNumber, Course, Qualification, Country,StudentName, Flag) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');

            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/BindRegistrationList",
                data: "{'RegionId':'" + RegionId + "','RowPerPage':'" + RowPerPage + "','PageNumber':'" + PageNumber + "','Course':'" + Course + "','Qualification':'" + Qualification + "','Country':'" + Country + "','StudentName':'" + StudentName + "','Flag':'" + Flag + "'}",
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
                        var redirect = '';
                        var Plateform = '';
                        var Flag = '', FlagSts = '', PhoneNumbWithPlus = '', PhoneNumbWithoutPlus = '';
                        $("#sampleTable_info").html('&nbsp;Showing ' + data.d[0].SNo + ' to ' + data.d[len - 1].SNo + ' of ' + data.d[0].TotalRows + ' records');
                        for (var k = 0; k < len; k++) {
                            id = data.d[k].Reg_Id;
                            FlagSts = data.d[k].Flag;

                            if (FlagSts == "Active") {
                                // Gray->Active
                                Flag = "<i class='fa fa-flag fa-2x' aria-hidden='true' style='font-weight:bold; color:gray'></i>";
                            }
                            else if (FlagSts == "Counsellor Spoken") {
                                // yellow color->Spoken or approached Counsellor 
                                Flag = "<i class='fa fa-flag fa-2x' aria-hidden='true' style='color:yellow; font-weight:bold'></i>";
                            }
                            else if (FlagSts == "Potential") {
                                // green color->Potential Student 
                                Flag = "<i class='fa fa-flag fa-2x' aria-hidden='true' style='color:green; font-weight:bold'></i>";
                            }
                            else if (FlagSts == "Signed Up/ Lock") {
                                // blue color->Sign Up/ Lock 
                                Flag = "<i class='fa fa-flag fa-2x' aria-hidden='true' style='color:blue; font-weight:bold'></i>";
                            }

                            else if (FlagSts == "Lost") {
                                // red color->Lost
                                Flag = "<i class='fa fa-flag fa-2x' aria-hidden='true' style='color:red; font-weight:bold'></i>";
                            }
                            else if (FlagSts == "Blocked") {
                                // black color->Blocked 
                                Flag = "<i class='fa fa-flag fa-2x' aria-hidden='true' style='color:black; font-weight:bold'></i>";
                            }
                            else if (FlagSts == "University Spoken") {
                                // pink color->university approached 
                                Flag = "<i class='fa fa-flag fa-2x' aria-hidden='true' style='color:pink; font-weight:bold'></i>";
                            }
                            else {
                                // white ->InActive
                                Flag = "<i class='fa fa-flag fa-2x my-bordered-icon' aria-hidden='true' style='color:white;'></i>";
                            }

                            item += "<tr>";
                            item += "<td>" + data.d[k].SNo + "</td>";
                            item += "<td>" + Flag + "</td>";
                            item += "<td><a href='javascript:void(0);' id=" + id + " class='btn-sm btn-info viewData' style='display:inline' data-toggle='modal' onclick='return ViewDetails(this.id);' >View</a>&nbsp;<a href='javascript:void(0);' onclick='return ShowNotes(" + id + ");' class='btn-sm btn-secondary'>Notes</a></td>";
                            item += "<td>" + data.d[k].RegNo + "</td>";
                            item += "<td>" + data.d[k].Country + "</td>";
                            item += "<td>" + data.d[k].Name + "</td>";
                            item += "<td><a href='http://mail.qstudyabroad.com/Login.aspx' target='_blank'>" + data.d[k].EMail + "</a></td>";
                            item += "<td>" + data.d[k].CountryCode + "</td>";
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


                            Plateform = data.d[k].msg;
                            var PlateformArray = Plateform.split(',');
                            var SmLen = PlateformArray.length;
                            
                            item += "<td>";
                            for (var s = 0; s < SmLen; s++) {
                                if (PlateformArray[s].trim().toUpperCase() == "WHATSAPP") {
                                    //item += "&nbsp;<img src='../img/WhatsApp.png' height='30'/>&nbsp;";
                                    item += "<a href=https://web.whatsapp.com/send?phone=" + data.d[k].WhatsApp + "&amp;text=Hi target='_blank'>&nbsp;<img src='../img/WhatsApp.png' height='30'/>&nbsp;</a>";
                                }
                                else if (PlateformArray[s].trim().toUpperCase() == "VIBER") {
                                    //item += "&nbsp;<img src='../img/Viber.png' height='30' />&nbsp;";
                                    // for mobile view
                                    //item += "<a href='https://viber.chat?number=" + PhoneNumbWithoutPlus + "' class='d-lg-none' target='_blank'>&nbsp;<img src='../img/Viber.png' height='30' />&nbsp;</a>";
                                    // for web view
                                    item += "<a href='viber://keypad?number=%2B" + PhoneNumbWithoutPlus + "' class='d-none d-lg-block' target='_blank'>&nbsp;<img src='../img/Viber.png' height='30' />&nbsp;</a>";
                                }
                                else if (PlateformArray[s].trim().toUpperCase() == "IMO") {
                                    // item += "&nbsp;<img src='../img/imo.png' height='30' />&nbsp;";
                                    item += "&nbsp;<a href='https://imo.onelink.me/nbj0/df13cbc#' target='_blank'>&nbsp;<img src='../img/imo.png' height='30' />&nbsp;</a>&nbsp;</a>";
                                }
                                else if (PlateformArray[s].trim().toUpperCase() == "TELEGRAM") {
                                    // item += "&nbsp;<img src='../img/imo.png' height='30' />&nbsp;";
                                    item += "&nbsp;<a href='https://web.telegram.org' target='_blank'>&nbsp;<img src='../img/telegram.png' height='30' />&nbsp;</a>&nbsp;</a>";
                                }
                            }
                            item += "</td>";
                            
                            item += "<td>" + data.d[k].hq + "</td>";
                            item += "<td>" + data.d[k].Course + "</td>";
                            item += "<td>" + data.d[k].LastUpdatedBy + "</td>";
                            item += "<td>" + data.d[k].LastUpdateOn + "</td>";
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
        window.onload = BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val(), $("#ContentPlaceHolder1_txtStudentName").val(), $("#dropdownMenuButton").html());

        function NextRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) + 1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, StudentName, Flag);
        }

        function PrevRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) - 1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, StudentName, Flag);
        }

        function PageSize() {
            $("#hdfCurrentPageIndex").val(1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, StudentName, Flag);
        }
        function FileterByRegion() {
            $("#hdfCurrentPageIndex").val(1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, StudentName, Flag);
        }
        function RefreshGrid() {
            $("#hdfCurrentPageIndex").val(1);
            $("#ContentPlaceHolder1_ddlRegion").val('-All Region-');
            $("#ddlPageSize").val(50);
            $("#ContentPlaceHolder1_ddlCourse").val('-Courses-');
            $("#ContentPlaceHolder1_ddlQualification").val('-Qualification-');
            $("#ContentPlaceHolder1_txtCountry").val('');
            $("#ContentPlaceHolder1_txtStudentName").val('');
            $("#dropdownMenuButton").html('All Flag');

            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html('All Flag').html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, StudentName, Flag);
            return false;
        }

        function Search() {
            $("#hdfCurrentPageIndex").val(1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, StudentName, Flag);
            return false;
        }

        function ViewDetails(id) {
            $("#tblDetails").html('');
            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/GetDetails",
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

        function ShowNotes(RegId) {
            $("#txtStudentNote").val('');
            $("#hdfRegId").val(RegId);
            $("#dropdownMenuButtonNote").html('Flag');
            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/ShowNotes",
                data: "{'RegId':'" + RegId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#tbodyNoteDetails").html(response.d);
                    $("#modelNotes").modal("show");
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong. !")
                }
            });
            return false;
        }

        function SaveNotes() {
            var RegId = $("#hdfRegId").val();
            var Notes = $("#txtStudentNote").val();
            var NoteId = $("#hdfNoteEditId").val();
            var Flag = $.trim($("#dropdownMenuButtonNote").html());
            var UniversityId = "0";

            if (Flag == '') {
                showMsg("ERROR", "Flag must not be blank. !");
                return false;
            }
            else if (Flag == 'Flag') {
                showMsg("ERROR", "Please Select Valid Flag. !");
                return false;
            }
            else if (Flag == 'Signed Up/ Lock' && $("#ContentPlaceHolder1_ddlUniversity").val() == "-University-") {
                showMsg("ERROR", "Please Select Valid University. !");
                return false;
            }

           else if ($("#txtStudentNote").val() == '') {
                showMsg("ERROR", "Note must not be blank. !");
                return false;
            }
            else if ($("#txtStudentNote").val().trim() == '') {
                showMsg("ERROR", "Note must not be blank. !");
                return false;
            }

            else if (Flag == 'Signed Up/ Lock') {
                UniversityId = $("#ContentPlaceHolder1_ddlUniversity").val();
            }

            $("#ContentPlaceHolder1_btnNotes").attr("disabled", true);
            $("#ContentPlaceHolder1_btnNotes").val("Please Wait..");

            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/SaveNote",
                data: "{'RegId':'" + RegId + "','Notes':'" + Notes + "','NoteId':'" + NoteId + "','Flag':'" + Flag + "','UniversityId':'" + UniversityId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "ER") {
                        showMsg("ERROR", "Something went wrong. !")
                        $("#ContentPlaceHolder1_btnNotes").attr("disabled", false);
                        $("#ContentPlaceHolder1_btnNotes").val("Save");
                        return false;
                    }
                    else if (response.d == "EX") {
                        showMsg("ERROR", "Lead is already Locked. !");
                        $("#ContentPlaceHolder1_btnNotes").attr("disabled", false);
                        $("#ContentPlaceHolder1_btnNotes").val("Save");
                        return false;
                    }
                    else {                        
                        showMsg("SUCCESS", "Note has been saved successfully. !");
                        $("#hdfRegId").val('');
                        $("#txtStudentNote").val('');
                        $("#hdfNoteEditId").val('');
                        $("#ContentPlaceHolder1_btnNotes").attr("disabled", false);
                        $("#ContentPlaceHolder1_btnNotes").val("Save");
                        $("#trLockUniversity").css("display", "none");
                        $("#ContentPlaceHolder1_ddlUniversity").val("-University-");
                        $("#dropdownMenuButtonNote").html('Flag');
                        BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val(), $("#ContentPlaceHolder1_txtStudentName").val(), $("#dropdownMenuButton").html());
                    }
                    $("#modelNotes").modal("hide");
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong. !");
                    $("#ContentPlaceHolder1_btnNotes").attr("disabled", false);
                    $("#ContentPlaceHolder1_btnNotes").val("Save");
                }
            });
            return false;
        }

        function FetchEditNoteData(id) {
            $("#hdfNoteEditId").val(id);
            $("#txtStudentNote").val($("#" + id).attr("data-id"));
            $("#dropdownMenuButtonNote").html($.trim($("#" + id).attr("data-Flag")));
            if ($.trim($("#" + id).attr("data-Flag")) == "Signed Up/ Lock") {
                $("#trLockUniversity").css("display", "table-row");
                $("#ContentPlaceHolder1_ddlUniversity").val($.trim($("#" + id).attr("data-University")));
                
            }
            else {
                $("#trLockUniversity").css("display", "none");
                $("#ContentPlaceHolder1_ddlUniversity").val('-University-');
            }
            return false;
        }

        $("#dropdownMenuButton").click(function () {
            $("#divFlg").toggle();
        });
        $("#dropdownMenuButtonNote").click(function () {
            $("#divFlgNote").toggle();
        });

        function selectFlag(eleId) {
            var selectedText = $("#" + eleId).attr("data-value");
            $("#dropdownMenuButtonNote").html(selectedText);
            if ($.trim(selectedText).toUpperCase() == "SIGNED UP/ LOCK") {
                $("#ContentPlaceHolder1_ddlUniversity").val('-University-');
                $("#trLockUniversity").css("display", "table-row");
            }
            else {
                $("#ContentPlaceHolder1_ddlUniversity").val('-University-');
                $("#trLockUniversity").css("display", "none");
            }
            $("#divFlgNote").hide();
            return false;
        }

        function selectFlagFilter(eleId) {
            var selectedText = $("#" + eleId).attr("data-value");
            $("#dropdownMenuButton").html(selectedText);
            $("#divFlg").hide();
            return false;
        }

        document.getElementById('ContentPlaceHolder1_txtStudentName').onkeydown = function (event) {
            if (event.keyCode == 13) {
                Search();
                return false;
            }
        }
        document.getElementById('ContentPlaceHolder1_txtCountry').onkeydown = function (event) {
            if (event.keyCode == 13) {
                Search();
                return false;
            }
        }

    </script>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/Qstudy/MasterPageQstudy.master" AutoEventWireup="true" CodeFile="ManageEmail.aspx.cs" Inherits="Qstudy_ManageEmail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
     


  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
    <asp:HiddenField ID="hdfUserId" runat="server" />
   <div> 
  <div class="row" style="width:100%;">
            <div class="filter" style="display:none">
                <span>Region</span>
                <asp:DropDownList ID="ddlRegion" runat="server" CssClass="form-control"></asp:DropDownList>

                <asp:DropDownList ID="ddlCourse" CssClass="form-control" runat="server"></asp:DropDownList>
                <asp:DropDownList ID="ddlQualification" CssClass="form-control" runat="server"></asp:DropDownList>
                <asp:TextBox ID="txtCountry" placeholder="Country Name" CssClass="form-control" Height="38" runat="server"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="return Search();" CssClass="form-control btn btn-secondary" style="font-size:18px; font-weight:bold; height:39px" />
                <asp:Button ID="btnRefresh" runat="server" OnClientClick="return RefreshGrid();" Text="All Data" CssClass="form-control btn btn-primary" style="font-size:18px; font-weight:bold; height:39px" />

    </div>            
          
        <div class="filter" style="margin-bottom:10px;">
            <asp:Button ID="Button1" runat="server" Text="+ Create Email" OnClientClick="return ShowMail();" CssClass="form-control btn btn-secondary" style="font-size:18px; font-weight:bold; height:39px" />
                <asp:Button ID="Button2" runat="server" OnClientClick="return ShowText();" Text="+ Create Text" CssClass="form-control btn btn-primary" style="font-size:18px; font-weight:bold; height:39px" />
        </div>
  </div>
          <div style="overflow:auto;max-width:100%;max-height:calc(100vh - 210px);">   
            <table id="customers1">
                <thead>
                    <tr><th>S.No</th>
                    <th style="width:61px;">View</th>                    
                    <th>Title</th>
                    <th>Type</th>
                    <th>Details</th>
                    <th>CreatedDateTime</th>
                </tr></thead>
                <tbody id="gridReg">
                    <tr><td>1</td><td><a href="javascript:void(0);" id="1" class="btn-sm btn-info viewData" style="display:inline" data-toggle="modal" onclick="return ViewDetails(this.id);">View</a></td><td>SACA Region</td><td>Mail</td><td>We are participating.</td><td>02/09/2021 05:45:30PM</td></tr>
                    <tr><td>2</td><td><a href="javascript:void(0);" id="2" class="btn-sm btn-info viewData" style="display:inline" data-toggle="modal" onclick="return ViewDetails(this.id);">View</a></td><td>SACA Region</td><td>Text</td><td>Hi, We are here to help.</td><td>01/09/2021 03:20:10PM</td></tr>

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
  
    <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
            <h4 id="hTitle"></h4>
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
      <div class="modal-content" style="width:711px">
      
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
                    <td><span>Note <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><textarea id="txtStudentNote" cols="68" rows="5"></textarea><br /></td>
                </tr>
                 <tr>
                     <td>DateTime</td><td id="dtDateTime" runat="server"></td>
                 </tr>
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

        <!--mail-->
    <div class="modal" id="modelMail">
    <div class="modal-dialog">
      <div class="modal-content" style="width:711px">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Mail Template</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError5" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">

             <table>
                 <tr>
                    <td><span>Title <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><input type="text" style="width:100%" /></td>
                </tr>
                <tr>
                    <td><span>Details <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><textarea id="txtBlockMsg" cols="69" rows="10"></textarea></td>
                </tr>
                 <tr>
                     <td>Status</td><td><input type="checkbox" />&nbsp;Active </td>
                 </tr>
                 </table>
            
          
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">            
            <asp:Button ID="Button3" runat="server" CssClass="btn btn-success" Text="Save" />           
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->

            <!--text-->
    <div class="modal" id="modelText">
    <div class="modal-dialog">
      <div class="modal-content" style="width:711px">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Text Template</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError6" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">

             <table>
                 <tr>
                    <td><span>Title <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><input type="text" style="width:100%" /></td>
                </tr>
                <tr>
                    <td><span>Details <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><textarea id="txtTextDetails" cols="69" rows="2"></textarea></td>
                </tr>
                 <tr>
                     <td>Status</td><td><input type="checkbox" />&nbsp;Active </td>
                 </tr>
                 </table>
            
          
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">            
            <asp:Button ID="Button4" runat="server" CssClass="btn btn-success" Text="Save" />           
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->


    <script type="text/javascript">
        function BindGrid(RegionId, RowPerPage, PageNumber, Course, Qualification, Country) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');

            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/BindRegistrationList",
                data: "{'RegionId':'" + RegionId + "','RowPerPage':'" + RowPerPage + "','PageNumber':'" + PageNumber + "','Course':'" + Course + "','Qualification':'" + Qualification + "','Country':'" + Country + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var len = data.d.length;
                    
                    var item = '';
                    if (len > 0) {
                        $("#curIndex").html(1);
                        $("#sampleTable_info").html('&nbsp;Showing 1 to 2 of 2 records');
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
        window.onload = BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val());

        function NextRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) + 1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country);
        }

        function PrevRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) - 1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country);
        }

        function PageSize() {
            $("#hdfCurrentPageIndex").val(1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country);
        }
        function FileterByRegion() {
            $("#hdfCurrentPageIndex").val(1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country);
        }
        function RefreshGrid() {
            $("#hdfCurrentPageIndex").val(1);
            $("#ContentPlaceHolder1_ddlRegion").val('2');
            $("#ddlPageSize").val(10);
            $("#ContentPlaceHolder1_ddlCourse").val('-Courses-');
            $("#ContentPlaceHolder1_ddlQualification").val('-Qualification-');
            $("#ContentPlaceHolder1_txtCountry").val('');

            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country);
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
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country);
            return false;
        }

        function ViewDetails(id) {
            $("#tblDetails").html('');
            var tbl = '';
            if (id == 1) {
                $("#hTitle").html('Mail Template');
                tbl = "<tbody><tr><td>Title</td><td>SACA Region</td></tr>";
                tbl += "<tr><td>Type</td><td>Mail</td></tr>";
                tbl += "<tr><td>Details</td><td>We are participating.</td></tr>";
                tbl += "<tr><td>CreatedDateTime</td><td>02/09/2021 05:45:30PM</td></tr>";
                tbl += "<tr><td>Status</td><td>Active</td></tr></tbody>";
                $("#tblDetails").html(tbl);
            }
            else if (id == 2) {
                $("#hTitle").html('Text Template');
                tbl = "<tbody><tr><td>Title</td><td>SACA Region</td></tr>";
                tbl += "<tr><td>Type</td><td>Text</td></tr>";
                tbl += "<tr><td>Details</td><td>Hi, We are here to help.</td></tr>";
                tbl += "<tr><td>CreatedDateTime</td><td>01/09/2021 03:20:10PM</td></tr>";
                tbl += "<tr><td>Status</td><td>Active</td></tr></tbody>";
                $("#tblDetails").html(tbl);
            }
            $("#myModal").modal("show");
        }

        function ShowNotes(RegId) {
            $("#txtStudentNote").val('')
            $("#hdfRegId").val(RegId);
            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/ShowNotes",
                data: "{'RegId':'" + RegId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#txtStudentNote").val(response.d)
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

            if ($("#txtStudentNote").val() == '') {
                showMsg("ERROR", "Note must not be blank. !");
                return false;
            }
            else if ($("#txtStudentNote").val().trim() == '') {
                showMsg("ERROR", "Note must not be blank. !");
                return false;
            }

            $("#ContentPlaceHolder1_btnNotes").attr("disabled", true);
            $("#ContentPlaceHolder1_btnNotes").val("Please Wait..");
            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/SaveNote",
                data: "{'RegId':'" + RegId + "','Notes':'" + Notes + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "ER") {
                        showMsg("ERROR", "Something went wrong. !")
                        $("#ContentPlaceHolder1_btnNotes").attr("disabled", false);
                        $("#ContentPlaceHolder1_btnNotes").val("Save");
                        return false;
                    }
                    $("#modelNotes").modal("hide");
                    showMsg("SUCCESS", "Note has been saved successfully. !");
                    $("#hdfRegId").val('');
                    $("#txtStudentNote").val('');
                    $("#ContentPlaceHolder1_btnNotes").attr("disabled", false);
                    $("#ContentPlaceHolder1_btnNotes").val("Save");

                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong. !");
                    $("#ContentPlaceHolder1_btnNotes").attr("disabled", false);
                    $("#ContentPlaceHolder1_btnNotes").val("Save");
                }
            });
            return false;
        }

        function ShowMail() {
            $("#modelMail").modal("show");
            return false;
        }
        function ShowText() {
            $("#modelText").modal("show");
            return false;
        }
        
    </script>
</asp:Content>


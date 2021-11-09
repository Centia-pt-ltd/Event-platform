<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/MasterPageSuperAdmin.master" AutoEventWireup="true" CodeFile="frmManageUser.aspx.cs" Inherits="SuperAdmin_frmManageUser" %>

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
    <asp:HiddenField ID="hdfUid" runat="server" />
     <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
        <div style="overflow:auto;max-width:100%;max-height:calc(100vh - 100px);">
     <div class="rowse"> <%--management--%>
                <div class="management">
                    <div class="mform" style="background-color:#d7d7f7;padding-bottom:0px;margin-bottom:10px;">
                    <div class="col-md-12">
                         <label for="txtUserType" class="manag_label">Select User Type <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                         <select id="ddlUser" class="form-control"  oninput="filterTable()">
                               <option value="0" selected="selected">-Select User Type-</option>
                               <option value="SuperAdmin">SuperAdmin</option>
                               <option value="Qstudy">Qstudy</option>
                               <option value="University">University</option>
             </select>
                    </div></div>
                <div class="mform">
                    <div class="row">
                        <div class=" col-sm-4" >
                             <label for="lblFirstName" class="manag_label">Full Name <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <input type="text" class="form-control" id="txtFirstName" maxlength="50" placeholder="full name" />
                          </div>
                    <div class=" col-sm-4" style="display:none" >
                             <label for="lblLastName" class="manag_label">Last Name <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <input type="text" class="form-control" id="txtLastName" maxlength="50" placeholder="last name" />
                          </div>
                        <div class=" col-sm-4" style="display:none" >
                               <label for="lblGender" class="manag_label">Gender <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                             <select id="ddlGender" class="form-control">
                               <option value="0" selected="selected">-Select-</option>
                               <option value="Male" selected="selected">Male</option>
                               <option value="Female">Female</option>
                              <%-- <option>Other</option>--%>
                           </select>
                          </div>
                       </div>
                   
                    <div class="row">  
                        <div class=" col-sm-4">
                             <label for="txtEmail" class="manag_label">Email ID <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <input type="email" class="form-control" id="txtEmail" maxlength="200" placeholder="enter email" />
                        </div>
                   <div class="col-sm-4" >
                             <label for="txtUserName" class="manag_label">User Name <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                              <input type="text" class="form-control" id="txtUserName" maxlength="50" placeholder="user name" />
                          </div>
                      
                           
                        <div class="col-sm-4">
                             <label for="txtPwd" class="manag_label">Password 
                                 <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>
                             </label>   
                            <input id="chkShowPassword" type="checkbox" onchange="showPsd()" style="margin-left:85px" title="Show" />
                            Show

                              <input type="password" class="form-control" id="txtPwd" maxlength="50" placeholder="enter password" />
                          </div>
                        </div>
                            <div class="row">
                       
                          <div class="col-sm-4">
                             <label for="txtStatus" class="manag_label">Status <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</label>
                               <select id="ddlStatus" class="form-control">
                                   <option value="2" selected="selected">-Select Status-</option>
                                   <option value="1">Active</option>
                                   <option value="0">Inactive</option>
                               </select>
                          </div>
                                <div class="col-sm-4" id="divUniversity" style="display:none">
                                    <label for="lblUniversity" id="lblUniversity" class="manag_label">University <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

                                    </label>
                               <select id="ddlUniversity" class="form-control">
                                   
                               </select>
                                    </div>

                                 <div class="col-sm-4" id="divRole" style="display:none">
                                    <label for="lblRole" id="lblRole" class="manag_label">Role <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

                                    </label>
                               <select id="ddlRole" class="form-control">
                                   <option value="0">-Select Role-</option>
                                   <option value="Admin">Admin</option>
                                   <option value="User">User</option>
                               </select>
                                    </div>


                                <div class="col-sm-4" style="vertical-align:bottom;text-align:center;margin-top:30px;">
                                  <a href="javascript:void();" id="btnSave" onclick="return AddUpdateUser();" class="btn btn-success" style="margin: 0;">create</a>
                                    </div>

                                </div>
                       
                   <%-- <div class="col-md-14 col-sm-14" style="text-align:center;width:100%;">
                       <a href="javascript:void();" id="btnSave" onclick="return AddUpdateUser();" class="btn btn-success" style="margin: 0;">create</a>
            </div>--%>
                    </div>
        </div> 

 </div>
         
  
        <div>
                <div style="width:20%;float:left;" class="form-group has-search">
                <span class="fa fa-search form-control-feedback"></span>
      <input type="text" class="form-control" id="txtfilter" value="" onkeyup="myFunction()" placeholder="Search for UserName" />
         
                    </div>
    <div style="float:right;">
              <table><tr><td><img src="img/refresh.png" height="30" data-toggle="tooltip" data-placement="bottom" title="Reload Data" style="cursor:pointer" id="imgRefresh" alt="refresh" onclick="RefreshGrid();" />

                         </td><td><a target="_blank" href="javascript:void();" data-toggle="tooltip" data-placement="bottom" title="Excel Download" onclick="ExcelDownload(); ">
                    <img src="img/excel.png" height="35" />
                </a></td></tr>
              </table>
                
                
                </div>
    </div>
            <div class="tabel_wrapper" id="divTable">

            </div>
            <div class="row" style="width:95%!important">
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
          function filterTable() {
             
              
              $("#txtFirstName").val('');
              $("#txtLastName").val('');
              $("#ddlGender").val(0);
              $("#txtUserName").val('');
              $("#ddlStatus").val(2);
              $("#txtEmail").val('');
              $("#txtPwd").val('');
              $("#ddlUniversity").val(0);
              $("#ContentPlaceHolder1_hdfUid").val('');
              $("#btnSave").html('Create');
              var filter = $("#ddlUser").val();
              
              // change by arv on 06/09/21
              /*if (filter == "University" || filter == "0") {
                  $("#lblUniversity").css("display", "");
                  $("#ddlUniversity").css("display", "");

              }*/

              if (filter == "University") {
                  $("#lblUniversity").css("display", "");
                  $("#ddlUniversity").css("display", "");
                  $("#divRole").css("display", "block");
                  $("#divUniversity").css("display", "block");

              }
                  // end changes
              else {
                  $("#lblUniversity").css("display", "none");
                  $("#ddlUniversity").css("display", "none");
                  $("#divRole").css("display", "none");
                  $("#divUniversity").css("display", "none");
              }
              BindGrid($("#txtfilter").val(), $("#ddlUser").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());

          }
      </script>
    <script>
        function myFunction() {
            BindGrid($("#txtfilter").val(), $("#ddlUser").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
            // Declare variables
            //var input, filter, table, tr, td1, i, txtValue;
            //input = document.getElementById("txtfilter");
            //filter = input.value.toUpperCase();
            //table = document.getElementById("MyTable");
            //tr = table.getElementsByTagName("tr");

            //// Loop through all table rows, and hide those who don't match the search query
            //var len = 0;
            //for (i = 0; i < tr.length; i++) {
            //    td1 = tr[i].getElementsByTagName("td")[5];
            //    if (td1) {
            //        txtValue = td1.textContent || td1.innerText ;
            //        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            //            tr[i].style.display = "";
            //            len = len + 1;
            //        } else {
            //            tr[i].style.display = "none";
            //        }
            //    }
                
            //}  
            //$("#sampleTable_info").html('&nbsp;Showing ' + 1 + ' to ' + len + ' of ' + len + ' records');
        }
    </script>
    <script type="text/javascript">

        //function BindGrid() {
        //    $.ajax({
        //        type: "POST",
        //        url: "frmManageUser.aspx/BindList",
        //        data: "{}",
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (response) {
        //            $("#divTable").html(response.d);
        //        },
        //        error: function (response) {
        //            showMsg("ERROR", "Something went wrong.!");
        //        }
        //    });
        //}
        //window.onload = BindGrid();
        function BindUniversity() {
            $.ajax({
                type: "POST",
                url: "frmManageUser.aspx/BindUniversity",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#ddlUniversity").html(response.d);
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        $(document).ready(function () {
            BindUniversity();
            RefreshGrid();
        });

   

        ///Binnd table with paging Start

        function BindGrid(SearchValue,UserType,RowPerPage, PageNumber) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');
            $.ajax({
                type: "POST",
                url: "frmManageUser.aspx/BindList",
                data: "{'SearchValue':'" + SearchValue + "','UserType':'" + UserType+"', 'RowPerPage':'" + RowPerPage + "','PageNumber':'" + PageNumber + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var len = response.d.length;
                    $("#MyTable").empty();
                    var Data = '';
                    Data = "<table id='MyTable' >";
                    Data += "<thead><tr>";
                    Data += "<th>S No-</th>";
                    Data += "<th>Action</th>";
                    Data += "<th>Full Name</th>";
                    Data += "<th style='display:none'>Last Name</th>";
                    Data += "<th style='display:none'>Gender</th>";
                    Data += "<th>User Name</th>";
                    Data += "<th>Email</th>";
                    Data += "<th>Status</th>";
                    Data += "<th>UserType</th>";
                    Data += "<th>University</th>";
                    Data += "</tr></thead><tbody>";
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
                            Id = response.d[i].Id;
                            Data += "<tr>";
                            Data += "<td>" + response.d[i].SNo + "</td>";
                            Data += "<td><a href='javascript:void();'  class='btn-sm btn-success' onclick='return GetEditData(" + Id + ");'>Edit</a><a href='javascript:void();'  onclick='return Delete(" + Id + ");' class='btn-danger btn-sm' style='background-color:#dc3545!important'>Delete</a></td>";
                            Data += "<td>" + response.d[i].FirstName + "</td>";
                            Data += "<td style='display:none'>" + response.d[i].LastName + "</td>";
                            Data += "<td style='display:none'>" + response.d[i].Gender + "</td>";
                            Data += "<td>" + response.d[i].Name + "</td>";
                            Data += "<td>" + response.d[i].EmailId + "</td>";
                            Data += "<td>" + response.d[i].Status + "</td>";
                            Data += "<td>" + response.d[i].LoginType + "</td>";
                            Data += "<td>" + response.d[i].university + "</td>";
                            Data += "</tr>";

                           
                        }
                        Data += "</tbody></table>";
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
          
        window.onload = BindGrid($("#txtfilter").val(), $("#ddlUser").val(),$("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());

        function NextRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) + 1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtfilter").val(), $("#ddlUser").val(),RowPerPage, PageNumber);
        }

        function PrevRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) - 1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtfilter").val(), $("#ddlUser").val(),RowPerPage, PageNumber);
        }

        function PageSize() {
            $("#hdfCurrentPageIndex").val(1);
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtfilter").val(), $("#ddlUser").val(),RowPerPage, PageNumber);
            }
        ///bind table END
        function RefreshGrid() {
            $("#hdfCurrentPageIndex").val(1);
            $("#txtfilter").val('');
            $("#ddlPageSize").val(10);
            document.getElementById("btnSave").innerHTML = 'Create';
            $("#txtFirstName").val('');
            $("#txtLastName").val('');
            $("#ddlGender").val(0);
            $("#txtUserName").val('');
            $("#ddlStatus").val(2);
            $("#txtEmail").val('');
            $("#txtPwd").val('');
            $("#ddlUser").val(0);
            $("#ddlUniversity").val(0);
            $("#ContentPlaceHolder1_hdfUid").val('');
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            BindGrid($("#txtfilter").val(), $("#ddlUser").val(),RowPerPage,PageNumber);
        }

        function ExcelDownload() {
            var SearchValue = $("#txtfilter").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var UserType = $("#ddlUser").val();
            var Status = "UserList";
            window.location.href = "download.aspx?Status=" + Status + "&SearchValue=" + SearchValue + "&UserType=" + UserType + "&RowPerPage=" + RowPerPage + "&PageNumber=" + PageNumber;
        }

        function AddUpdateUser() {
            var FirstName = $("#txtFirstName").val();
            var LastName = $("#txtLastName").val();
            var Gender = $("#ddlGender").val();
            var Name = $("#txtUserName").val();
            var Status = $("#ddlStatus").val();
            var mail = $("#txtEmail").val();
            var pwd = $("#txtPwd").val();
            var userType = $("#ddlUser").val();
            var university = $("#ddlUniversity").val();
            var Uid = $("#ContentPlaceHolder1_hdfUid").val();
            var atpos = mail.indexOf("@");
            var dotpos = mail.lastIndexOf(".");            

            if (userType == '0') {
                showMsg("ERROR", "Please Select User Type. !");
                $("#ddlUser").focus();
                return false;
            }
            else if (userType == 'University' && university=='0') {
                showMsg("ERROR", "Please Select University. !");
                $("#ddlUniversity").focus();
                return false;
            }                
            /*else if (Gender == '0') {
                Gender = '0';
                showMsg("ERROR", "Please Select Gender. !");
                $("#ddlGender").focus();
                return false;
            }*/
            
            else if (FirstName.trim() == '') {
                showMsg("ERROR", "Please Enter First Name.!");
                $("#txtFirstName").focus();
                return false;
            }
            else if (Name.trim() == '') {
                showMsg("ERROR", "Please Enter User Name.!");
                $("#txtUserName").focus();
                return false;
            }
            else if (Status == '2') {
                showMsg("ERROR", "Please Select Status. !");
                $("#ddlStatus").focus();
                return false;
            }
            else if (mail.trim() == '') {
                showMsg("ERROR", "Please Enter E-Mail. !");
                $("#txtEmail").focus();
                return false;
            }
            else if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= mail.length) {
                showMsg("ERROR", "Please Fill Valid Email Address. !");
                $('#txtEmail').focus();
                return false;
            }
            else if (pwd.trim() == '') {
                showMsg("ERROR", "Please Enter Password. !");
                $("#txtPwd").focus();
                return false;
            }
            else if (pwd.trim().length < 5) {
                showMsg("ERROR", "Your password must be atleast 5 characters !");
                $("#txtPwd").focus();
                return false;
            }

            Gender = '0';


            var Role = '';
            if ($("#ddlUser").val() == 'University' && $("#ddlRole").val() == '0') {
                showMsg("ERROR", "Please Select Role. !");
                $("#txtPwd").focus();
                return false;
            }
            else {
                if ($("#ddlUser").val() == 'University')
                    Role = $("#ddlRole").val();
                else
                    Role = "0";
            }

            document.getElementById("btnSave").disabled = true;
            document.getElementById("btnSave").innerHTML = 'Please wait..';
            $.ajax({
                type: "POST",
                url: "frmManageUser.aspx/AddUpdateUser",
                data: "{'FirstName':'" + FirstName + "','LastName':'" + LastName + "','Gender':'" + Gender + "','Name': '" + Name + "', 'Status': '" + Status + "', 'mail': '" + mail + "', 'pwd': '" + pwd + "', 'Uid': '" + Uid + "', 'userType': '" + userType + "','university':'" + university + "','Role':'" + Role + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if (sts == "1") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("ERROR", "User Name Already Exists.!");
                        return false;
                    }
                    else if (sts == "3") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("ERROR", "E-Mail Already Exists.!");
                        return false;
                    }
                    else if (sts == "4") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("SUCCESS", "Data updated successfully.!");
                        $("#txtFirstName").val('');
                        $("#txtLastName").val('');
                        $("#ddlGender").val(0);
                        $("#txtUserName").val('');
                        $("#ddlStatus").val(2);
                        $("#txtEmail").val('');
                        $("#txtPwd").val('');
                        $("#ddlUser").val(0);
                        $("#ddlUniversity").val(0);
                        $("#ContentPlaceHolder1_hdfUid").val('');
                        $("#ddlRole").val(0);

                        $("#divRole").css("display", "none");
                        $("#divUniversity").css("display", "none");

                        BindGrid($("#txtfilter").val(), $("#ddlUser").val(),$("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
                        return false;
                    }
                    else if (sts == "5") {
                        document.getElementById("btnSave").disabled = false;
                        document.getElementById("btnSave").innerHTML = 'Create';
                        showMsg("SUCCESS", "Data saved successfully.!");
                        $("#txtFirstName").val('');
                        $("#txtLastName").val('');
                        $("#ddlGender").val(0);
                        $("#txtUserName").val('');
                        $("#ddlStatus").val(2);
                        $("#txtEmail").val('');
                        $("#txtPwd").val('');
                        $("#ddlUser").val(0);
                        $("#ddlUniversity").val(0);
                        $("#ContentPlaceHolder1_hdfUid").val('');
                        $("#ddlRole").val(0);
                        $("#divRole").css("display", "none");
                        $("#divUniversity").css("display", "none");
                        BindGrid($("#txtfilter").val(), $("#ddlUser").val(),$("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
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

        function GetEditData(Uid) {
            $("#txtFirstName").val('');
            $("#txtLastName").val('');
            $("#ddlGender").val(0);
            $("#txtUserName").val('');            
            $("#txtEmail").val('');
            $("#txtPwd").val('');
            $("#ddlStatus").val(2);
            $("#ddlUser").val(0);
            $("#ddlUniversity").val(0);
            $("#ContentPlaceHolder1_hdfUid").val('');
            
           

            $.ajax({
                type: "POST",
                url: "frmManageUser.aspx/GetEditData",
                data: "{'Uid':'" + Uid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                   
                    $("#txtFirstName").val(response.d[0].FirstName);
                    $("#txtLastName").val(response.d[0].LastName);
                    $("#ddlGender").val(response.d[0].Gender);
                    $("#txtUserName").val(response.d[0].Name);
                    $("#txtEmail").val(response.d[0].EmailId);
                    $("#txtPwd").val(response.d[0].Pwd);
                    $("#ddlStatus").val(response.d[0].Status);
                    $("#ddlUser").val(response.d[0].LoginType);
                    $("#ddlUniversity").val(response.d[0].university);
                    $("#ContentPlaceHolder1_hdfUid").val(response.d[0].Id);
                    $("#ddlRole").val(response.d[0].Role);
                    document.getElementById("btnSave").innerHTML = 'Update';
                    
                    if ($("#ddlUser").val() == "University" || $("#ddlUser").val() == "0") {
                        $("#lblUniversity").css("display", "");
                        $("#ddlUniversity").css("display", "");
                        $("#divRole").css("display", "block");
                        $("#divUniversity").css("display", "block");
                    }
                    else {
                        $("#lblUniversity").css("display", "none");
                        $("#ddlUniversity").css("display", "none");
                        $("#divRole").css("display", "none");
                        $("#divUniversity").css("display", "none");
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            
            return false;
        }

        function Delete(Uid) {

            var cnf = confirm('Are you sure to Delete ?');
            if (cnf == false)
                return false;

            $.ajax({
                type: "POST",
                url: "frmManageUser.aspx/DeleteUsers",
                data: "{'Uid':'" + Uid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "D") {
                        showMsg("SUCCESS", "Record Delete successfully.!");
                        BindGrid($("#txtfilter").val(), $("#ddlUser").val(),$("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
                    }
                    else if (response.d == "ER") {
                        showMsg("ERROR", "Something went wrong.!");
                        BindGrid($("#txtfilter").val(), $("#ddlUser").val(),$("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val());
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }
        function showPsd() {
            if (document.getElementById('chkShowPassword').checked == true) {
                $("#txtPwd").prop('type', 'text');
            }
            else {
                $("#txtPwd").prop('type', 'password');
            }
        }
        document.getElementById('txtFirstName').onkeydown = function (event) {
            if (event.keyCode == 13) {
                AddUpdateUser();
                return false;
            }
        }
        document.getElementById('txtEmail').onkeydown = function (event) {
            if (event.keyCode == 13) {
                AddUpdateUser();
                return false;
            }
        }
        document.getElementById('txtUserName').onkeydown = function (event) {
            if (event.keyCode == 13) {
                AddUpdateUser();
                return false;
            }
        }
        document.getElementById('txtPwd').onkeydown = function (event) {
            if (event.keyCode == 13) {
                AddUpdateUser();
                return false;
            }
        }
        document.getElementById('chkShowPassword').onkeydown = function (event) {
            if (event.keyCode == 13) {
                AddUpdateUser();
                return false;
            }
        }
        document.getElementById('ddlStatus').onkeydown = function (event) {
            if (event.keyCode == 13) {
                AddUpdateUser();
                return false;
            }
        }
        document.getElementById('ddlUniversity').onkeydown = function (event) {
            if (event.keyCode == 13) {
                AddUpdateUser();
                return false;
            }
        }
        document.getElementById('ddlRole').onkeydown = function (event) {
            if (event.keyCode == 13) {
                AddUpdateUser();
                return false;
            }
        }
        document.getElementById('txtfilter').onkeydown = function (event) {
            if (event.keyCode == 13) {
                myFunction();
                return false;
            }
        }
        
    </script>
</asp:Content>


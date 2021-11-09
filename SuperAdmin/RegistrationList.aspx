<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/MasterPageSuperAdmin.master" AutoEventWireup="true" CodeFile="RegistrationList.aspx.cs" Inherits="SuperAdmin_RegistrationList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .tblModifyRowPad table tr td {
    padding:3px !important;
}
.tblModifyRowPad table tr td .form-control {
    padding:.305rem .75rem !important;
}


      #customers {

     margin: 0.5em 0 !important;
    width: 180%  !important;
    background: #fff  !important;
    color: #024457  !important;
    border-radius: 5px  !important;
    border: 0.5px solid #167f92  !important;
    font-size:11px !important;
}
#customers tr {
        border: 0.5px solid #d9e4e6  !important;
         background-color: #fff  !important;
    }
#customers tr:nth-child(odd) {
    background-color: #eaf3f3  !important;
}
#customers th {
   
    border: 0.5px solid #fff  !important;
    background-color: #167f92  !important;
    color: #fff  !important;
    padding: 0.5em  !important;
    height:30px  !important;
}
#customers td {
   
    border: 0.5px solid #fff  !important;
    padding: 0.5em  !important;
     height:30px  !important;
}
#customers tr td a{
    margin: 0 0 0 3px!important;
    text-decoration:none;
    padding: 4px;
    font-size: 11px !important;
    
}
#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 4px;
  /*text-align: center  !important;*/
}

#customers tr:hover {background-color: #ddd !important;}
   

.modal-dialog{
    max-width:700px!important;
}
/*tr td{
      border: 0.5px solid #fff  !important;
    padding: 0.5em  !important;
}*/
  </style>

    <style>
        h1 {
            color: green;
        }
  
        .multipleSelection {
            width: 300px;
            background-color: #bcc2c12b;
        }
  
        .selectBox {
            position: relative;
        }
  
        .selectBox select {
            width: 100%;
            /*font-weight: bold;*/
        }
  
        .overSelect {
            position: absolute;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
        }
  
        #checkHq {
            display: none;
            border: 1px #8DF5E4 solid;
        }
  
        #checkHq label {
            display: block;
        }
  
        #checkHq label:hover {
            background-color: lightblue;
        }
        #checkCourse {
            display: none;
            border: 1px #8DF5E4 solid;
        }
  
        #checkCourse label {
            display: block;
        }
  
        #checkCourse label:hover {
            background-color:lightblue;
        }
        #checkPlateform {
            display: none;
            border: 1px #8DF5E4 solid;
        }
  
        #checkPlateform label {
            display: block;
        }
  
        #checkPlateform label:hover {
            background-color: lightblue;
        }

        #checkUniversity {
            display: none;
            border: 1px #8DF5E4 solid;
        }
  
        #checkUniversity label {
            display: block;
        }
  
        #checkUniversity label:hover {
            background-color: lightblue;
        }
           .chat_video_icon a:hover{
            transition: transform .2s;
             transform: scale(2);
        }
           #tblLog tbody tr:hover{background-color:azure}
           #tblHighLights td,th{border:none!important}

        .my-bordered-icon {
            text-shadow: -1px 0 #000, 0 1px #000, 1px 0 #000, 0 -1px #000;
        }
        .form-control{
            padding:0;
        }

        /*university*/

         #checkUniversity {
            display: none;
            border: 1px #8DF5E4 solid;
        }
  
        #checkUniversity label {
            display: block;
        }
  
        #checkUniversity label:hover {
            background-color:lightblue;
        }

table tr{
    background-color:#eaf3f3 !important;
    font-size:13px !important;
}
.height_font_custom{
    height: calc(1.5rem + 2px)!important;
    font-size: 13px;
}

/*ReAssign*/
       #checkReUniversity {
            display: none;
            border: 1px #8DF5E4 solid;
        }
  
        #checkReUniversity label {
            display: block;
        }
  
        #checkReUniversity label:hover {
            background-color: lightblue;
        }
/*end*/

@media (min-width: 768px){
    .modal-dialog {
    max-width: 850px!important;
}
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <input type="hidden" id="hdfCurrentPageIndex" name="hdfCurrentPageIndex" value="1" />
    <asp:HiddenField ID="hdfUserId" runat="server" />
    <div class="" id="bdy">
            <div class="filter" style="margin-left: 30px;">

                <div class="row">
               <div class="col-lg-12" style="display:flex;padding-right: 50px;">                
                 <div style="width: -webkit-fill-available; margin-top: 20px;font-size: 16px;font-weight: 600;">Filter By: </div>
                <asp:DropDownList ID="ddlRegion" runat="server" CssClass="form-control" style="margin-bottom:0px"></asp:DropDownList>

                <asp:DropDownList ID="ddlCourse" CssClass="form-control" runat="server" style="margin-bottom:0px"></asp:DropDownList>
                <asp:DropDownList ID="ddlQualification" CssClass="form-control" runat="server" style="margin-bottom:0px"></asp:DropDownList>
                <asp:TextBox ID="txtStudentName" placeholder=" Name/Reg No." CssClass="form-control" Height="38" runat="server" style="margin-bottom:0px;text-align:left"></asp:TextBox>
                <asp:TextBox ID="txtCountry" placeholder=" Country Name" CssClass="form-control" Height="38" runat="server" style="margin-bottom:0px;text-align:left"></asp:TextBox>
                <asp:DropDownList ID="ddlStatus" CssClass="form-control" runat="server" style="margin-bottom:0px"><asp:ListItem Value="Al"  Selected="True">All</asp:ListItem><asp:ListItem Value="Ac">Active</asp:ListItem><asp:ListItem Value="In">In-Active</asp:ListItem></asp:DropDownList>
                

                <div class="dropdown">
                  <button style="width:100px;padding:6px 0;" class="form-control dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">All Flag</button>
                  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="divFlg">
                   <%-- <a class="dropdown-item" href="#"><i class="fa fa-flag my-bordered-icon" aria-hidden="true" style="color:white; font-weight:bold"></i> InActive</a>
                    <a class="dropdown-item" href="#"><i class="fa fa-flag" aria-hidden="true" style="font-weight:bold; color:gray"></i> Active</a>         
                    <a class="dropdown-item" href="#"><i class="fa fa-flag" aria-hidden="true" style="color:yellow; font-weight:bold"></i> Spoken or approached</a>
                    <a class="dropdown-item" href="#"><i class="fa fa-flag" aria-hidden="true" style="color:green; font-weight:bold"></i> Potential</a>
                    <a class="dropdown-item" href="#"><i class="fa fa-flag" aria-hidden="true" style="color:blue; font-weight:bold"></i> Signed Up/ Lock</a>
                    <a class="dropdown-item" href="#"><i class="fa fa-flag" aria-hidden="true" style="color:pink; font-weight:bold"></i> University Spoken</a>
                    <a class="dropdown-item" href="#"><i class="fa fa-flag" aria-hidden="true" style="color:red; font-weight:bold"></i> Lost</a>             
                    <a class="dropdown-item" href="#"><i class="fa fa-flag" aria-hidden="true" style="color:black; font-weight:bold"></i> Blocked</a>--%>

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
                <asp:Button ID="btnRefresh" runat="server" OnClientClick="return RefreshGrid();" Text="All Data" CssClass="form-control btn btn-primary" style="font-size:18px; font-weight:bold; height:39px" />
                </div>

                    <div class="col-lg-12" style="display:flex;margin-left: 100px;"> 
                        <div id="divAssign" style="display:none">
                    <asp:DropDownList ID="ddlCounslers" CssClass="form-control height_font_custom" runat="server" Width="175px"></asp:DropDownList> 
                    <input type="button" value="Assign" class="form-control btn btn-success height_font_custom" style="padding:0 10px; font-weight:bold" onclick="return AssignLead();" id="btnAssignLead" />
                    <input type="button" value="Move" class="form-control btn btn-info height_font_custom" style="padding:0 10px;  font-weight:bold" onclick="return OpenMoveModel();" id="btnMoveLead" />
                    <input type="button" value="Assign To University" class="form-control btn btn-info height_font_custom" style="padding:0 10px;font-weight:bold;background-color:orange; border-color:orange;" onclick="return OpenAssignLeadToUniversityModel();" id="btnAssignLeadToUniversity" />
                </div>
                <div style="display:flex;margin-top:17px;">
                <a href="javascript:void();" data-toggle="tooltip" data-placement="bottom" title="Excel Download" onclick="ExcelDownload();"style="display:inline;width:40px;">
                    <img src="img/excel.png" height="25">
                </a>
                <a href="javascript:void();" data-toggle="tooltip" data-placement="bottom" title="Upload Data" onclick="OpenUploadPopup();"style="display:inline;width:40px;">
                    <img src="img/uploadExcel.png" height="25" width="205">
                </a>
                    <input type="button" value="Re-Assign Lead" class="form-control btn btn-info height_font_custom mt-0 float-lg-right" style="padding:0 10px;font-weight:bold;background-color:orange; border-color:orange;" onclick="return OpenReAssignLeadModel();" id="btnReAssign" />
                    </div>

                    </div>
                </div>



               
            </div>

        
        <div class="row" style="overflow:auto;max-width:100%;max-height:calc(100vh - 270px);">
         <div style="width:1800px;">  
            <table id="customers" class="fixed_header1">
                <thead style="position: sticky;top: 0;">
                    <tr>
                    <th style='width:100px!important'><input type="checkbox" id="chkAll" onchange="checkAll();" />&nbsp;S.No</th>
                    <th style='width:50px!important'>FLG</th>
                    <th style='width:250px!important'>Action</th> 
                    <th>Active</th>   
                        <th>Assigned By</th>
                    <th>Assigned To</th>                    
                   <th>Registration No.</th>
                   <th>Country</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Code</th>
                    <th >Phone</th>
                    <th>Message Plateform</th>
                    <th>Highest<br /> Qualification</th>
                    <th>Course</th> 
                    <th style="display:none">Handled By</th>
                    <th>Last UpdatedOn</th>
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
            <option value="50" selected="selected">100</option>
            <option value="100">300</option>
             <option value="250">500</option>
            <option value="500">1000</option>
        </select>
        <a href="javascript:void();" data-toggle="tooltip" data-placement="bottom" title="Download Format" onclick="downloadRegFormat();">
           <img src="img/downloadExcelFormat.png" height="30" /> Download Excel Format
        </a>
    </div>
</div>
        <!-- flag details -->
        


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

    <!-- Modify Registration-->
    <div class="modal" id="modelEditReg">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modify Registration Detail</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError2" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body tblModifyRowPad">
            <table>
                
                <tr>
                    <td>Registration No.</td><td><asp:TextBox ID="txtRegNo" disabled runat="server" CssClass="form-control"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Gender <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup>

</td><td><select class="slect_item form-control" id="gn" runat="server">
                               <option>Select</option>
                               <option>Male</option>
                               <option>Female</option>
                           </select></td>
                </tr>
                <tr>
                    <td>Full Name <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td><asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox></td>
                </tr>
                
                <tr style="display:none">
                    <td>Country Code</td><td><input name="phone" type="text" class="form-control mb-2 inptFielsd" id="phone"
               placeholder="Phone Number" style="display:none" /></td>
                </tr>
                <tr>
                    <td>Mobile Number <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td><input runat="server" class="form-control m_num numeric" id="txtno" placeholder="000 000 000 000 000 000 00" maxlength="20"/>
                        
                                          </td>
                </tr>
                <tr>
                    <td>Select Platform You Use <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td>

            <div class="multipleSelection">
            <div class="selectBox" 
                onclick="showPlateform()">
                <select class="form-control">
                    <option>Select Platform</option>
                </select>
                <div class="overSelect"></div>
            </div>
  
            <div id="checkPlateform">                 
               <%=MsgPlateform %>
            </div>
        </div>
                                                    </td>
                </tr>
                <tr>
                    <td>Email Address <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td><input type="text" runat="server" class="form-control" id="txtemail" placeholder="Enteryouremail@mail.com" /></td>
                </tr>
                <tr>
                    <td>Country <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td><input type="text" runat="server" class="form-control" id="txtCountryUpdate" placeholder="country" /></td>
                </tr>
                 <tr>
                    <td>City <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td><input type="text" runat="server" class="form-control" id="city" placeholder="city" /></td>
                </tr>
                 <tr>
                    <td>Current highest qualification <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td> 
                       <!-- <select class="slect_item" id="hq" multiple="multiple" > </select>-->

                        <div class="multipleSelection">
            <div class="selectBox" 
                onclick="showHq()">
                <select class="form-control">
                    <option>Select Qualification</option>
                </select>
                <div class="overSelect"></div>
            </div>
  
            <div id="checkHq">
                <%=Qualification %>
            </div>
        </div>

                                                          </td>
                </tr>
                 <tr>
                    <td> what course are you looking for <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td>
                                                <div class="multipleSelection">
            <div class="selectBox" 
                onclick="showCourse()">
                <select class="form-control">
                    <option>Select Course</option>
                </select>
                <div class="overSelect"></div>
            </div>
  
            <div id="checkCourse" style="overflow: scroll; min-height: 200px; max-height:200px">
                <%=Course %>
            </div>
        </div>
                                                             </td>
                </tr>
                <tr>
                    <td> </td><td>  <input type="text" runat="server" class="form-control" id="txtOtherCourse" style="display:none" placeholder="Other course" />  </td>
                </tr>
                <tr>
                    <td> IELTS/TOEFL <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td>  

                         <input type="radio" name="status" checked="checked" id="RdbIeltsYes" onclick="CheckIelts();" value="Yes" class="radio_registration"/>
                                            Yes
                                            <input type="radio" id="RdbIeltsNo" onclick="CheckIelts();" name="status" value="No" class="radio_registration"/>
                                            No  
                        <input type="text" class="form-control" id="txtscore" runat="server" style="width:60%" placeholder="Enter your score here" name="" />
                                         </td>
                </tr>
                <tr>
                    <td>Are you planning to study abroad? <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td>  
                        <input type="radio" name="Abroad" id="RdbAbYes" checked="checked" value="Yes" class="radio_registration"/>
                                            Yes
                                            <input type="radio" id="RdbAbNo" name="Abroad" value="No" class="radio_registration"/>
                                            No   


                                                               </td>
                </tr>
                 <tr>
                    <td>What fee range are you looking at? <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></td><td>  
                        <select class="slect_item form-control" id="ddlFee" runat="server">       
                             <option value="0"> Select</option>                        
                               <option value="USD 2,000 to USD 3,000 per year"> USD 2,000 to USD 3,000 per year</option>
                               <option value="USD 3,000 to USD 4,000 per year"> USD 3,000 to USD 4,000 per year</option>
                             <option value="USD 4,000 to USD 5,000 per year"> USD 4,000 to USD 5,000 per year</option>
                               <option value="USD 5,000 to USD 6,000 per year"> USD 5,000 to USD 6,000 per year</option>
                             <option value="I am ok with any fee/ any fee is fine">I am ok with any fee/ any fee is fine</option>
                              
                           </select>

                                                               </td>
                </tr>
                <tr><td>Active</td><td><input type="checkbox" id="chkActive" runat="server" /> </td></tr>
               
                
            </table>
          
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
            <asp:HiddenField ID="hdfEditRegId" runat="server" />
            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClientClick="return UpdateRegistration();" />
            
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->

    <!-- Model Track-->
    <div class="modal fade" id="modelTrack" role="dialog">
    <div class="modal-dialog modal-lg">
          <div class="modal-content">
        <div class="modal-header">
            <h4>Track Activity</h4>
          <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
          
        </div>
        
        <div class="modal-body">
            <table> 
                <thead>                    
                    <th>Media Name</th> 
                    <th>Icon</th>                   
                    <th>Activity Type</th>
                    <th>Activity DateTime</th>
                    <th>Activity Done By</th>                    
                </thead>
                <tbody  id="tblTrack"></tbody>  
    
            </table>
                 </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </div>
        </div>
     <!-- End Model Track-->

        <!-- Model Move-->
    <div class="modal fade" id="modelMove" role="dialog">
    <div class="modal-dialog modal-lg">
          <div class="modal-content">
        <div class="modal-header">
            <h4>Move Lead</h4>
          <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
          
        </div>
        
        <div class="modal-body">
         <span>Region To : </span> <asp:DropDownList ID="ddlMoveRegion" runat="server" Width="175px"></asp:DropDownList>
            
                 </div>
        <div class="modal-footer">
            <input type="button" id="btnSaveMoveLead" onclick="return MoveLead();" class="btn btn-primary" value="Save" />
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </div>
        </div>
     <!-- End Model Move-->

            <!-- Model upload-->
    <div class="modal fade" id="modelUpload" role="dialog">
    <div class="modal-dialog modal-lg">
          <div class="modal-content" style="width:150% !important; margin-left:-20% !important">
        <div class="modal-header">
            <h4>Upload Registration</h4>
            
          <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
          
        </div>
        
        <div class="modal-body">
         <span>Excel File : </span> 
            <input type="file" id="flUploadExcel" onchange="return ValidateExcelUpload(this.id)" />
            <div id="divFailedExcel" style="margin-top:20px">
                <img src="img/loader.gif" alt="loader" height="120" />
            </div>
                 </div>
        <div class="modal-footer">
            <input type="button" id="btnUploadLead" onclick="return UploadLead();" class="btn btn-primary" value="Upload" />
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </div>
        </div>
     
    <!-- End Model Upload-->

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
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f1" data-value="InActive"><i class="fa fa-flag my-bordered-icon" aria-hidden="true" style="color:white; font-weight:bold"></i> InActive</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f2" data-value="Active"><i class="fa fa-flag" aria-hidden="true" style="font-weight:bold; color:gray"></i> Active</a>         
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f3" data-value="Counsellor Spoken"><i class="fa fa-flag" aria-hidden="true" style="color:yellow; font-weight:bold"></i> Counsellor Spoken</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f4" data-value="Potential"><i class="fa fa-flag" aria-hidden="true" style="color:green; font-weight:bold"></i> Potential</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f5" data-value="Signed Up/ Lock"><i class="fa fa-flag" aria-hidden="true" style="color:blue; font-weight:bold"></i> Signed Up/ Lock</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f6" data-value="University Spoken"><i class="fa fa-flag" aria-hidden="true" style="color:pink; font-weight:bold"></i> University Spoken</a>
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f7" data-value="Lost"><i class="fa fa-flag" aria-hidden="true" style="color:red; font-weight:bold"></i> Lost</a>             
                    <a class="dropdown-item" href="javascript:void(0);" onclick="selectFlag(this.id);" id="f8" data-value="Blocked"><i class="fa fa-flag" aria-hidden="true" style="color:black; font-weight:bold"></i> Blocked</a>           
                    
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
                 <tr>
                     <td>Assign To</td>
                     <td>
                         <table>
                             <tr>
                                 <td style="width:30%">
                                     <label for="chkAssignToNone">
                          <input type="radio" id="chkAssignToNone" name="RdbAssignNote" checked="checked" onclick="AssignToNote();" /> None</label>
                                     <label for="chkAssignToCounsellor">
                          <input type="radio" id="chkAssignToCounsellor" name="RdbAssignNote" onclick="AssignToNote();" /> Counsellors</label>
                          <label for="chkAssignToUniversity">
                          <input type="radio" id="chkAssignToUniversity" name="RdbAssignNote" onclick="AssignToNote();" /> University</label></td>

                                 <td><asp:DropDownList ID="ddlAssignNoteToCounsellors" CssClass="form-control" runat="server" style="display:none; width:268px"></asp:DropDownList>
                         <asp:DropDownList ID="ddlAssignNoteToUniversity" CssClass="form-control" runat="server" style="display:none; width:268px"></asp:DropDownList></td>
                             </tr>
                         </table>
                         

                     </td>
                 </tr>
                 <tr>
                     <td>Action</td><td><asp:Button ID="btnNotes" runat="server" CssClass="btn btn-success" Text="Save" OnClientClick="return SaveNotes();" />            
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button></td>
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
            
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->

            <!--Lock-->
    <div class="modal" id="modelLock">
    <div class="modal-dialog">
      <div class="modal-content" style="width:711px">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Lock Student</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError4" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">

             <table>
                <tr>
                    <td><span>University <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><asp:DropDownList ID="ddlUniversity2" runat="server" style="height:35px"></asp:DropDownList></td>
                </tr>
                 </table>
            
          
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">            
            <asp:Button ID="btnLockStudent" runat="server" CssClass="btn btn-success" Text="Save" OnClientClick="return LockStudent();" />           
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->

    <!--BLock-->
    <div class="modal" id="modelBLock">
    <div class="modal-dialog">
      <div class="modal-content" style="width:711px">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Block Student</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError5" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">

             <table>
                <tr>
                    <td><span>Remark <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup> </span> </td>
                    <td><textarea id="txtBlockMsg" cols="65" rows="2"></textarea></td>
                </tr>
                 </table>
            
          
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">            
            <asp:Button ID="btnBlock" runat="server" CssClass="btn btn-success" Text="Save" OnClientClick="return BLockStudent();" />           
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->

        <!-- Model AssignToUniversity-->
    <div class="modal fade" id="modelAssignLeadToUniversity" role="dialog">
    <div class="modal-dialog modal-lg">
          <div class="modal-content">
        <div class="modal-header">
            <h4>Assign Lead To University</h4>
          <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
          
        </div>
        
        <div class="modal-body">
         <span>University : <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></span> 
            <asp:DropDownList ID="ddlUniversityToAssignLead" runat="server" Width="175px" style="display:none"></asp:DropDownList>
            
            <div class="multipleSelection">
            <div class="selectBox" 
                onclick="showUniversity()">
                <select class="form-control">
                    <option>Select University</option>
                </select>
                <div class="overSelect"></div>
            </div>
  
            <div id="checkUniversity" style="overflow: scroll; min-height: 200px; max-height:200px">
                <label for="U0"> <input type="checkbox" value="U0" id="U0" onchange="selectAllUniToAssign();">&nbsp;Select All</label>
                <%=_sbUniversity %>
            </div>
        </div>

                 </div>
        <div class="modal-footer">
            <input type="button" id="btnSaveAssignLeadToUniversity" onclick="return SaveAssignLeadToUniversity();" class="btn btn-primary" value="Save" />
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </div>
        </div>
     <!-- End Model AssignToUniversity-->

    

    <!-- Model ReAssign-->
    <div class="modal fade" id="modelReAssignUniversity" role="dialog">
    <div class="modal-dialog modal-lg">
          <div class="modal-content">
        <div class="modal-header">
            <h4>Re-Assign Lead</h4>          
        </div>
        
        <div class="modal-body">
            <div class="row">
                <div class="col-md-5">
                    <div class="row">
                        <div class="col-md-5">
                   <input type="radio" checked id="rdbCounsellors" name="RdbReAssign" />  <span>Counsellors : <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></span>   

                        </div>
                        <div class="col-md-7">
                            <select id="ddlReCounslers" class="form-control height_font_custom" style="width:175px;">
	                        <%=_sbReCounsellor %>
                        </select>

                        </div>
                       
                        <div class="col-md-6 pt-3">
                            <input type="text" class="form-control p-2" id="txtfilter" value="" onkeyup="myFunction()" placeholder="Filter by Reg No." />
                        </div>
                    </div>
            
            </div>
            <div class="col-md-7">
                <div class="row">
                <div class="col-md-4" style="display:none">
        <input type="radio" id="rdbUniversity" name="RdbReAssign" /> <span>University : <sup><i class="fa fa-asterisk" style="font-size:8px;color: darkred;"></i></sup></span>           
                </div>
                <div class="col-md-8" style="display:none">
                    <div class="multipleSelection">
            <div class="selectBox" 
                onclick="showReUniversity()">
                <select class="form-control">
                    <option>Select University</option>
                </select>
                <div class="overSelect"></div>
            </div>
  
            <div id="checkReUniversity" style="overflow: scroll; min-height: 200px; max-height:200px">
                <!--<label for="R0"> <input type="checkbox" value="R0" id="R0" />&nbsp;Select All</label>-->
                <%=_sbUniversity %>
            </div>
               </div>
                </div>
            </div>
          
                
          </div>
     <div class="col-md-7 mt-3">
         <div style="width:100%;">  
            <table class="fixed_header1 table-responsive" style="height:400px;">
                <thead style="position: sticky;top: 0;">
                    <tr>
                    <th style='width:100px!important'><input type="checkbox" id="chkReAll" onchange="checkAll();" />&nbsp;S.No</th>                                       
                    <th>Registration No.</th>
                    <th>Full Name</th>
                    <th>Status</th>
                    </tr>
                </thead>
                <tbody id="gridRegRe">
                    
                </tbody>

            </table>
        </div>
     </div>
            
                </div>
                 </div>
        <div class="modal-footer">
            <input type="button" id="btnSaveReAssignLead" onclick="return ReAssignLead();" class="btn btn-primary" value="Save" />
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </div>
        </div>
     <!-- End Model ReAssign-->

        <input type="hidden" id="hdfMsgPlateUpdate" />
         <input type="hidden" id="hdfHqUpdate" />
         <input type="hidden" id="hdfCrUpdate" />
        <input type="hidden" id="hdfMsgPlateUpdateText" />
         <input type="hidden" id="hdfHqUpdateText" />
         <input type="hidden" id="hdfCrUpdateText" />

    <script type="text/javascript">
        
        function BindGrid(RegionId, RowPerPage, PageNumber, Course, Qualification, Country, Status, StudentName, Flag) {
            $("#sampleTable_info").html('&nbsp;Showing 0 to 0 records of 0');

            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/BindRegistrationList",
                data: "{'RegionId':'" + RegionId + "','RowPerPage':'" + RowPerPage + "','PageNumber':'" + PageNumber + "','Course':'" + Course + "','Qualification':'" + Qualification + "','Country':'" + Country + "','Status':'" + Status + "','StudentName':'" + StudentName + "','Flag':'" + Flag + "'}",
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
                            item += "<td style='text-align:center;width:100px!important'><input type='checkbox' onchange='check();' value=" + id + " id='chk" + k + "'/>&nbsp;" + data.d[k].SNo + "</td>";
                            //item += "<td><a href='javascript:void(0);' id=" + id + " class='btn-sm btn-info viewData' style='display:inline' data-toggle='modal' onclick='return ViewDetails(this.id);' >View</a></td>";

                           /* if (FlagSts.trim().toUpperCase() == "")
                                Flag = "<i class='fa fa-flag-o fa-2x' aria-hidden='true'></i>";
                            else if (FlagSts.trim().toUpperCase() == "INACTIVE")
                                Flag = "<i class='fa fa-flag-o fa-2x' aria-hidden='true'></i>";
                           else if (FlagSts.trim().toUpperCase() == "ACTIVE")
                               Flag = "<i class='fa fa-flag-o fa-2x' aria-hidden='true' style='font-weight:bold'></i>";*/

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

                            item += "<td style='width:50px!important'>" + Flag + "</td>";
                            item += "<td style='width:250px!important'><a href='javascript:void(0);' id=" + id + " class='btn-sm btn-info viewData' style='display:inline' data-toggle='modal' onclick='return ViewDetails(this.id);' >View</a>";
                            item += " <a href='javascript:void(0);' onclick='return ShowEditReg(" + id + ");' class='btn-sm btn-success'>Edit</a>";
                            item += " <a href='javascript:void(0);' id=" + id + " onclick='return DeleteReg(this.id);' class='btn-danger btn-sm'>Delete</a>";
                            item += " <a href='javascript:void(0);' id=" + id + " onclick='return TrackActReg(this.id);' class='btn-primary btn-sm'>Track</a>";                            
                            item += " <a href='javascript:void(0);' onclick='return ShowNotes(" + id + ");' class='btn-sm btn-secondary'>Notes</a>&nbsp;";
                            item += " <a href='javascript:void(0);' onclick='return Lock(" + id + ");' class='btn-sm btn-secondary' style='background-color:orange; display:none'>Lock</a>&nbsp;";
                            item += " <a href='javascript:void(0);' onclick='return BLock(" + id + ");' class='btn-sm btn-secondary' style='background-color:orangered; display:none'>Block</a>";
                            item += " </td>";
                            

                            if (data.d[k].Active == 'Yes')
                                item += "<td style='text-align:center'><input checked onchange='return ChangeStatus(this.id);' type='checkbox' id=chk" + id + " name=''></td>";
                            else
                                item += "<td style='text-align:center'><input type='checkbox' onchange='return ChangeStatus(this.id);' id=chk" + id + " name=''></td>";
                            item += "<td id=tdAssignBy" + id + ">" + data.d[k].AssignedBy + "</td>";
                            item += "<td id=tdAssignTo" + id + ">" + data.d[k].AssignedTo + "</td>";
                            item += "<td>" + data.d[k].RegNo + "</td>";
                            item += "<td>" + data.d[k].Country + "</td>";
                            item += "<td>" + data.d[k].Name + "</td>";
                            item += "<td><a href='http://mail.qstudyabroad.com/Login.aspx' target='_blank' style='word-break:break-all'>" + data.d[k].EMail + "</a></td>";
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

                            item += "<td>" + data.d[k].hq + "</td>";
                            item += "<td>" + data.d[k].Course + "</td>";
                            
                            item += "<td style='display:none'>" + data.d[k].LastUpdatedBy + "</td>";                           
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
        window.onload = BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val(), $("#ContentPlaceHolder1_ddlStatus").val(), $("#ContentPlaceHolder1_txtStudentName").val(), $("#dropdownMenuButton").html());

        function NextRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) + 1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var Status = $("#ContentPlaceHolder1_ddlStatus").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, Status, StudentName, Flag);
        }

        function PrevRecords() {
            $("#hdfCurrentPageIndex").val(Number($("#hdfCurrentPageIndex").val()) - 1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var Status = $("#ContentPlaceHolder1_ddlStatus").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, Status, StudentName, Flag);
        }

        function PageSize() {
            $("#hdfCurrentPageIndex").val(1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var Status = $("#ContentPlaceHolder1_ddlStatus").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, Status, StudentName, Flag);
        }
        function FileterByRegion() {
            $("#hdfCurrentPageIndex").val(1);
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var Status = $("#ContentPlaceHolder1_ddlStatus").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, Status, StudentName, Flag);
        }
        function RefreshGrid() {
            $("#hdfCurrentPageIndex").val(1);
            $("#ContentPlaceHolder1_ddlRegion").val('-All Region-');
            $("#ddlPageSize").val(50);
            $("#ContentPlaceHolder1_ddlCourse").val('-Courses-');
            $("#ContentPlaceHolder1_ddlQualification").val('-Qualification-');
            $("#ContentPlaceHolder1_txtCountry").val('');
            $("#ContentPlaceHolder1_ddlStatus").val('Al');
            $("#ContentPlaceHolder1_txtStudentName").val('');
            $("#dropdownMenuButton").html('All Flag');
            var Region = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var Status = $("#ContentPlaceHolder1_ddlStatus").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, Status, StudentName, Flag);
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
            var Status = $("#ContentPlaceHolder1_ddlStatus").val();
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            BindGrid(Region, RowPerPage, PageNumber, Course, Qualification, Country, Status, StudentName, Flag);
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


        function DeleteReg(id) {
            var cnf = confirm('Are you sure to Delete ???');
            if (cnf == false)
                return false;
            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/DeleteRegistration",
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if (sts == "D") {
                        showMsg("SUCCESS", "Record Delete Successfully.!");
                        BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val(), $("#ContentPlaceHolder1_ddlStatus").val(), $("#ContentPlaceHolder1_txtStudentName").val(), $("#dropdownMenuButton").html());
                        
                    }
                    else if (sts == "ER") {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                },
                failure: function (xhr, errorType, exception) {
                    showMsg("ERROR", "Something went wrong.!");
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }

        function TrackActReg(id) {
            $("#tblTrack").empty();
            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/GetActivity",
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    $("#tblTrack").append(sts);
                    $("#modelTrack").modal("show");
                },
                failure: function (xhr, errorType, exception) {
                    showMsg("ERROR", "Something went wrong.!");
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        
        function ChangeStatus(ele) {
            var cnf = confirm('Are you sure to Change Status ???');
            if (cnf == false) {
                if (document.getElementById(ele).checked == true)
                    document.getElementById(ele).checked = false;
                else
                    document.getElementById(ele).checked = true;
                return false;
            }
            var sts = '';
            if (document.getElementById(ele).checked == true)
                sts = 'Yes';
            else
                sts = 'No';

            var id = ele.replace("chk", '');
            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/ChangeStatus",
                data: "{'id':'" + id + "','sts':'" + sts + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var sts = response.d;
                    if (sts == "D") {                        
                        showMsg("SUCCESS", "Status changed Successfully.!");
                        BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val(),$("#ContentPlaceHolder1_ddlStatus").val(), $("#ContentPlaceHolder1_txtStudentName").val(), $("#dropdownMenuButton").html());
                    }
                    else if (sts == "ER") {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                },
                failure: function (xhr, errorType, exception) {
                    showMsg("ERROR", "Something went wrong.!");
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
        }
        function ShowEditReg(RegId) {
            document.getElementById("divError2").innerHTML = '';
            if (document.getElementById("divError2").classList.contains("d-none")) {

            }
            else {
                document.getElementById("divError2").classList.add("d-none");
            }

            ClearModelValue();

            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/GetEditData",
                data: "{'RegId':'" + RegId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#ContentPlaceHolder1_hdfEditRegId").val(response.d[0].Reg_Id);
                    $("#ContentPlaceHolder1_txtRegNo").val(response.d[0].RegistrationNo);
                    $("#ContentPlaceHolder1_txtFullName").val(response.d[0].Name);
                    $("#ContentPlaceHolder1_gn").val(response.d[0].Gender);
                    //$("#phone").val(response.d[0].Country_Code);
                    $("#ContentPlaceHolder1_txtno").val(response.d[0].phone_no);

                    

                    //checkPlateform

                    var mapPlateform = response.d[0].msg;
                    var msgArray = mapPlateform.split(',');
                    len = msgArray.length;
                    var msgId = '';
                    var tmpid = '';
                    for (var m = 0; m < len; m++) {
                        msgId = msgArray[m];
                        if (msgId != '') {
                            tmpid = "m" + msgId;
                            if (document.getElementById(tmpid))
                                document.getElementById(tmpid).checked = true;
                        }
                    }
                    
                    // end
                    $("#ContentPlaceHolder1_txtemail").val(response.d[0].emailid);
                    $("#ContentPlaceHolder1_txtCountryUpdate").val(response.d[0].Country);
                    $("#ContentPlaceHolder1_city").val(response.d[0].City);

                    //checkHq
                    var mapHq = response.d[0].hq;
                    var mapHqArray = mapHq.split(',');
                    len = mapHqArray.length;
                    var mapHqId = '';

                    for (var m = 0; m < len; m++) {
                        mapHqId = mapHqArray[m];
                        if (mapHqId != '') {
                            tmpid = "q" + mapHqId;
                            if (document.getElementById(tmpid))
                                document.getElementById(tmpid).checked = true;
                        }
                    }

                    // end


                    //checkCourse

                    var mapCourse = response.d[0].course;
                    var mapCourseArray = mapCourse.split(',');
                    len = mapCourseArray.length;
                    var mapCourseId = '';

                    for (var m = 0; m < len; m++) {
                        mapCourseId = mapCourseArray[m];
                        if (mapCourseId != '') {
                            tmpid = "c" + mapCourseId;
                            if (document.getElementById(tmpid))
                                document.getElementById(tmpid).checked = true;
                        }
                    }

                    // end                   

                    var ielts = '';
                    ielts = response.d[0].TOEFLScore;
                    if (ielts == '') {
                        document.getElementById('RdbIeltsNo').checked = true;
                        document.getElementById('ContentPlaceHolder1_txtscore').style.display = 'none';
                        document.getElementById('RdbIeltsYes').checked = false;
                        document.getElementById('ContentPlaceHolder1_txtscore').value = '';
                    }
                    else {
                        document.getElementById('RdbIeltsNo').checked = false;
                        document.getElementById('ContentPlaceHolder1_txtscore').style.display = 'inline-block';
                        document.getElementById('RdbIeltsYes').checked = true;
                        document.getElementById('ContentPlaceHolder1_txtscore').value = ielts;
                    }

                    var abroad = response.d[0].StudyAbroad;
                    if (abroad == 'Yes') {
                        document.getElementById('RdbAbYes').checked = true;
                        document.getElementById('RdbAbNo').checked = false;
                    }
                    else {
                        document.getElementById('RdbAbYes').checked = false;
                        document.getElementById('RdbAbNo').checked = true;
                    }
                    $("#ContentPlaceHolder1_ddlFee").val(response.d[0].FeeRange == '' ? 0 : response.d[0].FeeRange);
                    var Active = response.d[0].Active;
                    if (Active == 'Yes')
                        document.getElementById('ContentPlaceHolder1_chkActive').checked = true;
                    else
                        document.getElementById('ContentPlaceHolder1_chkActive').checked = false;
                    $("#modelEditReg").modal("show");
                },
                failure: function (xhr, errorType, exception) {
                    showMsg('ERROR', 'Something went wrong.!');

                },
                error: function (response) {
                    showMsg('ERROR', 'Something went wrong.!');
                }
            });
        }

        var show = true;

        function showHq() {
            var checkboxes =
                document.getElementById("checkHq");

            if (show) {
                checkboxes.style.display = "block";
                show = false;
            } else {
                checkboxes.style.display = "none";
                show = true;
            }
        }

        function showCourse() {
            var checkboxes =
                document.getElementById("checkCourse");

            if (show) {
                checkboxes.style.display = "block";
                show = false;
            } else {
                checkboxes.style.display = "none";
                show = true;
            }
        }

        function showUniversity() {
            var checkboxes =
                document.getElementById("checkUniversity");

            if (show) {
                checkboxes.style.display = "block";
                show = false;
            } else {
                checkboxes.style.display = "none";
                show = true;
            }
        }


        function showPlateform() {
            var checkboxes =
                document.getElementById("checkPlateform");

            if (show) {
                checkboxes.style.display = "block";
                show = false;
            } else {
                checkboxes.style.display = "none";
                show = true;
            }
        }
        function CheckIelts() {
            if (document.getElementById('RdbIeltsYes').checked == true) {
                document.getElementById("ContentPlaceHolder1_txtscore").style.display = 'inline-block';
            }
            if (document.getElementById('RdbIeltsNo').checked == true) {
                document.getElementById("ContentPlaceHolder1_txtscore").style.display = 'none';
            }
        }

        function showReUniversity() {
            var checkboxes =
                document.getElementById("checkReUniversity");

            if (show) {
                checkboxes.style.display = "block";
                show = false;
            } else {
                checkboxes.style.display = "none";
                show = true;
            }
        }

        function UpdateRegistration() {
            
            document.getElementById("divError2").innerHTML = '';
            if (document.getElementById("divError2").classList.contains("d-none")) {

            }
            else {
                document.getElementById("divError2").classList.add("d-none");
            }

            if ($("#ContentPlaceHolder1_gn").val() == 'Select') {
                document.getElementById("divError2").innerHTML = "Please Select Gender.";
                document.getElementById("divError2").classList.remove("d-none");
                $("#ContentPlaceHolder1_Select").focus();
                return false;
            }

            if ($("#ContentPlaceHolder1_txtFullName").val().trim() == '') {
                document.getElementById("divError2").innerHTML = "Please enter Full Name.";
                document.getElementById("divError2").classList.remove("d-none");
                $("#ContentPlaceHolder1_txtFullName").focus();
                return false;
            }

            if ($("#ContentPlaceHolder1_txtno").val().trim() == '') {
                document.getElementById("divError2").innerHTML = "Please enter Mobile No.";
                document.getElementById("divError2").classList.remove("d-none");
                $("#ContentPlaceHolder1_txtno").focus();
                return false;
            }

            var Mc = 0;
            var RegGrid = document.getElementById('checkPlateform');
            var chk = RegGrid.getElementsByTagName('input');
            var len = chk.length;
            var Msg = '', MsgText = '';
            for (var k = 0; k < len; k++) {
                if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                    Mc = Number(Mc) + 1;
                    if (k == 0) {
                        Msg = (chk[k].id).replace("m", "");
                        MsgText = (chk[k].value);
                    }
                    else {
                        Msg = Msg + ',' + (chk[k].id).replace("m", "");
                        MsgText = MsgText + ',' + (chk[k].value);
                    }
                }
            }
            if (Mc == 0) {
                document.getElementById("divError2").innerHTML = "Please enter Platform You Use.";
                document.getElementById("divError2").classList.remove("d-none");
                return false;
            }
            document.getElementById('hdfMsgPlateUpdate').value = Msg;
            document.getElementById('hdfMsgPlateUpdateText').value = MsgText;

            if ($("#ContentPlaceHolder1_txtemail").val().trim() == '') {
                document.getElementById("divError2").innerHTML = "Please enter E-Mail.";
                document.getElementById("divError2").classList.remove("d-none");
                $("#ContentPlaceHolder1_txtemail").focus();
                return false;
            }

            if ($("#ContentPlaceHolder1_txtCountryUpdate").val().trim() == '') {
                document.getElementById("divError2").innerHTML = "Please enter Country";
                document.getElementById("divError2").classList.remove("d-none");
                $("#ContentPlaceHolder1_txtCountryUpdate").focus();
                return false;
            }

            if ($("#ContentPlaceHolder1_city").val().trim() == '') {
                document.getElementById("divError2").innerHTML = "Please enter City";
                document.getElementById("divError2").classList.remove("d-none");
                $("#ContentPlaceHolder1_city").focus();
                return false;
            }
            
            var Mc = 0;
            var RegGrid = document.getElementById('checkHq');
            var chk = RegGrid.getElementsByTagName('input');
            var len = chk.length;
            var Hq = '', HqText = '';
            for (var k = 0; k < len; k++) {
                if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                    Mc = Number(Mc) + 1;
                    if (k == 0) {
                        Hq = (chk[k].id).replace("q", "");
                        HqText = (chk[k].value);
                    }
                    else {
                        Hq = Hq + ',' + (chk[k].id).replace("q", "");
                        HqText = HqText + "," + (chk[k].value);
                    }
                }
            }
            if (Mc == 0) {
                document.getElementById("divError2").innerHTML = "Please enter Current highest qualification.";
                document.getElementById("divError2").classList.remove("d-none");
                return false;
            }
            document.getElementById('hdfHqUpdate').value = Hq;
            document.getElementById('hdfHqUpdateText').value = HqText;

            var Mc = 0;
            var RegGrid = document.getElementById('checkCourse');
            var chk = RegGrid.getElementsByTagName('input');
            var len = chk.length;
            var Cr = '', CrText = '';
            for (var k = 0; k < len; k++) {
                if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                    Mc = Number(Mc) + 1;
                    if (k == 0) {
                        Cr = (chk[k].id).replace("c", "");
                        CrText = (chk[k].value);
                    }
                    else {
                        Cr = Cr + ',' + (chk[k].id).replace("c", "");
                        CrText = CrText + "," + (chk[k].value);
                    }
                }
            }
            if (Mc == 0) {
                document.getElementById("divError2").innerHTML = "Please enter what course are you looking for. ?";
                document.getElementById("divError2").classList.remove("d-none");
                return false;
            }
            document.getElementById('hdfCrUpdate').value = Cr;
            document.getElementById('hdfCrUpdateText').value = CrText;
            
            if (document.getElementById('RdbIeltsYes').checked == true && document.getElementById('ContentPlaceHolder1_txtscore').value == '') {
                document.getElementById("divError2").innerHTML = "Please enter Score.";
                document.getElementById("divError2").classList.remove("d-none");
                $("#ContentPlaceHolder1_txtscore").focus();
                return false;
            }
            if ($("#ContentPlaceHolder1_ddlFee").val() == '0') {
                document.getElementById("divError2").innerHTML = "What fee range are you looking at. ?";
                document.getElementById("divError2").classList.remove("d-none");
                $("#ContentPlaceHolder1_ddlFee").focus();
                return false;
            }

            var RegId = $("#ContentPlaceHolder1_hdfEditRegId").val();
            var Gender = $("#ContentPlaceHolder1_gn").val();
            var FullName = $("#ContentPlaceHolder1_txtFullName").val();
            var Mobile = $("#ContentPlaceHolder1_txtno").val();
            var email = $("#ContentPlaceHolder1_txtemail").val();
            var country = $("#ContentPlaceHolder1_txtCountryUpdate").val();
            var city = $("#ContentPlaceHolder1_city").val();
            var ieltsScore = $("#ContentPlaceHolder1_txtscore").val();
            var Abroad = '';
            var fee = $("#ContentPlaceHolder1_ddlFee").val();
            var active = '';
            var MsgId = Msg;
            MsgText = MsgText
            var HqId = Hq;
            HqText = HqText;
            var CrId = Cr;
            CrText = CrText;

            if (document.getElementById('RdbAbYes').checked == true)
                Abroad = "Yes";
            else
                Abroad = "No";
            if (document.getElementById('ContentPlaceHolder1_chkActive').checked == true)
                active = "Yes";
            else
                active = "No";

            document.getElementById("ContentPlaceHolder1_btnUpdate").disabled = true;
            document.getElementById("ContentPlaceHolder1_btnUpdate").innerHTML = 'Please wait..';

            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/UpdateRegistration",
                data: "{'RegId':'" + RegId + "','Gender':'" + Gender + "','FullName':'" + FullName + "','Mobile':'" + Mobile + "','email':'" + email + "','country':'" + country + "','city':'" + city + "','ieltsScore':'" + ieltsScore + "','Abroad':'" + Abroad + "','fee':'" + fee + "','active':'" + active + "','MsgId':'" + MsgId + "','MsgText':'" + MsgText + "','HqId':'" + HqId + "','HqText':'" + HqText + "','CrId':'" + CrId + "','CrText':'" + CrText + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    document.getElementById("ContentPlaceHolder1_btnUpdate").disabled = false;
                    document.getElementById("ContentPlaceHolder1_btnUpdate").value = 'Update';
                    ClearModelValue();
                    if (response.d == "S") {
                        $("#modelEditReg").modal("hide");
                        BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val(), $("#ContentPlaceHolder1_ddlStatus").val(), $("#ContentPlaceHolder1_txtStudentName").val(), $("#dropdownMenuButton").html());
                        showMsg("SUCCESS", "Record has been updated successfully.!");
                    }
                    else if (response.d == "ER") {
                        document.getElementById("divError2").innerHTML = 'Something went wrong.!';
                        if (document.getElementById("divError2").classList.contains("d-none")) {

                        }
                        else {
                            document.getElementById("divError2").classList.add("d-none");
                        }
                    }
                },
                error: function (response) {
                    document.getElementById("ContentPlaceHolder1_btnUpdate").disabled = false;
                    document.getElementById("ContentPlaceHolder1_btnUpdate").value = 'Update';
                    document.getElementById("divError2").innerHTML = 'Something went wrong.!';
                    if (document.getElementById("divError2").classList.contains("d-none")) {

                    }
                    else {
                        document.getElementById("divError2").classList.add("d-none");
                    }
                }
            });
            return false;
        }

        function ClearModelValue() {
            $("#ContentPlaceHolder1_hdfEditRegId").val('');
            $("#ContentPlaceHolder1_txtRegNo").val('');
            $("#ContentPlaceHolder1_txtFullName").val('');
            $("#ContentPlaceHolder1_gn").val('Select');
            //$("#phone").val(response.d[0].Country_Code);
            $("#ContentPlaceHolder1_txtno").val('');

            $("#ContentPlaceHolder1_txtemail").val('');
            $("#ContentPlaceHolder1_txtCountryUpdate").val('');
            $("#ContentPlaceHolder1_city").val('');
            document.getElementById('RdbIeltsNo').checked = true;
            document.getElementById('ContentPlaceHolder1_txtscore').style.display = 'none';
            document.getElementById('ContentPlaceHolder1_txtscore').value = '';
            document.getElementById('RdbAbYes').checked = false;
            document.getElementById('RdbAbNo').checked = false;
            $("#ContentPlaceHolder1_ddlFee").val('0');
            document.getElementById('ContentPlaceHolder1_chkActive').checked = false;

            var RegGrid = document.getElementById('checkPlateform');
            var chk = RegGrid.getElementsByTagName('input');
            var len = chk.length;
            for (var k = 0; k < len; k++) {
                if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                    document.getElementById(chk[k].id).checked = false;
                }
            }

            RegGrid = document.getElementById('checkHq');
            chk = RegGrid.getElementsByTagName('input');
            len = chk.length;
            for (var k = 0; k < len; k++) {
                if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                    document.getElementById(chk[k].id).checked = false;
                }
            }

            RegGrid = document.getElementById('checkCourse');
            chk = RegGrid.getElementsByTagName('input');
            len = chk.length;
            for (var k = 0; k < len; k++) {
                if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                    document.getElementById(chk[k].id).checked = false;
                }
            }
        }

        function checkAll() {

            var grd = document.getElementById('gridReg');
            var rows = grd.rows.length;
            var chkId = '';
            if (document.getElementById('chkAll').checked == true) {
                for (var k = 0; k < rows; k++) {
                    chkId = "chk" + k;
                    document.getElementById(chkId).checked = true;
                }
                document.getElementById('divAssign').style.display = 'flex';
                document.getElementById('ContentPlaceHolder1_btnSearch').disabled = true;
                document.getElementById('ContentPlaceHolder1_btnRefresh').disabled = true;
            }
            else {
                for (var k = 0; k < rows; k++) {
                    chkId = "chk" + k;
                    document.getElementById(chkId).checked = false;
                }
                document.getElementById('divAssign').style.display = 'none';
                document.getElementById('ContentPlaceHolder1_btnSearch').disabled = false;
                document.getElementById('ContentPlaceHolder1_btnRefresh').disabled = false;
            }
            return false;
        }

        function check() {
            
            document.getElementById('chkAll').checked = false;
            var grd = document.getElementById('gridReg');
            var rows = grd.rows.length;
            var c = '0';
            for (var k = 0; k < rows; k++) {
                chkId = "chk" + k;
                if (document.getElementById(chkId).checked == true) {
                    c = Number(c) + 1;
                }
            }
            if (Number(c) > Number(0)) {
                document.getElementById('divAssign').style.display = 'flex';
                document.getElementById('ContentPlaceHolder1_btnSearch').disabled = true;
                document.getElementById('ContentPlaceHolder1_btnRefresh').disabled = true;
                $("#ContentPlaceHolder1_ddlCounslers").val('-Select Users-');
            }
            else {
                document.getElementById('divAssign').style.display = 'none';
                document.getElementById('ContentPlaceHolder1_btnSearch').disabled = false;
                document.getElementById('ContentPlaceHolder1_btnRefresh').disabled = false;
            }
            return false;
        }

        function AssignLead() {

            var tmpLead = '';
            var grd = document.getElementById('gridReg');
            var rows = grd.rows.length;
            var c = 0;
            for (var k = 0; k < rows; k++) {
                chkId = "chk" + k;
                if (document.getElementById(chkId).checked == true) {
                    c = Number(c) + Number(1);
                    tmpLead = tmpLead + ',' + document.getElementById(chkId).value;
                }
            }
            if (Number(c) == Number(0)) {
                showMsg("ERROR", "Please select Lead to Assign. !");
                return false;
            }
            
            var LeadId = tmpLead.slice(1);
            
            var AssignTo = $("#ContentPlaceHolder1_ddlCounslers").val();
            var AssignBy = $("#ContentPlaceHolder1_hdfUserId").val();

            if (AssignTo == "-Select Users-") {                
                showMsg("ERROR", "Please select Users to Assign. !");
                return false;
            }

            document.getElementById('btnAssignLead').disabled = true;
            document.getElementById('btnAssignLead').value = "Please Wait..";

            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/AssignLeads",
                data: "{'LeadId':'" + LeadId + "','AssignTo':'" + AssignTo + "','AssignBy':'" + AssignBy + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    document.getElementById('btnAssignLead').disabled = false;
                    document.getElementById('btnAssignLead').value = "Assign";
                    var tmpSts = response.d;
                    var sts = '', TotalRec = 0;
                    if (tmpSts.includes('^')) {
                        sts = tmpSts.split('^')[0];
                        TotalRec = tmpSts.split('^')[1];
                    }
                    else {
                        sts = response.d;
                    }
                    
                    if (sts == "S") {
                        document.getElementById('ContentPlaceHolder1_btnSearch').disabled = false;
                        document.getElementById('ContentPlaceHolder1_btnRefresh').disabled = false;
                        $("#ContentPlaceHolder1_ddlCounslers").val('-Select Users-')
                        document.getElementById('divAssign').style.display = 'none';
                        showMsg("SUCCESS", "Total " + TotalRec + "&nbsp;Lead assigned successfully. !");
                        //BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val());
                    }
                    else if (sts == "EX") {
                        showMsg("ERROR", "Lead already assigned. !");

                    }
                    else {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                },
                failure: function (xhr, errorType, exception) {
                    document.getElementById('btnAssignLead').disabled = false;
                    document.getElementById('btnAssignLead').value = "Assign";
                    showMsg("ERROR", "Something went wrong.!");
                },
                error: function (response) {
                    document.getElementById('btnAssignLead').disabled = false;
                    document.getElementById('btnAssignLead').value = "Assign";
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }

        function OpenMoveModel() {
            $("#ContentPlaceHolder1_ddlMoveRegion").val("-All Region-");
            $("#modelMove").modal("show");
        }

        function MoveLead() {

            var RegionId = $("#ContentPlaceHolder1_ddlMoveRegion").val();
            if (RegionId == "-All Region-") {
                alert('Please select Region. !')
                return false;
            }

            var tmpLead = '';
            var grd = document.getElementById('gridReg');
            var rows = grd.rows.length;
            var c = 0;
            for (var k = 0; k < rows; k++) {
                chkId = "chk" + k;
                if (document.getElementById(chkId).checked == true) {
                    c = Number(c) + Number(1);
                    tmpLead = tmpLead + ',' + document.getElementById(chkId).value;
                }
            }
            if (Number(c) == Number(0)) {
                showMsg("ERROR", "Please select Lead to move. !");
                return false;
            }

            var LeadId = tmpLead.slice(1);

            document.getElementById('btnSaveMoveLead').disabled = true;
            document.getElementById('btnSaveMoveLead').value = "Please Wait..";

            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/MoveLead",
                data: "{'LeadId':'" + LeadId + "','RegionId':'" + RegionId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    document.getElementById('btnSaveMoveLead').disabled = false;
                    document.getElementById('btnSaveMoveLead').value = "Save";
                    var sts = response.d;
                    if (sts == "S") {
                        $("#modelMove").modal("hide");
                        document.getElementById('ContentPlaceHolder1_btnSearch').disabled = false;
                        document.getElementById('ContentPlaceHolder1_btnRefresh').disabled = false;
                        $("#ContentPlaceHolder1_ddlMoveRegion").val('-All Region-')
                        document.getElementById('divAssign').style.display = 'none';
                        showMsg("SUCCESS", "Lead moved successfully. !");
                       // BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val());
                    }
                    else if (sts == "EX") {
                        showMsg("ERROR", "Lead already moved. !");
                    }
                    else {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                },
                failure: function (xhr, errorType, exception) {
                    document.getElementById('btnSaveMoveLead').disabled = false;
                    document.getElementById('btnSaveMoveLead').value = "Save";
                    showMsg("ERROR", "Something went wrong.!");
                },
                error: function (response) {
                    document.getElementById('btnSaveMoveLead').disabled = false;
                    document.getElementById('btnSaveMoveLead').value = "Save";
                    showMsg("ERROR", "Something went wrong.!");
                }
            });
            return false;
        }

        function ExcelDownload() {

            var RegionId = $("#ContentPlaceHolder1_ddlRegion").val();
            var RowPerPage = $("#ddlPageSize").val();
            var PageNumber = $("#hdfCurrentPageIndex").val();
            var Course = $("#ContentPlaceHolder1_ddlCourse").val();
            var Qualification = $("#ContentPlaceHolder1_ddlQualification").val();
            var Country = $("#ContentPlaceHolder1_txtCountry").val();
            var AStatus = $("#ContentPlaceHolder1_ddlStatus").val();
            var Status = "RegList";
            var StudentName = $("#ContentPlaceHolder1_txtStudentName").val();
            var Flag = $("#dropdownMenuButton").html();
            window.location.href = "download.aspx?Status=" + Status + "&RegionId=" + RegionId + "&RowPerPage=" + RowPerPage + "&PageNumber=" + PageNumber + "&Course=" + Course + "&Qualification=" + Qualification + "&Country=" + Country + "&AStatus=" + AStatus + "&StudentName=" + StudentName + "&Flag=" + Flag;
        }
        function OpenUploadPopup() {
            $("#divFailedExcel").empty();
            $("#flUploadExcel").val('');
            $("#modelUpload").modal("show");
        }

        function UploadLead() {

            if ($("#flUploadExcel").val() == '') {
                showMsg('ERROR', 'Please select valid Excel File. !');
                return false;
            }
            $("#divFailedExcel").empty();
            var formData = new FormData();
            formData.append('file', $('#flUploadExcel')[0].files[0]);

            document.getElementById('btnUploadLead').disabled = true;
            document.getElementById('btnUploadLead').value = "Please Wait...";
            //
            $("#divFailedExcel").html('<img src="img/loader.gif" alt="loader" height="120">');
            $.ajax({
                url: '../SuperAdmin/UploadRegistrationExcel.ashx',
                type: "POST",
                contentType: false, // Not to set any content header  
                processData: false, // Not to process data  
                data: formData,
                success: function (result) {                  
                    
                    var Rslt = result;
                    var sts = Rslt.split('^')[0];
                    var tbl = Rslt.split('^')[1];
                    
                    if (sts == 'S') {
                        setTimeout(function () {
                            $("#divFailedExcel").empty();
                            $("#divFailedExcel").append(tbl);
                            document.getElementById('btnUploadLead').disabled = false;
                            document.getElementById('btnUploadLead').value = "Upload";
                            showMsg('SUCCESS', 'Records have been uploaded successfully. !');
                        }, 3000);
                        //$("#modelUpload").modal("hide");
                        
                    }
                    else {
                        setTimeout(function () {
                            $("#divFailedExcel").empty();
                            $("#divFailedExcel").append(tbl);
                            document.getElementById('btnUploadLead').disabled = false;
                            document.getElementById('btnUploadLead').value = "Upload";
                        }, 3000);
                    }    
                },
                error: function (err) {
                    showMsg('ERROR', 'Something went wrong. !');
                    document.getElementById('btnUploadLead').disabled = false;
                    document.getElementById('btnUploadLead').value = "Upload";
                }
            });
            return false;
        }

        function ValidateExcelUpload(eleId) {
            var fuData = document.getElementById(eleId);
            var FileUploadPath = fuData.value;

            //To check if user upload any file
            if (FileUploadPath == '') {
                showMsg("ERROR", "Please upload an Excel File.");

            } else {
                var Extension = FileUploadPath.substring(
                        FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

                //The file uploaded is an image

                if (Extension == "xls" || Extension == "xlsx") {

                }
                else {
                    showMsg("ERROR", "Excel File only allows file types of xls, xlsx. ");
                    document.getElementById(eleId).value = '';
                }
            }
        }

        function downloadRegFormat() {
            var Status = "RegFormat";
            var FileName = "RegistrationUploadFormat.xlsx";
            window.location.href = "download.aspx?Status=" + Status + "&FileName=" + FileName;
        }

        function ShowNotes(RegId) {
            $("#txtStudentNote").val('');
            $("#dropdownMenuButtonNote").html('Flag');
            $("#hdfRegId").val(RegId);
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
            var AssignTo = '0';
            var Sts = 'None';

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
            else if (document.getElementById('chkAssignToCounsellor').checked == true && $("#ContentPlaceHolder1_ddlAssignNoteToCounsellors").val() == '-Select Counsellors-') {
                showMsg("ERROR", "Counsellors must not be blank. !");
                return false;
            }
            else if (document.getElementById('chkAssignToUniversity').checked == true && $("#ContentPlaceHolder1_ddlAssignNoteToUniversity").val() == '-Select University-') {
                showMsg("ERROR", "University must not be blank. !");
                return false;
            }

            if (document.getElementById('chkAssignToCounsellor').checked == true) {
                AssignTo = $("#ContentPlaceHolder1_ddlAssignNoteToCounsellors").val();
                Sts = "Counsellors";
            }
            else if (document.getElementById('chkAssignToUniversity').checked == true) {
                AssignTo = $("#ContentPlaceHolder1_ddlAssignNoteToUniversity").val();
                Sts = "University";
            }

            $("#ContentPlaceHolder1_btnNotes").attr("disabled", true);
            $("#ContentPlaceHolder1_btnNotes").val("Please Wait..");
            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/SaveNote",
                data: "{'RegId':'" + RegId + "','Notes':'" + Notes + "','NoteId':'" + NoteId + "','Flag':'" + Flag + "','UniversityId':'" + UniversityId + "','AssignTo':'" + AssignTo + "','Sts':'" + Sts + "'}",
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
                        BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val(), $("#ContentPlaceHolder1_ddlStatus").val(), $("#ContentPlaceHolder1_txtStudentName").val(), $("#dropdownMenuButton").html());
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

        function Lock(RegId) {
            $("#ContentPlaceHolder1_ddlUniversity").val('-University-');
            $("#ContentPlaceHolder1_hdfEditRegId").val(RegId);
            $("#modelLock").modal("show");
        }
        function BLock(RegId) {
            $("#ContentPlaceHolder1_hdfEditRegId").val(RegId);
            $("#txtBlockMsg").val('');
            $("#modelBLock").modal("show");
        }

        function FetchEditNoteData(id) {
            $("#hdfNoteEditId").val(id);
            $("#txtStudentNote").val($("#" + id).attr("data-id"));
            $("#dropdownMenuButtonNote").html($.trim($("#" + id).attr("data-Flag")));
            document.getElementById('chkAssignToNone').checked = false;
            document.getElementById('chkAssignToCounsellor').checked = false;
            document.getElementById('chkAssignToUniversity').checked = false;
            $("#ContentPlaceHolder1_ddlAssignNoteToCounsellors").val('-Select Counsellors-');
            $("#ContentPlaceHolder1_ddlAssignNoteToUniversity").val('-Select University-');
            document.getElementById('ContentPlaceHolder1_ddlAssignNoteToCounsellors').style.display = 'none';
            document.getElementById('ContentPlaceHolder1_ddlAssignNoteToUniversity').style.display = 'none';

            if ($.trim($("#" + id).attr("data-Flag")) == "Signed Up/ Lock") {
                $("#trLockUniversity").css("display", "table-row");
                $("#ContentPlaceHolder1_ddlUniversity").val($.trim($("#" + id).attr("data-University")));

            }
            else {
                $("#trLockUniversity").css("display", "none");
                $("#ContentPlaceHolder1_ddlUniversity").val('-University-');
            }

            var sts = $("#" + id).attr("data-Status");
            var AssignTo = $("#" + id).attr("data-AssignTo");
            if (sts == "Counsellors") {
                $("#ContentPlaceHolder1_ddlAssignNoteToCounsellors").val(AssignTo);
                document.getElementById('chkAssignToCounsellor').checked = true;
                document.getElementById('ContentPlaceHolder1_ddlAssignNoteToCounsellors').style.display = 'block';
            }
            else if (sts == "University") {
                $("#ContentPlaceHolder1_ddlAssignNoteToUniversity").val(AssignTo);
                document.getElementById('chkAssignToUniversity').checked = true;
                document.getElementById('ContentPlaceHolder1_ddlAssignNoteToUniversity').style.display = 'block';
            }
            else {
                document.getElementById('chkAssignToNone').checked = true;
                $("#ContentPlaceHolder1_ddlAssignNoteToCounsellors").val('-Select Counsellors-');
                $("#ContentPlaceHolder1_ddlAssignNoteToUniversity").val('-Select University-');
                document.getElementById('ContentPlaceHolder1_ddlAssignNoteToCounsellors').style.display = 'none';
                document.getElementById('ContentPlaceHolder1_ddlAssignNoteToUniversity').style.display = 'none';
            }
            return false;
        }

        function LockStudent() {
            var UniversityId = $("#ContentPlaceHolder1_ddlUniversity").val();            
            var LeadId = $("#ContentPlaceHolder1_hdfEditRegId").val();
            if ($("#ContentPlaceHolder1_ddlUniversity").val() == '-University-') {
                showMsg("ERROR", "Please select University. !");
                return false;
            }

            $("#ContentPlaceHolder1_btnLockStudent").attr("disabled", true);
            $("#ContentPlaceHolder1_btnLockStudent").val("Please Wait..");
            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/LockStudent",
                data: "{'UniversityId':'" + UniversityId + "','LeadId':'" + LeadId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "ER") {
                        showMsg("ERROR", "Something went wrong. !");                                             
                    }
                    else if (response.d == "EX") {
                        showMsg("ERROR", "Lead Already Locked. !");
                    }
                    else {
                        $("#modelLock").modal("hide");
                        BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val(), $("#ContentPlaceHolder1_ddlStatus").val(), $("#ContentPlaceHolder1_txtStudentName").val(), $("#dropdownMenuButton").html());
                        $("#ContentPlaceHolder1_ddlUniversity").val('-University-');
                        $("#ContentPlaceHolder1_hdfEditRegId").val('');
                        showMsg("SUCCESS", "Lead has been Locked successfully. !");
                    }
                    $("#ContentPlaceHolder1_btnLockStudent").attr("disabled", false);
                    $("#ContentPlaceHolder1_btnLockStudent").val("Save");
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong. !");
                    $("#ContentPlaceHolder1_btnLockStudent").attr("disabled", false);
                    $("#ContentPlaceHolder1_btnLockStudent").val("Save");
                }
            });
            return false;
        }

        function BLockStudent() {
            
            var LeadId = $("#ContentPlaceHolder1_hdfEditRegId").val();
            var Remark = $("#txtBlockMsg").val();
            if ($("#txtBlockMsg").val() == '') {
                showMsg("ERROR", "Please Enter Remark. !");
                return false;
            }

            $("#ContentPlaceHolder1_btnBlock").attr("disabled", true);
            $("#ContentPlaceHolder1_btnBlock").val("Please Wait..");
            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/BLockStudent",
                data: "{'LeadId':'" + LeadId + "','Remark':'" + Remark + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "ER") {
                        showMsg("ERROR", "Something went wrong. !");
                    }
                    else if (response.d == "EX") {
                        showMsg("ERROR", "Lead Already BLocked. !");
                    }
                    else {
                        $("#modelBLock").modal("hide");
                        BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val(), $("#ContentPlaceHolder1_ddlStatus").val(), $("#ContentPlaceHolder1_txtStudentName").val(), $("#dropdownMenuButton").html());
                        $("#ContentPlaceHolder1_hdfEditRegId").val('');
                        $("#txtBlockMsg").val('');
                        showMsg("SUCCESS", "Lead has been BLocked successfully. !");
                    }
                    $("#ContentPlaceHolder1_btnBlock").attr("disabled", false);
                    $("#ContentPlaceHolder1_btnBlock").val("Save");
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong. !");
                    $("#ContentPlaceHolder1_btnBlock").attr("disabled", false);
                    $("#ContentPlaceHolder1_btnBlock").val("Save");
                }
            });
            return false;
        }
        
        function OpenAssignLeadToUniversityModel() {
            $("#ContentPlaceHolder1_ddlUniversityToAssignLead").val('-University-');
            $("#modelAssignLeadToUniversity").modal("show");
        }

        function SaveAssignLeadToUniversity() {

            var UniversityId = $("#ContentPlaceHolder1_ddlUniversityToAssignLead").val();
            var tmpLead = '';
            var grd = document.getElementById('gridReg');
            var rows = grd.rows.length;
            var c = 0;
            for (var k = 0; k < rows; k++) {
                chkId = "chk" + k;
                if (document.getElementById(chkId).checked == true) {
                    c = Number(c) + Number(1);
                    tmpLead = tmpLead + ',' + document.getElementById(chkId).value;
                }
            }
            if (Number(c) == Number(0)) {
                showMsg("ERROR", "Please select Lead to Assign. !");
                return false;
            }
            
            var div = document.getElementById('checkUniversity');
            var chk = div.getElementsByTagName('input');
            var len = chk.length;
            var UniversityId = '', tmpUniversityId='';
            c = 0;
            var tmpUid = '';
            for (var j = 0; j < len; j++) {
                if (chk[j].type == 'checkbox' && chk[j].checked == true) {
                    tmpUid = chk[j].id;
                    if (document.getElementById(tmpUid).value != 'U0') {
                        tmpUniversityId = tmpUniversityId + ',' + document.getElementById(tmpUid).value.replace("U", '');
                        c = Number(c) + Number(1);
                    }
                }
            }

            if (Number(c) == Number(0)) {
                showMsg("ERROR", "Please select University to Assign. !");
                return false;
            }

            var LeadId = tmpLead.slice(1);
            UniversityId = tmpUniversityId.slice(1);

            document.getElementById('btnSaveAssignLeadToUniversity').disabled = true;
            document.getElementById('btnSaveAssignLeadToUniversity').value = "Please Wait..";

            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/AssignLeadToUniversity",
                data: "{'LeadId':'" + LeadId + "','UniversityId':'" + UniversityId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    document.getElementById('btnSaveAssignLeadToUniversity').disabled = false;
                    document.getElementById('btnSaveAssignLeadToUniversity').value = "Save";
                    var tmpSts = response.d;
                    var sts = '', Total = '';
                    if (tmpSts.includes('^')) {
                        sts = tmpSts.split('^')[0];
                        Total = tmpSts.split('^')[1];
                    }
                    else {
                        sts = response.d;
                    }
                    if (sts == "S") {
                        $("#modelAssignLeadToUniversity").modal("hide");
                        document.getElementById('ContentPlaceHolder1_btnSearch').disabled = false;
                        document.getElementById('ContentPlaceHolder1_btnRefresh').disabled = false;
                        $("#ContentPlaceHolder1_ddlUniversityToAssignLead").val('-University-');
                        document.getElementById('divAssign').style.display = 'none';
                        showMsg("SUCCESS", "Total " + Total + " Lead Assigned Successfully. !");

                        var div = document.getElementById('checkUniversity');
                        var chk = div.getElementsByTagName('input');
                        var len = chk.length;                        
                        for (var j = 0; j < len; j++) {
                            if (chk[j].type == 'checkbox') {
                                document.getElementById(chk[j]).checked = false;
                            }
                        }

                       // BindGrid($("#ContentPlaceHolder1_ddlRegion").val(), $("#ddlPageSize").val(), $("#hdfCurrentPageIndex").val(), $("#ContentPlaceHolder1_ddlCourse").val(), $("#ContentPlaceHolder1_ddlQualification").val(), $("#ContentPlaceHolder1_txtCountry").val());
                    }
                    else if (sts == "EX") {
                        showMsg("ERROR", "Lead already Assigned. !");
                    }
                    else {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                },
                failure: function (xhr, errorType, exception) {
                    document.getElementById('btnSaveAssignLeadToUniversity').disabled = false;
                    document.getElementById('btnSaveAssignLeadToUniversity').value = "Save";
                    showMsg("ERROR", "Something went wrong.!");
                },
                error: function (response) {
                    document.getElementById('btnSaveAssignLeadToUniversity').disabled = false;
                    document.getElementById('btnSaveAssignLeadToUniversity').value = "Save";
                    showMsg("ERROR", "Something went wrong.!");
                }
            });

            return false;
        }

        $("#dropdownMenuButton").click(function () {
            $("#divFlg").toggle();
        });

        $("#dropdownMenuButtonNote").click(function () {
            $("#divFlgNote").toggle();
        });

        function selectAllUniToAssign() {
            var div = document.getElementById('checkUniversity');
            var chk = div.getElementsByTagName('input');
            var len = chk.length;

            if (document.getElementById('U0').checked == true) {
                for (var k = 0; k < len; k++) {
                    if (chk[k].type == 'checkbox')
                        document.getElementById(chk[k].id).checked = true;
                }

            }
            else {
                for (var k = 0; k < len; k++) {
                    if (chk[k].type == 'checkbox')
                        document.getElementById(chk[k].id).checked = false;
                }
            }
            return false;
        }

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

        function OpenReAssignLeadModel() {
            // $("#ContentPlaceHolder1_ddlUniversityToAssignLead").val('-University-');
            $("#modelReAssignUniversity").modal("show");
            BindReGrid(0, 0, '');
        }
        function myFunction() {
            BindReGrid(0, 0, $("#txtfilter").val());
        }
        document.getElementById('txtfilter').onkeydown = function (event) {
            if (event.keyCode == 13) {
                myFunction();
                return false;
            }
        }
        function BindReGrid(RowPerPage, PageNumber, FilterBy) {
            // $("#sampleTable_infoRe").html('&nbsp;Showing 0 to 0 records of 0');

            $.ajax({
                type: "POST",
                url: "RegistrationList.aspx/BindReAssignRegistrationList",
                data: "{'RowPerPage':'" + RowPerPage + "','PageNumber':'" + PageNumber + "','FilterBy':'" + FilterBy + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var len = data.d.length;
                    $("#gridRegRe").empty();
                    var item = '';
                    if (len > 0) {
                        var id = '';
                        for (var k = 0; k < len; k++) {
                            id = data.d[k].Reg_Id;
                            item += "<tr>";
                            item += "<td style='text-align:center;width:100px!important'><input type='checkbox' onchange='check();' value=" + id + " id='chk" + k + "'/>&nbsp;" + data.d[k].SNo + "</td>";
                            item += "<td>" + data.d[k].RegNo + "</td>";
                            item += "<td>" + data.d[k].Name + "</td>";
                            item += "<td id=tdImg" + id + "></td>";
                            item += "</tr>";
                        }
                        $("#gridRegRe").append(item);
                    }
                    else {
                        $("#gridRegRe").empty();
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");

                }
            });
            return false;
        }

        function ReAssignLead() {

            if ($("#ddlReCounslers").val() == "-Select Users-") {
                showMsg('ERROR', 'Please select valid Counsellors. !');
                return false;
            }

            var Table = document.getElementById('gridRegRe');
            var chk = Table.getElementsByTagName('input');
            var len = chk.length;
            var RegId = '';
            var CounselorId = '', UniversityId = '';
            var sts = '';
            var c = 0;
            var img = '';

            for (var k = 0; k < len; k++) {
                if (chk[k].type == 'checkbox' && chk[k].checked == true) {
                    c = Number(c) + Number(1);
                    RegId = chk[k].value;
                    if (document.getElementById('rdbCounsellors').checked == true) {
                        CounselorId = $("#ddlReCounslers").val();
                        sts = 'CNS';
                        $.ajax({
                            type: "POST",
                            url: "RegistrationList.aspx/ReAssignLead",
                            data: "{'LeadId':'" + RegId + "','AssignTo':'" + CounselorId + "','sts':'" + sts + "','UniversityId':'" + UniversityId + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == "S") {
                                }
                                else if (data.d == "ER") {
                                }

                            },
                            error: function (data) {
                            }
                        });
                    }
                }
            }
            showMsg("SUCCESS", "Total " + c + " Lead Re-Assigned Successfully. !");
            return false;
        }

        function AssignToNote() {
            $("#ContentPlaceHolder1_ddlAssignNoteToUniversity").val('-Select University-');
            $("#ContentPlaceHolder1_ddlAssignNoteToCounsellors").val('-Select Counsellors-');
            if (document.getElementById('chkAssignToCounsellor').checked == true) {
                document.getElementById('ContentPlaceHolder1_ddlAssignNoteToCounsellors').style.display = 'block';
                document.getElementById('ContentPlaceHolder1_ddlAssignNoteToUniversity').style.display = 'none';
            }
            else if (document.getElementById('chkAssignToUniversity').checked == true) {
                document.getElementById('ContentPlaceHolder1_ddlAssignNoteToUniversity').style.display = 'block';
                document.getElementById('ContentPlaceHolder1_ddlAssignNoteToCounsellors').style.display = 'none';
            }
            else {
                document.getElementById('chkAssignToCounsellor').checked = false;
                document.getElementById('chkAssignToUniversity').checked = false;
                document.getElementById('chkAssignToNone').checked = true;
                document.getElementById('ContentPlaceHolder1_ddlAssignNoteToUniversity').style.display = 'none';
                document.getElementById('ContentPlaceHolder1_ddlAssignNoteToCounsellors').style.display = 'none';
            }
        }
    </script>
</asp:Content>


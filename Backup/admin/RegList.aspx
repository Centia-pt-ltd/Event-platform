<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegList.aspx.cs" Inherits="admin_RegList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Qstudy:RegistrationList</title>
     <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style type="text/css">
        .modal-dialog{
            max-width:55%!important
        }
        .table-bordered td, .table-bordered th{
            padding:7px!important;
        }
        a:active{background-color:orange}
        .btn_disabled {
            pointer-events: none;
            cursor: default;
        }
        .btn_enabled {
            pointer-events:all;
            cursor:pointer;
        }
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblmsg" runat="server"></asp:Label>
        <div>
<div>
            <h3>Registration List:  
            <asp:DropDownList ID="ddlRegion" runat="server" OnSelectedIndexChanged="ddlRegion_SelectedIndexChanged" style="font-size:16px" AutoPostBack="true"></asp:DropDownList>
                <asp:Button ID="btnLogOut" runat="server" Text="LogOut" OnClick="btnLogOut_Click" Style="float: right; margin-left: 10px; cursor: pointer; font-weight: bold; font-size: 16px;  margin: 11px 10px 0 0;" />
                <asp:Button ID="btnWelcome" runat="server" Text="" Style="float: right; margin-left: 10px; font-weight: bold; font-size: 16px;  margin: 11px 10px 0 0;" />
                <asp:Button ID="btnDownload" runat="server" Text="Download in Excel" Style="float: right; cursor: pointer; font-weight: bold; font-size: 16px;  margin: 11px 10px 0 0;" OnClick="btnDownload_Click" />
                <asp:Button ID="btnLoginList" runat="server" Text="Go To Login List" OnClick="btnLoginList_Click" Style="float: right; margin-right: 10px; cursor: pointer; font-weight: bold;font-size: 16px;  margin: 11px 10px 0 0;" />
<asp:Button ID="btnUniversityList" runat="server" Text="Go To University List" OnClick="btnUniversityList_Click" Style="float: right; margin-right: 10px; cursor: pointer; font-weight: bold;font-size: 16px;  margin: 11px 10px 0 0;" />
            
            <%-- <div class="chat_video_icon" style="position:fixed; top:50%; right:30px">
                <a href="https://dashboard.tawk.to/?lang=en#/dashboard" target="_blank" style="display:block;margin-right:5px;">
                    <img src="img/chat.png" height="30"/></a>
                 
                <a href="https://kmilab.zoom.us/j/9612749677?pwd=V0lHZGY0MW8zMkdORWJtUkMvWDVLZz09" target="_blank" style="display:block;">
                    <img src="img/VideoChat.png" height="30"/></a>
                 </div>
            --%>
            </h3>
    </div>
            <div style="float:right;margin-right:30px;">

                 <div class="chat_video_icon" >
                <a href="https://dashboard.tawk.to/?lang=en#/dashboard" target="_blank" style="margin-right:5px;">
                    <img src="img/chat.png" height="50"/></a>
                 
                <a href="https://kmilab.zoom.us/j/9612749677?pwd=V0lHZGY0MW8zMkdORWJtUkMvWDVLZz09" target="_blank" >
                    <img src="img/VideoChat.png" height="50"/></a>
                 </div>
            
            </div>
            <asp:GridView CssClass="table table-bordered" OnRowDataBound="grdList_RowDataBound" ID="grdList" AutoGenerateColumns="false" runat="server" GridLines="Both" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" AllowPaging="true" PageSize="10" OnPageIndexChanging="OnPageIndexChanging">


                <Columns>

                    <asp:TemplateField HeaderText="SNo.">
                        <ItemTemplate>
                            <%#Eval("SNo")%>
                            <asp:HiddenField ID="hdfRegId"  runat="server" Value='<%#Eval("Reg_Id")%>' />
                            <asp:HiddenField ID="hdfSocialPlateform"  runat="server" Value='<%#Eval("Messaging Platform")%>' />
                        </ItemTemplate>                        
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="View">
                        <ItemTemplate>
                  <button type="button" class="btn btn-primary" onclick="return ShowDetails(this.id);" data-toggle="modal" id="<%#Eval("Reg_Id")%>" data-target="#myModal">View</button>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Edit" Visible="false">
                        <ItemTemplate>
                        <button type="button" class="btn btn-success" onclick="return ShowEdit(this.id);" data-toggle="modal" id="<%#Eval("Reg_Id")%>" >Edit</button>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                        <asp:Button ID="btnDel" runat="server" Text="Delete" OnClientClick="return Delele();" CssClass="btn btn-danger" OnClick="btnDel_Click" />
                        </ItemTemplate>                        
                    </asp:TemplateField> 
                    <asp:TemplateField HeaderText="Active">                        
                        <ItemTemplate>
                            <asp:HiddenField ID="hdfActive"  runat="server" Value='<%#Eval("Active")%>' />                            
                           <asp:CheckBox ID="chkActive" OnCheckedChanged="chkActive_CheckedChanged" AutoPostBack="true" runat="server" />
                        </ItemTemplate>                        
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Registration No.">
                        <ItemTemplate>
                            <%#Eval("RegNo")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>                    
                    <asp:TemplateField HeaderText="Country">
                        <ItemTemplate>
                            <%#Eval("Country")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Full Name">
                        <ItemTemplate>
                            <%#Eval("Name")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="EMail">
                        <ItemTemplate>
                            <%#Eval("EMail")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Code">
                        <ItemTemplate>
                            <%#Eval("CountryCode")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone">
                        <ItemTemplate>
                            <%#Eval("Phone")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Highest Qualification">
                        <ItemTemplate>
                            <%#Eval("Highest Qualification")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Course">
                        <ItemTemplate>
                            <%#Eval("Course")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Social Link" HeaderStyle-Width="150px">
                        <ItemTemplate>
                            
                            <a href="https://api.whatsapp.com/send?phone=<%#Eval("WhatsApp")%>&amp;text=Hi" id="aWhatsApp" target="_blank">
                          <img src="img/WhatsApp.png" height="36" style="cursor:pointer" /></a>
                                <a href="https://imo.onelink.me/nbj0/df13cbc#" target="_blank">
                          <img src="img/imo.png" height="30" style="cursor:pointer" />
                                </a>
                             <a href="http://mail.qstudyabroad.com/Login.aspx" target="_blank">
                          <img src="img/mail.png" height="37" style="cursor:pointer" />
                                </a>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CreatedOn">
                        <ItemTemplate>
                            <%#Eval("CreatedOn")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    
                </Columns>


                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
            </asp:GridView>
        </div>


          <!-- The Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Registration Detail</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" id="mdlBody">
          
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>

        <div class="modal" id="myModal2">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modify Registration Detail</h4>
            <label id="lblReqMsg" style="font-weight:bold; color:red"></label>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
            <table>
                
                <tr>
                    <td>Registration No.</td><td><asp:TextBox ID="txtRegNo" disabled runat="server" CssClass="form-control"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Gender</td><td><select class="slect_item form-control" id="gn" runat="server">
                               <option>Select</option>
                               <option>Male</option>
                               <option>Female</option>
                           </select></td>
                </tr>
                <tr>
                    <td>Full Name</td><td><asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox></td>
                </tr>
                
                <tr style="display:none">
                    <td>Country Code</td><td><input name="phone" type="text" class="form-control mb-2 inptFielsd" id="phone"
               placeholder="Phone Number" style="display:none" /></td>
                </tr>
                <tr>
                    <td>Mobile Number</td><td><input runat="server" class="form-control m_num numeric" id="txtno" placeholder="000 000 000 000" maxlength="10"/>
                        
                                          </td>
                </tr>
                <tr>
                    <td>Select Platform You Use</td><td>

                                                <div class="multipleSelection">
            <div class="selectBox" 
                onclick="showPlateform()">
                <select class="form-control">
                    <option>Select Platform</option>
                </select>
                <div class="overSelect"></div>
            </div>
  
            <div id="checkPlateform">
                <%=_sbMsg %>
            </div>
        </div>
                                                    </td>
                </tr>
                <tr>
                    <td>Email Address</td><td><input type="text" runat="server" class="form-control" id="txtemail" placeholder="Enteryouremail@mail.com" /></td>
                </tr>
                <tr>
                    <td>Country</td><td><input type="text" runat="server" class="form-control" id="txtcountry" placeholder="country" /></td>
                </tr>
                 <tr>
                    <td>City</td><td><input type="text" runat="server" class="form-control" id="city" placeholder="city" /></td>
                </tr>
                 <tr>
                    <td>Current highest qualification</td><td> 
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
                <%=_sbHQ %>
            </div>
        </div>

                                                          </td>
                </tr>
                 <tr>
                    <td> what course are you looking for</td><td>
                                                <div class="multipleSelection">
            <div class="selectBox" 
                onclick="showCourse()">
                <select class="form-control">
                    <option>Select Course</option>
                </select>
                <div class="overSelect"></div>
            </div>
  
            <div id="checkCourse">
                <%=_sbCourse %>
            </div>
        </div>
                                                             </td>
                </tr>
                <tr>
                    <td> </td><td>  <input type="text" runat="server" class="form-control" id="txtOtherCourse" style="display:none" placeholder="Other course" />  </td>
                </tr>
                <tr>
                    <td> IELTS/TOEFL</td><td>  

                         <input type="radio" name="status" checked="checked" id="RdbIeltsYes" onclick="CheckIelts();" value="Yes" class="radio_registration"/>
                                            Yes
                                            <input type="radio" id="RdbIeltsNo" onclick="CheckIelts();" name="status" value="No" class="radio_registration"/>
                                            No  
                        <input type="text" class="form-control" id="txtscore" runat="server" placeholder="Enter your score here" name="" />
                                         </td>
                </tr>
                <tr>
                    <td>Are you planning to study abroad? </td><td>  
                        <input type="radio" name="Abroad" id="RdbAbYes" checked="checked" value="Yes" class="radio_registration"/>
                                            Yes
                                            <input type="radio" id="RdbAbNo" name="Abroad" value="No" class="radio_registration"/>
                                            No   


                                                               </td>
                </tr>
                 <tr>
                    <td>What fee range are you looking at? </td><td>  
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
            <asp:Button ID="btnUpdate" OnClick="btnUpdate_Click" runat="server" CssClass="btn btn-success" Text="Update" OnClientClick="return ValidateUpdate();" />
            
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
        <script type="text/javascript">

            function CheckIelts() {
                if (document.getElementById('RdbIeltsYes').checked == true) {
                    document.getElementById("txtscore").style.display = 'block';
                }
                if (document.getElementById('RdbIeltsNo').checked == true) {
                    document.getElementById("txtscore").style.display = 'none';
                }
            }

            function Delele() {
                var rr = confirm("Are you sure to delete ??");
                if (rr == true) {

                }
                else {
                    return false;
                }
            }

            function ShowDetails(id) {
                $("#mdlBody").html('');
                $.ajax({
                    type: "POST",
                    url: "RegList.aspx/GetDetails",
                    data: "{'id':'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var sts = response.d;
                        $("#mdlBody").html(response.d);
                    },
                    failure: function (xhr, errorType, exception) {
                        alert(jQuery.parseJSON(xhr.responseText));
                        $("#mdlBody").html('');
                    },
                    error: function (response) {
                        $("#mdlBody").html('');
                    }
                });
            }

            function ValidateUpdate() {

                if ($("#gn").val() == 'Select') {
                    $("#lblReqMsg").html('Please Select Gender.');
                    $("#Select").focus();
                    return false;
                }

                if ($("#txtFullName").val().trim() == '') {
                    $("#lblReqMsg").html('Please enter Full Name.');
                    $("#txtFullName").focus();
                    return false;
                }

                if ($("#txtno").val().trim() == '') {
                    $("#lblReqMsg").html('Please enter Mobile No.');
                    $("#txtno").focus();
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
                    $("#lblReqMsg").html('Please enter Platform You Use');
                    return false;
                }
                document.getElementById('hdfMsgPlateUpdate').value = Msg;
                document.getElementById('hdfMsgPlateUpdateText').value = MsgText;

                if ($("#txtemail").val().trim() == '') {
                    $("#lblReqMsg").html('Please enter E-Mail');
                    $("#txtemail").focus();
                    return false;
                }

                if ($("#txtcountry").val().trim() == '') {
                    $("#lblReqMsg").html('Please enter Country');
                    $("#txtcountry").focus();
                    return false;
                }

                if ($("#city").val().trim() == '') {
                    $("#lblReqMsg").html('Please enter City');
                    $("#city").focus();
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
                    $("#lblReqMsg").html('Please enter Current highest qualification');
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
                    $("#lblReqMsg").html('Please enter what course are you looking for ?');
                    return false;
                }
                document.getElementById('hdfCrUpdate').value = Cr;
                document.getElementById('hdfCrUpdateText').value = CrText;

                if (document.getElementById('RdbIeltsYes').checked == true && document.getElementById('txtscore').value == '') {
                    $("#lblReqMsg").html('Please enter Score');
                    $("#txtscore").focus();
                    return false;
                }
                if ($("#ddlFee").val() == '0') {
                    $("#lblReqMsg").html('What fee range are you looking at.');
                    $("#ddlFee").focus();
                    return false;
                }
            }

            function ShowEdit(RegId) {

                $.ajax({
                    type: "POST",
                    url: "RegList.aspx/GetEditData",
                    data: "{'RegId':'" + RegId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#hdfEditRegId").val(response.d[0].Reg_Id);
                        $("#txtRegNo").val(response.d[0].RegistrationNo);
                        $("#txtFullName").val(response.d[0].Name);
                        $("#gn").val(response.d[0].Gender);
                        $("#phone").val(response.d[0].Country_Code);
                        $("#txtno").val(response.d[0].phone_no);

                        //checkPlateform

                        var mapPlateform = response.d[0].msg;
                        var msgArray = mapPlateform.split(',');
                        var len = msgArray.length;
                        var msgId = '';
                        var tmpid = '';
                        for (var m = 0; m < len; m++) {
                            msgId = msgArray[m];
                            if (msgId != '') {
                                tmpid = "m" + msgId;
                                document.getElementById(tmpid).checked = true;
                            }
                        }

                        // end
                        $("#txtemail").val(response.d[0].emailid);
                        $("#txtcountry").val(response.d[0].Country);
                        $("#city").val(response.d[0].City);

                        //checkHq
                        var mapHq = response.d[0].hq;
                        var mapHqArray = mapHq.split(',');
                        var len = mapHqArray.length;
                        var mapHqId = '';

                        for (var m = 0; m < len; m++) {
                            mapHqId = mapHqArray[m];
                            document.getElementById("q" + mapHqId).checked = true;
                        }

                        // end


                        //checkCourse

                        var mapCourse = response.d[0].course;
                        var mapCourseArray = mapCourse.split(',');
                        var len = mapCourseArray.length;
                        var mapCourseId = '';

                        for (var m = 0; m < len; m++) {
                            mapCourseId = mapCourseArray[m];
                            document.getElementById("c" + mapCourseId).checked = true;
                        }

                        // end

                        var ielts = '';
                        ielts = response.d[0].TOEFLScore;
                        if (ielts == '') {
                            document.getElementById('RdbIeltsNo').checked = true;
                            document.getElementById('txtscore').style.display = 'none';
                            document.getElementById('RdbIeltsYes').checked = false;
                            document.getElementById('txtscore').value = '';
                        }
                        else {
                            document.getElementById('RdbIeltsNo').checked = false;
                            document.getElementById('txtscore').style.display = 'block';
                            document.getElementById('RdbIeltsYes').checked = true;
                            document.getElementById('txtscore').value = ielts;
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
                        $("#ddlFee").val(response.d[0].FeeRange == '' ? 0 : response.d[0].FeeRange);
                        var Active = response.d[0].Active;
                        if (Active == 'Yes')
                            document.getElementById('chkActive').checked = true;
                        else
                            document.getElementById('chkActive').checked = false;


                        $("#myModal2").modal("show");
                    },
                    failure: function (xhr, errorType, exception) {
                        alert('something went wrong');

                    },
                    error: function (response) {
                        alert('something went wrong !');
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
        </script>

         <asp:HiddenField ID="hdfMsgPlateUpdate" runat="server" />
         <asp:HiddenField ID="hdfHqUpdate" runat="server" />
         <asp:HiddenField ID="hdfCrUpdate" runat="server" />

        <asp:HiddenField ID="hdfMsgPlateUpdateText" runat="server" />
         <asp:HiddenField ID="hdfHqUpdateText" runat="server" />
         <asp:HiddenField ID="hdfCrUpdateText" runat="server" />

    </form>
</body>
</html>

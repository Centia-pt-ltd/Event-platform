<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmVideoCall.aspx.cs" Inherits="university_frmVideoCall" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>QStudy</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- Libraries CSS -->
 <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="css/style.css" type="text/css" rel="stylesheet" />
<link href="css/all.css" type="text/css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Pragati+Narrow:wght@400;700&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

   <style>
            .MyTable {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
  max-height:400px;
  overflow:scroll;
  
  overflow-x:scroll;
}

.MyTable td, .MyTable th {
  border: 1px solid #ddd;
  padding: 4px;
  font-size: 12px;
}

.MyTable tr:nth-child(even){background-color: #f2f2f2;}

.MyTable tr:hover {background-color: #ddd;}

.MyTable th {
    padding: 3px 5px;
    text-align: center;
    color: white;
    font-size: 11px;
    background-color: #757575;
    position: sticky;
  top: 0px;
}
.MyTable tr td a{
    font-size: 11px;
    margin: 0 0 0 5px;
}
  </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="alert alertboxes alert-success d-none" id="divSuccess" role="alert"></div>
        <div class="alert alertboxes alert-danger d-none"  id="divError" role="alert"></div>
            <div class="container-fluid" onclick="ClearMsg();">
        <div class="row">
<header class="main-header dark">
    <div class="logo">
        <img src="img/trans_branding.png" alt="logo" />
    </div>
    <div class="nav">
        <div class="nav-right">
            <ul class="navright_menu">
                <li class="login_icon"><a href="javascript:void();" onclick="return SessionLogout();">LogOut<i class="fa fa-sign-out"></i></a></li>
                <div style="display:none"><asp:Button ID="btnLogOut" runat="server" OnClick="btnLogOut_Click" /></div>
                <script type="text/javascript">
                    function SessionLogout() {
                        var btn = document.getElementById("btnLogOut");
                        btn.click();
                    }
                </script>
            </ul>
        </div>
    </div>
</header>
</div>   
</div>
 <asp:HiddenField ID="hdfUid" runat="server" />
	 <asp:HiddenField ID="hdfUserId" runat="server" />
        <div style="text-align:center;" class="page_wrapper">
           
 

             <div style="width:75%;height: calc(100vh - 150px);float:left;margin-left:2%;margin-right:2%;">
        <iframe allow="camera; microphone; fullscreen; speaker; display-capture"
         id="ifrmmodify" style="height:100%;width:100%">
        </iframe>
    </div>
            <div class="tabel_wrapper" style="float:right;">
               
 
                
       <div>
                <div><table class="MyTable">     
                     <thead>
                        <tr> <th style="background-color:green !important;color:white;">
                        Online Students
                        </th></tr>
                   <tr> <th style="text-align:left">
                        <div class="select_box">
                        <select class="slect_item" id='ddlRoom' style="width:100%;"> 
                           <option value="0">--Select Room--</option>
                        </select>  <%--class='university'--%>
                       </div>
                         </th></tr>
                     </thead></table></div>
                    
    <div  style="overflow-y:scroll;max-height:calc(100vh - 300px);">
     <table id="MyTable" class="MyTable">
                    <thead><tr>
                    <th>Select</th>
                    <th>Name(Reg.No)</th>
                  </tr> </thead>
                    
                    <tbody id="gridUniversity">

                    </tbody>

                    
                    
                </table>
                </div>
                <div>
                    <table class="MyTable">
                        <tr>
                    <td colspan="4">
                    <a href='javascript:void();' onclick='return MoveToUniversityUser();' class='btn-Success' style='background-color:Green!important'>Move Student</a>
                        </td></tr></table>
                </div>
                
   
             
    <br />

   

    <script type="text/javascript">

        function BindGrid() {
            $.ajax({
                type: "POST",
                url: "frmVideoCall.aspx/BindStudentList",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var len = data.d.length;
                    $("#gridUniversity").empty();
                    var item = '';
                    if (len > 0) {
                       
                        var id = '';
                        var redirect = '';
                        var chk = '';
                        for (var k = 0; k < len; k++) {
                            id = data.d[k].SNo;
                            chk = "chk" + id;
                            item += "<tr id=trId" + data.d[k].SNo + ">";
                            item += "<td><input type='hidden' id='hdId" + data.d[k].SNo + "' value='" + data.d[k].StudentId + "'><input value='0' id=" + chk + " type='checkbox'  style='background-color:Green!important' />";
                            item += "<td>" + data.d[k].Name + "(" + data.d[k].RegNo + ")</td>";
                            item += "</tr>";
                        }
                        $("#gridUniversity").append(item);
                    }
                    else {
                       
                    }
                },
                error: function (response) {
                    showMsg("ERROR", "Something went wrong.!");
                    return false;
                }
                
            });
        }
        $(document).ready(function () {
            BindRoom();
            BindGrid();
            
        });
        

        function RefreshGrid() {
            BindGrid();
          
            //BindUniversity();
        }

        
        function BindRoom() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmVideoCall.aspx/BindRoom",
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

        //function MoveStudent(Sid,id) {

        function MoveToUniversityUser() {

            var UserId = $("#hdfUserId").val();
            var RoomId = $("#ddlRoom").val();
            var tbody = document.getElementById('gridUniversity');
            var rows = tbody.rows.length;
           
            if (RoomId == '0') {
                showMsg("ERROR", "Please Select Room. !");
                $("#ddlRoom").focus();
                return false;
            }
            else if (rows==0)
            {
                showMsg("ERROR", "Please Select Student. !");
                $("#gridUniversity").focus();
                return false;
            }
            else {

                var EventModel = new Array();
                var counter = 0;
                for (var r = 1; r <= rows; r++) {
                    var service = {};
                    document.getElementById('trId' + r).style.backgroundColor = '';
                    if (document.getElementById('chk' + r).checked == true) {
                        service.UserId = UserId;
                        service.Sid = $("#hdId" + r).val();
                        EventModel.push(service);
                        counter = Number(counter) + Number(1);
                    }
                }
                $.ajax({
                    type: "POST",
                    url: "frmVideoCall.aspx/MoveToUniversityUser",
                    data: "{'_Events':" + JSON.stringify(EventModel) + ",'RoomId':'" + RoomId+"'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == "S") {
                            showMsg("SUCCESS", "User has been Moved successfully.!");
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
            }
            return false;
        }
       
        setInterval(function () {
            BindGrid();
        }, 30000);


        function SetIFrameSource() {
            $("#ifrmmodify").attr("src", "<%=strVideoAPI%>");
        }
        $(function () { SetIFrameSource(); });

    </script>
    
    

            <%--</div>--%>
                </div> </div>
        </div>
    

    <script src="js/jquery.min.js"></script>
  <script src="js/owl.carousel.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/function.js"></script>


                <script src="../js/comman.js"></script>
        <script type="text/javascript">
            function ClearMsg() {
                $("#divSuccess").html('');
                $("#divError").html('');

                if ($("#divSuccess").hasClass("d-none")) {

                }
                else {
                    $("#divSuccess").addClass('d-none');
                }
                if ($("#divError").hasClass("d-none")) {

                }
                else {
                    $("#divError").addClass('d-none');
                }
            }
        </script>

    </form>
</body>
</html>



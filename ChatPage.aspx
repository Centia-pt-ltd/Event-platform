<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChatPage.aspx.cs" Inherits="ChatPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <title>QStudy</title>

     <link rel="stylesheet" href="WebCSS/bootstrap.min.css" />
  <script src="WebJS/Ajax_jquery.min.js"></script>
    <script src="WebJS/bootstrap.min.js"></script>
    <link href="css_latest/style.css" type="text/css" rel="stylesheet" />


<%--    <script src="WebJS/jquery-3.6.0.js"></script>--%>
      <script src="WebJS/Ajax_jquery.min.js"></script>
    <script src="WebJS/bootstrap.min.js"></script>
    <link rel="stylesheet" href="WebCSS/bootstrap.min.css" />
    <link href="css_latest/chatforall.css" rel="stylesheet" />    
    <link href="css_latest/style.css" type="text/css" rel="stylesheet" />
    <link href="WebCSS/font-awesome.min.css" rel="stylesheet" type="text/css" />
  <style>
       
    
        .modalTable{
            background-color:white;
            font-size:15px;
           /*  border: 0px none #fff !important;*/
            width:100% !important;
        }
        .modalTable td,th {
              /*  background-color: #b4e3ea4a;*/
            font-size: 15px;
            border: .1px solid #345860 !important;
            padding: 5px !important;
            width:50% !important;
        }
        .modalTable tr {
           
             border: 0px none #fff !important;
        }
      .btn {
          display: inline;
          margin-left: 10px;
      }
      .chkChatAll{
              width: 20px !important;
    height: 19px !important;
    margin-top: 10px;

      }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdfUserId" runat="server" />
        <asp:HiddenField ID="hdfSenderId" runat="server" />
       <asp:HiddenField ID="hdfUniId" runat="server" />
         <asp:HiddenField ID="hdfSenderType" runat="server" />
         <asp:HiddenField ID="hdfSenderName" runat="server" />
         <asp:HiddenField ID="CurrentReceiverId" runat="server" />
         <asp:HiddenField ID="CurrentReceiverName" runat="server" />


     <div class="container">
         <div class="row">
             <div class="col-md-10 mx-auto mt-5">
                   <div class="box1">
                 <div class="row" style="height:100%;">
                     <div class="col-md-8 pr-lg-0">
                       
                     <header class="chat-header header-bot1">
                         <div class="chat-logo">
                            <h5><label id="lblUserName"></label></h5>
                         </div>
                        
                     </header>
                     <div class="chat-body">
                        <ul class="list-group" id="uiQstudyAdmin">
                             <%-- <li class="bot-chat">
                                 <div class="chat-img mr-2">
                                   <img src="img/chatbot.png" />
                                 </div>
                                 <div class="bot-content">
                                     <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
                                 </div>
                             </li>
                              <li class="user-chat">
                                 <div class="user-content">
                                     <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
                                 </div>
                                 <div class="chat-img ml-2">
                                     <img src="img/chatbot.png" />
                                 </div>
                                
                             </li>--%>
                         </ul>

                         <div class="box-footer ml-lg-3">
                             <form>
                                 <div class="input-group">
                                  <input type="text" class="form-control" id="txtMessage" placeholder="Message..." />
                                   
                                  <div class="input-group-append">
                                    <button class="btn btn-primary mr-lg-3" type="button" onclick="return sendMessage();"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
                                  </div>
                                </div>

                                  <input type="checkbox" id="chkAll"  class="chkChatAll" value="All" name="Send To All" />                                 
                                    <label for="SendMsg"> Select here to send message to all assigned students</label>
                           </form>

                         </div> 
                          
                     </div>
                 </div>
                    
                     <div class="col-md-4 pl-lg-0">
                         <div class="chat-header text-center">
                         <div class="chat-logo header-bot2">
                            <h5>Online Students</h5> <a id="aRefresh" href="#" onclick="SelectOnlineStudentList()">Refresh List</a>
                             </div>  
                             <div class="body-bot" style="overflow-y:scroll">
                             <ul id="StudentList" class="list-group">
                              
                             </ul>
                           </div>                 
                     </div>
                        
                     </div>
                 </div>
                 </div>
                 

             </div>
         </div>
         <!--- View Modal -->
           <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">

       <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Student Detail</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError3" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
<table id="tblDetails" class="modalTable">   
    
</table>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->
     </div>
        <script>
            $(document).ready(function () {
                var userName = $("#hdfSenderName").val();
                $("#lblUserName").html(userName);

                $(".std_name a").click(function () {
                    $(".std_name a").removeClass("bg-online");
                    $(this).addClass("bg-online");

                })

            });
        </script>
        <script>
            function SectedStudent(id,name) {
                $("#CurrentReceiverId").val(id);
                $("#CurrentReceiverName").val(name);
                $("#StudentList li").removeClass("std_active");
                $(".std_name a").removeClass("bg-online");
                
                $("#" + id).addClass("bg-online");
                $("#li" + id).addClass("std_active");

                var UserType = $("#hdfSenderType").val();
                if (UserType == "QSTUDY") {
                    showChatHistory();
                }
                else {
                    showUniChatHistory();
                }
                
            }
            function SelectOnlineStudentList() {
                var SenderId = $("#hdfSenderId").val();
                var UserType = $("#hdfSenderType").val();
                $("#uiQstudyAdmin").empty();
                $("#CurrentReceiverId").val("0");

                $.ajax({
                    type: "POST",
                    url: "ChatPage.aspx/SelectOnlineStudentList",
                    data: "{'SenderId':'" + SenderId + "','UserType':'" + UserType + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#StudentList").empty();
                        var len = response.d.length;
                        var name = '';
                        var id = '';
                        var item = '';
                        var loginstatus = '';
                        if (len > 0) {
                            for (var k = 0; k < len; k++) {
                                id = response.d[k].Reg_Id;
                                name = response.d[k].Name;
                                loginstatus = response.d[k].LoginStatus;
                                if (loginstatus == 'Login') {
                                    item += " <li class='std_name' id='li" + id + "'><a class='bg' href='javascript:void ();' onclick='return SectedStudent(" + id + ",\"" + name + "\");' id='" + id + "'>" + response.d[k].StudentName + "</a><a class='btn btn-info' href='javascript:void ();' onclick='return ViewStudent(" + id + ");' id='view" + id + "'>View</a> </li>";
                                }
                                else {
                                    item += " <li class='std_name std-offline' id='li" + id + "'><a class='bg' href='javascript:void ();' onclick='return SectedStudent(" + id + ",\"" + name + "\");' id='" + id + "'>" + response.d[k].StudentName + "</a><a class='btn btn-info' href='javascript:void ();' onclick='return ViewStudent(" + id + ");' id='view" + id + "'>View</a> </li>";
                                }
                            }
                            $("#StudentList").append(item);
                        }

                    },
                    error: function (response) {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                });

                return false;
            }
              

            function SelectOnlineStudentRefreshList() {
                var SenderId = $("#hdfSenderId").val();
                var UserType = $("#hdfSenderType").val();
                $(".std_name").removeClass("bg-offline");
                $.ajax({
                    type: "POST",
                    url: "ChatPage.aspx/SelectOnlineStudentList",
                    data: "{'SenderId':'" + SenderId + "','UserType':'" + UserType + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                       /* $("#StudentList").empty();*/
                        var len = response.d.length;
                        var name = '';
                        var id = '';
                        var item = '';
                        var action = 'Yes';
                        var action1 = 'Yes';
                        var loginstatus = '';
                        if (len > 0) {
                            for (var k = 0; k < len; k++) {
                                id = response.d[k].Reg_Id;
                                name = response.d[k].Name;
                                loginstatus = response.d[k].LoginStatus;
                                action = 'Yes';

                                $("#StudentList").find('li a').each(function () {
                                    var current = $(this).attr("id");
                                    if (current == id) {
                                        action = 'No';
                                        if (loginstatus == 'Logout') {
                                            $("#li" + id).addClass("std-offline");
                                        }
                                        else {

                                            $("#li" + id).removeClass("std-offline");
                                        }
                                    }
                                });
                                if (action == 'Yes') {
                                    if (loginstatus == 'Login') {
                                        item += " <li class='std_name' id='li" + id + "'><a class='bg' href='javascript:void ();' onclick='return SectedStudent(" + id + ",\"" + name + "\");' id='" + id + "'>" + response.d[k].StudentName + "</a><a class='btn btn-info' href='javascript:void ();' onclick='return ViewStudent(" + id + ");' id='view" + id + "'>View</a> </li>";
                                    }
                                    else {
                                        item += " <li class='std_name std-offline' id='li" + id + "'><a class='bg' href='javascript:void ();' onclick='return SectedStudent(" + id + ",\"" + name + "\");' id='" + id + "'>" + response.d[k].StudentName + "</a><a class='btn btn-info' href='javascript:void ();' onclick='return ViewStudent(" + id + ");' id='view" + id + "'>View</a> </li>";
                                    }
                                }
                            }
                            $("#StudentList").append(item);



                        }
                           

                    },
                    error: function (response) {
                        showMsg("ERROR", "Something went wrong.!");
                    }
                });

                return false;
            }

            document.getElementById('txtMessage').onkeydown = function (event) {
                if (event.keyCode == 13) {
                    sendMessage();
                    return false;
                }
            }

            function sendMessage() {

                var Msg = $("#txtMessage").val();
                var SenderId = $("#hdfSenderId").val();
                var SenderName = $("#hdfSenderName").val();
                var ReceiverId = $("#CurrentReceiverId").val();
                var ReceiverName = $("#CurrentReceiverName").val();
                var UserType = $("#hdfSenderType").val();
                var sendToAll = 'No';
                if (document.getElementById("chkAll").checked == true)
                    {
                    sendToAll='Yes'
                }
                var SenderType = '';
                if (UserType == "QSTUDY") {
                    SenderType = 'QSTUDY';
                }
                else {
                    SenderType = 'UNIVERSITY';
                }

                if (Msg != '') {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/SendMessageByAdmin",
                        data: "{'SenderId':'" + SenderId + "','SenderName':'" + SenderName + "', 'Msg':'" + Msg + "', 'SenderType':'" + SenderType + "','ReceiverId':'" + ReceiverId + "','ReceiverName':'" + ReceiverName + "','sendToAll':'" + sendToAll + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d == "S") {
                                $("#txtMessage").val('');
                                $("#txtMessage").focus();
                                document.getElementById("chkAll").checked = false;
                                showLatestQstudyHistory();
                            }
                        },
                        error: function (response) {
                            $("#txtMessage").val('Something went wrong. !');
                            document.getElementById("chkAll").checked = false;
                        }
                    });
                }
                else {
                    $("#txtMessage").css('border-color', 'red');
                    document.getElementById("chkAll").checked = false;
                    $("#txtMessage").focus();
                }
                return false;
            }

            function showChatHistory() {
                var SenderId = $("#hdfSenderId").val();
                var ReceiverId = $("#CurrentReceiverId").val();
                $("#uiQstudyAdmin").empty();
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetAllQstudyChatHistory",
                    data: "{'ReceiverId':'" + ReceiverId + "','SenderId':'" + SenderId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#uiQstudyAdmin").append(response.d);
                    },
                    error: function (response) {
                        $("#uiQstudyAdmin").append('error');
                    }
                });
            }

            function showLatestQstudyHistory() {

                var SenderId = $("#hdfSenderId").val();
                var ReceiverId = $("#CurrentReceiverId").val();

                const ul = document.querySelectorAll('ul li p');
                var LastMsg = '';
                if (ul.length > 0) {
                    LastMsg = ul[ul.length - 1].innerHTML;
                }
                else {
                    LastMsg = "";
                }
                var Result = "";
                if (ReceiverId != "0") {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/GetLatestQstudyChatHistory",
                        data: "{'ReceiverId':'" + ReceiverId + "','SenderId':'" + SenderId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var len = response.d.length;
                            var SenderType = '', Message = '';
                            if (len > 0) {
                                for (var k = 0; k < len; k++) {
                                    SenderType = response.d[k].SenderType;
                                    Message = response.d[k].Message;

                                    if (SenderType == "STUDENT" && LastMsg != Message) {
                                        Result += "<li class='user-chat'><div class='user-content'>";
                                        Result += "<p>" + Message + "</p></div>";
                                        Result += "<div class='chat-img ml-2'>";
                                        Result += "<img src='img/User_chat.png' />";
                                        Result += "</div>";
                                        Result += "</li>";
                                    }
                                    else if (SenderType == "QSTUDY" && LastMsg != Message) {
                                        Result += "<li class='bot-chat'><div class='chat-img mr-2'>";
                                        Result += "<img src='img/chatbot.png'/></div>";
                                        Result += "<div class='bot-content'><p>" + Message + "</p></div>";
                                        Result += "</li>";
                                    }

                                    $("#uiQstudyAdmin").append(Result);
                                }
                            }
                        },
                        error: function (response) {
                            $("#uiQstudyAdmin").append('error');
                        }
                    });
                }
            }

            function showUniChatHistory() {
                var SenderId = $("#hdfSenderId").val();
                var ReceiverId = $("#CurrentReceiverId").val();
                $("#uiQstudyAdmin").empty();
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetAllUniChatHistory",
                    data: "{'ReceiverId':'" + ReceiverId + "','SenderId':'" + SenderId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#uiQstudyAdmin").append(response.d);
                    },
                    error: function (response) {
                        $("#uiQstudyAdmin").append('error');
                    }
                });
            }

            function showLatestUniHistory() {

                var SenderId = $("#hdfSenderId").val();
                var ReceiverId = $("#CurrentReceiverId").val();

                const ul = document.querySelectorAll('ul li p');
                var LastMsg = '';
                if (ul.length > 0) {
                    LastMsg = ul[ul.length - 1].innerHTML;
                }
                else {
                    LastMsg = "";
                }
                var Result = "";
                if (ReceiverId != "0") {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/GetLatestUniChatHistory",
                        data: "{'ReceiverId':'" + ReceiverId + "','SenderId':'" + SenderId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var len = response.d.length;
                            var SenderType = '', Message = '';
                            if (len > 0) {
                                for (var k = 0; k < len; k++) {
                                    SenderType = response.d[k].SenderType;
                                    Message = response.d[k].Message;

                                    if (SenderType == "STUDENT" && LastMsg != Message) {
                                        Result += "<li class='user-chat'><div class='user-content'>";
                                        Result += "<p>" + Message + "</p></div>";
                                        Result += "<div class='chat-img ml-2'>";
                                        Result += "<img src='img/User_chat.png' />";
                                        Result += "</div>";
                                        Result += "</li>";
                                    }
                                    else if (SenderType == "UNIVERSITY" && LastMsg != Message) {
                                        Result += "<li class='bot-chat'><div class='chat-img mr-2'>";
                                        Result += "<img src='img/chatbot.png'/></div>";
                                        Result += "<div class='bot-content'><p>" + Message + "</p></div>";
                                        Result += "</li>";
                                    }

                                    $("#uiQstudyAdmin").append(Result);
                                }
                            }
                        },
                        error: function (response) {
                            $("#uiQstudyAdmin").append('error');
                        }
                    });
                }
            }

            function RefreshChatData() {
                var UserType = $("#hdfSenderType").val();
                if (UserType == "QSTUDY") {
                    setInterval(function () { showLatestQstudyHistory() }, 2000);
                }
                else
                {
                    setInterval(function () { showLatestUniHistory() }, 2000);
                }
            }
            window.onload = function () {
                SelectOnlineStudentList();
                RefreshChatData();
            }
            setInterval(function () { SelectOnlineStudentRefreshList() }, 5000);

            function ViewStudent(id) {

                $("#tblDetails").html('');
                $.ajax({
                    type: "POST",
                    url: "ChatPage.aspx/GetDetails",
                    data: "{'id':'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var sts = response.d;
                        $("#tblDetails").html(response.d);
                        $("#myModal").modal("show");
                    },
                    failure: function (xhr, errorType, exception) {
                        $("#tblDetails").html('');
                    },
                    error: function (response) {
                        $("#tblDetails").html('');
                    }
                });
            }

        </script>
    </form>
</body>
</html>

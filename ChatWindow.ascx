<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChatWindow.ascx.cs" Inherits="UserControl_ChatWindow" %>
<!---- Chat Code Start ---->
 <link href="../css_latest/chatcss.css" type="text/css" rel="stylesheet" />
<div class="col-md-12">
    <input type="hidden" id="hdfReceiverId" runat="server" />
    <input type="hidden" id="hdfReceiverName" runat="server" />
    <input type="hidden" id="hdfSenderId" runat="server" />
    <input type="hidden" id="hdfSenderName" runat="server" />
    <input type="hidden" id="hfRegNo" runat="server" />
    <input type="hidden" id="hdfSenderType" runat="server" />

                 <div class="chat-button">
                     <a href="javascript:void();" class="button-chat">
                    <%--   <i class="fa fa-comments-o" aria-hidden="true"></i>--%><img src="../img/chat.png" />
                     </a>
                 </div>

                 <div class="box">
                     <header class="chat-header justify-content-between">
                         <div class="chat-logo">
                             <img src="../img/chat.png" />
                         </div>
                         <div class="chat-close">
                             <a href="javascript:void();" id="close-box" ><i class="fa fa-times" aria-hidden="true"></i>  </a>
                         </div>
                     </header>
                     <div class="chat-body">
                         <ul class="list-group" id="ulChat">
                             <li class="user-chat">
                                 <div class="user-content">
                                     <p></p>
                                 </div>
                                 <div class="chat-img ml-2">
                                     <img src="img/User_chat.png">
                                 </div></li>

                             <!--<li class="bot-chat">
                                 <div class="chat-img mr-2">
                                   <img src="img/chatbot.png" />
                                 </div>
                                 <div class="bot-content">
                                     <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
                                 </div>
                             </li>
                              <li class="user-chat">
                                 <div class="user-content">
                                     <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
                                 </div>
                                 <div class="chat-img ml-2">
                                     <img src="img/chatbot.png" />
                                 </div>
                             </li>
                              <li class="bot-chat">
                                 <div class="chat-img mr-2">
                                   <img src="img/chatbot.png" />
                                 </div>
                                 <div class="bot-content">
                                     <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
                                 </div>
                             </li>
                              <li class="user-chat">
                                 <div class="user-content">
                                     <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
                                 </div>
                                 <div class="chat-img ml-2">
                                     <img src="img/chatbot.png" />
                                 </div>
                             </li>-->
                         </ul>

                         <div class="box-footer">
                                 <div class="input-group">
                                  <input type="text" id="txtMessage" class="form-control" placeholder="Message..." />
                                  <div class="input-group-append">
                                    <a class="btn btn-primary" href="javascript:void();" onclick="return sendMessage();"><i class="fa fa-paper-plane" aria-hidden="true"></i></a>
                                      <div style="display:none"><asp:Button ID="btnSendMessage" runat="server" OnClick="btnSendMessage_Click" /></div>
                                  </div>
                                </div>
                         </div> 
                     </div>
                 </div>

             </div>

<!---- Chat Code END ---->

<!---- Chat script Start ---->

<script type="text/javascript">
    function sendMessage() {
        //  var btn = document.getElementById("chat_btnSendMessage");
        //  btn.click();
        //  $(".box").toggle();
        var Msg = $("#txtMessage").val();
        var ReceiverId = $("#chat_hdfReceiverId").val();
        var ReceiverName = $("#chat_hdfReceiverName").val();
        var SenderId = $("#chat_hdfSenderId").val();
        var SenderName = $("#chat_hdfSenderName").val();
        var SenderType = 'Student';

        if (Msg != '') {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SendMessage",
                data: "{'ReceiverId':'" + ReceiverId + "','ReceiverName':'" + ReceiverName + "', 'Msg':'" + Msg + "', 'SenderType':'" + SenderType + "','SenderId':'" + SenderId + "','SenderName':'" + SenderName + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "S") {
                        $("#txtMessage").val('');
                        $("#txtMessage").focus();
                        showLatestHistory();
                    }
                },
                error: function (response) {
                    $("#txtMessage").val('Something went wrong. !');
                }
            });
        }
        else {
            $("#txtMessage").css('border-color', 'red');
            $("#txtMessage").focus();
        }
        return false;
    }

    document.getElementById('txtMessage').onkeydown = function (event) {
        if (event.keyCode == 13) {
            sendMessage();
            return false;
        }
    }

    function showChatHistory() {
        var ReceiverId = $("#chat_hdfReceiverId").val();
        var UserType = $("#chat_hdfSenderType").val();
        var SenderId = $("#chat_hdfSenderId").val();
        $("#ulChat").empty();
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetAllChatHistory",
            data: "{'ReceiverId':'" + ReceiverId + "','UserType':'" + UserType + "','SenderId':'" + SenderId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $("#ulChat").append(response.d);
            },
            error: function (response) {
                $("#ulChat").append('error');
            }
        });
    }

    function showLatestHistory() {

        var ReceiverId = $("#chat_hdfReceiverId").val();
        var SenderId = $("#chat_hdfSenderId").val();
        const ul = document.querySelectorAll('ul li p');
        var LastMsg = '';
        if (ul.length > 0) {
            LastMsg = ul[ul.length - 1].innerHTML;
        }
        else {
            LastMsg = "";
        }
        var UserType=$("#chat_hdfSenderType").val();
        var Result = "";
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetLatestChatHistory",
            data: "{'ReceiverId':'" + ReceiverId + "','UserType':'" + UserType + "','SenderId':'" + SenderId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var len = response.d.length;
                var SenderType = '', Message = '';
                if (len > 0) {
                    for (var k = 0; k < len; k++) {
                        SenderType = response.d[k].SenderType;
                        Message = response.d[k].Message;

                        if (SenderType == "STUDENT" && LastMsg!=Message) {
                            Result += "<li class='user-chat'><div class='user-content'>";
                            Result += "<p>" + Message + "</p></div>";
                            Result += "<div class='chat-img ml-2'>";
                            Result += "<img src='img/User_chat.png' />";
                            Result += "</div>";
                            Result += "</li>";
                        }
                        else if (SenderType == UserType && LastMsg != Message) {
                            Result += "<li class='bot-chat'><div class='chat-img mr-2'>";
                            Result += "<img src='img/chatbot.png'/></div>";
                            Result += "<div class='bot-content'><p>" + Message + "</p></div>";
                            Result += "</li>";
                        }

                        $("#ulChat").append(Result);
                    }
                }
            },
            error: function (response) {
                $("#ulChat").append('error');
            }
        });
    }

    /*document.getElementById("chat_txtMessage")
        .addEventListener("keyup", function (event) {
            event.preventDefault();
            if (event.keyCode === 13) {
                document.getElementById("chat_btnSendMessage").click();
            }
            return false;
        });*/
    function RefreshChatData() {
        setInterval(function () { showLatestHistory() }, 2000);
    }
    window.onload = RefreshChatData();
</script>

 <script>
     $(document).ready(function () {
         $(".chat-button").click(function () {
             showChatHistory();
             $(".box").toggle();
         })
         $("#close-box").click(function () {
             $(".box").hide();
         })
     });
 </script>

<!---- Chat script End ---->
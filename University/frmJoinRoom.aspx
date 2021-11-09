<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmJoinRoom.aspx.cs" Inherits="university_frmJoinRoom" %>
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

        <div style="text-align:center;" class="page_wrapper">
            <asp:HiddenField ID="hdfUid" runat="server" />
	 <asp:HiddenField ID="hdfUserId" runat="server" />
   <div style="width:80%;margin-left:10%;margin-right:10%;height: calc(100vh - 100px);">
		 <div id="dvmsg"  style="height:100%;width:100%;background-color:black;color:white;display:none;">
             <h1 style="padding-top:20%;"> No Room Assigned To You !! </h1>

		 </div>
		 <iframe allow="camera; microphone; fullscreen; speaker; display-capture"
        id="ifrmmodify" style="height:100%;width:100%;">
        </iframe>
		
		
		
			 </div>
        </div>
    
<script>
    function SetIFrameSource() {
        if ("<%=strVideoAPI%>" == "") {

            $("#ifrmmodify").css("display", "none");
            $("#dvmsg").css("display", "block");
        }
        else {
            $("#ifrmmodify").css("display", "block");
            $("#dvmsg").css("display", "none");
            $("#ifrmmodify").attr("src", "<%=strVideoAPI%>");
        }
    }
      $(function () { SetIFrameSource(); });
</script>
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



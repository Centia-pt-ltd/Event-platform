<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="University_login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<title>Login::University</title>
<script src="js/bootstrap.min.js"></script>
<!-- Libraries CSS -->
<link href="css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="css/style.css" type="text/css" rel="stylesheet" />
<link href="css/all.css" type="text/css" rel="stylesheet" />
<link href="css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="css/style.css" type="text/css" rel="stylesheet" />
   
</head>
<body>
    <form id="form1" runat="server">
           <div class="container-fluid">
        <div class="row">
<%--<header class="main-header dark">
    <div class="logo">
        <img src="img/trans_branding.png" alt="logo" />
    </div>
    <div class="nav">
        <div class="nav-right">
            <ul class="navright_menu">
                <li class="login_icon" style="visibility:hidden"><a href="#">LogOut<i class="fa fa-sign-out"></i></a></li>
            </ul>
        </div>
    </div>
</header>--%>
</div>   
</div>
       <div class="all_pages_wrappere">
            <div class="login-page">
                <div class="bg_layer">
           <div class="mform">
                     <a href="#" class="branding"><img src="img/logo.png" alt="logo"></a>
               <asp:Label ID="lblmsg" runat="server" style="color: Red; font-size: 20px; font-family: sans-serif; font-weight: 600;"></asp:Label>
                        <h2>University Login</h2>
                        <div class="form-group">
                        <input type="text" class="form-control" id="txtUserName" runat="server" placeholder="user name" />
                         <input type="password" id="txtPwd" runat="server" class="form-control" placeholder="password" />
                        </div>
                       <%-- <a href="#" class="forgot">forgot password</a>--%>
                       <a href="javascript:void();" onclick="BtnLoginPost();" id="btn_hide" class="registration_btn btn btnblue btn-block log_text" style="background-color:#ffffff;"> 
                        <%-- <button type="submit" class="btn btnblue btn-block">
                            <span class="log_text" id="btnLogin">Login</span>
                        </button>--%>Login
                    </a>
               <div style="display:none">
               <asp:Button ID="btnPostLogin" runat="server" OnClick="btnPostLogin_Click" />
                   </div>
            </div>
        </div>
        </div>
    </div>
<script type="text/javascript">
    function slidemenu(){
        $('.side_menu_wrapper').addClass('.active')
    }

    function BtnLoginPost() {
        var btn = document.getElementById("btnPostLogin");
        btn.click();
    }

</script>
  <script src="js/jquery.min.js"></script>
  <script src="js/owl.carousel.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/function.js"></script>




    </form>
</body>
</html>

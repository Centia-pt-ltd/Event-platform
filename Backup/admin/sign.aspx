<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sign.aspx.cs" Inherits="admin_sign" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta charset="utf-8">
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'/>
    <title>kmi</title>
     
<!-- Latest compiled and minified CSS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Optional theme -->

<!-- Libraries CSS -->
<link href="css/style.css" type="text/css" rel="stylesheet">
<link href="css/all.css" type="text/css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Pragati+Narrow:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
    <header>
    <div class="container-fluid">
        <div class="main_header" id="registrationHeader">
            <div class="main_header_left">
                <a href="#" class="logo"><img src="img/logo2.png" alt="logo"></a>
            </div>
             <div class="main_header_right">
                 <h3>Event Regitration(South East Asia Region)</h3>
                 <p>Event Date:27th July 2021</p>
                 <p>Event Time:27th 17:30hrs-2130hrs (GMT+6:30)</p>
             </div>
        </div>
    </div>
</header>
    <div class="container-fluid">
    	<div class="row">
    		<div class="col-sm-6 col-md-6 col-lg-6">
    			<img src="img/logo2.png" alt="logo">
    		</div>
    		<div class="col-sm-6 col-md-6 col-lg-6">
                 <div class="regis_form">
                     <asp:Label ID="lblmsg" runat="server"></asp:Label>
                 	<h2>Login</h2>
                    <div>
                        <label for="name">User Name</label>
                        <input runat="server" type="text" class="form-control" id="txtname" placeholder="Enter your user name here" name="neme" />
                            <label for="exampleInputPassword1">Password</label>
                       <input type="password" runat="server" class="form-control" id="txtPassword" placeholder="Enter your Password" />
  
             <a href="#" class="registration_btn" onclick="ValidateLogin()"> <button type="button" class="btn btnblue btn-block">Login</button></a>
                        <div style="display:none">
                        <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" /></div>
                      </div>
        </div>
    	</div>
    </div>
        <script type="text/javascript">
            function ValidateLogin() {
                var btn = document.getElementById('btnLogin');
                btn.click();
            }
        </script>

    </form>
</body>
</html>

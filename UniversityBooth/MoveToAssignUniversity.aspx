<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MoveToAssignUniversity.aspx.cs" Inherits="UniversityBooth_MoveToAssignUniversity" %>
<%@ Register Src="~/UserControl/ucDoc.ascx" TagName="docMenu" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <link rel="stylesheet" href="WebCSS/bootstrap.min.css" />
  <script src="WebJS/Ajax_jquery.min.js"></script>
    <script src="WebJS/bootstrap.min.js"></script>
    <link href="../css_latest/style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="image-wrapper" style="background-image:url(../img/nouniBacknew.png);height:100vh; width:100%; background-color: #d53b41; background-size: 100% 100%;">
           
        </div> 
        <uc:docMenu ID="doc" runat="server" />
    </form>
</body>
</html>

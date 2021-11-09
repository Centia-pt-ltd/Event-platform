<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/MasterPageSuperAdmin.master" AutoEventWireup="true" CodeFile="Theme.aspx.cs" Inherits="SuperAdmin_Theme" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
div.polaroid {
  background-color: white;
  position: relative;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}
div.polaroid2 {
  background-color: white;
  position: relative;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}


div.container {
  text-align: center;
  padding: 10px 20px;
}
.polaroid:hover .overlay {
  opacity: 1!important;
}
.polaroid2:hover .overlay {
  opacity: 1!important;
}
.sec-redio{
	margin-bottom: 40px;
}

span{
	color: #001393;
  font-weight: 500;
}
.overlay{
  position: absolute;
  cursor: pointer;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100%;
  width: 100%;
  opacity: 0;
  transition: .5s ease;
  background-color:rgba(0, 0, 0, 0.5);
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField ID="hdfUserId" runat="server" />

            
                


                    <div class="container">
		<div class="row">
            <%=_sbTheme %>
		</div>
</div>
                  
 
                

                <!-- Model upload-->
    
     
    <!-- End Model Upload-->

    <script type="text/javascript">
        function themeActive(Rdbid) {
            var Id = Rdbid.replace('Rdb', '');

            $.ajax({
                type: "POST",
                url: "Theme.aspx/ActivateTheme",
                data: "{'ThemeId':'" + Id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == 'U') {
                        if (Id == '1') {
                            document.getElementById("polaroid2").style.opacity = "";
                            document.getElementById("polaroid").style.opacity = "0.5";
                        }
                        else if (Id == '2') {
                            document.getElementById("polaroid").style.opacity = "";
                            document.getElementById("polaroid2").style.opacity = "0.5";
                        }
                        showMsg('SUCCESS', 'Theme has been activated successfully. !');
                    }
                    else if (response.d == 'ER') {
                        showMsg('ERROR', 'Something went wrong.');
                    }
                },
                error: function (response) {
                    showMsg('ERROR', 'Something went wrong.');
                }
            });
        }
    </script>
        
</asp:Content>


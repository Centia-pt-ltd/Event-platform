<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucDoc.ascx.cs" Inherits="UserControl_ucDoc" %>
   <link href="../css_latest/StyleDoc.css" type="text/css" rel="stylesheet" />

 <%--    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />--%>

<style>
.languageMod {
    color: white !important;
    background-color: #000000ad;
    border-radius: 12px;
    min-width: 18%;
    border: 1px solid white;
    font-weight: 400 !important;
    font-size: 15px !important;
    cursor: pointer;
    padding-right: 5px;
    padding-left: 5px;

}
.languageMod_active {
    background-color: #ff45008f;
}
.languageMod:hover {
    border: 1px solid white;
    background-color: #2d2d6ae3
}

.languageMod_active:hover {
    background-color: #ff45008f;
}

    @media screen and (min-width: 768px) {
        .modal-content{
            width:450px;
        }
    }
</style>
<input type="hidden" id="hfLang" runat="server" />
<input type="hidden" id="hfRegNo" runat="server" />
<div class="menu-container">

    <div class="row">
        <input type="checkbox" checked="checked" id="openmenu" class="hamburger-checkbox">
  
        <div class="hamburger-icon">
            <label for="openmenu" id="hamburger-label" class="lblhamburger">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
            </label>
        </div>
        <div class="menu-pane">

            <nav>
                <ul class="menu-links">
                    <li id="liLan" runat="server">
                        <a href="javascript:void();" class="language" OnClick="return OpenLang();" data-title="Choose Language">
                            <img src="../img/lang.png">
                        </a>
                    </li>
                    <li id="liaAudi" runat="server">
                        <a href="../Auditorium.aspx" class="auditorium" data-title="Auditorium">
                            <img src="../img/audi.png">
                        </a>
                    </li>
                    <li id="liLobby" runat="server">
                        <a href="../lobby.aspx?move=no" class="reception" data-title="Lobby">
                            <img src="../img/lobby.png">
                        </a>
                    </li>
                    <li id="liHelp" runat="server">
                        <a href="../reception.aspx" class="help" data-title="Counsellor Desk Chat">
                            <img src="../img/hdesk.png">
                        </a>
                    </li>
                    <li id="liExpo" runat="server">
                        <a href="../exhibition.aspx" class="expo" data-title="Universities">
                            <img src="../img/uni.png">
                        </a>
                    </li>
                     <li id="liCouncil" runat="server">
                        <a href="../UniversityBooth/MoveToCouncilRoom.aspx" class="Council" data-title="Council Room">
                            <img src="../img/Council.png">
                        </a>
                    </li>
                    <li id="liAssignUni" runat="server">
                        <a href="../UniversityBooth/MoveToAssignUniversity.aspx" class="AssignUni" data-title="Assignd University">
                            <img src="../img/AssignUni.png">
                        </a>
                    </li>
                    <li id="liContact" runat="server">
                        <a href="https://web.whatsapp.com/" target="_blank" class="contact" data-title="Help Desk WhatsApp">
                            <img src="../img/whtsap.png">
                        </a>
                    </li>
                     <li id="liLogout" runat="server">
                        <a href="javascript:void();" onclick="return SessionLogout();" class="logout" data-title="Logout">
                            <img src="../img/logout.png">
                        </a>
                          <div style="display:none"><asp:Button ID="btnLogOut" runat="server" OnClick="btnLogOut_Click" /></div>
                        
                    </li>
                </ul>

            </nav>
        </div>
   </div>     
    </div>



 <!-- Change Language Model-->
    <div class="modal" id="modelNotes">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 style="font-weight: bold; font-size: 1.2rem;text-shadow: 2px -1px 0px #c2c9ca;color: black !important;">Change Language</h4>
            <div class="alert alertboxes alert-danger d-none"  id="divError3" role="alert"></div>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
<div class="index_radio_btn text-center" style="color:white;width:100%;" id="divLanguage">  
 <label class="languageMod languageMod_active" id="English" onclick="SelectLanguage(this.id);" >English</label>
 
 <label class="languageMod" id="Arabic" onclick="SelectLanguage(this.id);">Arabic</label>
 
 <label class="languageMod" id="Russian" onclick="SelectLanguage(this.id);">Russian</label>
 
 <label class="languageMod" id="Indonesian" onclick="SelectLanguage(this.id);">Indonesian</label>  
      
        </div>
          
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
            <input type="hidden" id="hdfRoomId" />
            <asp:Button ID="btnChange" runat="server" CssClass="btn btn-success" Text="Save" OnClientClick="return ChangeLang();" />
            
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
    <!-- End-->

<script>
    window.onload = onPageLoad();

    function onPageLoad() {
        document.getElementById("openmenu").checked = true;

    }

    function SelectLanguage(eleId) {
        var div = document.getElementById("divLanguage");
        var lebel = div.getElementsByTagName('label');
        var len = lebel.length;
        var tmpId = '';
        for (var k = 0; k < len; k++) {
            tmpId = lebel[k].id;
            if ($("#" + tmpId).hasClass("languageMod_active") == true) {
                $("#" + tmpId).removeClass("languageMod_active");
            }
        }
        $("#" + eleId).addClass("languageMod_active");
        $("#doc_hfLang").val(eleId);

        return false;
    }
    function OpenLang() {
        var lg = $("#doc_hfLang").val();
        SelectLanguage(lg)
        $("#modelNotes").modal("show");
        return false;
    }

    function ChangeLang() {
        var lang = $("#doc_hfLang").val();
        var StRegNo = $("#doc_hfRegNo").val();

        $("#doc_btnChange").attr("disabled", true);
        $("#doc_btnChange").val("Please Wait..");
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/WebService.asmx/ChangeLang")%>',
            data: "{'lang':'" + lang + "','StRegNo':'" + StRegNo + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {
                if (response.d == "ER") {
                    showMsg("ERROR", "Something went wrong. !")
                    $("#doc_btnChange").attr("disabled", false);
                    $("#doc_btnChange").val("Save");
                    return false;
                }
                
               <%-- '<%Session["Lang"] = "' + lang + '"; %>';--%>
                $("#modelNotes").modal("hide");
                showMsg("SUCCESS", "Data saved successfully. !");
                $("#doc_btnChange").attr("disabled", false);
                $("#doc_btnChange").val("Save");
            },
            error: function (response) {
                showMsg("ERROR", "Something went wrong. !");
                $("#doc_btnChange").attr("disabled", false);
                $("#doc_btnChange").val("Save");
            }
        });
        return false;
    }
</script>
 <script type="text/javascript">
     function SessionLogout() {
         var btn = document.getElementById("doc_btnLogOut");
         btn.click();
     }
 </script>


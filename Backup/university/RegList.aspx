<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegList.aspx.cs" Inherits="university_RegList" %>

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
        .chat_video_icon:hover{
            transition: transform .2s;
             transform: scale(1.5);
             border:1px solid gray;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblmsg" runat="server"></asp:Label>
        <div>

            <h3>Registration List: 
                
            <asp:DropDownList ID="ddlRegion" runat="server" OnSelectedIndexChanged="ddlRegion_SelectedIndexChanged" style="font-size:16px" AutoPostBack="true"></asp:DropDownList>
                <asp:Button ID="btnLogOut" runat="server" Text="LogOut" OnClick="btnLogOut_Click" Style="float: right; margin-left: 10px; cursor: pointer; font-weight: bold; font-size: 16px;  margin: 11px 10px 0 0;" />
                <asp:Button ID="btnWelcome" runat="server" Text="" Style="float: right; margin-left: 10px; font-weight: bold; font-size: 16px;  margin: 11px 10px 0 0;" />
                <asp:Button ID="btnDownload" runat="server" Text="Download in Excel" Style="float: right; cursor: pointer; font-weight: bold; font-size: 16px;  margin: 11px 10px 0 0; display:none" OnClick="btnDownload_Click" />
                <asp:Button ID="btnLoginList" runat="server" Text="Go To Login List" OnClick="btnLoginList_Click" Style="float: right; margin-right: 10px; cursor: pointer; font-weight: bold;font-size: 16px;  margin: 11px 10px 0 0; display:none" />
                
                <asp:DropDownList ID="ddlCourse" style="font-size:16px; width:215px" runat="server"></asp:DropDownList>
                <asp:DropDownList ID="ddlQualification" style="font-size:16px" runat="server"></asp:DropDownList>
                <asp:TextBox ID="txtCountry" style="font-size:16px" runat="server"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-secondary" OnClick="btnSearch_Click" style="font-size:9px; font-weight:bold" />
                <asp:Button ID="btnRefresh" runat="server" OnClick="btnRefresh_Click" Text="All Data" CssClass="btn btn-primary" style="font-size:9px; font-weight:bold" />
                <div class="chat_video_icon" style="position:absolute; top:50%; right:30px">
                <a href="https://dashboard.tawk.to/?lang=en#/dashboard" target="_blank" style="display:block;margin-right:5px;">
                    <img src="img/chat.png" height="30"/></a>
                 
                <a href="https://kmilab.zoom.us/j/9612749677?pwd=V0lHZGY0MW8zMkdORWJtUkMvWDVLZz09" target="_blank" style="display:block;">
                    <img src="img/VideoChat.png" height="30"/></a>
                 </div>
            </h3>
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
                    <asp:TemplateField HeaderText="Active"  Visible="false">                        
                        <ItemTemplate>
                            <asp:HiddenField ID="hdfActive"  runat="server" Value='<%#Eval("Active")%>' />                            
                           <%--<asp:CheckBox ID="chkActive" OnCheckedChanged="chkActive_CheckedChanged" AutoPostBack="true" runat="server" />--%>
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
                            <a style='color:blue' href='mailto:<%#Eval("EMail")%>'><%#Eval("EMail")%></a>                           
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
                    <asp:TemplateField HeaderText="CreatedOn" Visible="false">
                        <ItemTemplate>
                            <%#Eval("CreatedOn")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    
                </Columns>


                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#ed614b" Font-Bold="True" ForeColor="White" />
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
        <script type="text/javascript">
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

        </script>


    </form>
</body>
</html>

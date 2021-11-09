<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UniversityList.aspx.cs" Inherits="admin_UniversityList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Qstudy:University List</title>
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
    </style>

        <style>
        h1 {
            color: green;
        }
  
        .multipleSelection {
            width: 300px;
            background-color: #BCC2C1;
        }
  
        .selectBox {
            position: relative;
        }
  
        .selectBox select {
            width: 100%;
            font-weight: bold;
        }
  
        .overSelect {
            position: absolute;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
        }
  
        #checkHq {
            display: none;
            border: 1px #8DF5E4 solid;
        }
  
        #checkHq label {
            display: block;
        }
  
        #checkHq label:hover {
            background-color: #4F615E;
        }
        #checkCourse {
            display: none;
            border: 1px #8DF5E4 solid;
        }
  
        #checkCourse label {
            display: block;
        }
  
        #checkCourse label:hover {
            background-color: #4F615E;
        }
        #checkPlateform {
            display: none;
            border: 1px #8DF5E4 solid;
        }
  
        #checkPlateform label {
            display: block;
        }
  
        #checkPlateform label:hover {
            background-color: #4F615E;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblmsg" runat="server" Font-Bold="true" style="margin-left:40%; font-size:20px"></asp:Label>
        <div>

            <h3>University List:  
            <asp:DropDownList ID="ddlRegion"  runat="server" OnSelectedIndexChanged="ddlRegion_SelectedIndexChanged" style="font-size:16px; display:none" AutoPostBack="true"></asp:DropDownList>
                <asp:Button ID="btnLogOut" runat="server" Text="LogOut" OnClick="btnLogOut_Click" Style="float: right; margin-left: 10px; cursor: pointer; font-weight: bold; font-size: 16px;  margin: 11px 10px 0 0;" />
                <asp:Button ID="btnWelcome" runat="server" Text="" Style="float: right; margin-left: 10px; font-weight: bold; font-size: 16px;  margin: 11px 10px 0 0;" />
                <asp:Button ID="btnDownload" runat="server" Text="Download in Excel" Style="float: right; cursor: pointer; font-weight: bold; font-size: 16px;  margin: 11px 10px 0 0;" OnClick="btnDownload_Click" />
                <asp:Button ID="btnLoginList" runat="server" Text="Go To Login List" OnClick="btnLoginList_Click" Style="float: right; margin-right: 10px; cursor: pointer; font-weight: bold;font-size: 16px;  margin: 11px 10px 0 0;" />
                <asp:Button ID="btnRegistration" runat="server" Text="Go To Registration List" OnClick="btnRegistration_Click" Style="float: right; margin-right: 10px; cursor: pointer; font-weight: bold;font-size: 16px;  margin: 11px 10px 0 0;" />

            </h3>
            <asp:GridView CssClass="table table-bordered" ID="grdList" AutoGenerateColumns="false" runat="server" GridLines="Both" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" AllowPaging="true" PageSize="10" OnPageIndexChanging="OnPageIndexChanging">

                <Columns>

                    <asp:TemplateField HeaderText="ID">
                        <ItemTemplate>
                            <%#Eval("Id")%>
                            <asp:HiddenField ID="hdfRegId"  runat="server" Value='<%#Eval("Id")%>' />
                        </ItemTemplate>                        
                    </asp:TemplateField>                   

                    <asp:TemplateField HeaderText="UniversityName">
                        <ItemTemplate>
                            <%#Eval("UniversityName")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>                    
                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <%#Eval("Email")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Pwd">
                        <ItemTemplate>
                            <%#Eval("Pwd")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Active">
                        <ItemTemplate>
                            <%#Eval("Active")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CreatedDateTime">
                        <ItemTemplate>
                            <%#Eval("CreatedDateTime")%>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                    
                    
                </Columns>


                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
            </asp:GridView>
        </div>
            </form>
</body>
</html>

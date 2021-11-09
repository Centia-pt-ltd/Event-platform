using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
public partial class SuperAdmin_MasterPageSuperAdmin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
        Response.Cache.SetNoStore();

        if (Session["UserId"] == null || Session["UserId"] == "")
        {
           
            Session.Clear();
            Session.RemoveAll();
            Response.Redirect("login.aspx", false);
        }
        else
        {
            if (Path.GetFileName(Request.Path) == "Dashboard.aspx")
            {
                liDashBoard.Attributes.Add("class", "active");
            }
            if (Path.GetFileName(Request.Path) == "PartialData.aspx")
            {
                liPartial.Attributes.Add("class", "active");
            }
            if (Path.GetFileName(Request.Path) == "UniversityManagement.aspx")
            {
                liUniversityManagent.Attributes.Add("class", "active");
            }
            else if (Path.GetFileName(Request.Path) == "RegistrationList.aspx")
            {
                liRegisterList.Attributes.Add("class", "active");
            }
            else if (Path.GetFileName(Request.Path) == "frmManageUser.aspx")
            {
                liManageUser.Attributes.Add("class", "active");
            }
            else if (Path.GetFileName(Request.Path) == "LogedInUsers.aspx")
            {
                liLogedInUser.Attributes.Add("class", "active");
            }
           
            else if (Path.GetFileName(Request.Path) == "BoothManagement.aspx")
            {
                liBoothManager.Attributes.Add("class", "active");
            }
            else if (Path.GetFileName(Request.Path) == "EventManagement.aspx")
            {
                liManageEvent.Attributes.Add("class", "active");
            }
            else if (Path.GetFileName(Request.Path) == "Theme.aspx")
            {
                liTheme.Attributes.Add("class", "active");
            }
            
        }
    }
    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] != null || Session["UserId"] != "")
            {
                string UserId = Session["UserId"].ToString();
                string Rslt = string.Empty;
                ClsCommanDataAccess _objComman = new ClsCommanDataAccess();
                Rslt = _objComman.UpdateLoginStatus(UserId, "LogOut");
            }
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
            Session.Clear();
            Session.RemoveAll();
            Response.Redirect("login.aspx", false);
        }
        catch (Exception ex)
        {
            Response.Write("Someting went wrong.!");
        }
    }
}

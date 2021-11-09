using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class University_MasterPageUniversity : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
        Response.Cache.SetNoStore();
        if (!Page.IsPostBack)
        {
            if (Session["UserId"] == null || Session["UserId"] == "")
            {

                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("login.aspx", false);
            }
            else
            {
                if(Convert.ToString(Session["Role"])=="Admin")
                {
                    liRoom.Visible = true;

                }
                else
                {
                    liRoom.Visible = false;
                }
                if (Path.GetFileName(Request.Path) == "RegistrationList.aspx")
                {
                    liRegisterList.Attributes.Add("class", "active");
                }
                else if (Path.GetFileName(Request.Path) == "ResourceManagement.aspx")
                {
                    liResource.Attributes.Add("class", "active");
                }
                //else if (Path.GetFileName(Request.Path) == "frmUniversityBooth.aspx")
                //{
                //  liBooth.Attributes.Add("class", "active");
                //}
                else if (Path.GetFileName(Request.Path) == "Dashboard.aspx")
                {
                    liDashBoard.Attributes.Add("class", "active");
                }
                else if (Path.GetFileName(Request.Path) == "frmVideoCall.aspx")
                {
                    liVideoCall.Attributes.Add("class", "active");
                }
                //else if (Path.GetFileName(Request.Path) == "ManageEmail.aspx")
                //{
                //    liEmail.Attributes.Add("class", "active");
                //}
                else if (Path.GetFileName(Request.Path) == "frmAssignRoom.aspx")
                {
                    liRoom.Attributes.Add("class", "active");
                }
            }
        }
    }
    protected void btnLogOut_Click(object sender, EventArgs e)
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
}

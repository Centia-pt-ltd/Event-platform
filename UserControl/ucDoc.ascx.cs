using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Text;
using System.Data.SqlClient;
using System.Data.Sql;
using System.IO;

public partial class UserControl_ucDoc : UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Reg_Id"] != null && Session["FullName"] != null && Session["Lang"] != null)
        {

            hfRegNo.Value = Session["FullName"].ToString();
            hfLang.Value = Session["Lang"].ToString();

        }
        //if (Path.GetFileName(Request.Path) == "UniversityManagement.aspx")
        //{
        //    liLan.Attributes.Add("class", "active");
        //}
        if (Path.GetFileName(Request.Path) == "lobby.aspx")
        {
            liLobby.Attributes.Add("class", "active");
        }
        else if (Path.GetFileName(Request.Path) == "Auditorium.aspx")
        {
            liaAudi.Attributes.Add("class", "active");
        }
        else if (Path.GetFileName(Request.Path) == "reception.aspx")
        {
            liHelp.Attributes.Add("class", "active");
        }
        else if (Path.GetFileName(Request.Path) == "exhibition.aspx")
        {
            liExpo.Attributes.Add("class", "active");
        }
        else if (Path.GetFileName(Request.Path) == "MoveToAssignUniversity.aspx")
        {
            liAssignUni.Attributes.Add("class", "active");
        }
        


    }

    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        try
        {
            ClsCommanDataAccess clscommon = new ClsCommanDataAccess();
            clscommon.UpdateLogout(hfRegNo.Value);

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
            Session.Clear();
            Session.RemoveAll();
            

            if (Path.GetFileName(Request.Path) == "lobby.aspx")
            {
                Response.Redirect("Welcome.aspx", false);
            }
            else if (Path.GetFileName(Request.Path) == "Auditorium.aspx")
            {
                Response.Redirect("Welcome.aspx", false);
            }
            else if (Path.GetFileName(Request.Path) == "reception.aspx")
            {
                Response.Redirect("Welcome.aspx", false);
            }
            else if (Path.GetFileName(Request.Path) == "exhibition.aspx")
            {
                Response.Redirect("Welcome.aspx", false);
            }
            else
            { 
            Response.Redirect("../Welcome.aspx", false);
            }
        }
        catch (Exception ex)
        {
            Response.Write("Someting went wrong.!");
        }
    }


    public void logout()
    {
        try
        {
            ClsCommanDataAccess clscommon = new ClsCommanDataAccess();
            clscommon.UpdateLogout(hfRegNo.Value);

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
            Session.Clear();
            Session.RemoveAll();


            if (Path.GetFileName(Request.Path) == "lobby.aspx")
            {
                Response.Redirect("Welcome.aspx", false);
            }
            else if (Path.GetFileName(Request.Path) == "Auditorium.aspx")
            {
                Response.Redirect("Welcome.aspx", false);
            }
            else if (Path.GetFileName(Request.Path) == "reception.aspx")
            {
                Response.Redirect("Welcome.aspx", false);
            }
            else if (Path.GetFileName(Request.Path) == "exhibition.aspx")
            {
                Response.Redirect("Welcome.aspx", false);
            }
            else
            {
                Response.Redirect("../Welcome.aspx", false);
            }
        }
        catch (Exception ex)
        {
            Response.Write("Someting went wrong.!");
        }
    }
   
}
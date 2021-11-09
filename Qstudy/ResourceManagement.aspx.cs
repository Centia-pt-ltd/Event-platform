using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Qstudy_ResourceManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["UserId"] == null || Session["UserId"] == "")
            {

                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
                Response.Cache.SetNoStore();
                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("login.aspx", false);
            }
            else
            {
                hdfUserId.Value = Session["UserId"].ToString();
                Page.Title = "Qstudy::ResourceManagement";
            }
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string FillAboutUs()
    {
        string Data = "";
        try
        {
            
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            string UploadedSource = _obj.Source;
            Data = _obj.GetAboutUs(UploadedSource);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveVideo(string Url)
    {
        string Data = "";
        try
        {            
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            Data = _obj.SaveVideoUrl(Url, _obj.Source, HttpContext.Current.Session["UserId"].ToString());
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveAboutUs(string details)
    {        
        string Rslt = string.Empty;
        ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();        
        string UploadedBy = HttpContext.Current.Session["UserId"].ToString();
        Rslt = _obj.UploadAbout(details, _obj.Source, UploadedBy);
        return Rslt;
    }

}
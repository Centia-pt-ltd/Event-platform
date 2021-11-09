using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class Auditorium : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();
        if (!Page.IsPostBack)
        {
            //Session["Reg_Id"] = "18";
            if (Session["Reg_Id"] == null)
            {
                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("Welcome.aspx", false);
            }
            else
            {
                hdfUserId.Value = Session["Reg_Id"].ToString();
                Page.Title = "Student::Auditorium";
               
                hfLang.Value = SelectLang(hdfUserId.Value); 
                Tracking(hdfUserId.Value, "Auditorium");
            }

        }
    }
    public void Tracking(string regId, string PageName)
    {
        try
        {
            ClsCommanDataAccess clscomm = new ClsCommanDataAccess();
            clscomm.InsertTracking(regId, PageName);
        }
        catch (Exception ex)
        {

        }
    }
    public string SelectLang(string regId)
    {
        string lang = "";
        ClsCommanDataAccess clscomm = new ClsCommanDataAccess();
        lang = clscomm.SelectLang(regId);
        return lang;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string BindVideo(string Uid)
    {
        
        string Data = "";
        try
        {
            DataTable dt = new DataTable();
            ClsStudentUIZone _objStudent = new ClsStudentUIZone();
            dt = _objStudent.GetVideo(Uid);
            int len = dt.Rows.Count;
            Regex YoutubeVideoRegex = new Regex(@"youtu(?:\.be|be\.com)/(?:(.*)v(/|=)|(.*/)?)([a-zA-Z0-9-_]+)", RegexOptions.IgnoreCase);

            if (len > 0)
            {
                string Id = string.Empty;
                string Title = string.Empty;
                string Url = string.Empty;
                Data = "";
                for (int i = 0; i < len; i++)
                {
                    
                    Title = dt.Rows[i]["Title"].ToString();
                    Id = dt.Rows[i]["Id"].ToString();
                    Url = dt.Rows[i]["Url"].ToString();

                    var youtubeMatch = YoutubeVideoRegex.Match(Url);
                    var YouId = youtubeMatch.Groups[youtubeMatch.Groups.Count - 1].Value;
                    Data += " <li><a href = '#' onclick = PlayVideo('"+ Url + "');> " ;
                    Data += " <h4> "+ Title + " </h4> ";
                    Data += "<img src='img/youtube-dark.png' style='width:130px;height:80px;'></img></a></li>";
                }
            }
            else
            {
                Data += " <li><a href = '#'> ";
                Data += " <h4> No Video Found For Selected University !!</h4> ";
                Data += "</a></li>";
            }

        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string BindUniversity()
    {
        string Data = "";
        try
        {
            DataTable dt = new DataTable();
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            dt = _obj.BindEventUniversityTable();
            int len = dt.Rows.Count;

            if (len > 0)
            {
                string Id = string.Empty;
                Data = "<option value =0 selected ='selected'>-Select University-</option>";
                for (int i = 0; i < len; i++)
                {
                    Id = dt.Rows[i]["Id"].ToString();
                    Data += "<option value=" + Id + ">" + dt.Rows[i]["UniversityName"].ToString() + "</option>";
                }
            }
            else
            {

            }

        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class SuperAdmin_EventManagement : System.Web.UI.Page
{
    public string _sbHtml = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

        if (!Page.IsPostBack)
        {
            try
            {
                if (Session["UserId"] == null || Session["UserId"] == "")
                {
                    Session.Clear();
                    Session.RemoveAll();
                    Response.Redirect("login.aspx", false);
                }
                else
                {
                    hdfUserId.Value = Session["UserId"].ToString();
                    Page.Title = "SuperAdmin::EventManagement";
                    ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
                    _sbHtml = _obj.BindUniversitytHtmlTable();
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showMsg('ERROR', 'Something went wrong.!');", true);
            }
        }
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string AddUpdateEvent(List<ClsSuperAdminDataAcces.EventModel> _Events)
    {
        string Data = "";
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            Data = _obj.EventSaveUpdate(_Events, UserId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsSuperAdminDataAcces.EventModel[] BindList(string SearchValue, string RowPerPage, string PageNumber)
    {
        List<ClsSuperAdminDataAcces.EventModel> details = new List<ClsSuperAdminDataAcces.EventModel>();
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            dt = _obj.BindEventList(SearchValue, RowPerPage, PageNumber);

            foreach (DataRow dr in dt.Rows)
            {
                ClsSuperAdminDataAcces.EventModel det = new ClsSuperAdminDataAcces.EventModel();
                det.TotalRows = dr["TotalRows"].ToString();
                det.SNo = dr["SNo"].ToString();
                det.EventId = dr["Id"].ToString();
                det.EventName = dr["EventName"].ToString();
                det.EventDate = dr["EventDateTime"].ToString();
                det.Status = dr["Status"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetEditEventTable()
    {
        string Rslt = string.Empty;
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            Rslt = _obj.BindUniversitytHtmlTable();
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsSuperAdminDataAcces.EventModel[] FillEditData(string EventId)
    {
        string Rslt = string.Empty;
        DataTable dt = new DataTable();
        List<ClsSuperAdminDataAcces.EventModel> details = new List<ClsSuperAdminDataAcces.EventModel>();
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            dt = _obj.GetEventEditData(EventId);
            foreach (DataRow dr in dt.Rows)
            {
                ClsSuperAdminDataAcces.EventModel det = new ClsSuperAdminDataAcces.EventModel();
                det.LineNo = dr["Line_No"].ToString();
                det.EventId = dr["EventId"].ToString();
                det.EventName = dr["EventName"].ToString();
                det.EventDate = dr["EventDateTime"].ToString();
                det.Universityid = dr["Universityid"].ToString();
                det.BoothId = dr["BoothId"].ToString();
                det.Position = dr["Position"].ToString();
                det.Status = dr["Status"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string DeleteEvent(string EventId)
    {
        string Rslt = string.Empty;
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            Rslt = _obj.DelEvent(EventId);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string ChangeEventStatus(string EventId, string Msg, string sts)
    {
        string Rslt = string.Empty;
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            Rslt = _obj.UpdateEventStatus(EventId, Msg, UserId, sts);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetStatusMsg(string EventId)
    {
        string Rslt = string.Empty;
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            Rslt = _obj.FetchStatusMsgValue(EventId);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
   
}
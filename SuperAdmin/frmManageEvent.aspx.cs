using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SuperAdmin_frmManageEvent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null || Convert.ToString(Session["UserId"]) == "")
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
            Page.Title = "SuperAdmin::ManageEvent";
        }
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string AddUpdateEvent(string EventId, string EventName, string EventDetail, string EventURL, string Status, string EventDate, string RegionId, string CreatedBy)
    {       

        string Data = "";
        try
        {
            ClsEventDataAccess _obj = new ClsEventDataAccess();
            Data = _obj.SaveUpdateEvent(EventId,EventName, EventDetail, EventURL, Status, EventDate, RegionId, CreatedBy);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsEventBO[] BindList(string SearchValue, string RowPerPage, string PageNumber)
    {
        string Data = "";
        List<ClsEventBO> details = new List<ClsEventBO>();
        try
        {
            DataTable dt = new DataTable();
            ClsEventDataAccess _obj = new ClsEventDataAccess();
            dt = _obj.GetEventList(SearchValue, RowPerPage, PageNumber);
            int len = dt.Rows.Count;

           
            foreach (DataRow dr in dt.Rows)
            {
                ClsEventBO det = new ClsEventBO();
                det.SNo = dr["SNo"].ToString();
                det.EventId = dr["EventId"].ToString();
                det.EventName = dr["EventName"].ToString();
                det.EventDetail = dr["EventDetail"].ToString();
                det.EventURL = dr["EventURL"].ToString();
                det.EventDate = dr["EventDate"].ToString();
                if (dr["Status"].ToString() == "Yes")
                {
                    det.Status = "Active";
                }
                else
                {
                    det.Status = "Inactive";
                }
                det.Region = dr["Region"].ToString();
                det.CreatedBy = dr["CreatedBy"].ToString();
                det.UpdatedBy = dr["UpdatedBy"].ToString();
                det.CreatedOn = dr["CreatedOn"].ToString();
                det.UpdatedOn = dr["UpdatedOn"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string BindRegion()
    {
        string Data = "";
        try
        {
            DataTable dt = new DataTable();
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            dt = _obj.FillRegion();
            int len = dt.Rows.Count;

            if (len > 0)
            {
                string Id = string.Empty;
                Data = "<option value =0 selected ='selected'>-Select Region-</option>";
                for (int i = 0; i < len; i++)
                {
                    Id = dt.Rows[i]["Id"].ToString();
                    Data += "<option value=" + Id + ">" + dt.Rows[i]["RName"].ToString() + "</option>";
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
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static ClsEventBO[] GetEditEventData(string EventId)
    {
        string Data = "";
        List<ClsEventBO> details = new List<ClsEventBO>();
        try
        {
            DataTable dt = new DataTable();
            ClsEventDataAccess _obj = new ClsEventDataAccess();
            dt = _obj.GetEventDetails(EventId);

            foreach (DataRow dr in dt.Rows)
            {
                ClsEventBO det = new ClsEventBO();
               
                det.EventId = dr["EventId"].ToString();
                det.EventName = dr["EventName"].ToString();
                det.EventDetail = dr["EventDetail"].ToString();
                det.EventURL = dr["EventURL"].ToString();
                det.EventDate = dr["EventDate"].ToString();
                det.Status = dr["Status"].ToString();
                det.Region = dr["Region"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string DeleteEvent(string EventId)
    {
        string Data = "";
        try
        {
            ClsEventDataAccess _obj = new ClsEventDataAccess();
            Data = _obj.DelEvent(EventId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string ViewEventData(string EventId)
    {
        string Data = "";
        string _table = string.Empty;
        try
        {
            DataTable dt = new DataTable();
            ClsEventDataAccess _obj = new ClsEventDataAccess();
            dt = _obj.ViewEventData(EventId);

            string status = "";
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["Status"].ToString() == "Yes") { status = "Active"; } else { status = "Inactive"; }

                _table += "<tbody>";
                _table += "<tr><td>Event Name</td><td>" + dr["EventName"].ToString() + "</td></tr>";
                _table += "<tr><td>Event Detail</td><td>" + dr["EventDetail"].ToString() + "</td></tr>";
                _table += "<tr><td>Event URL</td><td>" + dr["EventURL"].ToString() + "</td></tr>";
                _table += "<tr><td>Event Date</td><td>" + dr["EventDate"].ToString() + "</td></tr>";
                _table += "<tr><td>Status</td><td>" + status + "</td></tr>";
                _table += "<tr><td>Region</td><td>" + dr["Region"].ToString() + "</td></tr>";
                _table += "<tr><td>CreatedBy</td><td>" + dr["CreatedBy"].ToString() + "</td></tr>";
                _table += "<tr><td>CreatedOn</td><td>" + dr["CreatedOn"].ToString() + "</td></tr>";
                _table += "<tr><td>UpdatedBy</td><td>" + dr["UpdatedBy"].ToString() + "</td></tr>";
                _table += "<tr><td>UpdatedOn</td><td>" + dr["UpdatedOn"].ToString() + "</td></tr>";
                _table += "</tbody>";

            }
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return _table;
    }
    public class ClsEventBO
    {
        public string SNo { get; set; }
        public string EventId { get; set; }
        public string EventName { get; set; }
        public string EventDetail { get; set; }
        public string EventURL { get; set; }
        public string Status { get; set; }
        public string EventDate { get; set; }
        public string Region { get; set; }
        public string CreatedBy { get; set; }
        public string UpdatedBy { get; set; }
        public string CreatedOn { get; set; }
        public string UpdatedOn { get; set; }

    }
}
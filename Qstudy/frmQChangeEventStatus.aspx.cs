using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Configuration;
using System.Text;


public partial class Qstudy_frmQChangeEventStatus : System.Web.UI.Page
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
            Page.Title = "Qstudy::EventStatus";
        }
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

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string GetEditEventData(string EventId,string UpdatedBy)
    {
        string str = "";
        SqlTransaction transact = null;
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        try
        {

            con.Open();
            transact = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand("UPDATE tbl_EventDetails SET Status=CASE Status WHEN 'Yes' THEN 'No' WHEN 'No' THEN 'Yes' END, UpdatedBy= @UpdatedBy, UpdatedOn=getdate() WHERE EventId=@EventId", con);
            cmd.Parameters.AddWithValue("@EventId", EventId);
            cmd.Parameters.AddWithValue("@UpdatedBy", UpdatedBy);
            cmd.Transaction = transact;
            cmd.ExecuteNonQuery();
            str = "1";
            transact.Commit();

        }
        catch (Exception ex)
        {
            transact.Rollback();
            str = ex.Message;
        }
        finally
        {
            con.Close();
        }
        return str;
    }

    //[System.Web.Services.WebMethod(EnableSession = true)]
    //public static string GetEditEventData(string EventId)
    //{
    //    string Data = "";
    //    string _table = string.Empty;
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        ClsEventDataAccess _obj = new ClsEventDataAccess();
    //        dt = _obj.GetEventDetails(EventId);
            
    //        string status = "";
    //        foreach (DataRow dr in dt.Rows)
    //        {
    //            if (dr["Status"].ToString() == "Yes") { status = "Active"; } else { status = "Inactive"; }

    //            _table += "<tbody>";
    //            _table += "<tr><td>Event Name</td><td>" + dr["EventName"].ToString() + "</td></tr>";
    //            _table += "<tr><td>Event Detail</td><td>" + dr["EventDetail"].ToString() + "</td></tr>";
    //            _table += "<tr><td>Event URL</td><td>" + dr["EventURL"].ToString() + "</td></tr>";
    //            _table += "<tr><td>Event Date</td><td>" + dr["EventDate"].ToString() + "</td></tr>";
    //            _table += "<tr><td>Status</td><td>" + status + "</td></tr>";
    //            _table += "<tr><td>Region</td><td>" + dr["Region"].ToString() + "</td></tr>";
    //            _table += "</tbody>";

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Data = "ER";
    //    }
    //    return _table;
    //}
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
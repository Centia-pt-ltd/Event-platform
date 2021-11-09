using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Script.Services;
using System.IO;
using System.Drawing;

public partial class University_RegistrationList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
        Response.Cache.SetNoStore();

        if (!Page.IsPostBack)
        {
            if (Session["UserId"] == null || Session["UserId"] == "" || Session["University"] == null || Session["University"] == "")
            {                
                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("login.aspx", false);
            }
            else
            {
                BindRegion(Session["University"].ToString());
                BindHq();
                BindCourse();
                BindUniversity();
                hdfUserId.Value = Session["UserId"].ToString();
                Page.Title = "University::RegistrationList";
                
            }
        }
    }
    public void BindUniversity()
    {
        try
        {
            ClsCommanDataAccess _obj = new ClsCommanDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.GetAllUniversity();
            ddlUniversity.DataSource = dt;
            ddlUniversity.DataTextField = "UniversityName";
            ddlUniversity.DataValueField = "Id";
            ddlUniversity.DataBind();
            ddlUniversity.Items.Insert(0, "-University-");
            ddlUniversity.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "showMsg('ERROR', 'Something went wrong.!');", true);
        }
    }
    public void BindRegion(string UniversityId)
    {
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.FillRegion(UniversityId);
            ddlRegion.DataSource = dt;
            ddlRegion.DataTextField = "RName";
            ddlRegion.DataValueField = "Id";
            ddlRegion.DataBind();
            //ddlRegion.Items.Insert(0, "-All Region-");
            if (dt.Rows.Count==0)
                ddlRegion.Items.Insert(0, "-No Region-");
            else
                ddlRegion.Items.Insert(0, "-All Region-");
            ddlRegion.SelectedIndex = 0;
        }
        catch (Exception ex)
        {

        }
    }
    public void BindCourse()
    {
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.FillCourses();
            ddlCourse.DataSource = dt;
            ddlCourse.DataTextField = "CourseName";
            ddlCourse.DataValueField = "CourseId";
            ddlCourse.DataBind();
            ddlCourse.Items.Insert(0, "-Courses-");
            ddlCourse.SelectedIndex = 0;
        }
        catch (Exception ex)
        {

        }
    }
    public void BindHq()
    {
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.FillQualification();
            ddlQualification.DataSource = dt;
            ddlQualification.DataSource = dt;
            ddlQualification.DataTextField = "HigestQualificationName";
            ddlQualification.DataValueField = "HigestId";
            ddlQualification.DataBind();
            ddlQualification.Items.Insert(0, "-Qualification-");
            ddlQualification.SelectedIndex = 0;
        }
        catch (Exception ex)
        {

        }
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static RegListBO[] BindRegistrationList(string RegionId, string RowPerPage, string PageNumber,string Course, string Qualification,string Country,string StudentName, string Flag)
    {
        List<RegListBO> details = new List<RegListBO>();
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            DataTable dt = new DataTable();
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            dt = _obj.FillRegGrid(RegionId, RowPerPage, PageNumber, Course, Qualification, Country, UniversityId, StudentName, Flag);

            foreach (DataRow dr in dt.Rows)
            {
                RegListBO det = new RegListBO();
                det.TotalRows = dr["TotalRows"].ToString();
                det.SNo = dr["SNo"].ToString();
                det.Reg_Id = dr["Reg_Id"].ToString();
                det.RegNo = dr["RegNo"].ToString();
                det.Gender = dr["Gender"].ToString();
                det.Name = dr["Name"].ToString();
                det.EMail = dr["EMail"].ToString();
                det.CountryCode = dr["CountryCode"].ToString();
                det.Phone = dr["Phone"].ToString();
                det.WhatsApp = dr["WhatsApp"].ToString();
                det.Country = dr["Country"].ToString();
                det.City = dr["City"].ToString();
                det.TOEFLScore = dr["TOEFLScore"].ToString();
                det.msg = dr["Messaging Platform"].ToString();
                det.hq = dr["Highest Qualification"].ToString();
                det.Course = dr["Course"].ToString();
                det.StudyAbroad = dr["StudyAbroad"].ToString();
                det.FeeRange = dr["FeeRange"].ToString();
                det.CreatedOn = dr["CreatedOn"].ToString();
                det.Active = dr["Active"].ToString();
                det.LastUpdatedBy = dr["LastUpdatedBy"].ToString();
                det.LastUpdateOn = dr["updatedOn"].ToString();
                det.Flag = dr["Flag"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetDetails(string id)
    {
        string Rslt = string.Empty;
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            Rslt = _obj.GetRegDetails(id);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string ShowNotes(string RegId)
    {
        string Rslt = string.Empty;
        try
        {
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            string UserType = HttpContext.Current.Session["LoginType"].ToString();
            DataTable dt = new DataTable();
            ClsCommanDataAccess _obj = new ClsCommanDataAccess();
            dt = _obj.GetNotes(RegId, UserId, UserType);

            foreach (DataRow dr in dt.Rows)
            {
                Rslt += "<tr>";
                Rslt += "<td><a href='javascript:void();' onclick='FetchEditNoteData(this.id);' id=" + dr["Id"] + " data-id='" + dr["Notes"] + "' data-Flag='" + dr["Flag"] + "' data-University='" + dr["UniversityId"] + "'><i class='fa fa-pencil fa-lg' aria-hidden='true'></i></a></td><td>" + dr["Notes"] + "</td><td>" + dr["CreatedBy"] + "</td><td>" + dr["CreatedDateTime"] + "</td><td>" + dr["ModifyBy"] + "</td><td>" + dr["ModifyDateTime"] + "</td>";
                Rslt += "</tr>";
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveNote(string RegId, string Notes, string NoteId, string Flag, string UniversityId)
    {
        string Rslt = string.Empty;
        try
        {
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            ClsCommanDataAccess _obj = new ClsCommanDataAccess();
            string AssignTo = UserId;
            Rslt = _obj.AddUpdateNote(RegId, Notes, UserId, NoteId, Flag, UniversityId, AssignTo, "None");
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    public class RegListBO
    {
        public string TotalRows { get; set; }
        public string SNo { get; set; }
        public string Reg_Id { get; set; }
        public string RegNo { get; set; }
        public string Gender { get; set; }
        public string Name { get; set; }
        public string EMail { get; set; }
        public string CountryCode { get; set; }
        public string Phone { get; set; }
        public string WhatsApp { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string TOEFLScore { get; set; }
        public string msg { get; set; }
        public string hq { get; set; }
        public string Course { get; set; }
        public string StudyAbroad { get; set; }
        public string FeeRange { get; set; }
        public string CreatedOn { get; set; }
        public string Active { get; set; }
        public string LastUpdateOn { get; set; }
        public string LastUpdatedBy { get; set; }
        public string Flag { get; set; }
        
    }
}
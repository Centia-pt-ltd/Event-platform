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

public partial class Qstudy_RegistrationList : System.Web.UI.Page
{
    public string Qualification = string.Empty;
    public string Course = string.Empty;
    public string MsgPlateform = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

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
             
                ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
                MsgPlateform = _obj.FillMsgPlateform();
                Qualification = _obj.FillHQualification();
                Course = _obj.FillCourse();
                BindRegion();
                BindHq();
                BindCourse();
                BindUniversity();
                hdfUserId.Value = Session["UserId"].ToString();
                Page.Title = "Qstudy::RegistrationList";
                
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
    public void BindRegion()
    {
        try
        {
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.FillRegion();
            ddlRegion.DataSource = dt;
            ddlRegion.DataTextField = "RName";
            ddlRegion.DataValueField = "Id";
            ddlRegion.DataBind();
            ddlRegion.Items.Insert(0, "-All Region-");
            ddlRegion.SelectedIndex = 0;
        }
        catch (Exception ex)
        {

        }

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static ClsRegistration[] GetEditData(string RegId)
    {
        List<ClsRegistration> details = new List<ClsRegistration>();
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            string MappedQualification = _obj.GetMappedQualificationByRegId(RegId);
            string MappedCourse = _obj.GetMappedCourseByRegId(RegId);
            string MappedMsg = _obj.GetMappedMsgPlateFormByRegId(RegId);
            DataTable dt = new DataTable();
            dt = _obj.GetRegistrationEditData(RegId);
            foreach (DataRow dr in dt.Rows)
            {
                ClsRegistration det = new ClsRegistration();
                det.Reg_Id = dr["Reg_Id"].ToString();
                det.Name = dr["Name"].ToString();
                det.Gender = dr["Gender"].ToString();
                det.Country_Code = dr["Country_Code"].ToString();
                det.phone_no = dr["phone_no"].ToString();
                det.emailid = dr["emailid"].ToString();
                det.Country = dr["Country"].ToString();
                det.City = dr["City"].ToString();
                det.CreatedOn = dr["CreatedOn"].ToString();
                det.UpdatedOn = dr["UpdatedOn"].ToString();
                det.TOEFLScore = dr["TOEFLScore"].ToString();
                //det.msg = dr["msg"].ToString();
                //det.hq = dr["hq"].ToString();
                //det.course = dr["course"].ToString();
                det.RegistrationNo = dr["RegistrationNo"].ToString();
                det.StudyAbroad = dr["StudyAbroad"].ToString();
                det.FeeRange = dr["FeeRange"].ToString();
                det.Active = dr["Active"].ToString();
                det.msg = MappedMsg;
                det.hq = MappedQualification;
                det.course = MappedCourse;
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static RegListBO[] BindRegistrationList(string RegionId, string RowPerPage, string PageNumber, string Course, string Qualification, string Country, string Status, string StudentName, string Flag)
    {
        List<RegListBO> details = new List<RegListBO>();
        try
        {
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.GetRegisterList(RegionId, RowPerPage, PageNumber, UserId, Course, Qualification, Country, Status, StudentName, Flag);

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
                det.AssignBy = dr["AssignBy"].ToString();
                det.LastUpdateOn = dr["updatedOn"].ToString();
                det.LastUpdatedBy = dr["LastUpdatedBy"].ToString();
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
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            Rslt = _obj.GetRegDetails(id);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string DeleteRegistration(string id)
    {
        string Rslt = string.Empty;
        try
        {
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            Rslt = _obj.DeleteReg(id);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string ChangeStatus(string id, string sts)
    {
        string Rslt = string.Empty;
        try
        {
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            Rslt = _obj.UpdateStatus(id, sts);
            string TmpRslt = string.Empty;

            ClsCommanDataAccess _objComman = new ClsCommanDataAccess();
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            string tmpStatus = string.Empty;
            if (sts.Trim().ToUpper() == "YES")
                tmpStatus = "Active";
            else if (sts.Trim().ToUpper() == "NO")
                tmpStatus = "InActive";
            //TmpRslt = _objComman.AddFlagStatus(id, tmpStatus, UserId);
            string AssignTo = UserId;
            TmpRslt = _objComman.AddUpdateNote(id, tmpStatus, UserId, "", tmpStatus, "0", AssignTo, "None");
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveActivity(string LeadId, string ImageUrl, string Msg, string PlateFormName)
    {
        string Rslt = string.Empty;
        try
        {
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            Rslt = _obj.SaveActivity(LeadId, ImageUrl, Msg, PlateFormName, UserId);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string UpdateRegistration(string RegId, string Gender, string FullName, string Mobile, string email, string country, string city, string ieltsScore, string Abroad, string fee, string active, string MsgId, string MsgText, string HqId, string HqText, string CrId, string CrText)
    {
        string Rslt = string.Empty;
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            Rslt = _obj.UpdateRegistration(RegId, Gender, FullName, Mobile, email, country, city, ieltsScore, Abroad, fee, active, MsgId, MsgText, HqId, HqText, CrId, CrText, UserId);
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
                Rslt += "<td><a href='javascript:void();' onclick='FetchEditNoteData(this.id);' id=" + dr["Id"] + " data-id='" + dr["Notes"] + "' data-Flag='" + dr["Flag"] + "'><i class='fa fa-pencil fa-lg' aria-hidden='true'></i></a></td><td>" + dr["Notes"] + "</td><td>" + dr["CreatedBy"] + "</td><td>" + dr["CreatedDateTime"] + "</td><td>" + dr["ModifyBy"] + "</td><td>" + dr["ModifyDateTime"] + "</td>";
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

    public class ClsRegistration
    {
        public string Reg_Id { get; set; }
        public string Name { get; set; }
        public string Gender { get; set; }
        public string Country_Code { get; set; }
        public string phone_no { get; set; }
        public string emailid { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string CreatedOn { get; set; }
        public string UpdatedOn { get; set; }
        public string TOEFLScore { get; set; }
        public string msg { get; set; }
        public string hq { get; set; }
        public string course { get; set; }
        public string RegistrationNo { get; set; }
        public string StudyAbroad { get; set; }
        public string FeeRange { get; set; }
        public string Active { get; set; }

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
        public string AssignBy { get; set; }
        public string LastUpdateOn { get; set; }
        public string LastUpdatedBy { get; set; }
        public string Flag { get; set; }
    }
}
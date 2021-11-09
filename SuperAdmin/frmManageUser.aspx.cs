using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SuperAdmin_frmManageUser : System.Web.UI.Page
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
            Page.Title = "SuperAdmin::ManageUser";
        }
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string AddUpdateUser(string FirstName, string LastName, string Gender, string Name, string Status, string mail, string pwd, string Uid, string userType, string university, string Role)
    {

        string Data = "";
        try
        {
            if (Convert.ToString(university)=="null" )
                university = "0";

            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            Data = _obj.SaveUpdateUser(FirstName, LastName, Gender, Name, Status, mail, pwd, Uid, userType, university, Role);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsUserBO[] BindList(string SearchValue, string UserType, string RowPerPage, string PageNumber)
    {
        string Data = "";
        List<ClsUserBO> details = new List<ClsUserBO>();
        try
        {
            DataTable dt = new DataTable();
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            dt = _obj.GetUserList(SearchValue, UserType, RowPerPage, PageNumber);
            int len = dt.Rows.Count;

           
            foreach (DataRow dr in dt.Rows)
            {
                ClsUserBO det = new ClsUserBO();
                det.SNo = dr["SNo"].ToString();
                det.Id = dr["UserId"].ToString();
                det.FirstName = dr["FirstName"].ToString();
                det.LastName = dr["LastName"].ToString();
                det.Gender = dr["Gender"].ToString();
                det.Name = dr["Name"].ToString();
                det.EmailId = dr["EmailId"].ToString();
                det.Pwd = dr["Password"].ToString();
                if (dr["Status"].ToString() == "1")
                {
                    det.Status = "Active";
                }
                else
                {
                    det.Status = "Inactive";
                }
                det.LoginType = dr["LoginType"].ToString();
                det.university = dr["university"].ToString();
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
    public static string BindUniversity()
    {
        string Data = "";
        try
        {
            DataTable dt = new DataTable();
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            dt = _obj.GetUniversityDDLList();
            int len = dt.Rows.Count;

            if (len > 0)
            {
                string Id = string.Empty;
                Data ="<option value =0 selected ='selected'>-Select University-</option>";
                for (int i = 0; i < len; i++)
                {
                    Id = dt.Rows[i]["Id"].ToString();
                    Data += "<option value="+Id+">"+ dt.Rows[i]["UniversityName"].ToString() + "</option>";
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
    public static ClsUserBO[] GetEditData(string Uid)
    {
        string Data = "";
        List<ClsUserBO> details = new List<ClsUserBO>();
        try
        {
            DataTable dt = new DataTable();
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            dt = _obj.GetUserDetails(Uid);

            foreach (DataRow dr in dt.Rows)
            {
                ClsUserBO det = new ClsUserBO();
                det.Id = dr["UserId"].ToString();
                det.FirstName = dr["FirstName"].ToString();
                det.LastName = dr["LastName"].ToString();
                det.Gender = dr["Gender"].ToString();
                det.Name = dr["Name"].ToString();
                det.EmailId = dr["EmailId"].ToString();
                det.Pwd = dr["Password"].ToString();
                det.Status = dr["Status"].ToString();
                det.LoginType = dr["LoginType"].ToString();
                det.university = dr["university"].ToString();
                det.Role = dr["Role"].ToString();
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
    public static string DeleteUsers(string Uid)
    {
        string Data = "";
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            Data = _obj.DelUser(Uid);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }
    public class ClsUserBO
    {
        public string SNo { get; set; }
        public string Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Gender { get; set; }
        public string Name { get; set; }
        public string EmailId { get; set; }
        public string Pwd { get; set; }
        public string Status { get; set; }
        public string LoginType { get; set; }
        public string university { get; set; }
        public string Role { get; set; }
    }
}
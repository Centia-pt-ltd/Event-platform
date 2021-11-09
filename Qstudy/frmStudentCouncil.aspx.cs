using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public partial class Qstudy_frmStudentCouncil : System.Web.UI.Page
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    public string strVideoAPI = string.Empty;
    public string strChannelName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

        if (!Page.IsPostBack)
        {

            if (Session["UserId"] == null )
            {
                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("login.aspx", false);
            }
            else
            {
                hdfUserId.Value = Session["UserId"].ToString();
                Page.Title = "Qstudy::LogedIn Users";
                CreateChat(hdfUserId.Value);
            }
        }
    }

    public void CreateChat(string Uid)
    {
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt = new DataTable();
        using (SqlCommand cmd = new SqlCommand(@"select isnull(VideoAppId,'') as VideoAppId ,isnull(ChannelName,'') as ChannelName from tbl_Chat where CounsellorId=@Uid", con))
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Uid", Uid);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                strVideoAPI = dt.Rows[0]["VideoAppId"].ToString()+ "?prejoin=false&audio=enabled&video=enabled&name=" + Convert.ToString(Session["UserName"])+ "&password=123456"; 
                strChannelName = dt.Rows[0]["ChannelName"].ToString();
            }
        }
    }

    [System.Web.Services.WebMethod]
    public static stDetails[] BindUniversity()
    {
        List<stDetails> details = new List<stDetails>();
        try
        {

            DataTable dt = new DataTable();
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            dt = _obj.BindEventUniversityTable();
            int len = dt.Rows.Count;

            if (len > 0)
            {
                string Id = string.Empty;
                //Data =  "<option value =0 selected ='selected'>-Select University-</option>";
                //for (int i = 0; i < len; i++)
                //{
                //    Id = dt.Rows[i]["Id"].ToString();
                //    Data += "<option value=" + Id + ">" + dt.Rows[i]["UniversityName"].ToString().Trim() + "</option>";
                //}
                foreach (DataRow dr in dt.Rows)
                {
                    stDetails det = new stDetails();
                    det.uid = Convert.ToInt32(dr["Id"].ToString());
                    det.uname = dr["UniversityName"].ToString().Trim();
                    details.Add(det);
                }
            }
            else
            {

            }

        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }

    public class stDetails
    {
        public int uid { get; set; }
        public string uname { get; set; }
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsUsersBO[] BindList(string SearchValue, string RowPerPage, string PageNumber,string UserId)
    {
        List<ClsUsersBO> details = new List<ClsUsersBO>();
        try
        {
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.GetStudentListForCouncil(SearchValue, RowPerPage, PageNumber, UserId);

            foreach (DataRow dr in dt.Rows)
            {
                ClsUsersBO det = new ClsUsersBO();
                det.TotalRows = dr["TotalRows"].ToString();
                det.SNo = dr["SNo"].ToString();
                det.StudentId = dr["StudentId"].ToString();
                det.Id = dr["Id"].ToString();
                det.Name = dr["Name"].ToString();
                det.RegNo = dr["RegNo"].ToString();
                det.UniversityName = dr["UniversityName"].ToString();
                det.Active = dr["Active"].ToString();
                det.EntryTime = dr["EntryTime"].ToString();
                det.Moved = dr["Moved"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string MoveToUniversity(List<ClsQstudyDataAccess.StudentModel> _Events)//(string Uid,string Sid,string UserId)
    {
        string Data = "";
        try
        {
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            Data = _obj.MoveToUniversity(_Events);// (Uid, Sid, UserId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }
    public class ClsUsersBO
    {
        public string Id { get; set; }
        public string SNo { get; set; }
        public string TotalRows { get; set; }
        public string StudentId { get; set; }
        public string Name { get; set; }
        public string RegNo { get; set; }
        public string Active { get; set; }
        public string EntryTime { get; set; }
        public string UniversityName { get; set; }
        public string Moved { get; set; }
    }


    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["UserId"]) != null || Session["UserId"] != "")
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
    public static ClsUniversityEdit[] EditUniversity(string id)
    {
        DataTable Rsdt = new DataTable();
        List<ClsUniversityEdit> liEdit= new List<ClsUniversityEdit>();
        try
        {
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            Rsdt = _obj.EditAssignedUniversity(id);
            if (Rsdt.Rows.Count > 0)
            {
                foreach (DataRow dr in Rsdt.Rows)
                {
                    ClsUniversityEdit det = new ClsUniversityEdit();
                    det.Id = dr["Id"].ToString();
                    det.StudentId = dr["StudentId"].ToString();
                    det.Name = dr["Name"].ToString();
                    det.RegNo = dr["RegNo"].ToString();
                    det.UniversityId = dr["UniversityId"].ToString();
                    det.UniversityName = dr["UniversityName"].ToString();
                    liEdit.Add(det);
                }
            }

        }
        catch (Exception ex)
        {
            
        }
        return liEdit.ToArray();
    }
    public class ClsUniversityEdit
    {
        public string Id { get; set; }
        public string StudentId { get; set; }
        public string Name { get; set; }
        public string RegNo { get; set; }
        public string UniversityId { get; set; }
        public string UniversityName { get; set; }
    }

}
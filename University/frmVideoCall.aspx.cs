using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Text;
using System.Data.SqlClient;
using System.Data.Sql;

public partial class university_frmVideoCall : System.Web.UI.Page
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    public string strVideoAPI = string.Empty;
    public string strChannelName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

        if (Session["UserId"] == null)
        {
            Session.Clear();
            Session.RemoveAll();
            Response.Redirect("login.aspx", false);
        }
        else
        {
            hdfUserId.Value = Session["UserId"].ToString();
            CreateChat(hdfUserId.Value);
            Page.Title = "University::BoothManager";
        }
    }
   
    public void CreateChat(string Uid)
    {
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt = new DataTable();
        using (SqlCommand cmd = new SqlCommand(@"select isnull(VideoAppId,'') as VideoAppId ,isnull(ChannelName,'') as ChannelName,UserName from tbl_UserDetails Inner join tbl_Chat on tbl_Chat.UniversityId=tbl_UserDetails.university where UserId=@Uid", con))
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Uid", Uid);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                strVideoAPI = dt.Rows[0]["VideoAppId"].ToString()+ "?prejoin=false&audio=enabled&video=enabled&name=" + dt.Rows[0]["UserName"].ToString()+"&password=123456";
                strChannelName = dt.Rows[0]["ChannelName"].ToString();
            }
        }
    }
    

    [System.Web.Services.WebMethod]
    public static rmDetails[] BindRoom()
    {
        List<rmDetails> details = new List<rmDetails>();
        try
        {

            DataTable dt = new DataTable();
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            string uid = HttpContext.Current.Session["UserId"].ToString();
            dt = _obj.BindRoom(uid);
            int len = dt.Rows.Count;

            if (len > 0)
            {
                string Id = string.Empty;
                foreach (DataRow dr in dt.Rows)
                {
                    rmDetails det = new rmDetails();
                    det.rid = Convert.ToInt32(dr["Id"].ToString());
                    det.rname = dr["RoomName"].ToString().Trim();
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

    public class rmDetails
    {
        public int rid { get; set; }
        public string rname { get; set; }
    }

    [System.Web.Services.WebMethod]
    public static ClsUsersBO[] BindStudentList()
    {
        string uniId = HttpContext.Current.Session["University"].ToString();
        List<ClsUsersBO> details = new List<ClsUsersBO>();
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.GetStudentListForCouncil(uniId);

            foreach (DataRow dr in dt.Rows)
            {
                ClsUsersBO det = new ClsUsersBO();
                det.SNo = dr["SNo"].ToString();
                det.StudentId = dr["StudentId"].ToString();
                det.Id = dr["Id"].ToString();
                det.Name = dr["Name"].ToString();
                det.RegNo = dr["RegNo"].ToString();
                det.UniversityName = dr["UniversityName"].ToString();
                det.Active = dr["Active"].ToString();
                det.EntryTime = dr["EntryTime"].ToString();
                det.RoomId = dr["RoomId"].ToString();
                det.Moved = dr["Moved"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod]
    public static string MoveToUniversityUser(List<ClsUniversityDataAccess.StudentModel> _Events,string RoomId)//(string Uid,string Sid,string UserId)
    {
        string UniversityId = HttpContext.Current.Session["University"].ToString();
        string Data = "";
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            Data = _obj.MoveToUniversityUser(_Events,UniversityId,RoomId);
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
        public string StudentId { get; set; }
        public string Name { get; set; }
        public string RegNo { get; set; }
        public string Active { get; set; }
        public string EntryTime { get; set; }
        public string UniversityName { get; set; }
        public string Moved { get; set; }
        public string RoomId { get; set; }
    }
    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        if (Session["UserId"] != null )
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
}
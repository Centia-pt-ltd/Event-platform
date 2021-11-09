using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Text;
using System.Data.SqlClient;
using System.Data.Sql;

public partial class UniversityBooth_BoothView : System.Web.UI.Page
{

    public string strTawkCode = string.Empty;
    public string strVideoAPI = string.Empty;
    public string strChannelName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();
        if (!Page.IsPostBack)
        {
            try
            {

                if (Session["Reg_Id"] == null)
                {
                    Session.Clear();
                    Session.RemoveAll();
                    Response.Redirect("../Welcome.aspx", false);
                }
                else
                {
                    hdfUserId.Value = Session["Reg_Id"].ToString();
                    if (Session["Lang"] == null)
                    {
                        hfLang.Value = SelectLang(hdfUserId.Value);
                    }
                    else
                    {
                        hfLang.Value = Session["Lang"].ToString();
                    }


                    string s = Convert.ToString(Request.QueryString["Uid"]);
                    if (s != null)
                    {
                        GetMaxMin();
                        hdfUid.Value = Request.QueryString["Uid"].ToString();
                        hdfPid.Value = Request.QueryString["Pid"].ToString();

                        CreateChat(hdfUid.Value);
                    }
                    else
                    {
                        GetMaxMin();
                        GetFirstUniversity();
                        hdfPid.Value = Convert.ToString(hdfMin.Value);
                        CreateChat(hdfUid.Value);
                    }
                    Tracking(hdfUserId.Value, hdfUid.Value,"Assigned");
                }
            }
            catch (Exception ex)
            {

            }
        }
    }
    public void Tracking(string Reg_Id, string UniId, string type)
    {
        try
        {
            ClsCommanDataAccess clscomm = new ClsCommanDataAccess();
            clscomm.InsertTrackingBooth(Reg_Id, UniId, type);
        }
        catch (Exception ex)
        {

        }
    }
    public string SelectLang(string regId)
    {
        string lang = "";
        ClsCommanDataAccess clscomm = new ClsCommanDataAccess();
        lang= clscomm.SelectLang(regId);
        return lang;
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string CreateVideoChat(string Uid)
    {
        OnlineStudent("Yes", Uid);
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt = new DataTable();
        string Rslt = string.Empty;
        using (SqlCommand cmd = new SqlCommand(@"select isnull(VideoAppIdStudent,'') as VideoAppId  from tbl_Chat where UniversityId=@Uid", con))
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Uid", Uid);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                Rslt = dt.Rows[0]["VideoAppId"].ToString() + "?prejoin=false&audio=enabled&video=enabled&name=" + Convert.ToString(HttpContext.Current.Session["Name"]);
            }
            return Rslt;
        }
    }
    public static void OnlineStudent(String Active,string UniId)
    {
        try
        {
            string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
            string qry = string.Empty;
            string RegNo = HttpContext.Current.Session["FullName"].ToString();
            string name = HttpContext.Current.Session["Name"].ToString();
            string StudentId = HttpContext.Current.Session["Reg_Id"].ToString();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentCouncilUni", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@StudentId", StudentId.Trim());
                    cmd.Parameters.AddWithValue("@RegNo", RegNo.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@Name", name.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@Active", Active);
                    cmd.Parameters.AddWithValue("@UniversityId", UniId.Trim());
                    cmd.Parameters.AddWithValue("@CreatedBy", "0");
                    cmd.Parameters.AddWithValue("@Flag", "1");
                    cmd.Parameters.AddWithValue("@RoomId", "0");
                    cmd.Parameters.AddWithValue("@Moved", "No");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    string Result = sqlParameter.Value.ToString();

                }
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {

        }
    }
    public void CreateChat(string Uid)
    {        
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt = new DataTable();
        using (SqlCommand cmd = new SqlCommand(@"select ChatScript,VideoAppIdStudent as VideoAppId,ChannelName from tbl_Chat where UniversityId=@Uid", con))
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Uid", Uid);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                strTawkCode = dt.Rows[0]["ChatScript"].ToString();
                strVideoAPI = dt.Rows[0]["VideoAppId"].ToString() + "?prejoin=false&audio=enabled&video=enabled&name=" + Convert.ToString(Session["Name"]);
                strChannelName = dt.Rows[0]["ChannelName"].ToString();
            }
        }
        Session["UniID"] = Uid;
        Session["UniName"] = strChannelName;
    }
    public void GetMaxMin()
    {

        //string id = Session["UserId"].ToString();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt = new DataTable();
        DataTable dt0 = new DataTable();
        try
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                string qr0 = "";
                qr0 = @"select top(1) Id as EventId ";
                qr0 += "from Tab_Mst_Event ";
                qr0 += "where Status = 'Yes'";
                cmd.CommandText = qr0;
                cmd.Connection = con;
                SqlDataAdapter da0 = new SqlDataAdapter(cmd);
                da0.Fill(dt0);
                if (dt0.Rows.Count > 0)
                {
                    hdfEventId.Value = dt0.Rows[0]["EventId"].ToString();
                }
                string eventId = hdfEventId.Value;

                string qr = "";
                qr = @"DECLARE @LIST VARCHAR(200) ";
                qr += " Select @LIST=UniversityId from tblStudentCouncil where StudentId= " + hdfUserId.Value;
                qr += " select max(Position)as maxp,min(Position) as minp ";
                qr += " from Tab_Mst_Event ";
                qr += " Inner Join Tab_EventDetails on Tab_EventDetails.EventId = Tab_Mst_Event.Id ";
                qr += " where Tab_Mst_Event.Id = " + eventId ;
                qr += " and  Tab_EventDetails.UniversityId in (select id FROM dbo.CSVToTable(@LIST) ) ";


                cmd.CommandText = qr;
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    hdfMax.Value = dt.Rows[0]["maxp"].ToString();
                    hdfMin.Value = dt.Rows[0]["minp"].ToString();
                }
               
            }
        }
        catch (Exception ex)
        {
        }

    }
    public void GetFirstUniversity()
    {

        //string id = Session["UserId"].ToString();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt1 = new DataTable();
        try
        {
            using (SqlCommand cmd = new SqlCommand())
            {
               
                string qr1 = "";
                qr1 = @"select UniversityId ";
                qr1 += "from Tab_EventDetails ";
                qr1 += "where EventId = " + hdfEventId.Value + " and Position=" + hdfMin.Value;
                cmd.CommandText = qr1;
                cmd.Connection = con;
                SqlDataAdapter da1 = new SqlDataAdapter(cmd);
                da1.Fill(dt1);
                if (dt1.Rows.Count > 0)
                {
                    hdfUid.Value = dt1.Rows[0]["UniversityId"].ToString();
                }
            }
        }
        catch (Exception ex)
        {
        }

    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsNexthBO[] NextBoothDetail(string EventId,string nextId)
    {
        
        //string id = Session["UserId"].ToString();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);        
        DataTable dt = new DataTable();
        List<ClsNexthBO> details = new List<ClsNexthBO>();
        try
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                string qr = "";
                qr = @"DECLARE @LIST VARCHAR(200) ";
                qr += " Select @LIST=UniversityId from tblStudentCouncil where StudentId= " + HttpContext.Current.Session["Reg_Id"];
                qr += " select top(1) Tab_EventDetails.Position, Tab_EventDetails.BoothId, Tab_EventDetails.UniversityId ";
                qr += "from Tab_Mst_Event ";
                qr += "Inner Join Tab_EventDetails on Tab_EventDetails.EventId= Tab_Mst_Event.Id and UniversityId in (select id FROM dbo.CSVToTable(@LIST) )";
                qr += "where Tab_Mst_Event.Id = " + EventId ;
                qr += " and Position > " + nextId + " order by Position ";
                cmd.CommandText = qr;
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        ClsNexthBO det = new ClsNexthBO();
                        det.BoothId = dr["BoothId"].ToString();
                        det.Position = dr["Position"].ToString();
                        det.UniversityId = dr["UniversityId"].ToString();
                        details.Add(det);
                    }
                    
                }
            }
        }
        catch (Exception ex)
        {
        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsNexthBO[] PrevBoothDetail(string EventId,string prevId)
    {

        //string id = Session["UserId"].ToString();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt = new DataTable();
        List<ClsNexthBO> details = new List<ClsNexthBO>();
        try
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                string qr = "";
                qr = @"DECLARE @LIST VARCHAR(200) ";
                qr += " Select @LIST=UniversityId from tblStudentCouncil where StudentId= " + HttpContext.Current.Session["Reg_Id"];
                qr += " select top(1) Tab_EventDetails.Position, Tab_EventDetails.BoothId, Tab_EventDetails.UniversityId ";
                qr += "from Tab_Mst_Event ";
                qr += "Inner Join Tab_EventDetails on Tab_EventDetails.EventId= Tab_Mst_Event.Id and UniversityId in (select id FROM dbo.CSVToTable(@LIST) )"; 
                qr += "where Tab_Mst_Event.Id = " + EventId + " and Position < " + prevId + " order by Position desc ";
                cmd.CommandText = qr;
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        ClsNexthBO det = new ClsNexthBO();
                        det.BoothId = dr["BoothId"].ToString();
                        det.Position = dr["Position"].ToString();
                        det.UniversityId = dr["UniversityId"].ToString();
                        details.Add(det);
                    }
                    
                }

            }
        }
        catch (Exception ex)
        {
        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsBoothBO[] selectBoothDetail(string UniId,string EventId)
    {
        Dictionary<string, string> dictNew = new Dictionary<string, string>()
        {
            { "Booth1", "booth_brand" },
            { "Booth2", "booth_brand1" },
            { "Booth3", "booth_brand2" },
            { "Booth4", "booth_brand3" },
            { "Booth5", "booth_brand4" },
            { "Booth6", "booth_brand5" },
            { "Booth7", "booth_brand6" },
            { "Booth8", "booth_brand7" },
            { "Booth9", "booth_brand8" },
            { "Booth10", "booth_brand9" },
            { "Booth11", "booth_brand10" },
            { "Booth12", "booth_brand11" },
            { "Booth13", "booth_brand12" }
        };
        Dictionary<string, string> dictNew1 = new Dictionary<string, string>()
        {
            { "Booth1", "booth_name" },
            { "Booth2", "booth_name1" },
            { "Booth3", "booth_name2" },
            { "Booth4", "booth_name3" },
            { "Booth5", "booth_name4" },
            { "Booth6", "booth_name5" },
            { "Booth7", "booth_name6" },
            { "Booth8", "booth_name7" },
            { "Booth9", "booth_name8" },
            { "Booth10", "booth_name9" },
            { "Booth11", "booth_name10" },
            { "Booth12", "booth_name11" },
            { "Booth13", "booth_name12" }
        };

        //string id = Session["UserId"].ToString();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        List<ClsBoothBO> details = new List<ClsBoothBO>();
        DataTable dt = new DataTable();
        try {
            using (SqlCommand cmd = new SqlCommand())
            {
                string qr = "";
                qr = @"DECLARE @LIST VARCHAR(200) ";
                qr += " Select @LIST=UniversityId from tblStudentCouncil where StudentId= " + HttpContext.Current.Session["Reg_Id"];
                qr +=" select distinct Tab_University.UniversityName, BoothName, BoothPage, BoothImage, ImageBig,ImageSmall,ChatScript ";
                qr += "from Tab_Mst_Event ";
                qr += "Inner Join  Tab_EventDetails on Tab_EventDetails.EventId = Tab_Mst_Event.Id ";
                qr += "Inner join  Tab_University on Tab_EventDetails.UniversityId = Tab_University.Id  and Tab_University.Id in (select id FROM dbo.CSVToTable(@LIST) )";
                qr += "Left Join Tab_MstBooth on Tab_MstBooth.Id=Tab_University.BoothId ";
                qr += "Left Join tbl_Chat on Tab_University.Id=tbl_Chat.UniversityId ";
                qr += "where Tab_University.Id = "+ UniId + " and Tab_Mst_Event.Id = " + EventId;
               
                cmd.CommandText = qr;
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if(dt.Rows.Count>0)
                {
                    ClsBoothBO det = new ClsBoothBO();
                    det.BoothImage = dt.Rows[0]["BoothImage"].ToString();
                    det.BigImg= dt.Rows[0]["ImageBig"].ToString();
                    det.SmallImg=  dt.Rows[0]["ImageSmall"].ToString();
                    det.UniversityName= dt.Rows[0]["UniversityName"].ToString();
                    det.ChatScript = dt.Rows[0]["ChatScript"].ToString();
                    if (dictNew.ContainsKey(dt.Rows[0]["BoothName"].ToString()))
                    {
                        det.BigImgClass = dictNew[dt.Rows[0]["BoothName"].ToString()];
                    }
                    if (dictNew.ContainsKey(dt.Rows[0]["BoothName"].ToString()))
                    {
                        det.SmallImgClass = dictNew1[dt.Rows[0]["BoothName"].ToString()];
                    }
                    details.Add(det);


                    //bigImg.Src = "img/"+dt.Rows[0]["BoothImage"].ToString();
                    //imgBrand1.Src="../UploadedBooth/" + dt.Rows[0]["ImageBig"].ToString();
                    //imgBrand2.Src = "../UploadedBooth/" + dt.Rows[0]["ImageSmall"].ToString();
                    //universityName.InnerText= dt.Rows[0]["UniversityName"].ToString();
                    //if (dictNew.ContainsKey(dt.Rows[0]["BoothName"].ToString()))
                    //{
                    //    imgBrand1.Attributes.Add("class",dictNew[dt.Rows[0]["BoothName"].ToString()]);
                    //}
                    //if (dictNew.ContainsKey(dt.Rows[0]["BoothName"].ToString()))
                    //{
                    //    imgBrand2.Attributes.Add("class", dictNew1[dt.Rows[0]["BoothName"].ToString()]);
                    //}
                    //class="booth_name1"
                    //det.SmallImg = dr["LogoImageFunc"].ToString();
                }

            }
        }
        catch (Exception ex)
        {            
        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetAboutUs(string UniversityId)
    {
        string Rslt = string.Empty;
        try
        {
            ClsStudentUIZone _ObjStudent = new ClsStudentUIZone();
            Rslt = _ObjStudent.GetAboutUs(UniversityId);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsStudentUIZone.Photo[] ViewPhoto(string UniversityId)
    {
        List<ClsStudentUIZone.Photo> details = new List<ClsStudentUIZone.Photo>();
        ClsStudentUIZone _objStudent = new ClsStudentUIZone();
        DataTable dt = null;
        try
        {
            dt = _objStudent.GetPhoto(UniversityId);
            foreach (DataRow dr in dt.Rows)
            {
                ClsStudentUIZone.Photo det = new ClsStudentUIZone.Photo();
                det.DisplayImageName = dr["DisplayImageName"].ToString();
                det.DownloadImageName = dr["DownloadImageName"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsStudentUIZone.Brochure[] BindBrichureList(string UniversityId)
    {
        List<ClsStudentUIZone.Brochure> details = new List<ClsStudentUIZone.Brochure>();
        ClsStudentUIZone _objStudent = new ClsStudentUIZone();
        DataTable dt = null;
        try
        {
            dt = _objStudent.GetBrochure(UniversityId);
            foreach (DataRow dr in dt.Rows)
            {
                ClsStudentUIZone.Brochure det = new ClsStudentUIZone.Brochure();
                det.Id = dr["Id"].ToString();
                det.DisplayFileName = dr["DisplayFileName"].ToString();
                det.DownloadFileName = dr["DownloadFileName"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsStudentUIZone.Video[] ViewVideo(string UniversityId)
    {
        List<ClsStudentUIZone.Video> details = new List<ClsStudentUIZone.Video>();
        ClsStudentUIZone _objStudent = new ClsStudentUIZone();
        DataTable dt = null;
        try
        {
            dt = _objStudent.GetVideo(UniversityId);
            foreach (DataRow dr in dt.Rows)
            {
                ClsStudentUIZone.Video det = new ClsStudentUIZone.Video();
                det.Id = dr["Id"].ToString();
                det.Url = dr["Url"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string joinRoom(string Uid)
    {
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt = new DataTable();
        string Rslt = string.Empty;
        string Sid = HttpContext.Current.Session["Reg_Id"].ToString();
        string qr = "";
        qr = @"Select isnull(VideoUrlForStudent,'') as VideoUrlForStudent from tbl_ChatRoom ";
        qr += " Inner join tblStudentCouncilUni on tblStudentCouncilUni.UniversityId=tbl_ChatRoom.UniversityId and ";
        qr += " tblStudentCouncilUni.RoomId= tbl_ChatRoom.Id where tbl_ChatRoom.UniversityId=@Uid ";
        qr += " and tblStudentCouncilUni.StudentId=@Sid ";
        using (SqlCommand cmd = new SqlCommand(qr, con))
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Uid", Uid);
            cmd.Parameters.AddWithValue("@Sid", Sid);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["VideoUrlForStudent"].ToString() == "")
                {
                    Rslt = "";
                }
                else
                {
                    Rslt = dt.Rows[0]["VideoUrlForStudent"].ToString() + "?prejoin=false&audio=enabled&video=enabled&name=" + Convert.ToString(HttpContext.Current.Session["Name"]);
                }
               
            }
        }
        return Rslt;
    }

    public class ClsBoothBO
    {
        public string UniversityName { get; set; }
        public string BoothName { get; set; }
        public string BoothPage { get; set; }
        public string BoothImage { get; set; }
        public string SmallImg { get; set; }
        public string BigImg { get; set; }
        public string BigImgClass { get; set; }
        public string SmallImgClass { get; set; }
        public string ChatScript { get; set; }
    }
    public class ClsNexthBO
    {
        public string Position { get; set; }
        public string BoothId { get; set; }
        public string UniversityId { get; set; }
    }
}
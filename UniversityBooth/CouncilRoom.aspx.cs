using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.Script.Services;

public partial class UniversityBooth_CouncilRoom : System.Web.UI.Page
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
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
            //Session["Reg_Id"] = "18";
            if (Session["Reg_Id"] == null)
            {
                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("../Welcome.aspx", false);
            }
            else
            {
                hdfUserId.Value = Session["Reg_Id"].ToString();
                Page.Title = "Student::Counseling Room";
                hfLang.Value = SelectLang(hdfUserId.Value);
                Tracking(hdfUserId.Value, "Counseling Room");
                // ValidateLogin("Yes");
                CreateChat(hdfUserId.Value);
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
    public void ValidateLogin(String Active)
    {
        try
        {
            string qry = string.Empty;
            string RegNo = Session["FullName"].ToString();
            string name= Session["Name"].ToString();
            string StudentId= Session["Reg_Id"].ToString();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentCouncil", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure; 
                    cmd.Parameters.AddWithValue("@StudentId", StudentId.Trim());
                    cmd.Parameters.AddWithValue("@RegNo", RegNo.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@Name", name.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@Active", Active);
                    cmd.Parameters.AddWithValue("@UniversityId", "0");
                    cmd.Parameters.AddWithValue("@CreatedBy", "0");
                    cmd.Parameters.AddWithValue("@Flag", "1");
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
        using (SqlCommand cmd = new SqlCommand(@"select ChatScript, isnull(VideoAppIdStudent,'') as VideoAppId ,isnull(ChannelName,'') as ChannelName from tbl_Chat where CounsellorId=(select top 1 AssignedTo from Tab_AssignedLead where LeadId=@Uid)", con))
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Uid", Uid);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                strVideoAPI = dt.Rows[0]["VideoAppId"].ToString() + "?prejoin=false&audio=enabled&video=enabled&name=" + Convert.ToString(HttpContext.Current.Session["Name"]); 
                strChannelName = dt.Rows[0]["ChannelName"].ToString();
                strTawkCode = dt.Rows[0]["ChatScript"].ToString();
            }
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string CreateChatHtml()
    {
        string chat = "";
        string Uid = HttpContext.Current.Session["Reg_Id"].ToString();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt = new DataTable();
        using (SqlCommand cmd = new SqlCommand(@"select ChatScript, isnull(VideoAppIdStudent,'') as VideoAppId ,isnull(ChannelName,'') as ChannelName from tbl_Chat where CounsellorId=(select top 1 AssignedTo from Tab_AssignedLead where LeadId=@Uid)", con))
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Uid", Uid);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                chat= dt.Rows[0]["ChatScript"].ToString();
            }
        }
        return chat;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SelectUniversityToMove(string UserId)
    {
        string url = "";
       
        try
        {
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.GetStudentUniversity(UserId);
            if (dt.Rows.Count > 0)
            {
                string uid = dt.Rows[0]["UniversityId"].ToString();
                string pos = dt.Rows[0]["Position"].ToString();
                url = "BoothView.aspx?Uid=" + uid + "&Pid=" + pos;
            }
            else
            {
                url = "";
            }
        }
        catch (Exception ex)
        {

        }
        return url;
    }
}
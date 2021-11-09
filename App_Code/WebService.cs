using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.Script.Services;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    public WebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }
    [WebMethod]
    public string CreateChat(string Uid)
    {

        //string Uid = HttpContext.Current.Session["Reg_Id"].ToString();
        string strTawkCode = "";
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt = new DataTable();
        using (SqlCommand cmd = new SqlCommand(@"select ChatScript from tbl_Chat where CounsellorId=(select top 1 AssignedTo from Tab_AssignedLead where LeadId=@Uid)", con))
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Uid", Uid);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                strTawkCode = dt.Rows[0]["ChatScript"].ToString();
            }
        }
        return strTawkCode;

    }
    [WebMethod(EnableSession = true)]
    public string ChangeLang(string lang, string StRegNo)
    {
        try
        {
            string Data = "";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentLogin", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FullName", StRegNo.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@Lang", lang);
                    cmd.Parameters.AddWithValue("@Action", "Update");
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

                    Session["Lang"] = lang;
                    return Result;
                }
            }
        }
        catch (Exception ex)
        {
            return "ER";
        }
    }

    [WebMethod(EnableSession = true)]
    public string SendMessage(string ReceiverId, string ReceiverName, string Msg, string SenderType,string SenderId,string SenderName)
    {
        string Result = string.Empty;

        //string SenderId = HttpContext.Current.Session["Reg_Id"].ToString();
        //string SenderName = HttpContext.Current.Session["Name"].ToString();
        try
        {
            string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("ChatForAll", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SenderId", SenderId);
                    cmd.Parameters.AddWithValue("@SenderName", SenderName);
                    cmd.Parameters.AddWithValue("@ReceiverId", ReceiverId);
                    cmd.Parameters.AddWithValue("@ReceiverName", ReceiverName);
                    cmd.Parameters.AddWithValue("@Message", Msg);
                    cmd.Parameters.AddWithValue("@SenderType", SenderType);
                    cmd.Parameters.AddWithValue("@Action", "ADD");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                   // Result = sqlParameter.Value.ToString();
                    Result = "S";
                }
            }
        }
        catch (Exception ex)
        {
            Result = "ER";
        }
        return Result;
    }

    [WebMethod(EnableSession = true)]
    public string GetAllChatHistory(string ReceiverId, string UserType,string SenderId)
    {
        string Result = string.Empty;

        //string SenderId = HttpContext.Current.Session["Reg_Id"].ToString();
        string SenderType = string.Empty;
        try
        {
            string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("ChatForAll", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SenderId", SenderId);
                    cmd.Parameters.AddWithValue("@ReceiverId", ReceiverId);
                    cmd.Parameters.AddWithValue("@Action", "Select");
                    cmd.Parameters.AddWithValue("@SenderType", "STUDENT," + UserType);
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                int len=dt.Rows.Count;
                                for (int i = 0; i < len; i++)
                                {
                                    SenderType = dt.Rows[i]["SenderType"].ToString();
                                    if (SenderType.Trim().ToUpper() == "QSTUDY")
                                    {
                                        Result += "<li class='bot-chat'><div class='chat-img mr-2'>";
                                        Result += "<img src='img/chatbot.png'/></div>";
                                        Result += "<div class='bot-content'><p>" + dt.Rows[i]["Message"].ToString() + "</p></div>";
                                        Result += "</li>";
                                    }
                                    else if (SenderType.Trim().ToUpper() == "UNIVERSITY")
                                    {
                                        Result += "<li class='bot-chat'><div class='chat-img mr-2'>";
                                        Result += "<img src='img/chatbot.png'/></div>";
                                        Result += "<div class='bot-content'><p>" + dt.Rows[i]["Message"].ToString() + "</p></div>";
                                        Result += "</li>";
                                    }
                                    else if (SenderType.Trim().ToUpper() == "STUDENT")
                                    {
                                        Result += "<li class='user-chat'><div class='user-content'>";
                                        Result += "<p>" + dt.Rows[i]["Message"].ToString() + "</p></div>";
                                        Result += "<div class='chat-img ml-2'>";
                                        Result += "<img src='img/User_chat.png' />";
                                        Result += "</div>";
                                        Result += "</li>";
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Result = "ER";
        }
        return Result;
    }

    [WebMethod(EnableSession = true)]
    public ClsChat[] GetLatestChatHistory(string ReceiverId,string UserType, string SenderId)
    {
        string Result = string.Empty;
        List<ClsChat> details = new List<ClsChat>();
        DataTable dt = new DataTable();
        
        string Sts = string.Empty;
        try
        {
            //string SenderId = HttpContext.Current.Session["Reg_Id"].ToString();
            string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("ChatForAll", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SenderId", SenderId);
                    cmd.Parameters.AddWithValue("@ReceiverId", ReceiverId);
                    cmd.Parameters.AddWithValue("@Action", "SelectLatest");
                    cmd.Parameters.AddWithValue("@SenderType", "STUDENT,"+UserType);
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            foreach (DataRow dr in dt.Rows)
            {
                ClsChat det = new ClsChat();
                det.SenderType = dr["SenderType"].ToString().Trim().ToUpper();
                det.Message = dr["Message"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
            Result = "ER";
        }
        return details.ToArray(); ;
    }

    [WebMethod(EnableSession = true)]
    public string SendMessageByAdmin(string SenderId,string SenderName,string Msg,string SenderType,string ReceiverId,string ReceiverName,string sendToAll)
    {
        string Result = string.Empty;

        try
        {
            string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("ChatForAll", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SenderId", SenderId);
                    cmd.Parameters.AddWithValue("@SenderName", SenderName);
                    cmd.Parameters.AddWithValue("@ReceiverId", ReceiverId);
                    cmd.Parameters.AddWithValue("@ReceiverName", ReceiverName);
                    cmd.Parameters.AddWithValue("@Message", Msg);
                    cmd.Parameters.AddWithValue("@SenderType", SenderType);
                    if (sendToAll == "No")
                    {
                        cmd.Parameters.AddWithValue("@Action", "ADD");
                    }
                    if (sendToAll == "Yes" && SenderType== "QSTUDY")
                    {
                        cmd.Parameters.AddWithValue("@Action", "ADDALLQ");
                    }
                    if (sendToAll == "Yes" && SenderType == "UNIVERSITY")
                    {
                        cmd.Parameters.AddWithValue("@Action", "ADDALLU");
                    }
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    // Result = sqlParameter.Value.ToString();
                    Result = "S";
                }
            }
        }
        catch (Exception ex)
        {
            Result = "ER";
        }
        return Result;
    }

    [WebMethod(EnableSession = true)]
    public string GetAllQstudyChatHistory(string ReceiverId, string SenderId)
    {
        string Result = string.Empty;
        string SenderType = string.Empty;
        try
        {
            string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("ChatForAll", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SenderId", SenderId);
                    cmd.Parameters.AddWithValue("@ReceiverId", ReceiverId);
                    cmd.Parameters.AddWithValue("@Action", "Select");
                    cmd.Parameters.AddWithValue("@SenderType", "STUDENT,QSTUDY");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                int len = dt.Rows.Count;
                                for (int i = 0; i < len; i++)
                                {
                                    SenderType = dt.Rows[i]["SenderType"].ToString();
                                    if (SenderType.Trim().ToUpper() == "QSTUDY")
                                    {
                                        Result += "<li class='bot-chat'><div class='chat-img mr-2'>";
                                        Result += "<img src='img/chatbot.png'/></div>";
                                        Result += "<div class='bot-content'><p>" + dt.Rows[i]["Message"].ToString() + "</p></div>";
                                        Result += "</li>";
                                    }
                                    else if (SenderType.Trim().ToUpper() == "STUDENT")
                                    {
                                        Result += "<li class='user-chat'><div class='user-content'>";
                                        Result += "<p>" + dt.Rows[i]["Message"].ToString() + "</p></div>";
                                        Result += "<div class='chat-img ml-2'>";
                                        Result += "<img src='img/User_chat.png' />";
                                        Result += "</div>";
                                        Result += "</li>";
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Result = "ER";
        }
        return Result;
    }

    [WebMethod(EnableSession = true)]
    public ClsChat[] GetLatestQstudyChatHistory(string ReceiverId, string SenderId)
    {
        string Result = string.Empty;
        List<ClsChat> details = new List<ClsChat>();
        DataTable dt = new DataTable();

        string Sts = string.Empty;
        try
        {
            string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("ChatForAll", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SenderId", SenderId);
                    cmd.Parameters.AddWithValue("@ReceiverId", ReceiverId);
                    cmd.Parameters.AddWithValue("@Action", "SelectLatest");
                    cmd.Parameters.AddWithValue("@SenderType", "STUDENT,QSTUDY");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            foreach (DataRow dr in dt.Rows)
            {
                ClsChat det = new ClsChat();
                det.SenderType = dr["SenderType"].ToString().Trim().ToUpper();
                det.Message = dr["Message"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
            Result = "ER";
        }
        return details.ToArray(); ;
    }


    [WebMethod(EnableSession = true)]
    public string GetAllUniChatHistory(string ReceiverId, string SenderId)
    {
        string Result = string.Empty;
        string SenderType = string.Empty;
        try
        {
            string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("ChatForAll", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SenderId", SenderId);
                    cmd.Parameters.AddWithValue("@ReceiverId", ReceiverId);
                    cmd.Parameters.AddWithValue("@Action", "Select");
                    cmd.Parameters.AddWithValue("@SenderType", "STUDENT,UNIVERSITY");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                int len = dt.Rows.Count;
                                for (int i = 0; i < len; i++)
                                {
                                    SenderType = dt.Rows[i]["SenderType"].ToString();
                                    if (SenderType.Trim().ToUpper() == "UNIVERSITY")
                                    {
                                        Result += "<li class='bot-chat'><div class='chat-img mr-2'>";
                                        Result += "<img src='img/chatbot.png'/></div>";
                                        Result += "<div class='bot-content'><p>" + dt.Rows[i]["Message"].ToString() + "</p></div>";
                                        Result += "</li>";
                                    }
                                    else if (SenderType.Trim().ToUpper() == "STUDENT")
                                    {
                                        Result += "<li class='user-chat'><div class='user-content'>";
                                        Result += "<p>" + dt.Rows[i]["Message"].ToString() + "</p></div>";
                                        Result += "<div class='chat-img ml-2'>";
                                        Result += "<img src='img/User_chat.png' />";
                                        Result += "</div>";
                                        Result += "</li>";
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Result = "ER";
        }
        return Result;
    }

    [WebMethod(EnableSession = true)]
    public ClsChat[] GetLatestUniChatHistory(string ReceiverId, string SenderId)
    {
        string Result = string.Empty;
        List<ClsChat> details = new List<ClsChat>();
        DataTable dt = new DataTable();

        string Sts = string.Empty;
        try
        {
            string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("ChatForAll", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SenderId", SenderId);
                    cmd.Parameters.AddWithValue("@ReceiverId", ReceiverId);
                    cmd.Parameters.AddWithValue("@Action", "SelectLatest");
                    cmd.Parameters.AddWithValue("@SenderType", "STUDENT,UNIVERSITY");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            foreach (DataRow dr in dt.Rows)
            {
                ClsChat det = new ClsChat();
                det.SenderType = dr["SenderType"].ToString().Trim().ToUpper();
                det.Message = dr["Message"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
            Result = "ER";
        }
        return details.ToArray(); ;
    }
    public class ClsChat
    {
        public string SenderType { get; set; }
        public string Message { get; set; }
    }
}
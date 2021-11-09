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

public partial class ChatPage : System.Web.UI.Page
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
           
            if (hdfSenderType.Value.ToUpper() == "QSTUDY")
            {
                Response.Redirect("qstudy/login.aspx", false);
               
            }
            else
            {
                Response.Redirect("university/login.aspx", false);
            }
        }
        else
        {
            hdfUserId.Value = Session["UserId"].ToString();
            hdfSenderType.Value = Session["LoginType"].ToString().ToUpper();
            if (hdfSenderType.Value == "UNIVERSITY")
            {
                GetUniversity(hdfUserId.Value);
            }
            else
            {
                hdfSenderId.Value = Session["UserId"].ToString();
                hdfSenderName.Value = Session["UserName"].ToString();
            }
        }
    }
    public void GetUniversity(string userId)
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
                qr1 = @"select Tab_University.Id as universityId,Tab_University.UniversityName from tbl_UserDetails ";
                qr1 += "Inner join Tab_University on Tab_University.Id=university ";
                qr1 += " where tbl_UserDetails.UserId= " + userId;
                cmd.CommandText = qr1;
                cmd.Connection = con;
                SqlDataAdapter da1 = new SqlDataAdapter(cmd);
                da1.Fill(dt1);
                if (dt1.Rows.Count > 0)
                {
                    hdfSenderId.Value = dt1.Rows[0]["universityId"].ToString();
                    hdfSenderName.Value = dt1.Rows[0]["UniversityName"].ToString();
                }
            }
        }
        catch (Exception ex)
        {
        }

    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsChat[] SelectOnlineStudentList(string SenderId,string UserType)
    {
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        List<ClsChat> details = new List<ClsChat>();
        DataTable dt = new DataTable();
        string Action = "";
        if (UserType == "UNIVERSITY")
        {
            Action="SelectOnlineForUni";
        }
        else
        {
            Action="SelectOnlineForQs";
        }
        try
        {
            using (SqlCommand cmd = new SqlCommand("ChatForAll", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ReceiverId", SenderId);
                cmd.Parameters.AddWithValue("@Action", Action);
                cmd.Parameters.AddWithValue("@Result", "OK");
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                con.Close();

                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        ClsChat det = new ClsChat();
                        det.Reg_Id = dr["Reg_Id"].ToString();
                        det.StudentName = dr["StudentName"].ToString();
                        det.Name = dr["Name"].ToString();
                        det.LoginStatus = dr["LoginStatus"].ToString();
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
    public class ClsChat
    {
        public string Reg_Id { get; set; }
        public string StudentName { get; set; }
        public string Name { get; set; }
        public string LoginStatus { get; set; }
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
}
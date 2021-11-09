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

public partial class university_frmJoinRoom : System.Web.UI.Page
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
        using (SqlCommand cmd = new SqlCommand(@"select isnull(VideoUrl,'') as VideoUrl ,isnull(RoomName,'') as RoomName,UserName from tbl_UserDetails Inner join tbl_ChatRoom on tbl_ChatRoom.UserId=tbl_UserDetails.UserId  where tbl_ChatRoom.UserId=@Uid", con))
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Uid", Uid);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                strVideoAPI = dt.Rows[0]["VideoUrl"].ToString()+ "?prejoin=false&audio=enabled&video=enabled&name=" + dt.Rows[0]["UserName"].ToString()+"&password=123456";
                strChannelName = dt.Rows[0]["RoomName"].ToString();
            }
        }
    }
    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        if (Session["UserId"] != null || Session["UserId"] != "")
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
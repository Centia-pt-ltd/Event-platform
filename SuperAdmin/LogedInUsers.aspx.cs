using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SuperAdmin_LogedInUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

        if (!Page.IsPostBack)
        {

            if (Session["UserId"] == null || Session["UserId"] == "")
            {
                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("login.aspx", false);
            }
            else
            {
                hdfUserId.Value = Session["UserId"].ToString();
                Page.Title = "SuperAdmin::LogedIn Users";
            }
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsUsersBO[] BindList(string SearchValue, string RowPerPage, string PageNumber)
    {
        List<ClsUsersBO> details = new List<ClsUsersBO>();
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            dt = _obj.GetLogedInUserList(SearchValue, RowPerPage, PageNumber);

            foreach (DataRow dr in dt.Rows)
            {
                ClsUsersBO det = new ClsUsersBO();
                det.TotalRows = dr["TotalRows"].ToString();
                det.SNo = dr["SNo"].ToString();
                det.UserId = dr["UserId"].ToString();
                det.Name = dr["Name"].ToString();
                det.UserName = dr["UserName"].ToString();
                det.LoginType = dr["LoginType"].ToString();
                det.CurrentLoginStatus = dr["CurrentLoginStatus"].ToString();
                det.LoginDateTime = dr["LoginDateTime"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Logout(string Uid)
    {
        string Data = "";
        try
        {
            ClsCommanDataAccess _obComman = new ClsCommanDataAccess();
            Data = _obComman.UpdateLoginStatus(Uid, "LogOut");
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }
    public class ClsUsersBO
    {
        public string UserId { get; set; }
        public string SNo { get; set; }
        public string TotalRows { get; set; }
        public string Name { get; set; }
        public string UserName { get; set; }
        public string LoginType { get; set; }
        public string CurrentLoginStatus { get; set; }
        public string LoginDateTime { get; set; }
    }
}
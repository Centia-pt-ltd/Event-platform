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
public partial class University_frmAssignRoom : System.Web.UI.Page
{

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
            Page.Title = "University::BoothManager";
        }
    }
    [System.Web.Services.WebMethod]
    public static stDetails[] BindUniversityUser()
    {
        List<stDetails> details = new List<stDetails>();
        try
        {

            DataTable dt = new DataTable();
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            string uid = HttpContext.Current.Session["University"].ToString();
            dt = _obj.BindUnassignedUsers(uid);
            int len = dt.Rows.Count;

            if (len > 0)
            {
                string Id = string.Empty;
                stDetails det1 = new stDetails();
                det1.uid = 0;
                det1.uname = "--Select User--";
                details.Add(det1);
                foreach (DataRow dr in dt.Rows)
                {
                    stDetails det = new stDetails();
                    det.uid = Convert.ToInt32(dr["UserId"].ToString());
                    det.uname = dr["FirstName"].ToString().Trim();
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

    [System.Web.Services.WebMethod]
    public static rmDetails[] BindRoom()
    {
        List<rmDetails> details = new List<rmDetails>();
        try
        {

            DataTable dt = new DataTable();
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            string uid = HttpContext.Current.Session["UserId"].ToString();
            dt = _obj.BindAllRoom(uid);
            int len = dt.Rows.Count;

            if (len > 0)
            {
                string Id = string.Empty;
                rmDetails det1 = new rmDetails();
                det1.rid = 0;
                det1.rname = "--Select Room--";
                details.Add(det1);
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

    [System.Web.Services.WebMethod]
    public static rmDetails[] BindAssignedRoom()
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
                rmDetails det1 = new rmDetails();
                det1.rid = 0;
                det1.rname = "--Select Room--";
                details.Add(det1);
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

    public class stDetails
    {
        public int uid { get; set; }
        public string uname { get; set; }
    }
    public class rmDetails
    {
        public int rid { get; set; }
        public string rname { get; set; }
    }

    [System.Web.Services.WebMethod]
    public static ClsUsersBO[] BindList(string RowPerPage, string PageNumber)
    {
        string uniId = HttpContext.Current.Session["University"].ToString();
        List<ClsUsersBO> details = new List<ClsUsersBO>();
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.GetUserRoomList(uniId);

            foreach (DataRow dr in dt.Rows)
            {
                ClsUsersBO det = new ClsUsersBO();
                det.SNo = dr["SNo"].ToString();
                det.Id = dr["Id"].ToString();
                det.Name = dr["Name"].ToString();
                det.RoomName = dr["RoomName"].ToString();
               
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }
    public class ClsUsersBO
    {
        public string Id { get; set; }
        public string SNo { get; set; }
        public string Name { get; set; }
        public string RoomName { get; set; }
       
    }

    [System.Web.Services.WebMethod]
    public static string AddUpdate(string UniUserId, string RoomId)
    {
        string UniversityId = HttpContext.Current.Session["University"].ToString();
        string Data = "";
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            Data = _obj.AddUpdateRoom(UniversityId, UniUserId, RoomId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod]
    public static stDetails[] Edit(string RId)
    {                
        DataTable dt = new DataTable();
        ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
        dt = _obj.EditRoom(RId);
        int len = dt.Rows.Count;
        List<stDetails> details = new List<stDetails>();
        if (len > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                stDetails det = new stDetails();
                det.uid = Convert.ToInt32(dr["UserId"].ToString());
                det.uname = dr["FirstName"].ToString().Trim();
                details.Add(det);
            }
        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod]
    public static string Delete(string RId)
    {
        string Data = "";
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            Data = _obj.Delete(RId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

}
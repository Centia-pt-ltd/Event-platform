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

public partial class university_frmUniversityBooth : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

        if (Session["UserId"] == null || Session["UserId"] == "")
        {
            Session.Clear();
            Session.RemoveAll();
            Response.Redirect("login.aspx", false);
        }
        else
        {
            hdfUserId.Value = Session["UserId"].ToString();
            selectUniversityId();
            Page.Title = "University::BoothManager";
        }
    }

    //ContentPlaceHolder1_hdfUid
    public void selectUniversityId()
    {
        string id = Session["UserId"].ToString();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select university from tbl_UserDetails where UserId="+ hdfUserId.Value;
            cmd.Connection = con;
            con.Open();
            hdfUid.Value = Convert.ToString(cmd.ExecuteScalar());
            con.Close();

        }
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsBoothBO[] GetAllBooth(string Uid)
    {
        List<ClsBoothBO> details = new List<ClsBoothBO>();
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            dt = _obj.GetAllBooth(Uid);

            foreach (DataRow dr in dt.Rows)
            {
                ClsBoothBO det = new ClsBoothBO();
                det.Id = dr["Id"].ToString();
                det.SNo = dr["SNo"].ToString();
                det.TotalRows = dr["TotalRows"].ToString();
                det.BoothName = dr["BoothName"].ToString();
                det.BoothImage = dr["BoothImage"].ToString();
                det.Active = dr["Active"].ToString();
                det.UniversityName = dr["UniversityName"].ToString();
                det.createdDateTime = dr["createdDateTime"].ToString();
                det.UniversityId = dr["AssignedUniversityId"].ToString();
                det.SmallImg = dr["ImageSmall"].ToString();
                det.BigImg = dr["ImageBig"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static ClsBoothBO[] GetBoothEditData(string BoothId,string UniId)
    {
        string Data = "";
        List<ClsBoothBO> details = new List<ClsBoothBO>();
        try
        {
            DataTable dt = new DataTable();
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            dt = _obj.GetBoothDetailsForEdit(BoothId,UniId);

            foreach (DataRow dr in dt.Rows)
            {
                ClsBoothBO det = new ClsBoothBO();
                det.Id = dr["Id"].ToString();
                det.BoothName = dr["BoothName"].ToString();
                det.UniversityName = dr["UniversityName"].ToString();
                det.Active = dr["Active"].ToString();
                det.UniversityId = dr["UniversityId"].ToString();
                det.SmallImg = dr["ImageSmall"].ToString();
                det.BigImg = dr["ImageBig"].ToString();
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
    public static string SaveUpdateBooth(string EventId, string UniversityId, string sts, string BoothId)
    {
        string Rslt = "";
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            Rslt = _obj.UpdateBoothByUniversity(EventId, UniversityId, sts, BoothId, UserId);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string BindEvent()
    {
        string Data = "";
        try
        {

            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            dt = _obj.GetEvent();
            if (dt.Rows.Count > 0)
            {
                int len = dt.Rows.Count;
                Data += "<option value='0' selected='selected'>-Select Event-</option>";
                for (int i = 0; i < len; i++)
                {
                    Data += "<option value=" + dt.Rows[i]["Id"].ToString() + ">" + dt.Rows[i]["EventName"].ToString() + "</option>";
                }
            }
            else
            {
                Data += "<option value='0' selected='selected'>No Record</option>";
            }
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }
    
    public class ClsBoothBO
    {
        public string Id { get; set; }
        public string SNo { get; set; }
        public string TotalRows { get; set; }
        public string BoothName { get; set; }
        public string BoothPage { get; set; }
        public string BoothImage { get; set; }
        public string Active { get; set; }
        public string UniversityName { get; set; }
        public string createdDateTime { get; set; }
        public string UniversityId { get; set; }
        public string SmallImg { get; set; }
        public string BigImg { get; set; }
        public string CreatedByName { get; set; }
    }
}
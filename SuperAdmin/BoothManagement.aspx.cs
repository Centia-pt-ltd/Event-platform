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


public partial class SuperAdmin_BoothManagement : System.Web.UI.Page
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
            
            Page.Title = "SuperAdmin::BoothManager";
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string selectNextBoothName()
    {
        string BoothNam="";
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select count(*)+1 as total from Tab_MstBooth ";
            cmd.Connection = con;
            con.Open();
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            int div = count / 13;
            int res = 0;
            if(count>13)
            {
                res = count - (13 * div);
            }
            else
            {
                res = count;
            }
            BoothNam = "Booth"+Convert.ToString(res);
            con.Close();
            return BoothNam;


        }
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsBoothBO[] BindList(string SearchValue, string RowPerPage, string PageNumber)
    {
        List<ClsBoothBO> details = new List<ClsBoothBO>();
        try
        {
            ClsBooth _obj = new ClsBooth();
            DataTable dt = new DataTable();
            dt = _obj.GetBoothList(SearchValue, RowPerPage, PageNumber);

            foreach (DataRow dr in dt.Rows)
            {
                ClsBoothBO det = new ClsBoothBO();
                det.Id = dr["Id"].ToString();
                det.SNo = dr["SNo"].ToString();
                det.TotalRows = dr["TotalRows"].ToString();
                det.BoothName = dr["BoothName"].ToString();
                det.Active = dr["Active"].ToString();
                det.UniversityName = dr["UniversityName"].ToString();
                det.createdDateTime = dr["createdDateTime"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
      public static ClsBoothBO[] GetBoothEditData(string BoothId)
      {
          string Data = "";
          List<ClsBoothBO> details = new List<ClsBoothBO>();
          try
          {
              DataTable dt = new DataTable();
              ClsBooth _obj = new ClsBooth();
              dt = _obj.GetBoothDetails(BoothId);

              foreach (DataRow dr in dt.Rows)
              {
                  ClsBoothBO det = new ClsBoothBO();
                  det.Id = dr["Id"].ToString();
                  det.BoothName = dr["BoothName"].ToString();
                  det.UniversityName = dr["UniversityName"].ToString();
                  det.Active = dr["Active"].ToString();
                  det.UniversityId = dr["UniversityId"].ToString();
                  det.SmallImg = dr["LogoImageFunc"].ToString();
                  det.BigImg = dr["BannerImageFunc"].ToString();
                  det.CreatedByName = dr["CreatedBy"].ToString();
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
    public static string DeleteBooth(string BoothId)
    {
        string Data = "";
        try
        {
            ClsBooth _obj = new ClsBooth();
            Data = _obj.DelBooth(BoothId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string FillUniversity()
    {
        string Data = "";
        try
        {
            
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            dt = _obj.GetUniversityWithoutAssignBooth();
            if (dt.Rows.Count > 0)
            {
                int len = dt.Rows.Count;
                Data += "<option value='0' selected='selected'>-Select University-</option>";
                for (int i = 0; i < len; i++)
                {
                    Data += "<option value=" + dt.Rows[i]["Id"].ToString() + ">" + dt.Rows[i]["UniversityName"].ToString() + "</option>";
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
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveUpdateBooth(string Name, string UniversityId, string sts, string BoothId)
    {
        string Rslt = "";
        try
        {
            ClsBooth _obj = new ClsBooth();
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            Rslt = _obj.SaveUpdateBooth(Name, UniversityId, sts, BoothId, UserId);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public class ClsBoothBO
    {
        public string Id { get; set; }
        public string SNo { get; set; }
        public string TotalRows { get; set; }
        public string BoothName { get; set; }
        public string Active { get; set; }
        public string UniversityName { get; set; }
        public string createdDateTime { get; set; }
        public string UniversityId { get; set; }
        public string SmallImg { get; set; }
        public string BigImg { get; set; }
        public string CreatedByName { get; set; }
    }
}
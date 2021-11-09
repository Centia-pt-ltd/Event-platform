using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class SuperAdmin_UniversityManagement : System.Web.UI.Page
{
    public StringBuilder _sbMsg = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

        if (!Page.IsPostBack)
        {
            if (Session["UserId"] == null || Session["UserId"] == "")
            {

                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
                Response.Cache.SetNoStore();
                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("login.aspx", false);
            }
            else
            {
                hdfUserId.Value = Session["UserId"].ToString();
                Page.Title = "SuperAdmin::UniversityManagement";
                BindRegion();
            }
        }
    }

    public void BindRegion()
    {
        
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            dt = _obj.FillRegion();
            int len = dt.Rows.Count;
            string value = "";
            if (len > 0)
            {
                var id = "";
                _sbMsg.Append("<label for='m0'> <input type='checkbox' onchange='CheckAll(this.id);' value='All' id='m0' />&nbsp;All</label>");
                for (int i = 0; i < len; i++)
                {
                    value = dt.Rows[i]["Id"].ToString();
                    id = "m" + value;
                    _sbMsg.Append("<label for=" + id + "> <input type='checkbox' onchange='CheckSingle(this.id);' value='" + dt.Rows[i]["RName"].ToString() + "' id=" + id + " />&nbsp;" + dt.Rows[i]["RName"].ToString() + "</label>");
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static UniversityBO[] BindList(string SearchValue,string RowPerPage, string PageNumber)
    {
        List<UniversityBO> details = new List<UniversityBO>();
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            dt = _obj.GetUniversityList(SearchValue, RowPerPage, PageNumber);

            foreach (DataRow dr in dt.Rows)
            {
                UniversityBO det = new UniversityBO();
                det.TotalRows = dr["TotalRows"].ToString();
                det.SNo = dr["SNo"].ToString();
                det.Id = dr["Id"].ToString();
                det.Name = dr["Name"].ToString();
                det.Email = dr["Email"].ToString();                
                det.Active = dr["Active"].ToString();
                det.CreatedDateTime = dr["CreatedDateTime"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }

    public class UniversityBO
    {
        public string TotalRows { get; set; }
        public string SNo { get; set; }
        public string Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Active { get; set; }
        public string CreatedDateTime { get; set; }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static ClsUniversityBO[] GetEditData(string Uid)
    {
        string Data = "";
        List<ClsUniversityBO> details = new List<ClsUniversityBO>();
        try
        {
            DataTable dt = new DataTable();
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            dt = _obj.GetUniversityDetails(Uid);
            string MappedRegion = string.Empty;
            MappedRegion = _obj.GetMappedRegionInUniversityByUId(Uid);
            foreach (DataRow dr in dt.Rows)
            {
                ClsUniversityBO det = new ClsUniversityBO();
                det.Id = dr["Id"].ToString();
                det.Name = dr["UniversityName"].ToString();                
                det.Email = dr["Email"].ToString();
                det.Active = dr["Active"].ToString();
                det.Logo = dr["Logo"].ToString();
                det.MapRegion = MappedRegion;
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
    public static string DeleteUsers(string Uid)
    {
        string Data = "";
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            Data = _obj.DelUniversity(Uid);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }



    public class ClsUniversityBO
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Booth { get; set; }
        public string Email { get; set; }
        public string Pwd { get; set; }
        public string Active { get; set; }
        public string Logo { get; set; }
        public string MapRegion { get; set; }
    }
}
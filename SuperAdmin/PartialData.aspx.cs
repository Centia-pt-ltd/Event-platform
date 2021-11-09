using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Script.Services;
using System.IO;
using System.Drawing;
using System.Text;

public partial class SuperAdmin_PartialData : System.Web.UI.Page
{
    public string Qualification = string.Empty;
    public string Course = string.Empty;
    public string MsgPlateform = string.Empty;
    public string University = string.Empty;
    public StringBuilder _sbUniversity = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

        if (!Page.IsPostBack)
        {
            try
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
                    Page.Title = "SuperAdmin::PartialData";
                    BindRegion();

                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showMsg('ERROR', 'Something went wrong.!');", true);
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
            ddlRegion.DataSource = dt;
            ddlRegion.DataTextField = "RName";
            ddlRegion.DataValueField = "Id";
            ddlRegion.DataBind();
            ddlRegion.Items.Insert(0, "-All Region-");
            ddlRegion.SelectedIndex = 0;

        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "showMsg('ERROR', 'Something went wrong.!');", true);
        }
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string DeleteAll()
    {
        string rslt = "";
        ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
        rslt=_obj.DeletePartialData();
        return rslt;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static RegListBO[] BindPartialData(string RegionId, string RowPerPage, string PageNumber, string FDate, string TDate)
    {
        List<RegListBO> details = new List<RegListBO>();
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            dt = _obj.GetPartialData(RegionId, RowPerPage, PageNumber, FDate, TDate);

            foreach (DataRow dr in dt.Rows)
            {
                RegListBO det = new RegListBO();
                det.TotalRows = dr["TotalRows"].ToString();
                det.SNo = dr["SNo"].ToString();
                det.Reg_Id = dr["Reg_Id"].ToString();                
                det.Gender = dr["Gender"].ToString();
                det.Name = dr["Name"].ToString();
                det.EMail = dr["EMail"].ToString();
                det.CountryCode = dr["CountryCode"].ToString();
                det.Phone = dr["Phone"].ToString();
                det.WhatsApp = dr["WhatsApp"].ToString();
                det.Country = dr["Country"].ToString();
                det.City = dr["City"].ToString();                
                det.msg = dr["Messaging Platform"].ToString();
                det.CreatedOn = dr["CreatedOn"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {

        }
        return details.ToArray();
    }
    public class RegListBO
    {
        public string TotalRows { get; set; }
        public string SNo { get; set; }
        public string Reg_Id { get; set; }
        public string RegNo { get; set; }
        public string Gender { get; set; }
        public string Name { get; set; }
        public string EMail { get; set; }
        public string CountryCode { get; set; }
        public string Phone { get; set; }
        public string WhatsApp { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string TOEFLScore { get; set; }
        public string msg { get; set; }
        public string hq { get; set; }
        public string Course { get; set; }
        public string StudyAbroad { get; set; }
        public string FeeRange { get; set; }
        public string CreatedOn { get; set; }
        public string Active { get; set; }
        public string LastUpdateOn { get; set; }
        public string AssignedBy { get; set; }
        public string AssignedTo { get; set; }
        public string Flag { get; set; }
        public string LastUpdatedBy { get; set; }
    }
}
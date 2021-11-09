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

public partial class exhibition : System.Web.UI.Page
{
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
                Response.Redirect("Welcome.aspx", false);
            }
            else
            {
                hdfUserId.Value = Session["Reg_Id"].ToString();
                Page.Title = "Student::Exhibition";
                Tracking(hdfUserId.Value, "Exhibition");
                hfLang.Value = SelectLang(hdfUserId.Value);
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
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsBoothBO[] selectBoothDetail()
    {
        Dictionary<string, string> dictNew = new Dictionary<string, string>()
        {
            { "Booth1", "add_wrapper01" },
            { "Booth2", "add_wrapper02" },
            { "Booth3", "add_wrapper03" },
            { "Booth4", "add_wrapper04" },
            { "Booth5", "add_wrapper05" },
            { "Booth6", "add_wrapper06" },
            { "Booth7", "add_wrapper07" },
            { "Booth8", "add_wrapper08" },
            { "Booth9", "add_wrapper09" },
            { "Booth10", "add_wrapper010" },
            { "Booth11", "add_wrapper011" },
            { "Booth12", "add_wrapper012" },
            { "Booth13", "add_wrapper01" },
            { "Booth14", "add_wrapper02" },
            { "Booth15", "add_wrapper03" },
            { "Booth16", "add_wrapper04" },
            { "Booth17", "add_wrapper05" },
            { "Booth18", "add_wrapper06" },
            { "Booth19", "add_wrapper07" },
            { "Booth20", "add_wrapper08" },
            { "Booth21", "add_wrapper09" },
            { "Booth22", "add_wrapper010" },
            { "Booth23", "add_wrapper011" },
            { "Booth24", "add_wrapper012" }
        };

        //string id = Session["UserId"].ToString();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        List<ClsBoothBO> details = new List<ClsBoothBO>();
        DataTable dt = new DataTable();
        try
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                string qr = "";
                qr = @"select top(24) Tab_EventDetails.UniversityId,Tab_EventDetails.Position ";
                qr += "from Tab_EventDetails ";
                qr += "Inner Join Tab_Mst_Event on Tab_Mst_Event.Id=Tab_EventDetails.EventId ";
                qr += "where Tab_Mst_Event.Status = 'Yes' order by Position";

                cmd.CommandText = qr;
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                var i = 0;
                if (dt.Rows.Count > 0)
                {
                   
                    foreach (DataRow dr in dt.Rows)
                    { 
                        i++;
                        ClsBoothBO det = new ClsBoothBO();
                        det.UniversityId = dr["UniversityId"].ToString();
                        det.Position = dr["Position"].ToString();
                        det.Url = "Logo" + dr["UniversityId"].ToString() + ".jpg";
                        
                        if (i <= 12)
                        {
                            if (dictNew.ContainsKey(("Booth" + i).ToString()))
                            {
                                det.ImgClass1 = dictNew[("Booth" + i).ToString()];
                            }
                        }
                        else
                        {
                            if (dictNew.ContainsKey(("Booth" + i).ToString()))
                            {
                                det.ImgClass2 = dictNew[("Booth" + i).ToString()];
                            }
                        }
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

    public class ClsBoothBO
    {
        public string Position { get; set; }
        public string Url { get; set; }
        public string UniversityId { get; set; }
        public string ImgClass1 { get; set; }
        public string ImgClass2 { get; set; }
    }
}
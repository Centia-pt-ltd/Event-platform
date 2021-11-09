using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Configuration;
using System.Text;

public partial class QSLanding : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveRecord(string name, string email,string countryCode, string phoneNo,string eventName)
    {
        string Rslt = "";
        try
        {
            clsLanding _obj = new clsLanding();
            Rslt = _obj.SaveRecord(name, email, countryCode, phoneNo, eventName);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public class countryCodeList
    {

        public string CountryName { get; set; }
        public string CountryCode { get; set; }
        public string CountryMobCode { get; set; }
        public string CountryFlag { get; set; }
        public int MobileNoLength { get; set; }
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static countryCodeList[] bindCountryFlag(string pre)
    {
        List<countryCodeList> details = new List<countryCodeList>();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select distinct CountryName,CountryCode,CountryMobCode,CountryFlag,MobileNoLength from tbl_CountryCodeMob where CountryName like '%" + pre + "%' OR CountryCode like '%" + pre + "%' or CountryMobCode like '%" + pre + "%'";
            cmd.Connection = con;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                countryCodeList det = new countryCodeList();
                det.CountryName = dr["CountryName"].ToString();
                det.CountryCode = dr["CountryCode"].ToString();
                det.CountryMobCode = dr["CountryMobCode"].ToString();
                det.CountryFlag = dr["CountryFlag"].ToString();
                det.MobileNoLength = Convert.ToInt32(dr["MobileNoLength"].ToString());

                details.Add(det);
            }
        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static countryCodeList[] GetCountryName()
    {
        clsIPLocator ipl = new clsIPLocator();
        string CountryName = "";
        List<clsLocationList> l = ipl.GetLocation();
        CountryName = l[0].CountryName.ToString();

        List<countryCodeList> details = new List<countryCodeList>();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select distinct CountryName,CountryCode,CountryMobCode,CountryFlag,MobileNoLength from tbl_CountryCodeMob where CountryName='" + CountryName + "'";
            cmd.Connection = con;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                countryCodeList det = new countryCodeList();
                det.CountryName = dr["CountryName"].ToString();
                det.CountryCode = dr["CountryCode"].ToString();
                det.CountryMobCode = dr["CountryMobCode"].ToString();
                det.CountryFlag = dr["CountryFlag"].ToString();
                det.MobileNoLength = Convert.ToInt32(dr["MobileNoLength"].ToString());

                details.Add(det);
            }
        }
        return details.ToArray();
    }

}
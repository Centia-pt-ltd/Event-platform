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

public partial class university_frmUHomePage : System.Web.UI.Page
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
            selectUniversityName();
            Page.Title = "University::Home";
        }
    }
    public void selectUniversityName()
    {
        string id = Session["UserId"].ToString();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select UniversityName from tbl_UserDetails Inner join Tab_University on Tab_University.Id=tbl_UserDetails.university where UserId=" + id;
            cmd.Connection = con;
            con.Open();
            universityName.InnerText = Convert.ToString("Welcome "+cmd.ExecuteScalar());
            con.Close();

        }
    }
}
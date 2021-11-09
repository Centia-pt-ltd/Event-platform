using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class lobby : System.Web.UI.Page
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
                Page.Title = "Student::Lobby";
                Tracking(hdfUserId.Value, "Lobby");
                hfLang.Value = SelectLang(hdfUserId.Value);
            }

        }
    }
    public string SelectLang(string regId)
    {
        string lang = "";
        ClsCommanDataAccess clscomm = new ClsCommanDataAccess();
        lang = clscomm.SelectLang(regId);
        return lang;
    }
    public void Tracking(string regId,string PageName)
    {
        try
        {
            ClsCommanDataAccess clscomm = new ClsCommanDataAccess();
            clscomm.InsertTracking(regId, PageName);
        }
        catch(Exception ex)
        {

        }
    }
}
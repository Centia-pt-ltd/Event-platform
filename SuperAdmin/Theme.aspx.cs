using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class SuperAdmin_Theme : System.Web.UI.Page
{
    public StringBuilder _sbTheme = new StringBuilder();
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
                    Session.Clear();
                    Session.RemoveAll();
                    Response.Redirect("login.aspx", false);
                }
                else
                {
                    BindThemeList();
                    hdfUserId.Value = Session["UserId"].ToString();
                    Page.Title = "SuperAdmin::Theme";
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showMsg('ERROR', 'Something went wrong.!');", true);
            }
        }
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string ActivateTheme(string ThemeId)
    {
        string Data = "";
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            string UserId = HttpContext.Current.Session["UserId"].ToString();
            Data = _obj.ActivateTheme(ThemeId, UserId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    public string BindThemeList()
    {
        DataTable dt = new DataTable();
        ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
        dt = _obj.GetThemeList();
        int c = 1;
        string RdbId = string.Empty;
        string ImageUrl = string.Empty;
        string Active = string.Empty;
        foreach (DataRow dr in dt.Rows)
        {
            RdbId = "Rdb" + dr["Id"].ToString();
            ImageUrl = "../" + dr["IndexPage"].ToString();
            Active = dr["Active"].ToString();
            _sbTheme.Append("<div class='col-md-6 text-center'>");
            _sbTheme.Append("<div class='sec-redio'>");
            if (Active == "Yes")

                _sbTheme.Append("<label for=" + RdbId + "><input type='radio' checked='checked' name='RdbTheme' id=" + RdbId + " onclick='themeActive(this.id)' /> Theme-" + c.ToString() + "</label>");
            else
                _sbTheme.Append("<label for=" + RdbId + "><input type='radio' name='RdbTheme' id=" + RdbId + " onclick='themeActive(this.id)' /> Theme-" + c.ToString() + "</label>");
            //_sbTheme.Append("<span> Theme-" + c.ToString() + "</span>");
            _sbTheme.Append("</div>");
            if (c == 1)
                _sbTheme.Append("<div class='polaroid ' id='polaroid'>");
            else
                _sbTheme.Append("<div class='polaroid' id='polaroid" + c.ToString() + "'>");
            _sbTheme.Append("<img src='" + ImageUrl + "' alt='Index' style='width:100%' />");
            _sbTheme.Append("<div class='overlay'></div>");
            _sbTheme.Append("</div>");
            _sbTheme.Append("</div>");
            c = c + 1;
        }
        return _sbTheme.ToString();
    }
}
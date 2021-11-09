using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class University_Dashboard : System.Web.UI.Page
{
    public DataTable dt = new DataTable();
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
                    hdfUserId.Value = Session["UserId"].ToString();
                    Page.Title = "University::Dashboard";
                    ClsCommanDataAccess _objCommon = new ClsCommanDataAccess();
                    dt = _objCommon.BindDashBoardData("0", Session["University"].ToString());

                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showMsg('ERROR', 'Something went wrong.!');", true);
            }
        }
    }
}
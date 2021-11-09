using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.Script.Services;

public partial class UniversityBooth_MoveToAssignUniversity : System.Web.UI.Page
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["Reg_Id"] == null)
            {
                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("../Welcome.aspx", false);
            }
            else
            {
                string UserId = Session["Reg_Id"].ToString();
                SelectUniversityToMove(UserId);
            }
        }
    }

    public void SelectUniversityToMove(string UserId)
    {
        string url = "";

        try
        {
            ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
            DataTable dt = new DataTable();
            dt = _obj.GetStudentUniversityToView(UserId);
            if (dt.Rows.Count > 0)
            {
                string uid = dt.Rows[0]["UniversityId"].ToString();
                string pos = dt.Rows[0]["Position"].ToString();
                url = "BoothView.aspx?Uid=" + uid + "&Pid=" + pos;
                Response.Redirect(url,false);
            }
            else
            {
                //Response.Redirect("../lobby.aspx", false);
            }
        }
        catch (Exception ex)
        {

        }
        
    }
}
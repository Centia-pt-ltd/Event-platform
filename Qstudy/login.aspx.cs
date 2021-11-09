using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class SuperAdmin_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnPostLogin_Click(object sender, EventArgs e)
    {
        string userName = Request.Form["txtUserName"];
        string pwd = Request.Form["txtPwd"];
        try
        {
            ClsQstudyDataAccess _objDac = new ClsQstudyDataAccess();
            DataTable dt = new DataTable();
            dt = _objDac.ValidateLogin(userName, pwd);
            if (dt.Rows.Count > 0)
            {
                Session["UserName"] = dt.Rows[0]["UserName"].ToString();
                Session["Password"] = dt.Rows[0]["Password"].ToString();
                Session["UserId"] = dt.Rows[0]["UserId"].ToString();
                Session["LoginType"] = dt.Rows[0]["LoginType"].ToString();
                ClsCommanDataAccess _objComman = new ClsCommanDataAccess();
                string Rslt = _objComman.UpdateLoginStatus(dt.Rows[0]["UserId"].ToString(), "LOGIN");
                Response.Redirect("Dashboard.aspx", false);
            }
            else
            {
                lblmsg.Text = "Invalid Login credential.";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }

        }
        catch (Exception ex)
        {
            lblmsg.Text = "Something went wrong, Please contact to Administrator.";
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
    }
}
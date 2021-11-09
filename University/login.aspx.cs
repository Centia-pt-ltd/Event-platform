using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class University_login : System.Web.UI.Page
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
            ClsUniversityDataAccess _objDac = new ClsUniversityDataAccess();
            DataTable dt = new DataTable();
            dt = _objDac.ValidateLogin(userName, pwd);
            if (dt.Rows.Count > 0)
            {
                Session["UserName"] = dt.Rows[0]["Email"].ToString();
                Session["Password"] = dt.Rows[0]["Pwd"].ToString();
                Session["UserId"] = dt.Rows[0]["Id"].ToString();
                Session["University"] = dt.Rows[0]["University"].ToString();
                Session["LoginType"] = dt.Rows[0]["LoginType"].ToString();
                Session["Role"] = dt.Rows[0]["Role"].ToString();
                ClsCommanDataAccess _objComman = new ClsCommanDataAccess();
                string Rslt = _objComman.UpdateLoginStatus(dt.Rows[0]["Id"].ToString(), "LOGIN");
                //Response.Redirect("frmUHomePage.aspx", false);
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
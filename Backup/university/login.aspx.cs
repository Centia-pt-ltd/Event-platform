using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class university_login : System.Web.UI.Page
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        lblmsg.Text = "";
        ValidateLogin();
    }

    public void ValidateLogin()
    {
        try
        {
            string qry = string.Empty;

            string UserName = Request.Form["txtname"].ToString();
            string Password = Request.Form["txtPassword"].ToString();

            qry = @"SELECT Id,UniversityName,Email,Pwd FROM Tab_UniversityLogin where Email=@Uname AND Pwd=@Password and Active='Yes'";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@Uname", UserName);
                    cmd.Parameters.AddWithValue("@Password", Password);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                Session["UniversityName"] = dt.Rows[0]["UniversityName"].ToString();
                                Session["Email"] = dt.Rows[0]["Email"].ToString();
                                Session["Pwd"] = dt.Rows[0]["Pwd"].ToString();
                                Session["UniversityId"] = dt.Rows[0]["Id"].ToString();
                                Response.Redirect("RegList.aspx", false);
                            }
                            else
                            {
                                lblmsg.Text = "Invalid Login credential.";
                                lblmsg.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = "Something went wrong, Please contact to Administrator.";
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
    }
}
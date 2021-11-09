using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public partial class events : System.Web.UI.Page
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    public StringBuilder _sbCountry = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

        }
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

            string FullName = Request.Form["txtFullName"].ToString();
            //string Email = Request.Form["txtEMail"].ToString();
            //string Mobile = Request.Form["txtMobile"].ToString();
            //string CountryCode = hdfCountry.Value;

            string Email = "";
            string Mobile = "";
            string CountryCode = "";
            string Q = "0", S = "0";

            string RegNo = string.Empty; string DisplayName = string.Empty;
            RegNo = FullName.Trim().ToUpper();
            int len = 0;
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("select Name from tab_Registration where RegistrationNo=@RegNo and Active='Yes'", con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@RegNo", RegNo);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            len = dt.Rows.Count;
                            if (len > 0)
                                DisplayName = dt.Rows[0]["Name"].ToString();
                        }
                    }
                }
            }

            if (len > 0)
            {
                using (SqlConnection con = new SqlConnection(dbCon))
                {
                    using (SqlCommand cmd = new SqlCommand("Sp_StudentLogin", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@FullName", FullName.Trim().ToUpper());
                        cmd.Parameters.AddWithValue("@Email", Email);
                        cmd.Parameters.AddWithValue("@CountryCode", CountryCode);
                        cmd.Parameters.AddWithValue("@Mobile", Mobile);
                        cmd.Parameters.AddWithValue("@Action", "ADD");
                        SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(sqlParameter);
                        cmd.CommandTimeout = 0;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        string Result = sqlParameter.Value.ToString();

                        Session["FullName"] = FullName;
                        Session["Email"] = Email;
                        Session["CountryCode"] = CountryCode;
                        Session["Mobile"] = Mobile;
                        Session["Id"] = Result;
                        //Response.Redirect("http://qstudyabroad.com/reception.html?name=" + DisplayName, false);
                        Response.Redirect("entrance.html", false);

                        // Response.Redirect("https://kmilab.zoom.us/", false);
                    }
                }
            }
            else
            {
                lblmsg.Text = "Invalid Registration No.!";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }
        catch (Exception ex)
        {
            //lblmsg.Text = "Something went wrong, Please contact to Administrator.";
            lblmsg.Text = ex.Message;
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {

        }
    }
}
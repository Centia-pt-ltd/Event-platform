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

public partial class Home : System.Web.UI.Page
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
        ValidateCouncil("Yes");
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

            string RegNo = string.Empty; string DisplayName = string.Empty;
            RegNo = FullName.Trim().ToUpper();
            int len = 0;
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Name,Reg_Id FROM tab_Registration WHERE RegistrationNo=@RegNo ", con)) // AND Active = 'Yes'", con))
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
                            {
                                DisplayName = dt.Rows[0]["Name"].ToString();
                                Session["Name"] = DisplayName;
                                Session["Reg_Id"] = dt.Rows[0]["Reg_Id"].ToString();
                            }
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
                        //Response.Redirect("entrance.html", false);
                        Response.Redirect("all-page.aspx", false);
                    }
                }
                //ValidateCouncil("Yes");
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
    public void ValidateCouncil(String Active)
    {
        try
        {
            string qry = string.Empty;
            string RegNo = Session["FullName"].ToString();
            string name = Session["Name"].ToString();
            string StudentId = Session["Reg_Id"].ToString();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentCouncil", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@StudentId", StudentId.Trim());
                    cmd.Parameters.AddWithValue("@RegNo", RegNo.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@Name", name.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@Active", Active);
                    cmd.Parameters.AddWithValue("@UniversityId", "0");
                    cmd.Parameters.AddWithValue("@CreatedBy", "0");
                    cmd.Parameters.AddWithValue("@Flag", "1");
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

                }
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {

        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public partial class Welcome : System.Web.UI.Page
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
        labelMessage.Text = "";
        ValidateLogin();
        //ValidateCouncil("Yes");
    }
    public enum WarningType
    {
        Success,
        Info,
        Warning,
        Danger
    }
    public void ShowMessage(string Message, WarningType type)
    {
        
        //sets the message and the type of alert, than displays the message
        labelMessage.Text = Message;
        pnlMessage.CssClass = string.Format("alert alert-{0} alert-dismissable", type.ToString().ToLower());
        pnlMessage.Attributes.Add("role", "alert");
        pnlMessage.Visible = true;
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
            string Lang = hfLang.Value;
            if (Lang == "")
            {
                Lang = "English";
            }
            string Email = "";
            string Mobile = "";
            string CountryCode = "";

            string RegNo = string.Empty; string DisplayName = string.Empty;
            RegNo = FullName.Trim().ToUpper();
            int len = 0;
            string sts = "Pass";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Name,Reg_Id,ISNULL(BlockStatus,'')BlockStatus,ISNULL(RegistrationNo,'')RegistrationNo,ISNULL(Active,'')Active FROM tab_Registration WHERE RegistrationNo=@RegNo", con))
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
                                if (dt.Rows[0]["Active"].ToString().Trim() == "No" || dt.Rows[0]["Active"].ToString().Trim() == "")
                                {
                                    ShowMessage("Your Account is not Active. Please contact to Administrator.!",WarningType.Warning);
                                    //lblmsg.ForeColor = System.Drawing.Color.Red;
                                    sts = "Fail";
                                }
                                else if (dt.Rows[0]["BlockStatus"].ToString().Trim() == "Yes")
                                {
                                    ShowMessage("Your Account is Blocked. Please contact to Administrator.!", WarningType.Warning);
                                    //lblmsg.ForeColor = System.Drawing.Color.Red;
                                    sts = "Fail";
                                }
                                else
                                {
                                    DisplayName = dt.Rows[0]["Name"].ToString();
                                    Session["Name"] = DisplayName;
                                    Session["Reg_Id"] = dt.Rows[0]["Reg_Id"].ToString();                                    
                                    sts = "Pass";
                                }
                            }
                            else
                            {
                                ShowMessage("Invalid Registration No.!", WarningType.Danger);
                                //lblmsg.ForeColor = System.Drawing.Color.Red;
                                sts = "Fail";
                            }
                        }
                    }
                }
            }

            if (sts != "Fail")
            {
                string IPAddress = getIPAddress();
                using (SqlConnection con = new SqlConnection(dbCon))
                {
                    using (SqlCommand cmd = new SqlCommand("Sp_StudentLogin", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@FullName", FullName.Trim().ToUpper());
                        cmd.Parameters.AddWithValue("@Email", Email);
                        cmd.Parameters.AddWithValue("@CountryCode", CountryCode);
                        cmd.Parameters.AddWithValue("@Mobile", Mobile);
                        cmd.Parameters.AddWithValue("@Lang", Lang);
                        cmd.Parameters.AddWithValue("@IPAddress", IPAddress);
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
                        Session["Lang"] = Lang;
                        //Response.Redirect("entrance.html", false);
                        
                       
                       
                    }
                }
                ValidateCouncil("Yes");
            }
        }
        catch (Exception ex)
        {
            //lblmsg.Text = "Something went wrong, Please contact to Administrator.";
            ShowMessage("Something went wrong, Please contact to Website Administrator.", WarningType.Danger);
            //lblmsg.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {

        }
    }
    public void ValidateCouncil(string Active)
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

                    if (Result == "No")
                    {
                        Response.Redirect("lobby.aspx?move=no", false);
                    }
                    else
                    {
                        Response.Redirect("lobby.aspx?move=yes", false);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Something went wrong, Please contact to Website Administrator.", WarningType.Danger);
            //lblmsg.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {

        }
    }
    public string getIPAddress()
    {
        try
        {
            clsIPLocator objclsIPLocator = new clsIPLocator();
            return objclsIPLocator.IPaddress;
        }
        catch(Exception ex)
        {
            return "";
        }
    }
}
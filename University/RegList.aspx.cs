using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;
using System.Text;
using System.IO;
public partial class university_RegList : System.Web.UI.Page
{
   static string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    string ErMsg = "Something went wrong. Please contact to administrator.";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lblmsg.Text = "";
            if (Session["UniversityName"] == null || Session["UniversityName"].ToString() == "" || Session["UniversityId"] == null || Session["UniversityId"].ToString() == "")
            {
                Response.Redirect("login.aspx", false);
            }
            else
            {
                btnWelcome.Text = "Welcome, " + Session["UniversityName"];
                bindRegion();
                bindHq();
                bindCorse();
                // string Course = ddlCourse.SelectedItem.Text;
                // string Qualification = ddlQualification.SelectedItem.Text;
                // string Country = txtCountry.Text;
                string Course = "";
                string Qualification = "";
                string Country = "";
                string UId = Session["UniversityId"].ToString();
                bindGrid(UId, Course, Qualification, Country);
            }
        }
    }

    public void bindGrid(string UniversityId, string Course, string Qualification,string Country)
    {
        try
        {
            string qry = string.Empty;
            if (Qualification == "-Qualification-")
                Qualification = "";
            if (Course == "-Courses-")
                Course = "";

           /* if (ddlRegion.SelectedValue == "-All Region-")
            {
                qry = @"SELECT ROW_NUMBER() over(order by Reg_Id ASC) SNo,Reg_Id,RegistrationNo [RegNo],Gender,Name,emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],CreatedOn,Active from tab_Registration r
                       INNER JOIN Tab_Assign_Registration a on r.Reg_Id=a.RegId where 1=1 and a.universityId=@UniversityId";
                
            }
            else
            {
                qry = @"SELECT ROW_NUMBER() over(order by Reg_Id ASC) SNo,Reg_Id,RegistrationNo [RegNo],Gender,Name,emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],CreatedOn,Active from tab_Registration r
                   INNER JOIN Tab_Assign_Registration a on r.Reg_Id=a.RegId WHERE 1=1 and r.RegionId=@RegionId and a.universityId=@UniversityId";
            }
            if (Course != "")
            {
                
                qry += @" and (r.course like '%," + Course + ",%' or r.course like '%," + Course + "%' or r.course like '%" + Course + ",%' or r.course like '%" + Course + "%' )";
            }
            if (Qualification != "")
            {
               
                qry += @" and ( r.hq like '%" + Qualification + "%' or r.hq like '%," + Qualification + ",%' or r.hq like '%," + Qualification + "%' or r.hq like '%" + Qualification + ",%' )";
            }
            if (Country != "")
            {
                qry += @" and r.country like '%" + Country + "%'";
            }
            qry += @" ORDER BY a.Id DESC";*/




            if (ddlRegion.SelectedValue == "-All Region-")
            {
                qry = @"SELECT ROW_NUMBER() over(order by Reg_Id ASC) SNo,Reg_Id,RegistrationNo [RegNo],Gender,Name,emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],CreatedOn,Active from tab_Registration r
                       where 1=1";

            }
            else
            {
                qry = @"SELECT ROW_NUMBER() over(order by Reg_Id ASC) SNo,Reg_Id,RegistrationNo [RegNo],Gender,Name,emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],CreatedOn,Active from tab_Registration r
                   WHERE 1=1 and r.RegionId=@RegionId";
            }
            if (Course != "")
            {

                qry += @" and (r.course like '%," + Course + ",%' or r.course like '%," + Course + "%' or r.course like '%" + Course + ",%' or r.course like '%" + Course + "%' )";
            }
            if (Qualification != "")
            {

                qry += @" and ( r.hq like '%" + Qualification + "%' or r.hq like '%," + Qualification + ",%' or r.hq like '%," + Qualification + "%' or r.hq like '%" + Qualification + ",%' )";
            }
            if (Country != "")
            {
                qry += @" and r.country like '%" + Country + "%'";
            }
            qry += @" ORDER BY r.Reg_Id DESC";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@RegionId", ddlRegion.SelectedValue.ToString());
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                    

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            grdList.DataSource = dt;
                            grdList.DataBind();
                            if (dt.Rows.Count == 0)
                            {
                                btnDownload.Visible = false;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
            btnDownload.Visible = false;
        }

    }


    public void bindHq()
    {
        try
        {
            string qry = string.Empty;
            qry = @"select HigestId,HigestQualificationName from [dbo].[tbl_HigestQualification] order by HigestQualificationName asc";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                          ddlQualification.DataSource = dt;
                          ddlQualification.DataTextField = "HigestQualificationName";
                          ddlQualification.DataValueField = "HigestId";
                          ddlQualification.DataBind();
                        }
                        ddlQualification.Items.Insert(0, "-Qualification-");
                        ddlQualification.SelectedIndex = 0;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
    }

    public void bindCorse()
    {
        try
        {
            string qry = string.Empty;
            qry = @"select CourseId,CourseName from [dbo].[tbl_Course] order by CourseName asc";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                          ddlCourse.DataSource = dt;
                          ddlCourse.DataTextField = "CourseName";
                          ddlCourse.DataValueField = "CourseId";
                          ddlCourse.DataBind();
                        }
                        ddlCourse.Items.Insert(0, "-Courses-");
                        ddlCourse.SelectedIndex = 0;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
    }

    public void bindRegion()
    {
        try
        {
            string qry = string.Empty;
            qry = @"select Id,RName from tabMst_Region where Active='Y' order by RName asc";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            ddlRegion.DataSource = dt;
                            ddlRegion.DataTextField = "RName";
                            ddlRegion.DataValueField = "Id";
                            ddlRegion.DataBind();
                        }
                        //ddlRegion.Items.Insert(0, "-All Region-");
                        ddlRegion.SelectedIndex = 0;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }

    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdList.PageIndex = e.NewPageIndex;
            string Course = ddlCourse.SelectedItem.Text;
            string Qualification = ddlQualification.SelectedItem.Text;
            string Country = txtCountry.Text;
            bindGrid(Session["UniversityId"].ToString(), Course, Qualification, Country);
        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
            btnDownload.Visible = false;
        }
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        try
        {
            string FName = string.Empty;
            FName = ddlRegion.SelectedItem.Text;
            if (FName == "-All Region-")
                FName = "All";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FName + "-RegistrationList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                grdList.AllowPaging = false;
                string Course = ddlCourse.SelectedItem.Text;
                string Qualification = ddlQualification.SelectedItem.Text;
                string Country = txtCountry.Text;
                bindGrid(Session["UniversityId"].ToString(), Course, Qualification, Country);
                

                grdList.GridLines = GridLines.Both;

                grdList.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in grdList.HeaderRow.Cells)
                {
                    cell.BackColor = grdList.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in grdList.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = grdList.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = grdList.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                grdList.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { border: 1px solid gray } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
            btnDownload.Visible = false;
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
        Response.Cache.SetNoStore();
        Session.Clear();
        Session.RemoveAll();
        Response.Redirect("login.aspx", false);
    }
    protected void btnLoginList_Click(object sender, EventArgs e)
    {
        Response.Redirect("LoginList.aspx", false);
    }
    protected void ddlRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Course = ddlCourse.SelectedItem.Text;
        string Qualification = ddlQualification.SelectedItem.Text;
        string Country = txtCountry.Text;
        bindGrid(Session["UniversityId"].ToString(), Course, Qualification, Country);
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string GetDetails(string id)
    {
        string _table = string.Empty;
        string qry = string.Empty;
        qry = @"SELECT [Reg_Id],[Name],[Gender],[Country_Code],[phone_no],[emailid],[Country],[State] 'City',[CreatedOn],[UpdatedOn],[TOEFLScore]
      ,[msg],[hq],[course],[RegistrationNo],[StudyAbroad],[FeeRange],[Active] FROM [dbo].[tab_Registration] WHERE Reg_Id=@RegId";

        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@RegId", id);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            _table += "<table class='table table-bordered'>";
                            _table += "<tr><th>SNo.</th><td>" + dt.Rows[0]["Reg_Id"].ToString() + "</td></tr>";
                            _table += "<tr><th>Registration No.</th><td>" + dt.Rows[0]["RegistrationNo"].ToString() + "</td></tr>";
                            _table += "<tr><th>Full Name</th><td>" + dt.Rows[0]["Gender"].ToString() + " " + dt.Rows[0]["Name"].ToString() + "</td></tr>";
                            _table += "<tr><th>E-Mail</th><td>" + dt.Rows[0]["emailid"].ToString() + "</td></tr>";
                            _table += "<tr><th>Phone</th><td>" + dt.Rows[0]["Country_Code"].ToString() + "-" + dt.Rows[0]["phone_no"].ToString() + "</td></tr>";
                            _table += "<tr><th>Country</th><td>" + dt.Rows[0]["Country"].ToString() + "</td></tr>";
                            _table += "<tr><th>City</th><td>" + dt.Rows[0]["City"].ToString() + "</td></tr>";
                            _table += "<tr><th>Select Platform You Use</th><td>" + dt.Rows[0]["msg"].ToString() + "</td></tr>";
                            _table += "<tr><th>Current Highest Qualification</th><td>" + dt.Rows[0]["hq"].ToString() + "</td></tr>";
                            _table += "<tr><th>What Course Are You Looking For</th><td>" + dt.Rows[0]["course"].ToString() + "</td></tr>";
                            _table += "<tr><th>IELTS/TOEFL</th><td>" + dt.Rows[0]["TOEFLScore"].ToString() + "</td></tr>";
                            _table += "<tr><th>Are You Planning To Study Abroad</th><td>" + dt.Rows[0]["StudyAbroad"].ToString() + "</td></tr>";
                            _table += "<tr><th>What Fee Range Are You Looking At</th><td>" + dt.Rows[0]["FeeRange"].ToString() + "</td></tr>";
                            _table += "<tr><th>Active</th><td>" + dt.Rows[0]["Active"].ToString() + "</td></tr>";
                            _table += "</table>";
                        }
                        
                    }
                }
            }
        }
        return _table;
    }

    protected void grdList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string st = ((HiddenField)e.Row.FindControl("hdfActive")).Value;
                if (st.Trim().ToUpper() == "YES")
                {
                    ((CheckBox)e.Row.FindControl("chkActive")).Checked = true;
                }
                else
                {
                    ((CheckBox)e.Row.FindControl("chkActive")).Checked = false;
                }
                string SocialMedia = ((HiddenField)e.Row.FindControl("hdfSocialPlateform")).Value;
                if (SocialMedia.Length > 0)
                {
                    string[] Ary = SocialMedia.Split(',');
                    for (int i = 0; i < Ary.Length; i++)
                    {
                        if (Ary[i].Trim().ToUpper() == "WHATSAPP")
                        {
                        }
                    }
                }

            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
            btnDownload.Visible = false;
        }
    }
    protected void chkActive_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            GridViewRow row = ((GridViewRow)((CheckBox)sender).NamingContainer);
            int index = row.RowIndex;
            string RegId = ((HiddenField)grdList.Rows[index].FindControl("hdfRegId")).Value;
            CheckBox chk = (CheckBox)grdList.Rows[index].FindControl("chkActive");
            string sts = string.Empty;
            if (chk.Checked == true)
                sts = "Yes";
            else
                sts = "No";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Update tab_Registration set Active=@sts where Reg_id=@Reg_id", con))
                {
                    cmd.Parameters.AddWithValue("@sts", sts);
                    cmd.Parameters.AddWithValue("@Reg_id", RegId);
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    lblmsg.Text = "Record updated successfully !!";
                }
            }

        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }    

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string Course = ddlCourse.SelectedItem.Text;
        string Qualification = ddlQualification.SelectedItem.Text;
        string Country = txtCountry.Text;
        bindGrid(Session["UniversityId"].ToString(), Course, Qualification, Country);
    }
}
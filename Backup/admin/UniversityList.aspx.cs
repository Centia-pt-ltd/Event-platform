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

public partial class admin_UniversityList : System.Web.UI.Page
{
    static string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    string ErMsg = "Something went wrong. Please contact to administrator.";

    public StringBuilder _sbMsg = new StringBuilder();
    public StringBuilder _sbHQ = new StringBuilder();
    public StringBuilder _sbCourse = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["UserName"] == null || Session["UserName"].ToString() == "")
            {
                Response.Redirect("sign.aspx", false);
            }
            btnWelcome.Text = "Welcome, " + Session["UserName"];
            bindRegion();
            bindGrid();
        }
    }

    public void bindGrid()
    {
        try
        {
            string qry = string.Empty;
            qry = @"select ROW_NUMBER() over(order by UniversityName ASC) Id,UniversityName,Email,Pwd,Active,CreatedDateTime from [dbo].[Tab_UniversityLogin] order by UniversityName asc";
            
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    
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
                        ddlRegion.Items.Insert(0, "-All Region-");
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
            bindGrid();
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
            
                FName = "UniversityList";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FName + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                grdList.AllowPaging = false;
                bindGrid();

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
        Response.Redirect("sign.aspx", false);
    }
    protected void btnLoginList_Click(object sender, EventArgs e)
    {
        Response.Redirect("LoginList.aspx", false);
    }
    protected void ddlRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindGrid();
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
                            _table += "</table>";
                        }

                    }
                }
            }
        }
        return _table;
    }


    protected void btnRegistration_Click(object sender, EventArgs e)
    {
        Response.Redirect("RegList.aspx", false);
    }
}
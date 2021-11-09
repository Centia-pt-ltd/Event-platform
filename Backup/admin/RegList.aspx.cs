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
public partial class admin_RegList : System.Web.UI.Page
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
            {
                btnWelcome.Text = "Welcome, " + Session["UserName"];
                bindRegion();
                bindGrid();
                FillMsgPlateform();
                FillHQualification();
                FillCourse();
            }

        }
    }

    protected void btnDel_Click(object sender, EventArgs e)
    {

        try
        {
            GridViewRow row = ((GridViewRow)((Button)sender).NamingContainer);
            int index = row.RowIndex;
            string RegId = ((HiddenField)grdList.Rows[index].FindControl("hdfRegId")).Value;

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Delete from tab_Registration where Reg_id=@Reg_id", con))
                {
                    cmd.Parameters.AddWithValue("@Reg_id", RegId);
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    lblmsg.Text = "Record deleted successfully !!";
                    bindGrid();
                    FillMsgPlateform();
                    FillHQualification();
                    FillCourse();
                }
            }

        }
        catch (Exception ex)
        {
            lblmsg.Text = ""; ;
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
    }

    protected void btnUniversityList_Click(object sender, EventArgs e)
    {
        Response.Redirect("UniversityList.aspx", false);
    }
    public void bindGrid()
    {
        try
        {
            string qry = string.Empty;

            if (ddlRegion.SelectedValue == "-All Region-")
            {
                qry = @"SELECT ROW_NUMBER() over(order by Reg_Id ASC) SNo,Reg_Id,RegistrationNo [RegNo],Gender,Name,emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],CreatedOn,Active from tab_Registration
                    ORDER BY Reg_Id DESC";
            }
            else
            {
                qry = @"SELECT ROW_NUMBER() over(order by Reg_Id ASC) SNo,Reg_Id,RegistrationNo [RegNo],Gender,Name,emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],CreatedOn,Active from tab_Registration
                   WHERE RegionId=@RegionId ORDER BY Reg_Id DESC";
            }
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@RegionId", ddlRegion.SelectedValue.ToString());
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
            qry = @"select Id,RName from tabMst_Region order by RName asc";

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
            FillMsgPlateform();
            FillHQualification();
            FillCourse();
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



            string qry = string.Empty;

            if (ddlRegion.SelectedValue == "-All Region-")
            {
                qry = @"SELECT ROW_NUMBER() over(order by Reg_Id ASC) SNo,Reg_Id,RegistrationNo [RegNo],Gender,Name,emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],CreatedOn,Active from tab_Registration
                    ORDER BY Reg_Id DESC";
            }
            else
            {
                qry = @"SELECT ROW_NUMBER() over(order by Reg_Id ASC) SNo,Reg_Id,RegistrationNo [RegNo],Gender,Name,emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],CreatedOn,Active from tab_Registration
                   WHERE RegionId=@RegionId ORDER BY Reg_Id DESC";
            }

            GridView gv = new GridView();

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@RegionId", ddlRegion.SelectedValue.ToString());
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            gv.DataSource = dt;
                            gv.DataBind();
                            if (dt.Rows.Count == 0)
                            {
                                btnDownload.Visible = false;
                            }
                        }
                    }
                }
            }

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FName + "-RegistrationList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                gv.AllowPaging = false;
             

                gv.GridLines = GridLines.Both;

                gv.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in gv.HeaderRow.Cells)
                {
                    cell.BackColor = gv.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gv.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gv.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gv.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gv.RenderControl(hw);

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


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static ClsRegistration[] GetEditData(string RegId)
    {
        List<ClsRegistration> details = new List<ClsRegistration>();
        string qry = string.Empty;

        // msg plateform
        string tmpmsg = string.Empty;
        string tmpHq = string.Empty;
        string tmpCr = string.Empty;

        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand("select msg_id from [dbo].[tbl_map_msg] where reg_id=@RegId", con))
            {
                cmd.Parameters.AddWithValue("@RegId", RegId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);

                        int len = dt.Rows.Count;
                        for (int i = 0; i < len; i++)
                        {
                            if (i == 0)
                                tmpmsg = dt.Rows[i]["msg_id"].ToString();
                            else
                                tmpmsg = tmpmsg + "," + dt.Rows[i]["msg_id"].ToString();
                        }
                    }
                }
            }
        }

        // highest qualification
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand("select hq_id from [dbo].[tbl_map_hq] where reg_id=@RegId", con))
            {
                cmd.Parameters.AddWithValue("@RegId", RegId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);

                        int len = dt.Rows.Count;
                        for (int i = 0; i < len; i++)
                        {
                            if (i == 0)
                                tmpHq = dt.Rows[i]["hq_id"].ToString();
                            else
                                tmpHq = tmpHq + "," + dt.Rows[i]["hq_id"].ToString();
                        }
                    }
                }
            }
        }

        // courses
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand("select course_id from [dbo].[tbl_map_course] where reg_id=@RegId", con))
            {
                cmd.Parameters.AddWithValue("@RegId", RegId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);

                        int len = dt.Rows.Count;
                        for (int i = 0; i < len; i++)
                        {
                            if (i == 0)
                                tmpCr = dt.Rows[i]["course_id"].ToString();
                            else
                                tmpCr = tmpCr + "," + dt.Rows[i]["course_id"].ToString();
                        }
                    }
                }
            }
        }

        qry = @"SELECT [Reg_Id],[Name],[Gender],[Country_Code],[phone_no],[emailid],[Country],[State] 'City',[CreatedOn],[UpdatedOn],ISNULL([TOEFLScore],0)TOEFLScore
      ,[msg],[hq],[course],[RegistrationNo],ISNULL([StudyAbroad],'Yes')StudyAbroad,[FeeRange],[Active] FROM [dbo].[tab_Registration] WHERE Reg_Id=@RegId";


        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@RegId", RegId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        foreach (DataRow dr in dt.Rows)
                        {
                            ClsRegistration det = new ClsRegistration();

                            det.Reg_Id = dr["Reg_Id"].ToString();
                            det.Name = dr["Name"].ToString();
                            det.Gender = dr["Gender"].ToString();
                            det.Country_Code = dr["Country_Code"].ToString();
                            det.phone_no = dr["phone_no"].ToString();
                            det.emailid = dr["emailid"].ToString();
                            det.Country = dr["Country"].ToString();
                            det.City = dr["City"].ToString();
                            det.CreatedOn = dr["CreatedOn"].ToString();
                            det.UpdatedOn = dr["UpdatedOn"].ToString();
                            det.TOEFLScore = dr["TOEFLScore"].ToString();
                            det.msg = dr["msg"].ToString();
                            det.hq = dr["hq"].ToString();
                            det.course = dr["course"].ToString();
                            det.RegistrationNo = dr["RegistrationNo"].ToString();
                            det.StudyAbroad = dr["StudyAbroad"].ToString();
                            det.FeeRange = dr["FeeRange"].ToString();
                            det.Active = dr["Active"].ToString();
                            det.msg = tmpmsg;
                            det.hq = tmpHq;
                            det.course = tmpCr;
                            details.Add(det);
                        }
                    }
                }
            }
        }

        return details.ToArray();
    }
    public class ClsRegistration
    {
        public string Reg_Id { get; set; }
        public string Name { get; set; }
        public string Gender { get; set; }
        public string Country_Code { get; set; }
        public string phone_no { get; set; }
        public string emailid { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string CreatedOn { get; set; }
        public string UpdatedOn { get; set; }
        public string TOEFLScore { get; set; }
        public string msg { get; set; }
        public string hq { get; set; }
        public string course { get; set; }
        public string RegistrationNo { get; set; }
        public string StudyAbroad { get; set; }
        public string FeeRange { get; set; }
        public string Active { get; set; }

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
                           // _table += "<tr><th>SNo.</th><td>" + dt.Rows[0]["Reg_Id"].ToString() + "</td></tr>";
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

    [System.Web.Services.WebMethod]
    public static stDetails[] c_bindmsg()
    {
        List<stDetails> details = new List<stDetails>();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select msg_id,msg_name from tbl_msgplatform";
            cmd.Connection = con;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                stDetails det = new stDetails();
                det.msgid = Convert.ToInt32(dr["msg_id"].ToString());
                det.msgname = dr["msg_name"].ToString();
                details.Add(det);
            }
        }
        return details.ToArray();
    }
    public class stDetails
    {
        public int msgid { get; set; }
        public string msgname { get; set; }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {


        string FullName = txtFullName.Text.Trim();
        string Gender = Request.Form["gn"].ToString();
        string Mobile = Request.Form["txtno"].ToString();
        string email = Request.Form["txtemail"].ToString();
        string country = Request.Form["txtcountry"].ToString();
        string city = Request.Form["city"].ToString();
        string ieltsScore = Request.Form["txtscore"].ToString();
        string Abroad = Request.Form["Abroad"].ToString();
        string fee = Request.Form["ddlFee"].ToString();
        string active = Request.Form["chkActive"].ToString();

        if (active == "on")
            active = "Yes";
        else
            active = "No";


        string MsgId = hdfMsgPlateUpdate.Value.ToString();
        string MsgText = hdfMsgPlateUpdateText.Value.ToString();

        string HqId = hdfHqUpdate.Value.ToString();
        string HqText = hdfHqUpdateText.Value.ToString();

        string CrId = hdfCrUpdate.Value.ToString();
        string CrText = hdfCrUpdateText.Value.ToString();
        string RegId = hdfEditRegId.Value.ToString();

        SqlTransaction transact = null;
        string RegNo = string.Empty;
        SqlConnection con = new SqlConnection(dbCon);

        try
        {

            con.Open();
            transact = con.BeginTransaction();
            string qry = string.Empty;
            qry = @"update tab_Registration set Name=@Name,Gender=@Gender,phone_no=@phone_no,emailid=@emailid,Country=@Country,State=@state,UpdatedOn=getdate(),
				TOEFLScore=@TOEFLScore,msg=@msg,hq=@hq,course=@course,StudyAbroad=@StudyAbroad,FeeRange=@FeeRange,Active=@Active where Reg_id=@Reg_id";
            SqlCommand cmd;
            cmd = new SqlCommand(qry, con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@Name", FullName);
            cmd.Parameters.AddWithValue("@Gender", Gender);
            //cmd.Parameters.AddWithValue("@Country_Code", ccode);
            cmd.Parameters.AddWithValue("@phone_no", Mobile);
            cmd.Parameters.AddWithValue("@emailid", email);
            cmd.Parameters.AddWithValue("@Country", country);
            cmd.Parameters.AddWithValue("@state", city);
            cmd.Parameters.AddWithValue("@City", "");
            cmd.Parameters.AddWithValue("@TOEFLScore", ieltsScore);
            cmd.Parameters.AddWithValue("@msg", MsgText);
            cmd.Parameters.AddWithValue("@hq", HqText);
            cmd.Parameters.AddWithValue("@course", CrText);
            cmd.Parameters.AddWithValue("@StudyAbroad", Abroad);
            cmd.Parameters.AddWithValue("@FeeRange", fee);
            cmd.Parameters.AddWithValue("@Active", active);
            cmd.Parameters.AddWithValue("@Reg_id", RegId);
            cmd.CommandTimeout = 0;
            cmd.Transaction = transact;
            cmd.ExecuteNonQuery();

            if (RegId != "0")
            {


                SqlCommand cmdDelMsg;
                cmdDelMsg = new SqlCommand("delete from tbl_map_msg where reg_id=@RegId", con);
                cmdDelMsg.Parameters.AddWithValue("@RegId", RegId);
                cmdDelMsg.CommandType = CommandType.Text;
                cmdDelMsg.CommandTimeout = 0;
                cmdDelMsg.Transaction = transact;
                cmdDelMsg.ExecuteNonQuery();

                SqlCommand cmdDelHq;
                cmdDelHq = new SqlCommand("delete from tbl_HigestQualification where HigestId=@RegId", con);
                cmdDelHq.Parameters.AddWithValue("@RegId", RegId);
                cmdDelHq.CommandType = CommandType.Text;
                cmdDelHq.CommandTimeout = 0;
                cmdDelHq.Transaction = transact;
                cmdDelHq.ExecuteNonQuery();

                SqlCommand cmdDelCr;
                cmdDelCr = new SqlCommand("delete from tbl_map_course where Reg_id=@RegId", con);
                cmdDelCr.Parameters.AddWithValue("@RegId", RegId);
                cmdDelCr.CommandType = CommandType.Text;
                cmdDelCr.CommandTimeout = 0;
                cmdDelCr.Transaction = transact;
                cmdDelCr.ExecuteNonQuery();

                string[] strMessage = MsgId.Split(',');
                int mLen = strMessage.Length;

                for (int i = 0; i < mLen; i++)
                {
                    int flag = 0;
                    SqlCommand cmd2;
                    cmd2 = new SqlCommand("insert into tbl_map_msg (reg_id,msg_id) values(@reg_id,@msg_id)", con);
                    cmd2.Parameters.AddWithValue("@reg_id", RegId);
                    cmd2.Parameters.AddWithValue("@msg_id", strMessage[i]);
                    cmd2.Transaction = transact;
                    cmd2.ExecuteNonQuery();
                }

                string[] strHq = HqId.Split(',');
                int hqLen = strHq.Length;

                for (int j = 0; j < hqLen; j++)
                {
                    int flag = 0;
                    SqlCommand cmd3;
                    cmd3 = new SqlCommand("insert into tbl_map_hq (reg_id,hq_id) values(@reg_id,@hq_id)", con);
                    cmd3.Parameters.AddWithValue("@reg_id", RegId);
                    cmd3.Parameters.AddWithValue("@hq_id", strHq[j]);
                    cmd3.Transaction = transact;
                    cmd3.ExecuteNonQuery();
                }
                string[] strCr = CrId.Split(',');
                int crLen = strCr.Length;
                for (int c = 0; c < crLen; c++)
                {
                    int flag = 0;
                    SqlCommand cmd4;
                    cmd4 = new SqlCommand("insert into tbl_map_course (reg_id,course_id) values(@reg_id,@c_id)", con);
                    cmd4.Parameters.AddWithValue("@reg_id", RegId);
                    cmd4.Parameters.AddWithValue("@c_id", strCr[c]);
                    cmd4.Transaction = transact;
                    cmd4.ExecuteNonQuery();
                }
            }
            transact.Commit();
            lblmsg.ForeColor = System.Drawing.Color.Green;
            lblmsg.Text = "Record has been updated successfully !.";

            bindRegion();
            bindGrid();
            FillMsgPlateform();
            FillHQualification();
            FillCourse();
        }
        catch (Exception ex)
        {
            transact.Rollback();
            lblmsg.Text = ""; ;
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {
            con.Close();
        }
    }

    public string FillMsgPlateform()
    {

        try
        {
            string qry = string.Empty;
            qry = @"select msg_id,msg_name from tbl_msgplatform order by msg_name asc";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            int len = dt.Rows.Count;
                            string f = "";
                            string value = "";
                            if (len > 0)
                            {
                                var id = "";
                                for (int i = 0; i < len; i++)
                                {
                                    value = dt.Rows[i]["msg_id"].ToString();
                                    id = "m" + value;
                                    _sbMsg.Append("<label for=" + id + "> <input type='checkbox' value='" + dt.Rows[i]["msg_name"].ToString() + "' id=" + id + " />&nbsp;" + dt.Rows[i]["msg_name"].ToString() + "</label>");
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ""; ;
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
        return _sbMsg.ToString();
    }

    public string FillHQualification()
    {

        try
        {
            string qry = string.Empty;
            qry = @"select HigestId,HigestQualificationName from tbl_HigestQualification order by HigestQualificationName asc";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            int len = dt.Rows.Count;
                            string f = "";
                            string value = "";
                            if (len > 0)
                            {

                                for (int i = 0; i < len; i++)
                                {

                                    value = dt.Rows[i]["HigestId"].ToString();
                                    _sbHQ.Append("<label for=q" + value + "> <input type='checkbox' value='" + dt.Rows[i]["HigestQualificationName"].ToString() + "' id=q" + value + " />&nbsp;" + dt.Rows[i]["HigestQualificationName"].ToString() + "</label>");
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ""; ;
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
        return _sbHQ.ToString();
    }
    public string FillCourse()
    {

        try
        {
            string qry = string.Empty;
            qry = @"select CourseId,CourseName from tbl_Course order by CourseName asc";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            int len = dt.Rows.Count;
                            string f = "";
                            string value = "";
                            if (len > 0)
                            {

                                for (int i = 0; i < len; i++)
                                {

                                    value = dt.Rows[i]["CourseId"].ToString();
                                    _sbCourse.Append("<label for=c" + value + "> <input type='checkbox' value='" + dt.Rows[i]["CourseName"].ToString() + "' id=c" + value + " />&nbsp;" + dt.Rows[i]["CourseName"].ToString() + "</label>");
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ""; ;
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
        return _sbCourse.ToString();
    }


}
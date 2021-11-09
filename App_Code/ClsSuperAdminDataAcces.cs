using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// Summary description for ClsSuperAdminDataAcces
/// </summary>
public class ClsSuperAdminDataAcces
{

    public string Source = "SuperAdmin";
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    public ClsSuperAdminDataAcces()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public DataTable ValidateLogin(string UserName, string Password)
    {
        string qry = string.Empty;
        qry = @"SELECT UserId,UserName,Password,ISNULL(CurrentLoginStatus,'')CurrentLoginStatus,LoginType FROM tbl_UserDetails where UserName=@Uname AND Password=@Password AND LoginType='SuperAdmin' AND Status='1'";
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
                        return dt;
                    }
                }
            }
        }
    }
    public string SaveUpdateUniversity(string Name, string mail, string Uid, string Status, string UserId, string RegionId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            if (!string.IsNullOrEmpty(Uid))
            {
                Qry = @"IF EXISTS(SELECT 1 FROM Tab_University WHERE UniversityName=@Name AND Id!=@Uid)                        
                        SELECT 'N'
                        ELSE IF EXISTS(SELECT 1 FROM Tab_University WHERE Email=@Email AND Id!=@Uid)
                        SELECT 'E'
                        ELSE
                        BEGIN
                        UPDATE Tab_University SET UniversityName=@Name,Email=@Email,ModifyDateTime=getdate(),Active=@sts,ModifyBy=@UserId WHERE Id=@Uid
                        SELECT '" + Uid + "' END";
            }
            else
            {
                Qry = @"IF EXISTS (SELECT 1 FROM Tab_University WHERE UniversityName=@Name)                        
                        SELECT 'N'
                        ELSE IF EXISTS (SELECT 1 FROM Tab_University WHERE Email=@Email)
                        SELECT 'E'
                        ELSE
                        BEGIN
                        INSERT INTO Tab_University(UniversityName,Email,Active,CreatedBy,CreatedDateTime) VALUES(@Name,@Email,@sts,@UserId,getdate())
                        SELECT SCOPE_IDENTITY();
                        END";
            }

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@Name", Name);
                    cmd.Parameters.AddWithValue("@Email", mail);
                    cmd.Parameters.AddWithValue("@sts", Status);
                    cmd.Parameters.AddWithValue("@Uid", Uid);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Rslt = Convert.ToString(cmd.ExecuteScalar());
                    con.Close();
                }
            }
            if (Rslt != "E" || Rslt != "N")
            {
                Qry = "";
                Qry = @"DELETE FROM Tab_MappedRegionInUniversity WHERE UniversityId=@UniversityId";


                using (SqlConnection con = new SqlConnection(dbCon))
                {
                    using (SqlCommand cmd = new SqlCommand(Qry, con))
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@UniversityId", Rslt);
                        cmd.CommandTimeout = 0;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                Qry = "";
                Qry = @" INSERT INTO Tab_MappedRegionInUniversity (UniversityId,RegionId) VALUES(@UniversityId, @RegionId)";

                string[] RegArray = RegionId.Split(',');
                int len = RegArray.Length;

                for (int i = 0; i < len; i++)
                {
                    if (RegArray[i] != "")
                    {
                        using (SqlConnection con = new SqlConnection(dbCon))
                        {
                            using (SqlCommand cmd = new SqlCommand(Qry, con))
                            {
                                cmd.CommandType = CommandType.Text;
                                cmd.Parameters.AddWithValue("@UniversityId", Rslt);
                                cmd.Parameters.AddWithValue("@RegionId", RegArray[i].ToString());
                                cmd.CommandTimeout = 0;
                                con.Open();
                                cmd.ExecuteNonQuery();
                                con.Close();
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public DataTable GetUniversityList(string SearchValue, string RowPerPage, string PageNumber)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT ROW_NUMBER() over(order by Id DESC)'SNo',COUNT(*) OVER(PARTITION BY 1)TotalRows, Id,UniversityName 'Name',Email,Active,CreatedDateTime FROM Tab_University WHERE 1=1 ";
            if (SearchValue != "")
            {
                qry += " AND UniversityName like '%" + SearchValue + "%' OR Email like '%" + SearchValue + "%' OR Active like '%" + SearchValue + "%'";
            }

            qry += " ORDER BY Id desc OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public DataTable GetUniversityDetails(string Uid)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT Id,UniversityName,Email,Active,Logo  FROM Tab_University WHERE Id=@Uid";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@Uid", Uid);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public string DelUniversity(string Uid)
    {
        string Rslt = string.Empty;
        try
        {

            string Qry = string.Empty;

            string FileName = GetFileName("SELECT ISNULL(Logo,'')Logo FROM Tab_University WHERE Id=" + Uid + "");

            Qry = @"DELETE FROM Tab_University WHERE Id=@Uid";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@Uid", Uid);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "D";
                }
            }
            if (!string.IsNullOrEmpty(FileName))
            {
                string path = HttpContext.Current.Server.MapPath("../UploadedLogo/" + FileName);
                DeleteFile(path);
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;

    }
    public string DeleteFile(string FileWithPath)
    {
        string Rslt = string.Empty;
        try
        {
            if (System.IO.File.Exists(FileWithPath))
            {
                System.IO.File.Delete(FileWithPath);
                Rslt = "Ok";
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public string GetFileName(string Qry)
    {
        string Rslt = string.Empty;
        try
        {
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandTimeout = 0;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (dt.Rows.Count > 0)
                                Rslt = dt.Rows[0][0].ToString();
                            else
                                Rslt = "";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public DataTable FillRegion()
    {
        string qry = string.Empty;
        qry = @"SELECT Id,RName FROM TabMst_Region ORDER BY RName ASC";
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }
    public DataTable FillRegGrid(string RegionId, string RowPerPage, string PageNumber, string Course, string Qualification, string Country, string Status, string StudentName, string Flag)
    {
        DataTable dt = new DataTable();

        string qry = string.Empty;
        if (Qualification == "-Qualification-")
            Qualification = "";
        if (Course == "-Courses-")
            Course = "";

        qry = @"SELECT ROW_NUMBER() over(order by Reg_Id DESC) SNo,COUNT(*) OVER(PARTITION BY 1)TotalRows,Reg_Id,RegistrationNo [RegNo],r.Gender,Name,r.emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],r.CreatedOn,Active,r.updatedOn,(u1.FirstName+' '+u1.LastName)'AssignedBy',(u2.FirstName+' '+u2.LastName)'AssignedTo',Flag=ISNULL((select TOP(1) f.Flag from  Tab_Mst_RegistrationNotes f where f.LeadId=r.Reg_Id ORDER BY f.Id DESC),''),(u3.FirstName+' '+u3.LastName)LastUpdatedBy from tab_Registration r";
        qry += " left outer join Tab_AssignedLead l on r.Reg_Id=l.LeadId left outer join tbl_UserDetails u1 on l.AssignedBy=u1.UserId left outer join tbl_UserDetails u2 on l.AssignedTo=u2.UserId left outer join tbl_UserDetails u3 on r.ModifyBy=u3.UserId where 1=1";

        if (RegionId != "-All Region-")
        {

            qry += " and r.RegionId=@RegionId";
        }

        if (Status == "Ac")
        {
            qry += @" and r.Active='Yes'";
        }
        else if (Status == "In")
        {
            qry += @" and r.Active='No'";
        }

        if (Course != "")
        {
            Course = GetCourseById(Course);
            qry += @" and (r.course like '%," + Course + ",%' or r.course like '%," + Course + "%' or r.course like '%" + Course + ",%' or r.course like '%" + Course + "%' )";
        }
        if (Qualification != "")
        {
            Qualification = GetQualificationById(Qualification);
            qry += @" and ( r.hq like '%" + Qualification + "%' or r.hq like '%," + Qualification + ",%' or r.hq like '%," + Qualification + "%' or r.hq like '%" + Qualification + ",%' )";
        }
        if (Country != "")
        {
            qry += @" and r.country like '%" + Country + "%'";
        }
        if (StudentName != "")
        {
            qry += @" and (r.Name like '%" + StudentName + "%' OR r.RegistrationNo like '%" + StudentName + "%')";
        }
        if (Flag != "All Flag")
        {
            qry += @" and r.ActivityStatus='" + Flag + "'";
        }
        qry += @" ORDER BY r.Reg_Id DESC";
        qry += " OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";

        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@RegionId", RegionId.ToString());
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }

        return dt;
    }
    public string GetRegDetails(string Id)
    {
        string _table = string.Empty;
        string qry = string.Empty;
        qry = @"SELECT [Reg_Id],[Name],[Gender],[Country_Code],[phone_no],(cast([Country_Code] as varchar(20))+cast([phone_no] as varchar(100))) WhatsApp, [emailid],[Country],[State] 'City',[CreatedOn],[UpdatedOn],[TOEFLScore]
      ,[msg],[hq],[course],[RegistrationNo],[StudyAbroad],[FeeRange],[Active],[IPAddress] FROM [dbo].[tab_Registration] WHERE Reg_Id=@RegId";

        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@RegId", Id);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            _table += "<tbody>";
                            _table += "<tr><td>Registration No.</td><td>" + dt.Rows[0]["RegistrationNo"].ToString() + "</td></tr>";
                            _table += "<tr><td>Full Name</td><td>" + dt.Rows[0]["Gender"].ToString() + " " + dt.Rows[0]["Name"].ToString() + "</td></tr>";
                            _table += "<tr><td>E-Mail</td><td>" + dt.Rows[0]["emailid"].ToString() + "</td></tr>";
                            _table += "<tr><td>Phone</td><td>" + dt.Rows[0]["Country_Code"].ToString() + "-" + dt.Rows[0]["phone_no"].ToString() + "</td></tr>";
                            _table += "<tr><td>Country</td><td>" + dt.Rows[0]["Country"].ToString() + "</td></tr>";
                            _table += "<tr><td>City</td><td>" + dt.Rows[0]["City"].ToString() + "</td></tr>";
                            _table += "<tr><td>Select Platform You Use</td><td>" + dt.Rows[0]["msg"].ToString() + "</td></tr>";
                            _table += "<tr><td>Current Highest Qualification</td><td>" + dt.Rows[0]["hq"].ToString() + "</td></tr>";
                            _table += "<tr><td>What Course Are You Looking For</td><td>" + dt.Rows[0]["course"].ToString() + "</td></tr>";
                            _table += "<tr><td>IELTS/TOEFL</td><td>" + dt.Rows[0]["TOEFLScore"].ToString() + "</td></tr>";
                            _table += "<tr><td>Are You Planning To Study Abroad</td><td>" + dt.Rows[0]["StudyAbroad"].ToString() + "</td></tr>";
                            _table += "<tr><td>What Fee Range Are You Looking At</td><td>" + dt.Rows[0]["FeeRange"].ToString() + "</td></tr>";
                            _table += "<tr><td>Active</td><td>" + dt.Rows[0]["Active"].ToString() + "</td></tr>";
                            _table += "<tr><td>Social Media</td>";

                            string TmpPhone = dt.Rows[0]["WhatsApp"].ToString();
                            string PhoneNumbWithPlus = "", PhoneNumbWithoutPlus = "", Plateform = "";

                            PhoneNumbWithPlus = TmpPhone;
                            if (TmpPhone.Contains("+") == true)
                                PhoneNumbWithoutPlus = TmpPhone.Replace("+", "");
                            else
                                PhoneNumbWithoutPlus = TmpPhone;

                            var strLen = PhoneNumbWithoutPlus.Length;
                            for (var tt = 0; tt <= 0; tt++)
                            {
                                if (PhoneNumbWithoutPlus[tt].ToString() == "0")
                                    PhoneNumbWithoutPlus = PhoneNumbWithoutPlus.Substring(1, PhoneNumbWithoutPlus.Length);
                            }


                            Plateform = dt.Rows[0]["msg"].ToString().Trim();
                            string[] PlateformArray = Plateform.Split(',');
                            var SmLen = PlateformArray.Length;

                            _table += "<td>";
                            for (int s = 0; s < SmLen; s++)
                            {
                                if (PlateformArray[s].Trim().ToUpper() == "WHATSAPP")
                                {
                                    _table += "<a href=https://web.whatsapp.com/send?phone=" + dt.Rows[0]["WhatsApp"].ToString() + "&amp;text=Hi target='_blank'><img src='http://qstudyabroad.com/admin/img/WhatsApp.png' height='27' style='cursor:pointer'></a>";
                                }
                                else if (PlateformArray[s].Trim().ToUpper() == "VIBER")
                                {
                                    _table += "<a href='viber://keypad?number=%2B" + PhoneNumbWithoutPlus + "' target='_blank'>&nbsp;<img src='../img/Viber.png' height='20' style='cursor:pointer' />&nbsp;";
                                }
                                else if (PlateformArray[s].Trim().ToUpper() == "IMO")
                                {
                                    _table += "<a href='https://imo.onelink.me/nbj0/df13cbc#' target='_blank'>&nbsp;<img src='../img/imo.png' height='20' style='cursor:pointer' />&nbsp;</a>&nbsp;";
                                }
                                else if (PlateformArray[s].Trim().ToUpper() == "TELEGRAM")
                                {
                                    _table += "<a href='https://web.telegram.org' target='_blank'>&nbsp;<img src='../img/telegram.png' height='20' style='cursor:pointer' />&nbsp;</a>&nbsp;";
                                }
                            }
                            _table += "</td></tr>";

                            _table += "<tr><td>E-Mail</td><td><a href='http://mail.qstudyabroad.com/Login.aspx' target='_blank'><img src='http://qstudyabroad.com/admin/img/mail.png' height='26' style='cursor:pointer'></a></td></tr>";
                            _table += "<tr><td>IPAddress</td><td>" + dt.Rows[0]["IPAddress"].ToString() + "</td></tr>";
                            _table += "</tbody>";
                        }
                    }
                }
            }
        }
        return _table;
    }
    public string DeleteReg(string RegId)
    {
        string Rslt = string.Empty;
        try
        {
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
                    Rslt = "D";
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public string UpdateStatus(string RegId, string sts)
    {
        string Rslt = string.Empty;
        try
        {
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Update tab_Registration set Active=@sts where Reg_id=@Reg_id", con))
                {
                    cmd.Parameters.AddWithValue("@Reg_id", RegId);
                    cmd.Parameters.AddWithValue("@sts", sts);
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "D";
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    private string GetQualificationById(string Id)
    {
        string Rslt = string.Empty;
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(HigestQualificationName,'')HigestQualificationName FROM [dbo].[tbl_HigestQualification] WHERE HigestId=@Id", con))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@Id", Id);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                            Rslt = dt.Rows[0]["HigestQualificationName"].ToString();
                    }
                }
            }
        }
        return Rslt;
    }
    private string GetCourseById(string Id)
    {
        string Rslt = string.Empty;
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(CourseName,'')CourseName FROM [dbo].[tbl_Course] WHERE CourseId=@Id", con))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@Id", Id);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                            Rslt = dt.Rows[0]["CourseName"].ToString();
                    }
                }
            }
        }
        return Rslt;
    }
    public string FillMsgPlateform()
    {
        StringBuilder _sbMsg = new StringBuilder();
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
        }
        return _sbMsg.ToString();
    }
    public string FillHQualification()
    {
        StringBuilder _sbHQ = new StringBuilder();
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
        }
        return _sbHQ.ToString();
    }
    public string FillCourse()
    {
        StringBuilder _sbCourse = new StringBuilder();
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

        }
        return _sbCourse.ToString();
    }
    public string GetMappedMsgPlateFormByRegId(string RegId)
    {
        string tmpmsg = string.Empty;
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
        return tmpmsg;
    }
    public string GetMappedCourseByRegId(string RegId)
    {
        string tmpCr = string.Empty;
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
        return tmpCr;
    }
    public string GetMappedQualificationByRegId(string RegId)
    {
        string tmpHq = string.Empty;
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
        return tmpHq;
    }
    public DataTable GetRegistrationEditData(string RegId)
    {
        DataTable dt = new DataTable();
        string qry = string.Empty;
        qry = @"SELECT [Reg_Id],[Name],[Gender],[Country_Code],[phone_no],[emailid],[Country],[State] 'City',[CreatedOn],[UpdatedOn],ISNULL([TOEFLScore],0)TOEFLScore
      ,[msg],[hq],[course],[RegistrationNo],ISNULL([StudyAbroad],'Yes')StudyAbroad,[FeeRange],[Active] FROM [dbo].[tab_Registration] WHERE Reg_Id=@RegId";

        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@RegId", RegId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }
        return dt;
    }
    public string UpdateRegistration(string RegId, string Gender, string FullName, string Mobile, string email, string country, string city, string ieltsScore, string Abroad, string fee, string active, string MsgId, string MsgText, string HqId, string HqText, string CrId, string CrText, string UserId)
    {
        string Rslt = string.Empty;

        /* if (active == "on")
             active = "Yes";
         else
             active = "No";*/

        SqlTransaction transact = null;
        string RegNo = string.Empty;
        SqlConnection con = new SqlConnection(dbCon);

        try
        {

            con.Open();
            transact = con.BeginTransaction();
            string qry = string.Empty;
            qry = @"update tab_Registration set Name=@Name,Gender=@Gender,phone_no=@phone_no,emailid=@emailid,Country=@Country,State=@state,UpdatedOn=getdate(),
				TOEFLScore=@TOEFLScore,msg=@msg,hq=@hq,course=@course,StudyAbroad=@StudyAbroad,FeeRange=@FeeRange,Active=@Active,ModifyBy=@UserId where Reg_id=@Reg_id";
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
            cmd.Parameters.AddWithValue("@UserId", UserId);
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
            Rslt = "S";
        }
        catch (Exception ex)
        {
            transact.Rollback();
            Rslt = "ER";
        }
        finally
        {
            con.Close();
        }
        return Rslt;
    }

    // Nidhi 11/08/21

    public string SaveUpdateUser(string FirstName, string LastName, string Gender, string Name, string Status, string mail, string pwd, string Uid, string userType, string university, string Role)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            if (!string.IsNullOrEmpty(Uid))
            {
                Qry = @"IF EXISTS (SELECT 1 FROM tbl_UserDetails WHERE UserName=@Name AND UserId!=@Uid)                        
                        SELECT 1
                        ELSE IF EXISTS(SELECT 1 FROM tbl_UserDetails WHERE EmailId=@Email AND UserId!=@Uid)
                        SELECT 3
                        ELSE
                        BEGIN
                        UPDATE tbl_UserDetails SET FirstName=@FirstName,LastName=@LastName,Gender=@Gender,UserName=@Name,Status=@Status,EmailId=@Email,Password=@Pwd,LoginType=@LoginType,university=@university,Role=@Role WHERE UserId=@Uid 
                        SELECT 4
                        END";

            }
            else
            {
                Qry = @"IF EXISTS (SELECT 1 FROM tbl_UserDetails WHERE UserName=@Name)                        
                        SELECT 1
                        ELSE IF EXISTS (SELECT 1 FROM tbl_UserDetails WHERE EmailId=@Email)
                        SELECT 3
                        ELSE
                        BEGIN
                        INSERT INTO tbl_UserDetails(FirstName,LastName,Gender,UserName,EmailId,Password,Status,LoginType,university,CreatedOn,Role) VALUES(@FirstName,@LastName,@Gender,@Name,@Email,@Pwd,@Status,@LoginType,@university,getdate(),@Role)
                        SELECT 5
                        END";
            }

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@FirstName", FirstName);
                    cmd.Parameters.AddWithValue("@LastName", LastName);
                    cmd.Parameters.AddWithValue("@Gender", Gender);
                    cmd.Parameters.AddWithValue("@Name", Name);
                    cmd.Parameters.AddWithValue("@Email", mail);
                    cmd.Parameters.AddWithValue("@Pwd", pwd);
                    cmd.Parameters.AddWithValue("@Uid", Uid);
                    cmd.Parameters.AddWithValue("@Status", Status);
                    cmd.Parameters.AddWithValue("@LoginType", userType);
                    cmd.Parameters.AddWithValue("@university", university);
                    cmd.Parameters.AddWithValue("@Role", Role);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Rslt = Convert.ToString(cmd.ExecuteScalar());
                    con.Close();
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public DataTable GetUserList(string SearchValue, string UserType, string RowPerPage, string PageNumber)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT ROW_NUMBER() over(order by UserId desc)'SNo', UserId,FirstName,LastName,Gender,UserName 'Name',EmailId,Password,Status,LoginType,case when university=0 then '-' else Tab_University.UniversityName end as 'university' ";
            qry += "FROM tbl_UserDetails left join Tab_University on tbl_UserDetails.university=Tab_University.Id Where 1=1 ";
            if (Convert.ToString(SearchValue) != "")
            {
                qry += " and UserName like '%" + SearchValue + "%' ";
            }
            if (UserType != "0")
            {
                qry += " and LoginType = '" + UserType + "' ";
            }
            qry += " ORDER BY UserId desc OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public DataTable GetUniversityDDLList()
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT distinct Id,UniversityName  FROM Tab_University ORDER BY UniversityName desc";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public DataTable GetUserDetails(string Uid)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT UserId,FirstName,LastName,Gender,UserName 'Name',EmailId,Password,Status,LoginType,university,Role ";
            qry += "FROM tbl_UserDetails WHERE UserId=@Uid";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@Uid", Uid);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public string DelUser(string Uid)
    {
        string Rslt = string.Empty;
        try
        {

            string Qry = string.Empty;
            Qry = @"DELETE FROM tbl_UserDetails WHERE UserId=@Uid";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@Uid", Uid);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "D";
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;

    }

    // End 

    // ARV 12-8-21
    public DataTable GetCounsersList()
    {
        DataTable dt = new DataTable();
        try
        {
            string qry = string.Empty;
            qry = @"SELECT UserId,(FirstName+' '+LastName)UName FROM [dbo].[tbl_UserDetails] WHERE Status='1' AND LoginType='Qstudy' ORDER BY FirstName,LastName ASC";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public string AssignLead(string LeadId, string AssignTo, string AssignBy)
    {
        string Rslt = string.Empty;
        int counter = 0;
        try
        {
            string Qry = string.Empty;

            string[] Ary = LeadId.Split(',');
            int len = Ary.Length;
            string leadId = string.Empty;

            foreach (var items in Ary)
            {
                leadId = items.ToString();
                Qry = @"IF EXISTS(SELECT 1 FROM Tab_AssignedLead WHERE LeadId IN(" + leadId + "))";
                Qry += " SELECT 'EX'";
                Qry += " ELSE BEGIN";
                Qry += " INSERT INTO Tab_AssignedLead(AssignedTo,AssignedBy,LeadId) VALUES(@AssignTo,@AssignedBy,@Leadid)";
                Qry += " UPDATE tab_Registration SET ModifyBy=@UserId,UpdatedOn=GETDATE() WHERE Reg_Id IN(@Leadid)";
                Qry += " SELECT 'S'";
                Qry += " END";

                using (SqlConnection con = new SqlConnection(dbCon))
                {
                    using (SqlCommand cmd = new SqlCommand(Qry, con))
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@AssignTo", AssignTo);
                        cmd.Parameters.AddWithValue("@AssignedBy", AssignBy);
                        cmd.Parameters.AddWithValue("@LeadId", leadId);
                        cmd.Parameters.AddWithValue("@UserId", AssignBy);
                        cmd.CommandTimeout = 0;
                        con.Open();
                        Rslt = Convert.ToString(cmd.ExecuteScalar());
                        con.Close();
                        if (Rslt == "S")
                            counter = counter + 1;
                    }
                }

            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt + "^" + counter.ToString();
    }
    public string GetRegActivity(string Id)
    {
        string _table = string.Empty;
        string qry = string.Empty;
        qry = @"SELECT a.IconUrl,a.PlateFormName,a.ActivityMessage,a.ActivityDateTime,(u.FirstName+' '+u.LastName)'ActivityDoneBy' FROM Tab_SocialPlateformActivity a
                INNER JOIN tbl_UserDetails u ON a.UserId=u.UserId WHERE a.LeadId=@RegId ORDER BY a.Id DESC";

        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@RegId", Id);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            int len = dt.Rows.Count;
                            string icon = string.Empty;
                            for (int k = 0; k < len; k++)
                            {
                                icon = "http://qstudyabroad.com/admin/img/" + dt.Rows[k]["IconUrl"].ToString();
                                _table += "<tr>";
                                _table += "<td>" + dt.Rows[k]["PlateFormName"].ToString() + "</td>";
                                _table += "<td><img src='" + icon + "' alt='icon' height='40'/></td>";
                                _table += "<td>" + dt.Rows[k]["ActivityMessage"].ToString() + "</td>";
                                _table += "<td>" + dt.Rows[k]["ActivityDateTime"].ToString() + "</td>";
                                _table += "<td>" + dt.Rows[k]["ActivityDoneBy"].ToString() + "</td>";
                                _table += "</tr>";
                            }
                        }
                    }
                }
            }
        }
        return _table;
    }
    public string MoveReg(string LeadId, string RegionId, string UserId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            Qry = @"UPDATE tab_Registration SET RegionId=@RegionId,RegionChangedBy=@UserId,RegionChangedDateTime=GETDATE(),ModifyBy=@UserId,UpdatedOn=GETDATE() WHERE Reg_Id IN(" + LeadId + ")";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@RegionId", RegionId);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.Parameters.AddWithValue("@LeadId", LeadId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Rslt = Convert.ToString(cmd.ExecuteNonQuery());
                    con.Close();
                    Rslt = "S";
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    // ARV end 12-8-21

    // ARV 13-8-21
    public DataTable GetLogedInUserList(string SearchValue, string RowPerPage, string PageNumber)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT ROW_NUMBER() over(order by UserId DESC)'SNo',COUNT(*) OVER(PARTITION BY 1)TotalRows,UserId,(FirstName+' '+LastName)'Name',UserName,LoginType,CurrentLoginStatus,LoginDateTime FROM tbl_UserDetails WHERE 1=1 AND CurrentLoginStatus='LogIn'";
            if (SearchValue != "")
            {
                qry += " AND (FirstName like '%" + SearchValue + "%' OR LastName like '%" + SearchValue + "%' OR UserName like '%" + SearchValue + "%' OR LoginType like '%" + SearchValue + "%') ";
            }

            qry += " ORDER BY LoginDateTime DESC  OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public DataTable GetUniversityWithoutAssignBooth()
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT Id,UniversityName FROM Tab_University WHERE Active='Yes' AND Id NOT IN(SELECT DISTINCT(AssignedUniversityId) FROM Tab_MstBooth) ORDER BY UniversityName ASC";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public string SaveUpdateBooth(string BoothName, string AssignedUniversityId, string Active, string BoothId, string UserId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            if (!string.IsNullOrEmpty(BoothId))
            {
                Qry = @"IF EXISTS(SELECT 1 FROM Tab_MstBooth WHERE BoothName=@BoothName AND Id!=@BoothId)                        
                        SELECT 'N'
                        ELSE IF EXISTS(SELECT 1 FROM Tab_MstBooth WHERE AssignedUniversityId=@AssignedUniversityId AND Id!=@BoothId)
                        SELECT 'U'
                        ELSE
                        BEGIN
                        UPDATE Tab_MstBooth SET BoothName=@BoothName,AssignedUniversityId=@AssignedUniversityId,Active=@Active,UpdatedDateTime=getdate(),UpdatedBy=@UserId WHERE Id=@BoothId
                        SELECT '" + BoothId + "' END";
            }
            else
            {
                Qry = @"IF EXISTS (SELECT 1 FROM Tab_MstBooth WHERE BoothName=@BoothName)                        
                        SELECT 'N'
                        ELSE IF EXISTS (SELECT 1 FROM Tab_MstBooth WHERE AssignedUniversityId=@AssignedUniversityId)
                        SELECT 'U'
                        ELSE
                        BEGIN
                        INSERT INTO Tab_MstBooth(BoothName,AssignedUniversityId,Active,CreatedBy,CreatedDateTime) VALUES(@BoothName,@AssignedUniversityId,@Active,@UserId,getdate())
                        SELECT SCOPE_IDENTITY();
                        END";
            }

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@BoothName", BoothName);
                    cmd.Parameters.AddWithValue("@AssignedUniversityId", AssignedUniversityId);
                    cmd.Parameters.AddWithValue("@Active", Active);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.Parameters.AddWithValue("@BoothId", BoothId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Rslt = Convert.ToString(cmd.ExecuteScalar());
                    con.Close();
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public DataTable GetBoothList(string SearchValue, string RowPerPage, string PageNumber)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT ROW_NUMBER() over(order by b.Id DESC)'SNo',COUNT(*) OVER(PARTITION BY 1)TotalRows, b.id,b.BoothName,b.Active, u.UniversityName,b.createdDateTime FROM Tab_MstBooth b LEFT OUTER JOIN Tab_University u ON b.AssignedUniversityId=u.Id WHERE 1=1 ";
            if (SearchValue != "")
            {
                qry += " AND b.BoothName like '%" + SearchValue + "%' OR u.UniversityName like '%" + SearchValue + "%' OR b.Active like '%" + SearchValue + "%'";
            }

            qry += " ORDER BY b.Id desc OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public DataTable GetBoothDetails(string BoothId)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT b.id,b.BoothName,b.Active,u.UniversityName,isnull(u.Id,'')'UniversityId',b.createdDateTime,(s.FirstName+' '+s.LastName)'CreatedBy',isnull(b.LogoImageFunc,'')LogoImageFunc,
                    isnull(b.BoothImageFunc,'')BoothImageFunc FROM Tab_MstBooth b LEFT OUTER JOIN Tab_University u
                    ON b.AssignedUniversityId=u.Id inner join tbl_UserDetails s on b.createdBy=s.UserId WHERE b.id=@BoothId";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@BoothId", BoothId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public string DelBooth(string BoothId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            //string FileName = GetFileName("SELECT ISNULL(Logo,'')Logo FROM Tab_University WHERE Id=" + Uid + "");

            Qry = @"DELETE FROM Tab_MstBooth WHERE Id=@BoothId";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@BoothId", BoothId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "D";
                }
            }
            /* if (!string.IsNullOrEmpty(FileName))
             {
                 string path = HttpContext.Current.Server.MapPath("../UploadedLogo/" + FileName);
                 DeleteFile(path);
             }*/
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;

    }
    // ARV 13-8-21 END

    // ARV 16-8-21
    public string GetRegionByName(string RName)
    {
        string tmpCr = string.Empty;
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT id FROM TabMst_Region WHERE RName=@RName", con))
            {
                cmd.Parameters.AddWithValue("@RName", RName);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                            tmpCr = dt.Rows[0]["id"].ToString();
                        else
                            tmpCr = "";
                    }
                }
            }
        }
        return tmpCr;
    }
    // END ARV 16-8-21
    public string GetMappedRegionInUniversityByUId(string UniversityId)
    {
        string tmpmsg = string.Empty;
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT RegionId FROM Tab_MappedRegionInUniversity WHERE UniversityId=@UniversityId", con))
            {
                cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);

                        int len = dt.Rows.Count;
                        for (int i = 0; i < len; i++)
                        {
                            if (i == 0)
                                tmpmsg = dt.Rows[i]["RegionId"].ToString();
                            else
                                tmpmsg = tmpmsg + "," + dt.Rows[i]["RegionId"].ToString();
                        }
                    }
                }
            }
        }
        return tmpmsg;
    }
    public DataTable BindEventHtmlTable()
    {
        string qry = string.Empty;
        qry = @"SELECT Id,UniversityName FROM Tab_University WHERE Active='Yes' ORDER BY UniversityName ASC";
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }
    public DataTable BindBoothDDL()
    {
        string qry = string.Empty;
        qry = @"SELECT Id,BoothName FROM Tab_MstBooth WHERE Active='Yes' ORDER BY BoothName ASC";
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }
    public int TotalPosition()
    {
        int Total = 0;
        string qry = string.Empty;
        qry = @"SELECT ISNULL(count(*),0)TotalPosition FROM Tab_University WHERE Active='Yes'";
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                            Total = Convert.ToInt32(dt.Rows[0]["TotalPosition"].ToString());
                        return Total;
                    }
                }
            }
        }
    }
    public string EventSaveUpdate(List<EventModel> model, string UserId)
    {
        string Rslt = string.Empty;
        SqlConnection con = new SqlConnection(dbCon);
        SqlTransaction transact = null;
        try
        {
            string EventName = "", EventDate = "", EventId = "", Universityid = "", BoothId = "", Position = "", Status = "", LineNo = "";
            string Qry = string.Empty;
            string MxId = string.Empty;
            EventName = model[0].EventName;
            EventId = model[0].EventId;
            EventDate = model[0].EventDate;
            Status = model[0].Status;
            con.Open();
            transact = con.BeginTransaction();

            if (EventId == "0")
            {
                Qry = "";
                Qry += @"IF EXISTS(SELECT 1 FROM Tab_Mst_Event WHERE EventName=@EventName)";
                Qry += " SELECT 'EX'";
                Qry += " ELSE BEGIN";
                Qry += " INSERT INTO Tab_Mst_Event(EventName,EventDateTime,Status,CreatedBy,CreatedDateTime)VALUES(@EventName,@EventDateTime,@Status,@CreatedBy,GETDATE())";
                Qry += " SELECT SCOPE_IDENTITY();";
                Qry += " END";
            }
            else
            {
                Qry = "";
                Qry += @"IF EXISTS(SELECT 1 FROM Tab_Mst_Event WHERE EventName=@EventName AND Id!=@EventId)";
                Qry += " SELECT 'EX'";
                Qry += " ELSE BEGIN";
                Qry += " UPDATE Tab_Mst_Event SET EventName=@EventName,EventDateTime=@EventDateTime,Status=@Status,ModifyBy=@ModifyBy,ModifyDateTime=GETDATE() WHERE Id=@EventId";
                Qry += " SELECT 'U'";
                Qry += " END";
            }
            SqlCommand cmdMaster = new SqlCommand(Qry, con);
            cmdMaster.CommandType = CommandType.Text;
            cmdMaster.Parameters.AddWithValue("@EventId", EventId);
            cmdMaster.Parameters.AddWithValue("@EventName", EventName);
            cmdMaster.Parameters.AddWithValue("@EventDateTime", EventDate);
            cmdMaster.Parameters.AddWithValue("@Status", Status);
            cmdMaster.Parameters.AddWithValue("@ModifyBy", UserId);
            cmdMaster.Parameters.AddWithValue("@CreatedBy", UserId);
            cmdMaster.CommandTimeout = 0;
            cmdMaster.Transaction = transact;
            Rslt = Convert.ToString(cmdMaster.ExecuteScalar());

            if (Rslt != "EX")
            {

                if (Rslt != "U" && Rslt != "EX")
                    EventId = Rslt;


                /* SqlCommand cmdChangeStatus = new SqlCommand("DELETE FROM Tab_EventDetails WHERE EventId=@EventId", con);
                 cmdChangeStatus.CommandType = CommandType.Text;
                 cmdChangeStatus.Parameters.AddWithValue("@EventId", EventId);
                 cmdChangeStatus.CommandTimeout = 0;
                 cmdChangeStatus.Transaction = transact;
                 cmdChangeStatus.ExecuteNonQuery();
                 */

                SqlCommand cmdDel = new SqlCommand("DELETE FROM Tab_EventDetails WHERE EventId=@EventId", con);
                cmdDel.CommandType = CommandType.Text;
                cmdDel.Parameters.AddWithValue("@EventId", EventId);
                cmdDel.CommandTimeout = 0;
                cmdDel.Transaction = transact;
                cmdDel.ExecuteNonQuery();

                Qry = "";
                Qry += @"INSERT INTO Tab_EventDetails(EventId,UniversityId,BoothId,Position,CreatedBy,CreatedDateTime,Line_No)";
                Qry += " VALUES(@EventId,@UniversityId,@BoothId,@Position,@CreatedBy,GETDATE(),@LineNo)";
                Qry += " UPDATE Tab_University SET BoothId=@BoothId WHERE Id=@UniversityId and 'Yes'='" + Status + "'"; //Nidhi
                Qry += " SELECT 'S'";

                foreach (var item in model)
                {
                    EventName = item.EventName;
                    EventDate = item.EventDate;
                    Universityid = item.Universityid;
                    BoothId = item.BoothId;
                    Position = item.Position;
                    Status = item.Status;
                    LineNo = item.LineNo;
                    SqlCommand cmdDetails = new SqlCommand(Qry, con);
                    cmdDetails.CommandType = CommandType.Text;
                    cmdDetails.Parameters.AddWithValue("@EventId", EventId);
                    cmdDetails.Parameters.AddWithValue("@UniversityId", Universityid);
                    cmdDetails.Parameters.AddWithValue("@BoothId", BoothId);
                    cmdDetails.Parameters.AddWithValue("@Position", Position);
                    cmdDetails.Parameters.AddWithValue("@CreatedBy", UserId);
                    cmdDetails.Parameters.AddWithValue("@LineNo", LineNo);
                    cmdDetails.CommandTimeout = 0;
                    cmdDetails.Transaction = transact;
                    cmdDetails.ExecuteScalar();
                    //Rslt = "S";                    
                }
                Rslt = "S";
            }
            else
            {
                Rslt = "EX";
            }
            transact.Commit();

        }
        catch (Exception ex)
        {
            Rslt = "ER";
            transact.Rollback();
        }
        finally
        {
            con.Close();
        }
        return Rslt;
    }
    public DataTable BindEventList(string SearchValue, string RowPerPage, string PageNumber)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT ROW_NUMBER() over(order by Id DESC)'SNo',COUNT(*) OVER(PARTITION BY 1)TotalRows,Id,EventName,EventDateTime,Status FROM Tab_Mst_Event WHERE 1=1";
            if (SearchValue != "")
            {
                qry += " AND (EventName like '%" + SearchValue + "%' OR Status like '%" + SearchValue + "%') ";
            }

            qry += " ORDER BY Id DESC  OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public string BindUniversitytHtmlTable()
    {
        StringBuilder _sbHtml = new StringBuilder();
        try
        {
            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            DataTable dtBooth = new DataTable();
            int TotalPosition = 0;
            TotalPosition = _obj.TotalPosition();

            dtBooth = _obj.BindBoothDDL();
            string DDLBooth = string.Empty;
            int BoothLen = dtBooth.Rows.Count;

            string DDLPosition = string.Empty;

            dt = _obj.BindEventHtmlTable();
            int len = dt.Rows.Count;
            if (len > 0)
            {

                int SNo = 0;
                string UniversityId = "", UniversityName = "", chkId = "", tdUId = "", DdlBoothId = "", DdlPosId = "", trId = "";

                for (int i = 0; i < len; i++)
                {
                    SNo = i + 1;
                    UniversityId = dt.Rows[i]["Id"].ToString();
                    UniversityName = dt.Rows[i]["UniversityName"].ToString();
                    // Booth dropdown
                    chkId = "chk" + SNo;
                    tdUId = "tdUId" + SNo;
                    DdlBoothId = "DdlBoothId" + SNo;
                    DdlPosId = "DdlPos" + SNo;
                    trId = "trId" + SNo;
                    DDLBooth = "";

                    DDLBooth = "<select id=" + DdlBoothId + ">";
                    DDLBooth += "<option value='0' selected='selected'>-Booth-</option>";
                    for (int b = 0; b < BoothLen; b++)
                    {
                        DDLBooth += "<option value=" + dtBooth.Rows[b]["Id"].ToString() + ">" + dtBooth.Rows[b]["BoothName"].ToString() + "</option>";
                    }
                    DDLBooth += "</select>";
                    // end
                    // Position dropdown
                    DDLPosition = "";
                    DDLPosition = "<select id=" + DdlPosId + " class='position'>"; //Nidhi
                    DDLPosition += "<option value='0' selected='selected'>-Position-</option>";
                    for (int p = 1; p <= TotalPosition; p++)
                    {
                        DDLPosition += "<option value=" + p.ToString() + ">" + p.ToString() + "</option>";
                    }
                    DDLPosition += "</select>";
                    // end
                    _sbHtml.Append("<tr id=" + trId + "><td>" + SNo.ToString() + "</td><td style='text-align:center'><input value='0' id=" + chkId + " type='checkbox' /></td><td data-id=" + UniversityId + " id=" + tdUId + ">" + UniversityName + "</td><td>" + DDLBooth + "</td><td>" + DDLPosition + "</td></tr>");
                }
            }
        }
        catch (Exception ex)
        {

        }
        return _sbHtml.ToString();
    }
    public DataTable GetEventEditData(string EventId)
    {
        string qry = string.Empty;
        qry = @"SELECT e.Id EventId,e.EventName,FORMAT(e.EventDateTime, 'yyyy-MM-ddTHH:mm:ss') as EventDateTime,e.Status,d.UniversityId,d.BoothId,d.Position,d.Line_No FROM Tab_Mst_Event e INNER JOIN Tab_EventDetails d ON e.Id=d.EventId WHERE e.Id=@EventId ORDER BY d.Line_No ASC"; //Nidhi
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@EventId", EventId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }
    public string DelEvent(string EventId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            Qry = @"DELETE FROM Tab_Mst_Event WHERE Id=@EventId";
            Qry += " DELETE FROM Tab_EventDetails WHERE EventId=@EventId";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@EventId", EventId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "D";
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;

    }
    public class EventModel
    {
        public string EventName { get; set; }
        public string EventDate { get; set; }
        public string EventId { get; set; }
        public string Universityid { get; set; }
        public string BoothId { get; set; }
        public string Position { get; set; }
        public string Status { get; set; }
        public string TotalRows { get; set; }
        public string SNo { get; set; }
        public string LineNo { get; set; }
    }

    //Nidhi
    public DataTable GetAllBooth(string Uid)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            //qry = @"SELECT ROW_NUMBER() over(order by b.Id DESC)'SNo',COUNT(*) OVER(PARTITION BY 1)TotalRows, b.id,b.BoothName,b.BoothImage,b.BoothPage,b.Active,b.LogoImageFunc,b.BannerImageFunc, u.UniversityName,b.AssignedUniversityId,b.createdDateTime FROM Tab_MstBooth b LEFT OUTER JOIN Tab_University u ON b.AssignedUniversityId=u.Id WHERE 1=1 ";
            qry = @"SELECT ROW_NUMBER() over(order by b.Id)'SNo',COUNT(*) OVER(PARTITION BY 1)TotalRows, b.id,b.BoothName,b.BoothImage,b.BoothPage,b.Active,u.ImageSmall ,u.ImageBig,u.UniversityName,isnull(u.Id,'0') as AssignedUniversityId,b.createdDateTime FROM Tab_MstBooth b  ";
            qry += " LEFT OUTER JOIN Tab_University u ON b.Id = u.BoothId and u.Id = " + Uid;
            qry += " ORDER BY b.Id  ";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public string UpdateBoothByUniversity(string EventId, string AssignedUniversityId, string status, string BoothId, string UserId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            if (!string.IsNullOrEmpty(BoothId))
            {
                Qry = @"UPDATE Tab_University SET BoothId=@BoothId WHERE Id=@AssignedUniversityId 
                        UPDATE ED SET BoothId=@BoothId,ED.ModifyDateTime=getdate(),ED.ModifyBy=@UserId
                        From Tab_EventDetails ED Inner Join Tab_Mst_Event ME on ME.Id=ED.EventID and ME.Status='Yes'
                        WHERE UniversityId=@AssignedUniversityId 
                        SELECT '" + AssignedUniversityId + "'";
            }


            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@EventId", EventId);
                    cmd.Parameters.AddWithValue("@AssignedUniversityId", AssignedUniversityId);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.Parameters.AddWithValue("@BoothId", BoothId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Rslt = Convert.ToString(cmd.ExecuteScalar());
                    con.Close();
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    public DataTable GetBoothDetailsForEdit(string BoothId, string UniId)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {

            qry = @"SELECT b.Id,b.BoothName,b.BoothImage,b.BoothPage,b.Active,u.UniversityName,isnull(u.Id, '0')'UniversityId',isnull(u.ImageSmall, '')ImageSmall,isnull(u.ImageBig, '')ImageBig
                    FROM Tab_MstBooth b LEFT JOIN Tab_University u ON u.Id = @UniversityId WHERE b.Id = @BoothId ";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@BoothId", BoothId);
                    cmd.Parameters.AddWithValue("@UniversityId", UniId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public DataTable GetEvent()
    {
        DataTable dt = new DataTable();
        try
        {
            string qry = string.Empty;
            qry = @"SELECT Id,EventName FROM [dbo].[Tab_Mst_Event] WHERE Status='Yes'";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }

    public string UpdateEventStatus(string EventId, string Msg, string UserId, string sts)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            if (sts.Trim().ToUpper() == "YES")
            {
                Qry = @"UPDATE Tab_Mst_Event SET Status='No',ModifyBy=@UserId,ModifyDateTime=GETDATE() WHERE Id>0";
                Qry += " UPDATE Tab_Mst_Event SET Status='Yes',StatusMessage=@Msg,ModifyBy=@UserId,ModifyDateTime=GETDATE() WHERE Id=@EventId";
            }
            else if (sts.Trim().ToUpper() == "NO")
            {
                Qry += @"UPDATE Tab_Mst_Event SET Status='No',StatusMessage=@Msg,ModifyBy=@UserId,ModifyDateTime=GETDATE() WHERE Id=@EventId";
            }
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@EventId", EventId);
                    cmd.Parameters.AddWithValue("@Msg", Msg);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "S";
                }
            }
            if (sts.Trim().ToUpper() == "YES")   //Nidhi
            {
                string Qry1 = string.Empty;
                Qry1 = @";WITH table1 AS (SELECT UniversityId,BoothId FROM Tab_EventDetails Inner join Tab_Mst_Event on Tab_Mst_Event.Id=Tab_EventDetails.EventId and Tab_Mst_Event.Status='Yes') ";
                Qry1 += " UPDATE Tab_University set BoothId = (SELECT BoothId from table1 where table1.UniversityId = Tab_University.Id ) ";
                Qry1 += " where Tab_University.Id in (SELECT UniversityId from table1) ";

                SqlConnection con = new SqlConnection(dbCon);
                SqlCommand cmdDetails = new SqlCommand(Qry1, con);
                cmdDetails.CommandType = CommandType.Text;
                cmdDetails.CommandTimeout = 0;
                con.Open();
                cmdDetails.ExecuteNonQuery();
                con.Close();
                //Rslt = "S";                    

            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;

    }
    public string FetchStatusMsgValue(string EventId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            Qry = @"SELECT ISNULL(StatusMessage,'') StatusMessage,Status FROM Tab_Mst_Event WHERE Id=@EventId";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@EventId", EventId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (dt.Rows.Count > 0)
                                Rslt = dt.Rows[0]["StatusMessage"].ToString() + "||" + dt.Rows[0]["Status"].ToString();
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    public string AssignLeadToUniversity(string LeadId, string UniversityId, string UserId)
    {
        string Rslt = string.Empty;
        int c = 0;
        try
        {
            string Qry = string.Empty;
            //UPDATE tab_Registration SET RegionId=@RegionId,RegionChangedBy=@UserId,RegionChangedDateTime=GETDATE(),ModifyBy=@UserId,UpdatedOn=GETDATE() WHERE Reg_Id IN(" + LeadId + ")

            string[] LeadArray = LeadId.Split(',');

            string[] UniversityArray = UniversityId.Split(',');

            foreach (var item in LeadArray)
            {
                foreach (var uni in UniversityArray)
                {
                    Qry = "";
                    Qry = @"IF EXISTS(SELECT 1 FROM Tab_AssignedLeadToUniversity WHERE LeadId=@LeadId AND UniversityId=@UniversityId)";
                    Qry += " SELECT 'EX'";
                    Qry += " ELSE BEGIN";
                    Qry += " INSERT INTO Tab_AssignedLeadToUniversity(LeadId,UniversityId,AssignedBy) VALUES(@LeadId,@UniversityId,@AssignedBy)";
                    Qry += " UPDATE tab_Registration SET ModifyBy=@AssignedBy,UpdatedOn=GETDATE() WHERE Reg_Id IN(@LeadId)";
                    Qry += " SELECT 'S' END";
                    using (SqlConnection con = new SqlConnection(dbCon))
                    {
                        using (SqlCommand cmd = new SqlCommand(Qry, con))
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@LeadId", item);
                            cmd.Parameters.AddWithValue("@UniversityId", uni);
                            cmd.Parameters.AddWithValue("@AssignedBy", UserId);
                            cmd.CommandTimeout = 0;
                            con.Open();
                            Rslt = Convert.ToString(cmd.ExecuteScalar());
                            con.Close();
                            //Rslt = "S";                            
                        }
                    }
                }
                if (Rslt == "S")
                    c = c + 1;
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt + "^" + c.ToString();
    }

    public string ActivateTheme(string ThemeId, string UserId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            Qry = "";
            Qry = @"IF EXISTS(SELECT 1 FROM tab_Mst_Theme WHERE Id=@ThemeId)";
            Qry += " BEGIN";
            Qry += " UPDATE tab_Mst_Theme SET Active='No', ModifyBy=@UserId, ModifyDateTime=GETDATE() WHERE Id>0";
            Qry += " UPDATE tab_Mst_Theme SET Active='Yes', ModifyBy=@UserId, ModifyDateTime=GETDATE() WHERE Id=@ThemeId";
            Qry += " SELECT 'U'";
            Qry += " END";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@ThemeId", ThemeId);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Rslt = Convert.ToString(cmd.ExecuteScalar());
                    con.Close();
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public DataTable GetThemeList()
    {
        DataTable dt = new DataTable();
        try
        {
            string Qry = string.Empty;
            Qry = @"SELECT Id,IndexPage,Active FROM tab_Mst_Theme ORDER BY Id ASC";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }

    public DataTable GetPartialData(string RegionId, string RowPerPage, string PageNumber, string FDate, string TDate)
    {
        DataTable dt = new DataTable();

        string qry = string.Empty;

        qry = @"SELECT ROW_NUMBER() over(order by Reg_Id DESC) SNo,COUNT(*) OVER(PARTITION BY 1)TotalRows,Reg_Id,r.Gender,Name,r.emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],msg[Messaging Platform],r.CreatedOn from tab_Registration_temp r";
        qry += " where 1=1";

        if (RegionId != "-All Region-")
        {

            qry += " and r.RegionId=@RegionId";
        }

        if (FDate != "")
        {
            qry += @" and CONVERT(DATE,r.CreatedOn)>=CONVERT(DATE,@FDate)";
        }
        if (TDate != "")
        {
            qry += @" and CONVERT(DATE,r.CreatedOn)<=CONVERT(DATE,@TDate)";
        }
        qry += @" ORDER BY r.Reg_Id DESC";
        qry += " OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";

        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@RegionId", RegionId.ToString());
                cmd.Parameters.AddWithValue("@FDate", FDate.ToString());
                cmd.Parameters.AddWithValue("@TDate", TDate.ToString());
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }

        return dt;
    }


    public DataTable FillReAssignRegGrid(string RowPerPage, string PageNumber, string FilterBy)
    {
        DataTable dt = new DataTable();

        string qry = string.Empty;

        qry = @";WITH TabAssignLead (LeadId) as(
                SELECT distinct(LeadId)LeadId from Tab_AssignedLead 
                --UNION 
                --SELECT distinct(LeadId)LeadId from Tab_AssignedLeadToUniversity
                ) 
                SELECT ROW_NUMBER() over(order by r.Reg_Id DESC) SNo,COUNT(*) OVER(PARTITION BY 1)TotalRows,r.Reg_Id,r.RegistrationNo RegNo,r.Name FROM tab_Registration r 
                INNER JOIN TabAssignLead a ON r.Reg_Id=a.LeadId WHERE 1=1";
        if (FilterBy != "")
        {
            qry += @" AND r.RegistrationNo like '%" + FilterBy + "%'";
        }

        qry += @" ORDER BY r.Reg_Id DESC";
        //qry += " OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";

        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }

        return dt;
    }

    public string ReAssignLeads(string LeadId, string AssignBy, string AssignTo, string sts, string UniversityId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            Qry = "";
            if (sts.Trim().ToUpper() == "CNS")
            {
                Qry = @"IF EXISTS(SELECT 1 FROM Tab_AssignedLead WHERE LeadId=@LeadId)
                        BEGIN
                            DELETE FROM Tab_AssignedLead WHERE LeadId=@LeadId
                            INSERT INTO Tab_AssignedLead(LeadId,AssignedTo,AssignedBy,AssignedDateTime)VALUES(@LeadId,@AssignTo,@AssignedBy,GETDATE())
                            SELECT 'S'
                        END";
            }
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@LeadId", LeadId);
                    if (sts.Trim().ToUpper() == "CNS")
                    {
                        cmd.Parameters.AddWithValue("@AssignTo", AssignTo);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@UniversityId", "");
                    }
                    cmd.Parameters.AddWithValue("@AssignedBy", AssignBy);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Rslt = Convert.ToString(cmd.ExecuteScalar());
                    con.Close();
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    public string DeletePartialData()
    {
        string Rslt = string.Empty;
        try
        {
            
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("sp_Registration_temp", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "INSERTBACKUP");
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "D";
                }
            }
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("sp_Registration_temp", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "Delete");
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "D";
                }
            }

        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;

    }

}
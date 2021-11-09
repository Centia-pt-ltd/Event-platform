using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

/// <summary>
/// Summary description for ClsUniversityDataAccess
/// </summary>
public class ClsUniversityDataAccess
{

    public string Source = "University";
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
	public ClsUniversityDataAccess()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public DataTable ValidateLogin(string UserName, string Password)
    {
        string qry = string.Empty;
        //qry = @"SELECT Id,Email,Pwd FROM Tab_UniversityLogin where Email=@Uname AND Pwd=@Password AND Active='Yes'";
        qry = @"SELECT UserId as Id, EmailId as Email,Password as Pwd,University,LoginType,Role FROM tbl_UserDetails where EmailId=@Uname AND Password=@Password AND Status=1 AND LoginType='University'";

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
    public string GetAboutUs(string Source,string UniversityId)
    {
        string qry = string.Empty;
        string Rslt = string.Empty;
        try
        {
            qry = @"SELECT details from Tab_Mst_AboutUs where UploadedSource=@UploadedSource AND UniversityId=@UniversityId";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@UploadedSource", Source.Trim());
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId.Trim());
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (dt.Rows.Count > 0)
                                Rslt = dt.Rows[0]["details"].ToString();
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
    public string UploadAbout(string Details, string UploadedSource, string UploadedBy, string UniversityId)
    {
        string Rslt = string.Empty;
        try
        {

            string Qry = string.Empty;
            Qry = @"IF EXISTS(SELECT Id FROM Tab_Mst_AboutUs WHERE UploadedSource=@UploadedSource AND UniversityId=@UniversityId)
                    BEGIN
                    UPDATE Tab_Mst_AboutUs SET Details=@details,ModifyBy=@userId,ModifyDateTime=GETDATE() WHERE UploadedSource=@UploadedSource AND UniversityId=@UniversityId
                    END
                    ELSE
                    BEGIN
                    INSERT INTO Tab_Mst_AboutUs(Details,UploadedSource,UploadedBy,UploadedDateTime,UniversityId) VALUES(@details,@UploadedSource,@userId,GETDATE(),@UniversityId)
                    END";

            Details = Details.Replace("^", "'");

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@Details", Details);
                    cmd.Parameters.AddWithValue("@UploadedSource", UploadedSource);
                    cmd.Parameters.AddWithValue("@userId", UploadedBy);
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
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
    public string SaveVideoUrl(string Url, string UploadedSource, string UploadedBy, string UniversityId, string Title)
    {
        string Rslt = string.Empty;
        try
        {

            string Qry = string.Empty;
            int Total = 0;
            Qry = @"SELECT ISNULL(COUNT(*),0)TOTAL FROM Tab_Mst_Videos WHERE UniversityId=@UniversityId";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId);                    
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Total = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();
                }
            }

            if (Total < 3)
            {
                Qry = "";
                Qry = @"IF EXISTS(SELECT 1 FROM Tab_Mst_Videos WHERE Title=@Title AND UniversityId=@UniversityId)
                    SELECT 'EX'
                    ELSE BEGIN
                    INSERT INTO Tab_Mst_Videos(VideoUrl,UploadedSource,UploadedBy,UniversityId,Title) VALUES(@VideoUrl,@UploadedSource,@UploadedBy,@UniversityId,@Title)
                    SELECT 'S'                    
                    END";

                using (SqlConnection con = new SqlConnection(dbCon))
                {
                    using (SqlCommand cmd = new SqlCommand(Qry, con))
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@VideoUrl", Url);
                        cmd.Parameters.AddWithValue("@UploadedSource", UploadedSource);
                        cmd.Parameters.AddWithValue("@UploadedBy", UploadedBy);
                        cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                        cmd.Parameters.AddWithValue("@Title", Title);
                        cmd.CommandTimeout = 0;
                        con.Open();
                        Rslt = Convert.ToString(cmd.ExecuteScalar());
                        con.Close();
                    }
                }
            }
            else
            {
                Rslt = "L";
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public DataTable FillRegion(string UniversityId)
    {
        string qry = string.Empty;
       qry = @"SELECT id,RName FROM TabMst_Region WHERE id IN(
                SELECT RegionId FROM tab_Registration WHERE Reg_Id 
                IN(SELECT DISTINCT LeadId FROM Tab_AssignedLeadToUniversity WHERE UniversityId IN(@UniversityId))
                ) ORDER BY RName ASC";

       // qry = @"SELECT id,RName FROM TabMst_Region WHERE id='1'";

        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
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
    public DataTable FillCourses()
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
                        return dt;
                    }
                }
            }
        }
    }
    public DataTable FillQualification()
    {
        string qry = string.Empty;
        qry = @"select HigestId,HigestQualificationName from [dbo].[tbl_HigestQualification] order by HigestId asc";
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
    public DataTable FillRegGrid(string RegionId, string RowPerPage, string PageNumber, string Course, string Qualification, string Country, string UniversityId, string StudentName, string Flag)
    {
        DataTable dt = new DataTable();

          string qry = string.Empty;
            if (Qualification == "-Qualification-")
                Qualification = "";
            if (Course == "-Courses-")
                Course = "";

            qry = @"SELECT ROW_NUMBER() over(order by Reg_Id DESC) SNo,COUNT(*) OVER(PARTITION BY 1)TotalRows,Reg_Id,RegistrationNo [RegNo],r.Gender Gender,Name,r.emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],r.CreatedOn CreatedOn,Active,r.updatedOn,(u3.FirstName+' '+u3.LastName)LastUpdatedBy,Flag=ISNULL((select TOP(1) f.Flag from  Tab_Mst_RegistrationNotes f where f.LeadId=r.Reg_Id ORDER BY f.Id DESC),'') from tab_Registration r
                      INNER JOIN Tab_AssignedLeadToUniversity l ON r.Reg_Id=l.LeadId left outer join tbl_UserDetails u3 on r.ModifyBy=u3.UserId WHERE l.UniversityId IN(@UniversityId)";

            if (RegionId != "-All Region-")
            {
                qry += " AND r.RegionId=@RegionId";
               // qry = @"SELECT ROW_NUMBER() over(order by Reg_Id DESC) SNo,COUNT(*) OVER(PARTITION BY 1)TotalRows,Reg_Id,RegistrationNo [RegNo],Gender,Name,emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],CreatedOn,Active,r.updatedOn from tab_Registration r
                  //     where 1=1";

            }
            /*else
            {
                qry = @"SELECT ROW_NUMBER() over(order by Reg_Id DESC) SNo,COUNT(*) OVER(PARTITION BY 1)TotalRows,Reg_Id,RegistrationNo [RegNo],Gender,Name,emailid[EMail],Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],CreatedOn,Active,r.updatedOn from tab_Registration r
                   WHERE 1=1 and r.RegionId=@RegionId";
            }*/
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
                qry += @" and (r.Name like '%" + StudentName + "%' or r.RegistrationNo like '%" + StudentName + "%')";
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
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId.ToString());
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
    public DataTable GetUploadedYoutube(string UniversityId)
    {
        string qry = string.Empty;
        string Rslt = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT 'TotalRows'=(select ISNULL(COUNT(*),0) FROM Tab_Mst_Videos WHERE UploadedSource='University' AND UniversityId=@UniversityId),Id,VideoUrl FROM Tab_Mst_Videos WHERE UploadedSource='University' AND UniversityId=@UniversityId";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId.Trim());
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {

                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return dt;
    }

    public DataTable GetUploadedPhoto(string UniversityId)
    {
        string qry = string.Empty;
        string Rslt = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT 'TotalRows'=(select ISNULL(COUNT(*),0) FROM Tab_Mst_Photo WHERE UploadedSource='University' AND UniversityId=@UniversityId),Id,ImageName FROM Tab_Mst_Photo WHERE UploadedSource='University' AND UniversityId=@UniversityId";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId.Trim());
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {

                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return dt;
    }

    public DataTable GetUploadedBrouchers(string UniversityId)
    {
        string qry = string.Empty;
        string Rslt = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT 'TotalRows'=(select ISNULL(COUNT(*),0) FROM Tab_Mst_Brochure WHERE UploadedSource='University' AND UniversityId=@UniversityId),Id,FilesName FROM Tab_Mst_Brochure WHERE UploadedSource='University' AND UniversityId=@UniversityId";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId.Trim());
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {

                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return dt;
    }

    public string CheckUploadLimit(string UniversityId)
    {        
        string Rslt = string.Empty;        
        try
        {
            Rslt = "0";
            string Qry = string.Empty;
            Qry += "declare @TotalPhoto varchar(10)='0'";
            Qry += " declare @TotalBrochure varchar(10)='0'";
            Qry += " declare @TotalVideo varchar(10)='0'";
            Qry += " declare @All varchar(20)='0'";
            Qry += " SELECT @TotalPhoto=COUNT(*) FROM Tab_Mst_Photo WHERE UploadedSource='University' AND UniversityId=@UniversityId";
            Qry += " SELECT @TotalBrochure=COUNT(*) FROM Tab_Mst_Brochure WHERE UploadedSource='University' AND UniversityId=@UniversityId";
            Qry += " SELECT @TotalVideo=COUNT(*) FROM Tab_Mst_Videos WHERE UploadedSource='University' AND UniversityId=@UniversityId";
            Qry += " SET @All=@TotalPhoto+','+@TotalBrochure+','+@TotalVideo";
            Qry += " SELECT @All AS TotalRows";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {                    
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId.Trim());
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (dt.Rows.Count > 0)
                                Rslt = dt.Rows[0]["TotalRows"].ToString();
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

    public DataSet GetResourceList(string UniversityId)
    {
        DataSet ds = new DataSet();
        string qry = string.Empty;
        string Rslt = string.Empty;
        try
        {
            qry = @"SELECT p.Id,p.ImageName,p.UploadedDateTime,p.ImageDuplicateName,(u.FirstName+' '+u.LastName)UploadedBy FROM Tab_Mst_Photo p INNER JOIN tbl_UserDetails u ON p.UploadedBy=u.UserId WHERE UploadedSource='University' AND UniversityId=@UniversityId ORDER BY p.Id DESC
                    SELECT b.Id,b.Title,b.FilesName,b.UploadedDateTime,b.FileDuplicateName,(u.FirstName+' '+u.LastName)UploadedBy FROM Tab_Mst_Brochure b INNER JOIN tbl_UserDetails u ON b.UploadedBy=u.UserId WHERE UploadedSource='University' AND UniversityId=@UniversityId ORDER BY b.Id DESC
                    SELECT v.Id,v.Title,v.VideoUrl,v.UploadedDateTime,(u.FirstName+' '+u.LastName)UploadedBy FROM Tab_Mst_Videos v INNER JOIN tbl_UserDetails u ON v.UploadedBy=u.UserId WHERE UploadedSource='University' AND UniversityId=@UniversityId  ORDER BY v.Id DESC
                    ";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId.Trim());
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return ds;
    }

    public string DeleteResources(string Id, string Source,string FileName)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            if (Source.Trim().ToUpper() == "PHOTO")
                Qry = "DELETE FROM Tab_Mst_Photo WHERE UploadedSource='University' AND Id=@Id";
            else if (Source.Trim().ToUpper() == "BROCHURE")
                Qry = "DELETE FROM Tab_Mst_Brochure WHERE UploadedSource='University' AND Id=@Id";
            else if (Source.Trim().ToUpper() == "YOUTUBE")
                Qry = "DELETE FROM Tab_Mst_Videos WHERE UploadedSource='University' AND Id=@Id";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.Parameters.AddWithValue("@Id", Id);
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "D";
                }
            }

            if (Source.Trim().ToUpper() == "PHOTO")
            {
                if (File.Exists(HttpContext.Current.Server.MapPath("../UploadedImage/" + FileName)))
                {
                    File.Delete(HttpContext.Current.Server.MapPath("../UploadedImage/" + FileName));
                }
            }
            else if (Source.Trim().ToUpper() == "BROCHURE")
            {
                if (File.Exists(HttpContext.Current.Server.MapPath("../UploadedBrochure/" + FileName)))
                {
                    File.Delete(HttpContext.Current.Server.MapPath("../UploadedBrochure/" + FileName));
                }
            }
            else if (Source.Trim().ToUpper() == "YOUTUBE")
            {
            }

        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    public string DuplicateImageName(string ImageName, string UniversityId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            Qry += "IF EXISTS(SELECT 1 FROM Tab_Mst_Photo WHERE UploadedSource='University' AND ImageName=@ImageName AND UniversityId=@UniversityId)";
            Qry += " SELECT 'EX'";
            Qry += " ELSE";
            Qry += " SELECT 'N'";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@ImageName", ImageName.Trim());
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
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

    public string DuplicateBrochureImageName(string ImageName,string Title, string UniversityId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            Qry += "IF EXISTS(SELECT 1 FROM Tab_Mst_Brochure WHERE UploadedSource='University' AND UniversityId=@UniversityId AND (FilesName=@ImageName OR Title=@Title))";
            Qry += " SELECT 'EX'";
            Qry += " ELSE";
            Qry += " SELECT 'N'";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@ImageName", ImageName.Trim());
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                    cmd.Parameters.AddWithValue("@Title", Title);
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

    public string DuplicateVideo(string Url, string Title, string UniversityId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            Qry += "IF EXISTS(SELECT 1 FROM Tab_Mst_Videos WHERE UploadedSource='University' AND UniversityId=@UniversityId AND (VideoUrl=@VideoUrl OR Title=@Title))";
            Qry += " SELECT 'EX'";
            Qry += " ELSE";
            Qry += " SELECT 'N'";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@VideoUrl", Url.Trim());
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                    cmd.Parameters.AddWithValue("@Title", Title);
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
    public class Youtube
    {
        public string Id { get; set; }
        public string Url { get; set; }
        public string TotalRows { get; set; }
        public string Title { get; set; }
    }

    public class Photo
    {
        public string Id { get; set; }
        public string DisplayName { get; set; }
        public string TotalRows { get; set; }
    }

    public class Brochure
    {
        public string Id { get; set; }
        public string DisplayName { get; set; }
        public string TotalRows { get; set; }
    }


    //----Nidhi-21Sep
    public class StudentModel
    {
       
        public string Sid { get; set; }
        public string UserId { get; set; }
       

    }
    public string MoveToUniversityUser(List<StudentModel> model, string UniversityId, string RoomId)// (string UniUserId, string Sid, string UserId,string UniversityId)
    {
        string Rslt = string.Empty;
        SqlConnection con = new SqlConnection(dbCon);
        SqlTransaction transact = null;
        try
        {
            con.Open();
            string Qry = string.Empty;
            Qry = @"UPDATE tblStudentCouncilUni SET RoomId=@RoomId,CreatedOn=GETDATE(),CreatedBy=@UserId,Moved='Yes' WHERE StudentId=@Sid and UniversityId=@UniversityId ";
            foreach (var item in model)
            {

                SqlCommand cmdDetails = new SqlCommand(Qry, con);
                cmdDetails.CommandType = CommandType.Text;
                cmdDetails.Parameters.AddWithValue("@Sid", item.Sid);
                cmdDetails.Parameters.AddWithValue("@UserId", item.UserId);
                cmdDetails.Parameters.AddWithValue("@UniversityId", UniversityId);
                cmdDetails.Parameters.AddWithValue("@RoomId", RoomId);

                cmdDetails.CommandTimeout = 0;
                cmdDetails.Transaction = transact;
                cmdDetails.ExecuteScalar();
                //Rslt = "S";                    
            }
            
            Rslt = "S";
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        finally
        {
            con.Close();
        }
        return Rslt;
    }
    public DataTable GetStudentListForCouncil(string UniversityId)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT ROW_NUMBER() over(order by tblStudentCouncilUni.Id )'SNo',tblStudentCouncilUni.Id,StudentId,RegNo,Name,tblStudentCouncilUni.Active, ";
            qry += " Moved,RoomId,EntryTime,Case When UniversityId=0 then '' else UniversityName end as UniversityName,tblStudentCouncilUni.CreatedBy, ";
            qry += " tblStudentCouncilUni.CreatedOn FROM tblStudentCouncilUni ";
            qry += "  Inner join Tab_University on Tab_University.Id=UniversityId";
            qry += " WHERE UniversityId=" + UniversityId + " AND tblStudentCouncilUni.Active='Yes' AND Moved='No' AND format(EntryTime,'dd/MMM/yyyy')=format(getdate(),'dd/MMM/yyyy') ";
            qry += " ORDER BY EntryTime  ";
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

    public DataTable GetUserRoomList(string UniversityId)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT ROW_NUMBER() over(order by tbl_ChatRoom.Id )'SNo',tbl_ChatRoom.Id,FirstName+' '+LastName as Name,RoomName ";
            qry += "FROM tbl_ChatRoom Inner join Tab_University on Tab_University.Id=tbl_ChatRoom.UniversityId ";
            qry += "Inner join tbl_UserDetails on tbl_ChatRoom.UserId=tbl_UserDetails.UserId WHERE tbl_ChatRoom.UniversityId="+ UniversityId ;
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

    public DataTable BindEventUniversityUsers(string Uid)
    {
        string qry = string.Empty;
        qry = @"select t1.UserId, t1.FirstName+' '+t1.LastName as FirstName  from tbl_UserDetails t1 Inner join tbl_UserDetails t2 on t1.university=t2.university where t1.Status=1 and t2.UserId=" + Uid;
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

    public DataTable BindUnassignedUsers(string Uid)
    {
        string qry = string.Empty;
        qry = @"select t1.UserId, t1.FirstName+' '+t1.LastName as FirstName  from tbl_UserDetails t1 where t1.[Status]=1 and university="+Uid;
        qry += " and  t1.UserId not in (select UserId from tbl_ChatRoom where UniversityId=" + Uid + " and UserId is not null)";
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
    public DataTable BindAllRoom(string Uid)
    {
        string qry = string.Empty;
        qry = @"Select Id, RoomName  from tbl_ChatRoom Inner join tbl_UserDetails on university=UniversityId ";
        qry+= "where (isnull(tbl_ChatRoom.UserId,'') ='' or tbl_ChatRoom.UserId=0 or tbl_ChatRoom.UserId ='') and tbl_UserDetails.UserId=" + Uid;
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

    public DataTable BindRoom(string Uid)
    {
        string qry = string.Empty;
        qry = @"Select Id, RoomName  from tbl_ChatRoom Inner join tbl_UserDetails on university=UniversityId ";
        qry += "where (isnull(tbl_ChatRoom.UserId,'') !='' or tbl_ChatRoom.UserId!=0 or tbl_ChatRoom.UserId!='') and tbl_UserDetails.UserId=" + Uid;
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

    public string  AddUpdateRoom(string UniversityId, string UniUserId, string RoomId)
    {
        string Rslt = string.Empty;
        SqlConnection con = new SqlConnection(dbCon);
        SqlTransaction transact = null;
        try
        {
            con.Open();
            string Qry1 = string.Empty;         
            Qry1 = @"UPDATE tbl_ChatRoom Set UserId=" + UniUserId + " where Id=" + RoomId+ " and UniversityId="+ UniversityId;

            SqlCommand cmdDetails1 = new SqlCommand(Qry1, con);
            cmdDetails1.CommandType = CommandType.Text;
            cmdDetails1.CommandTimeout = 0;
            cmdDetails1.Transaction = transact;
            cmdDetails1.ExecuteScalar();

            Rslt = "S";
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        finally
        {
            con.Close();
        }
        return Rslt;
    }

    public DataTable EditRoom(string Rid)
    {
        string qry = string.Empty;
        qry = @"Select tbl_ChatRoom.UserId,FirstName+' '+LastName as FirstName from tbl_ChatRoom ";
        qry+= "Inner join tbl_UserDetails on tbl_ChatRoom.UserId=tbl_UserDetails.UserId where Id=" + Rid;
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
    public string Delete(string RoomId)
    {
        string Rslt = string.Empty;
        SqlConnection con = new SqlConnection(dbCon);
        SqlTransaction transact = null;
        try
        {
            con.Open();
            string Qry1 = string.Empty;
            Qry1 = @"UPDATE tbl_ChatRoom Set UserId=@UserId where Id=@RoomId" ;

            SqlCommand cmdDetails1 = new SqlCommand(Qry1, con);
            cmdDetails1.CommandType = CommandType.Text;
            cmdDetails1.Parameters.AddWithValue("@UserId", DBNull.Value);
            cmdDetails1.Parameters.AddWithValue("@RoomId", RoomId);
            cmdDetails1.CommandTimeout = 0;
            cmdDetails1.Transaction = transact;
            cmdDetails1.ExecuteScalar();

            Rslt = "S";
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        finally
        {
            con.Close();
        }
        return Rslt;
    }
    
    //End-Nidhi
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


/// <summary>
/// Summary description for ClsQstudyDataAccess
/// </summary>
public class ClsQstudyDataAccess
{
    public string Source = "Qstudy";
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    public ClsQstudyDataAccess()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public DataTable ValidateLogin(string UserName, string Password)
    {
        string qry = string.Empty;
        qry = @"SELECT UserId,UserName,Password,LoginType FROM tbl_UserDetails where UserName=@Uname AND Password=@Password AND LoginType='Qstudy' AND Status='1'";
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
    public string GetAboutUs(string Source)
    {
        string qry = string.Empty;
        string Rslt = string.Empty;
        try
        {
            qry = @"SELECT details from Tab_Mst_AboutUs where UploadedSource=@UploadedSource";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@UploadedSource", Source.Trim());
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
    public string UploadAbout(string Details, string UploadedSource, string UploadedBy)
    {
        string Rslt = string.Empty;
        try
        {

            string Qry = string.Empty;
            Qry = @"IF EXISTS(SELECT Id FROM Tab_Mst_AboutUs WHERE UploadedSource=@UploadedSource)
                    BEGIN
                    UPDATE Tab_Mst_AboutUs SET Details=@details,ModifyBy=@userId,ModifyDateTime=GETDATE() WHERE UploadedSource=@UploadedSource
                    END
                    ELSE
                    BEGIN
                    INSERT INTO Tab_Mst_AboutUs(Details,UploadedSource,UploadedBy,UploadedDateTime) VALUES(@details,@UploadedSource,@userId,GETDATE())
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
    public string SaveVideoUrl(string Url, string UploadedSource, string UploadedBy)
    {
        string Rslt = string.Empty;
        try
        {

            string Qry = string.Empty;
            Qry = @"INSERT INTO Tab_Mst_Videos(VideoUrl,UploadedSource,UploadedBy) VALUES(@VideoUrl,@UploadedSource,@UploadedBy)";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@VideoUrl", Url);
                    cmd.Parameters.AddWithValue("@UploadedSource", UploadedSource);
                    cmd.Parameters.AddWithValue("@UploadedBy", UploadedBy);
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
    public DataTable GetRegisterList(string RegionId, string RowPerPage, string PageNumber, string UserId,string Course, string Qualification,string Country,string Status,string StudentName,string Flag)
    {
        DataTable dt = new DataTable();
        string qry = string.Empty;
        if (Qualification == "-Qualification-")
            Qualification = "";
        if (Course == "-Courses-")
            Course = "";

        try
        {
            qry = @"SELECT ROW_NUMBER() over(order by Reg_Id DESC) SNo,COUNT(*) OVER(PARTITION BY 1)TotalRows,Reg_Id,RegistrationNo [RegNo],r.Gender,Name,r.emailid[EMail],
                    Country_Code [CountryCode],phone_no[Phone],(cast(Country_Code as varchar(max))+cast(phone_no as varchar(max)))WhatsApp,Country,State [City],
                    TOEFLScore,msg[Messaging Platform],hq[Highest Qualification],course[Course],StudyAbroad [StudyAbroad],FeeRange [FeeRange],r.CreatedOn,Active,(u.FirstName+' '+u.LastName)'AssignBy',r.updatedOn,(u3.FirstName+' '+u3.LastName)LastUpdatedBy,Flag=ISNULL((select TOP(1) f.Flag from  Tab_Mst_RegistrationNotes f where f.LeadId=r.Reg_Id ORDER BY f.Id DESC),'') 
                    from tab_Registration r
                    INNER JOIN 
                    Tab_AssignedLead l
                    ON r.Reg_Id=l.LeadId
                    INNER JOIN tbl_UserDetails u 
                    ON l.AssignedBy=u.UserId left outer join tbl_UserDetails u3 on r.ModifyBy=u3.UserId
                    WHERE 1=1 AND AssignedTo=@UserId";
            if (RegionId != "-All Region-")
            {
                qry += @" AND r.RegionId=@RegionId";
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
                qry += @" and (r.Name like '%" + StudentName + "%' or r.RegistrationNo like '%" + StudentName + "%')"; 
            }
            if (Flag != "All Flag")
            {
                qry += @" and r.ActivityStatus='" + Flag + "'";
            }

            qry += " ORDER BY r.Reg_Id DESC OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@RegionId", RegionId);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
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
                            string WhatsApp = dt.Rows[0]["WhatsApp"].ToString();
                            _table += "<tbody>";
                            _table += "<tr><td>Registration No.</td><td>" + dt.Rows[0]["RegistrationNo"].ToString() + "</td></tr>";
                            _table += "<tr><td>Full Name</td><td>" + dt.Rows[0]["Name"].ToString() + " ("+ dt.Rows[0]["Gender"].ToString() + ")</td></tr>";
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

                            _table += "<td><a onclick=SaveActivity('WhatsApp.png','WhatsAppMessage','" + Id + "','Whatsapp','" + WhatsApp + "');><img src='http://qstudyabroad.com/admin/img/WhatsApp.png' height='27' style='cursor:pointer'></a><a id='aWhatsApp' style='display:none' href=https://api.whatsapp.com/send?phone=" + dt.Rows[0]["WhatsApp"].ToString() + "&amp;text=Hi target='_blank'></a>";
                            _table += " &nbsp;<a onclick=SaveActivity('imo.png','IMOMessage','" + Id + "','IMO','');><img src='http://qstudyabroad.com/admin/img/imo.png' height='20' style='cursor:pointer'></a> <a id='aImo' style='display:none' href='https://imo.onelink.me/nbj0/df13cbc#' target='_blank'></a>";       
                            _table += "</td></tr>";
                            _table += " <tr><td>E-Mail</td><td><a onclick=SaveActivity('mail.png','Email','" + Id + "','Email','');><img src='http://qstudyabroad.com/admin/img/mail.png' height='26' style='cursor:pointer'></a> <a id='aMail' style='display:none' href='http://mail.qstudyabroad.com/Login.aspx' target='_blank'></a></td></tr>";
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
    public string UpdateStatus(string RegId,string sts)
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
    public string SaveActivity(string LeadId, string ImageUrl, string Msg,string PlateFormName,string UserId)
    {
        string Rslt = string.Empty;
        try
        {
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Tab_SocialPlateformActivity(LeadId,PlateFormName,IconUrl,ActivityMessage,UserId)VALUES(@LeadId,@PlateFormName,@IconUrl,@ActivityMessage,@UserId)", con))
                {
                    cmd.Parameters.AddWithValue("@LeadId", LeadId);
                    cmd.Parameters.AddWithValue("@PlateFormName", PlateFormName);
                    cmd.Parameters.AddWithValue("@IconUrl", ImageUrl);
                    cmd.Parameters.AddWithValue("@ActivityMessage", Msg);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.CommandType = CommandType.Text;
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
    // Nidhi 27Aug
    public class StudentModel
    {
        public string Uid { get; set; }
        public string Sid { get; set; }
        public string UserId { get; set; }

    }
    public string MoveToUniversity(List<StudentModel> model)// (string Uid, string Sid, string UserId)
    {
        string Rslt = string.Empty;
        SqlConnection con = new SqlConnection(dbCon);
        SqlTransaction transact = null;
        try
        {
            con.Open();
            string Qry = string.Empty;
            Qry = @"UPDATE tblStudentCouncil SET UniversityId=@Uid,CreatedOn=GETDATE(),CreatedBy=@UserId,Active='No',Moved='Yes' WHERE StudentId=@Sid ";
            foreach (var item in model)
            {

                SqlCommand cmdDetails = new SqlCommand(Qry, con);
                cmdDetails.CommandType = CommandType.Text;
                cmdDetails.Parameters.AddWithValue("@Uid", item.Uid);
                cmdDetails.Parameters.AddWithValue("@Sid", item.Sid);
                cmdDetails.Parameters.AddWithValue("@UserId", item.UserId);
                cmdDetails.CommandTimeout = 0;
                cmdDetails.Transaction = transact;
                cmdDetails.ExecuteScalar();
                //Rslt = "S";                    
            }
            //using (SqlConnection con = new SqlConnection(dbCon))
            //{
            //    using (SqlCommand cmd = new SqlCommand(Qry, con))
            //    {
            //        cmd.CommandType = CommandType.Text;
            //        cmd.Parameters.AddWithValue("@Uid", Uid);
            //        cmd.Parameters.AddWithValue("@Sid", Sid);
            //        cmd.Parameters.AddWithValue("@UserId", UserId);
            //        cmd.CommandTimeout = 0;
            //        con.Open();
            //        Rslt = Convert.ToString(cmd.ExecuteNonQuery());
            //        con.Close();
            //        Rslt = "S";
            //    }
            //}
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
    public DataTable GetStudentListForCouncil(string SearchValue, string RowPerPage, string PageNumber, string UserId)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT ROW_NUMBER() over(order by tblStudentCouncil.Id )'SNo',COUNT(*) OVER(PARTITION BY 1)TotalRows,tblStudentCouncil.Id,StudentId,RegNo,Name, ";
            qry += " tblStudentCouncil.Active,EntryTime,tblStudentCouncil.UniversityId as UniversityName,tblStudentCouncil.CreatedBy,tblStudentCouncil.CreatedOn,Moved ";
            qry += " FROM tblStudentCouncil ";
            qry += " Inner join Tab_AssignedLead on LeadId=StudentId ";
            qry += " WHERE 1=1 AND AssignedTo=" + UserId + " AND ((tblStudentCouncil.Active='Yes' and Moved='No') OR (tblStudentCouncil.Active='No' and Moved='No')) AND format(EntryTime,'dd/MMM/yyyy')=format(getdate(),'dd/MMM/yyyy') ";
            if (SearchValue != "")
            {
                qry += " AND (RegNo like '%" + SearchValue + "%' OR Name like '%" + SearchValue + "%') ";
            }

            qry += " ORDER BY EntryTime  OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";
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
    public DataTable GetStudentUniversity(string UserId)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            //qry = @" IF Not EXISTS(SELECT Id FROM tblStudentCouncil WHERE StudentId=" + UserId + " and tblStudentCouncil.Active='Yes') BEGIN ";
            //qry += " DECLARE @LIST VARCHAR(200), @Uid int ";
            //qry += " Select @LIST = UniversityId from tblStudentCouncil where StudentId = " + UserId ;
            //qry += " select @Uid = min(id) FROM dbo.CSVToTable(@LIST) ";
            //qry += " SELECT top(1) Tab_EventDetails.UniversityId,Tab_EventDetails.Position FROM tblStudentCouncil ";
            //qry += " Inner join Tab_Mst_Event on Status = 'Yes' ";
            //qry += " Inner join Tab_EventDetails on EventId = Tab_Mst_Event.Id and Tab_EventDetails.UniversityId = @Uid ";
            //qry += " where tblStudentCouncil.Active = 'No' and tblStudentCouncil.StudentId = " + UserId + " End";         
          

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentCouncil", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@StudentId", UserId.Trim());
                    cmd.Parameters.AddWithValue("@Flag", "2");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
                //using (SqlCommand cmd = new SqlCommand(qry, con))
                //{
                //    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                //    {
                //        da.Fill(dt);
                //    }
                //}
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public DataTable BindEventUniversityTable()
    {
        string qry = string.Empty;
        qry = @"SELECT Tab_University.Id,Tab_University.UniversityName FROM Tab_University Inner join Tab_Mst_Event on Status = 'Yes' ";
        qry += " Inner join Tab_EventDetails on EventId=Tab_Mst_Event.Id and Tab_EventDetails.UniversityId=Tab_University.Id ";
        qry += " WHERE Tab_University.Active='Yes' ORDER BY Tab_University.UniversityName ASC   ";
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
    public DataTable EditAssignedUniversity(string Id)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand("Sp_StudentCouncil", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", Id.Trim());
                cmd.Parameters.AddWithValue("@Flag", "4");
                SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(sqlParameter);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }
        return dt;
    }
    public DataTable GetStudentUniversityToView(string UserId)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentCouncil", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@StudentId", UserId.Trim());
                    cmd.Parameters.AddWithValue("@Flag", "5");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
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
    
}
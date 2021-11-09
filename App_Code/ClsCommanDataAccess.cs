using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// Summary description for ClsCommanDataAccess
/// </summary>
public class ClsCommanDataAccess
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    public ClsCommanDataAccess()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    // ARV 13-8-21
    public string UpdateLoginStatus(string UserId, string Sts)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            if (Sts.Trim().ToUpper() == "LOGIN")
                Qry = @"UPDATE tbl_UserDetails SET CurrentLoginStatus='LogIn',LoginDateTime=GETDATE() WHERE UserId=@UserId";
            else
                Qry = @"UPDATE tbl_UserDetails SET CurrentLoginStatus='LogOut',LogOutDateTime=GETDATE() WHERE UserId=@UserId";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@UserId", UserId);
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
    // ARV end 13-8-21
    public DataTable GetNotes(string RegId, string UserId, string UserType)
    {
        string Rslt = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            string Qry = string.Empty;
            if (UserType.Trim().ToUpper() == "SUPERADMIN")
            {
                Qry = @"SELECT n.id,n.Notes,(u.FirstName+' '+u.LastName)'CreatedBy',n.CreatedDateTime,(u1.FirstName+' '+u1.LastName)'ModifyBy',n.ModifyDateTime,n.Flag,ISNULL(l.UniversityId,'0')UniversityId,n.Status,n.AssignTo FROM Tab_Mst_RegistrationNotes n 
                        INNER JOIN tbl_UserDetails u ON n.CreatedBy=u.UserId LEFT OUTER JOIN tbl_UserDetails u1 ON n.ModifyBy=u1.UserId LEFT OUTER JOIN Tab_LockRegistration l ON n.LeadId=l.LeadId WHERE n.LeadId=@Lid";
            }
            if (UserType.Trim().ToUpper() == "QSTUDY")
            {
                Qry = @"SELECT n.id,n.Notes,(u.FirstName+' '+u.LastName)'CreatedBy',n.CreatedDateTime,(u1.FirstName+' '+u1.LastName)'ModifyBy',n.ModifyDateTime,n.Flag,ISNULL(l.UniversityId,'0')UniversityId,n.Status,n.AssignTo FROM Tab_Mst_RegistrationNotes n 
                        INNER JOIN tbl_UserDetails u ON n.CreatedBy=u.UserId LEFT OUTER JOIN tbl_UserDetails u1 ON n.ModifyBy=u1.UserId LEFT OUTER JOIN Tab_LockRegistration l ON n.LeadId=l.LeadId WHERE n.LeadId=@Lid";
                Qry += @" AND n.AssignTo=@UserId";
            }
            if (UserType.Trim().ToUpper() == "UNIVERSITY")
            {
                Qry = @"SELECT n.id,n.Notes,(u.FirstName+' '+u.LastName)'CreatedBy',n.CreatedDateTime,(u1.FirstName+' '+u1.LastName)'ModifyBy',n.ModifyDateTime,n.Flag,ISNULL(l.UniversityId,'0')UniversityId,n.Status,n.AssignTo FROM Tab_Mst_RegistrationNotes n 
                        INNER JOIN tbl_UserDetails u ON n.CreatedBy=u.UserId LEFT OUTER JOIN tbl_UserDetails u1 ON n.ModifyBy=u1.UserId LEFT OUTER JOIN Tab_LockRegistration l ON n.LeadId=l.LeadId WHERE n.LeadId=@Lid";
                Qry += @" AND n.AssignTo=@UserId";
            }
            Qry += @" ORDER BY n.Id DESC";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@Lid", RegId);
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
            Rslt = "ER";
        }
        return dt;
    }
    public string AddUpdateNote(string RegId, string Notes, string UserId, string NoteId, string Flag, string UniversityId, string AssignTo, string Status)
    {
        string Rslt = string.Empty;
        string tmpFlag = string.Empty;
        try
        {
            tmpFlag = Flag;
            string Qry = @"IF EXISTS(SELECT 1 FROM Tab_Mst_RegistrationNotes WHERE Id=@NoteId)";
            Qry += " BEGIN";
            Qry += " UPDATE Tab_Mst_RegistrationNotes SET Notes=@Notes,ModifyBy=@UserId,ModifyDateTime=GETDATE(),Flag=@Flag,AssignTo=@AssignTo,Status=@Status WHERE Id=@NoteId";
            Qry += " UPDATE tab_Registration SET UpdatedOn=GETDATE(),ModifyBy=@UserId,ActivityStatus=@tmpFlag WHERE Reg_Id=@LeadId";
            if (Flag.Trim().ToUpper() == "ACTIVE")
                Qry += " UPDATE tab_Registration SET Active='Yes',UpdatedOn=GETDATE(),ModifyBy=@UserId WHERE Reg_Id=@LeadId";
            else if (Flag.Trim().ToUpper() == "INACTIVE")
                Qry += " UPDATE tab_Registration SET Active='No',UpdatedOn=GETDATE(),ModifyBy=@UserId WHERE Reg_Id=@LeadId";
            else if (Flag.Trim().ToUpper() == "BLOCKED")
                Qry += " UPDATE tab_Registration SET BlockStatus='Yes',UpdatedOn=GETDATE(),ModifyBy=@UserId WHERE Reg_Id=@LeadId";
            Qry += " END";

            Qry += " ELSE BEGIN";
            Qry += " INSERT INTO Tab_Mst_RegistrationNotes(LeadId,Notes,CreatedBy,CreatedDateTime,Flag,AssignTo,Status) VALUES(@LeadId,@Notes,@UserId,GETDATE(),@Flag,@AssignTo,@Status)";
            Qry += " UPDATE tab_Registration SET UpdatedOn=GETDATE(),ModifyBy=@UserId,ActivityStatus=@tmpFlag WHERE Reg_Id=@LeadId";
            if (Flag.Trim().ToUpper() == "ACTIVE")
                Qry += " UPDATE tab_Registration SET Active='Yes',UpdatedOn=GETDATE(),ModifyBy=@UserId WHERE Reg_Id=@LeadId";
            else if (Flag.Trim().ToUpper() == "INACTIVE")
                Qry += " UPDATE tab_Registration SET Active='No',UpdatedOn=GETDATE(),ModifyBy=@UserId WHERE Reg_Id=@LeadId";
            else if (Flag.Trim().ToUpper() == "BLOCKED")
                Qry += " UPDATE tab_Registration SET BlockStatus='Yes',UpdatedOn=GETDATE(),ModifyBy=@UserId WHERE Reg_Id=@LeadId";
            Qry += " END";

            //string Qry = @"INSERT INTO Tab_Mst_RegistrationNotes(LeadId,Notes,CreatedBy,CreatedDateTime) VALUES(@LeadId,@Notes,@UserId,GETDATE())";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@NoteId", NoteId);
                    cmd.Parameters.AddWithValue("@LeadId", RegId);
                    cmd.Parameters.AddWithValue("@Notes", Notes);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.Parameters.AddWithValue("@Flag", Flag);
                    cmd.Parameters.AddWithValue("@tmpFlag", tmpFlag);
                    cmd.Parameters.AddWithValue("@AssignTo", AssignTo);
                    cmd.Parameters.AddWithValue("@Status", Status);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "S";
                }
            }
            if (Flag.Trim().ToUpper() == "SIGNED UP/ LOCK")
                Rslt = this.LockStudent(UserId, UniversityId, RegId);
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public string AddFlagStatus(string RegId, string Action, string UserId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = @"INSERT INTO Tab_FlagStatus(LeadId,Actions,CreatedBy) VALUES(@LeadId,@Actions,@UserId)";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@LeadId", RegId);
                    cmd.Parameters.AddWithValue("@Actions", Action);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
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
    public DataTable GetAllUniversity()
    {
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT Id,UniversityName FROM Tab_University WHERE Active='Yes' ORDER BY UniversityName ASC", con))
            {
                cmd.CommandType = CommandType.Text;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }
        return dt;
    }

    public string LockStudent(string UserId, string UniversityId, string LeadId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;

            Qry = @"IF EXISTS(SELECT 1 FROM [dbo].Tab_LockRegistration WHERE LeadId=@LeadId)";
            Qry += " SELECT 'EX'";
            Qry += " ELSE BEGIN";
            Qry += " DELETE FROM [dbo].Tab_AssignedLeadToUniversity WHERE LeadId=@LeadId AND UniversityId!=@UniversityId";
            Qry += " INSERT INTO [dbo].Tab_LockRegistration(LeadId,UniversityId,LockedBy) VALUES(@LeadId,@UniversityId,@LockedBy)";
            Qry += " SELECT 'S'";
            Qry += " END";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@LeadId", LeadId);
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                    cmd.Parameters.AddWithValue("@LockedBy", UserId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Rslt = Convert.ToString(cmd.ExecuteScalar());
                    con.Close();
                }
            }
            /*if (Rslt != "EX")
            {
                string tmp = this.AddFlagStatus(LeadId, "Locked", UserId);
            }*/
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }

    public string BLockStudent(string UserId, string Remark, string LeadId)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;

            Qry = @"IF EXISTS(SELECT 1 FROM tab_Registration WHERE Reg_id=@LeadId AND BlockStatus='Blocked')";
            Qry += " SELECT 'EX'";
            Qry += " ELSE BEGIN";
            Qry += " UPDATE tab_Registration SET BlockStatus='Block',BlockedBy=@BlockedBy,BlockedMsg=@Remark,BlockedDateTime=GETDATE(),ModifyBy=@UserId,UpdatedOn=GETDATE() WHERE Reg_Id=@LeadId";
            Qry += " SELECT 'S'";
            Qry += " END";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@BlockedBy", UserId);
                    cmd.Parameters.AddWithValue("@Remark", Remark.Trim());
                    cmd.Parameters.AddWithValue("@LeadId", LeadId);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Rslt = Convert.ToString(cmd.ExecuteScalar());
                    con.Close();
                }
            }
            if (Rslt != "EX")
            {
                string tmp = this.AddFlagStatus(LeadId, "BLock", UserId);
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public DataTable BindCountry()
    {
        string qry = string.Empty;
        qry = @"select distinct CountryName,CountryCode,CountryFlag from tbl_CountryCodeMob ";
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
    public DataTable BindDashBoardData(string CounsellerId, string UniversityId)
    {
        string qry = string.Empty;
        qry = @"DECLARE @TotalLoggedIn VARCHAR(100)=''
                DECLARE @TotalRegistration VARCHAR(100)=''
                DECLARE @TotalClosures VARCHAR(100)=''
                DECLARE @TotalContacted VARCHAR(100)=''
                DECLARE @TotalStudentsInEvent VARCHAR(100)=''
                DECLARE @TotalCouncillor VARCHAR(100)=''
                DECLARE @TotalUniversities VARCHAR(100)=''
                DECLARE @TotalStudentAssignedToCouncillor VARCHAR(100)=''
                DECLARE @TotalStudentAssignedToUniversity VARCHAR(100)=''

                SELECT @TotalLoggedIn=COUNT(*) FROM tbl_UserDetails WHERE CurrentLoginStatus='LogIn' AND CONVERT(DATE,LoginDateTime)=CONVERT(DATE,GETDATE())
                SELECT @TotalRegistration=COUNT(*) FROM tab_Registration
                SELECT @TotalClosures=COUNT(*) FROM Tab_LockRegistration
                SELECT @TotalContacted=COUNT(*) FROM Tab_SocialPlateformActivity
                SELECT @TotalStudentsInEvent=COUNT(*) FROM Tab_StudentLogin WHERE CONVERT(DATE,LoginDateTime)=CONVERT(DATE,GETDATE())
                SELECT @TotalCouncillor=COUNT(*) FROM tbl_UserDetails WHERE LoginType='QSTUDY'
                SELECT @TotalUniversities=COUNT(*) FROM Tab_University
                SELECT @TotalStudentAssignedToCouncillor=COUNT(*) FROM Tab_AssignedLead WHERE AssignedTo=@CounsellerId
                SELECT @TotalStudentAssignedToUniversity=COUNT(*) FROM Tab_AssignedLeadToUniversity WHERE UniversityId=@UniversityId

                SELECT @TotalLoggedIn 'TotalLoggedIn',@TotalRegistration 'TotalRegistration',@TotalClosures 'TotalClosures',@TotalContacted 'TotalContacted',@TotalStudentsInEvent 'TotalStudentsInEvent',@TotalCouncillor 'TotalCouncillor',@TotalUniversities 'TotalUniversities',@TotalStudentAssignedToCouncillor 'TotalStudentAssignedToCouncillor',@TotalStudentAssignedToUniversity 'TotalStudentAssignedToUniversity'

                ";

        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    cmd.Parameters.AddWithValue("@CounsellerId", CounsellerId);
                    cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }

    public DataTable GetChartData()
    {
        string qry = string.Empty;
        qry = @"SELECT COUNT(*)Total,CONVERT(VARCHAR(3),DATENAME(month,ActivityDateTime)) AS Month FROM Tab_SocialPlateformActivity
                GROUP BY CONVERT(VARCHAR(3),DATENAME(month,ActivityDateTime))";

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
    
// These Methods For Student -- START///
    public string SelectLang(string StRegNo)
    {
        try
        {
            string Result = "";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentLogin", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FullName", StRegNo.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@Action", "SelectLang");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                Result = dt.Rows[0]["Lang"].ToString();
                            }
                        }
                    }

                }
            }
            return Result;
        }
        catch (Exception ex)
        {
            return "ER";
        }
    }

    public string UpdateLogout(string StRegNo)
    {
        try
        {
            string Result = "";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentLogin", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FullName", StRegNo.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@Action", "Logout");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    // Result = sqlParameter.Value.ToString();
                    Result = "S";

                }
            }
            return Result;
        }
        catch (Exception ex)
        {
            return "ER";
        }
    }

    // END ///

    // These Methods For Student Tracking -- START///

    public void InsertTracking(string Reg_Id,string VisitedPage)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentTracking", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Reg_Id", Reg_Id);
                    cmd.Parameters.AddWithValue("@VisitedPage", VisitedPage);
                    cmd.Parameters.AddWithValue("@Action", "ADD");
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    //Result = "S";

                }
            }
           
        }
        catch (Exception ex)
        {
           
        }
    }
    public void InsertTrackingBooth(string Reg_Id, string UniId,string type)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentTracking", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Reg_Id", Reg_Id);
                    cmd.Parameters.AddWithValue("@UniId", UniId);
                    cmd.Parameters.AddWithValue("@Type", type);
                    cmd.Parameters.AddWithValue("@Action", "ADDBooth");
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    //Result = "S";

                }
            }

        }
        catch (Exception ex)
        {

        }
    }



    // END ///

    ////// added by arv 01/11/2021//////////

    public DataTable GetUniversityUsers()
    {
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT UserId,(FirstName +' '+LastName)Name FROM tbl_UserDetails WHERE LoginType='University' AND Status='1' ORDER BY (FirstName +' '+LastName) ASC", con))
            {
                cmd.CommandType = CommandType.Text;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }
        return dt;
    }

    ////// end by arv 01/11/2021//////////

}



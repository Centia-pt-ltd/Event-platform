using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Configuration;
using System.Text;

public partial class GLOBAL : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class countryCodeList
    {
      
        public string CountryName { get; set; }
        public string CountryCode { get; set; }
        public string CountryMobCode { get; set; }
        public string CountryFlag { get; set; }
        public int MobileNoLength { get; set; }
    }
    [System.Web.Services.WebMethod]
    public static countryCodeList[] bindCountryFlag(string pre)
    {
        List<countryCodeList> details = new List<countryCodeList>();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select distinct CountryName,CountryCode,CountryMobCode,CountryFlag,MobileNoLength from tbl_CountryCodeMob where CountryName like '%" + pre + "%' OR CountryCode like '%" + pre + "%' or CountryMobCode like '%" + pre + "%'";
            cmd.Connection = con;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                countryCodeList det = new countryCodeList();
                det.CountryName = dr["CountryName"].ToString();
                det.CountryCode = dr["CountryCode"].ToString();
                det.CountryMobCode = dr["CountryMobCode"].ToString();
                det.CountryFlag = dr["CountryFlag"].ToString();
                det.MobileNoLength = Convert.ToInt32(dr["MobileNoLength"].ToString());

                details.Add(det);
            }
        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod]
    public static countryCodeList[] GetCountryName()
    {
        clsIPLocator ipl = new clsIPLocator();
        string CountryName = "";
        List<clsLocationList> l = ipl.GetLocation();
        CountryName = l[0].CountryName.ToString();
        
        List<countryCodeList> details = new List<countryCodeList>();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select distinct CountryName,CountryCode,CountryMobCode,CountryFlag,MobileNoLength from tbl_CountryCodeMob where CountryName='"+CountryName+"'";
            cmd.Connection = con;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                countryCodeList det = new countryCodeList();
                det.CountryName = dr["CountryName"].ToString();
                det.CountryCode = dr["CountryCode"].ToString();
                det.CountryMobCode = dr["CountryMobCode"].ToString();
                det.CountryFlag = dr["CountryFlag"].ToString();
                det.MobileNoLength = Convert.ToInt32(dr["MobileNoLength"].ToString());

                details.Add(det);
            }
        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod]
    public static countryCodeList[] GetSelctedCountryCode(string CName)
    {
       
        List<countryCodeList> details = new List<countryCodeList>();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select distinct CountryName,CountryCode,CountryMobCode,CountryFlag,MobileNoLength from tbl_CountryCodeMob where CountryName='" + CName + "'";
            cmd.Connection = con;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                countryCodeList det = new countryCodeList();
                det.CountryCode = dr["CountryCode"].ToString();
                det.CountryMobCode = dr["CountryMobCode"].ToString();
                det.CountryFlag = dr["CountryFlag"].ToString();
                det.MobileNoLength = Convert.ToInt32(dr["MobileNoLength"].ToString());

                details.Add(det);
            }
        }
        return details.ToArray();
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

    [System.Web.Services.WebMethod]
    public static hqDetails[] c_bindhq()
    {
        List<hqDetails> details = new List<hqDetails>();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select HigestId,HigestQualificationName from tbl_HigestQualification";
            cmd.Connection = con;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                hqDetails det = new hqDetails();
                det.hid = Convert.ToInt32(dr["HigestId"].ToString());
                det.hname = dr["HigestQualificationName"].ToString();
                details.Add(det);
            }
        }
        return details.ToArray();
    }
    public class hqDetails
    {
        public int hid { get; set; }
        public string hname { get; set; }
    }

    [System.Web.Services.WebMethod]
    public static cDetails[] c_binddcourse()
    {
        List<cDetails> details = new List<cDetails>();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select CourseId,CourseName from tbl_Course";
            cmd.Connection = con;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                cDetails det = new cDetails();
                det.cid = Convert.ToInt32(dr["CourseId"].ToString());
                det.cname = dr["CourseName"].ToString();
                details.Add(det);
            }
        }
        return details.ToArray();
    }
    public class cDetails
    {
        public int cid { get; set; }
        public string cname { get; set; }
    }

    [System.Web.Services.WebMethod]
    public static codeDetails[] c_binddcode()
    {
        List<codeDetails> details = new List<codeDetails>();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandText = "select CountryCodeId,CountryCodeName from tbl_CountryCodes";
            cmd.Connection = con;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                codeDetails det = new codeDetails();
                det.codeid = Convert.ToInt32(dr["CountryCodeId"].ToString());
                det.countryname = dr["CountryCodeName"].ToString();
                details.Add(det);
            }
        }
        return details.ToArray();
    }
    public class codeDetails
    {
        public int codeid { get; set; }
        public string countryname { get; set; }
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string insertion(string name, string gender, string ccode, string phoneno, string emailid, string country, string state, string txtscore, string msg, string msgid, string hq, string hqid, string course, string courseid, string Abroad, string Fee)
    {
        if (msg != "")
        {
            msg = msg.Substring(0, msg.Length - 1);
        }
        if (msgid != "")
        {
            msgid = msgid.Substring(0, msgid.Length - 1);
        }
        if (hq != "")
        {
            hq = hq.Substring(0, hq.Length - 1);
        }
        if (hqid != "")
        {
            hqid = hqid.Substring(0, hqid.Length - 1);
        }
        if (course != "")
        {
            course = course.Substring(0, course.Length - 1);
        }
        if (courseid != "")
        {
            courseid = courseid.Substring(0, courseid.Length - 1);
        }
        string[] sttr = msgid.Split(',');
        int st = sttr.Length;
        string[] sttr1 = hqid.Split(',');
        int st1 = sttr1.Length;
        string[] sttr2 = courseid.Split(',');
        int st2 = sttr2.Length;
        string str = ""; SqlTransaction transact = null; SqlParameter RValue; int intresult; string iid = "";
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        string RegNo=string.Empty;
        try
        {
            
            con.Open();
            transact = con.BeginTransaction();


            SqlCommand cmdRegNo;
            cmdRegNo = new SqlCommand("SP_RegSeries", con);
            cmdRegNo.CommandType = CommandType.StoredProcedure;
            cmdRegNo.Parameters.AddWithValue("@RegionId", "3");
            RValue = cmdRegNo.Parameters.Add("@RegNo", SqlDbType.NVarChar,200);
            RValue.Direction = ParameterDirection.Output;
            cmdRegNo.CommandTimeout = 0;
            cmdRegNo.Transaction = transact;
            cmdRegNo.ExecuteNonQuery();
            RegNo = RValue.Value.ToString();

            SqlCommand cmd;
            cmd = new SqlCommand("add_registration", con);
            cmd.CommandType = CommandType.StoredProcedure;
            RValue = cmd.Parameters.Add("RValue", SqlDbType.Int);
            RValue.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.AddWithValue("@RegistrationNo", RegNo);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Gender", gender);
            cmd.Parameters.AddWithValue("@Country_Code", ccode);
            cmd.Parameters.AddWithValue("@phone_no", phoneno);
            cmd.Parameters.AddWithValue("@emailid", emailid);
            cmd.Parameters.AddWithValue("@Country", country);
            cmd.Parameters.AddWithValue("@state", state);
            cmd.Parameters.AddWithValue("@CreatedOn", DateTime.Now.ToString("MM/dd/yyyy"));
            cmd.Parameters.AddWithValue("@UpdatedOn", DateTime.Now.ToString("MM/dd/yyyy"));
            cmd.Parameters.AddWithValue("@City", "");
            cmd.Parameters.AddWithValue("@TOEFLScore", txtscore);
            cmd.Parameters.AddWithValue("@msg", msg);
            cmd.Parameters.AddWithValue("@hq", hq);
            cmd.Parameters.AddWithValue("@course", course);
            cmd.Parameters.AddWithValue("@StudyAbroad", Abroad);
            cmd.Parameters.AddWithValue("@FeeRange", Fee);
            cmd.Parameters.AddWithValue("@RegionId", "3");
            cmd.CommandTimeout = 0;
            cmd.Transaction = transact;
            cmd.ExecuteNonQuery();
            intresult = Convert.ToInt32(RValue.Value.ToString());
            if (intresult != 0)
            {
                //code added by Nidhi
                SqlCommand cmdOTPActive;
                cmdOTPActive = new SqlCommand("Update tblOTP Set Active = 1 Where EmailID = @EmailID ", con);
                cmdOTPActive.Parameters.AddWithValue("@EmailID", emailid);
                cmdOTPActive.Transaction = transact;
                cmdOTPActive.ExecuteNonQuery();
                //End Nidhi

                iid = Convert.ToString(intresult);
                for (int i = 0; i < st; i++)
                {
                    int flag = 0;
                    SqlCommand cmd2;
                    cmd2 = new SqlCommand("insert into tbl_map_msg (reg_id,msg_id) values(@reg_id,@msg_id)", con);
                    cmd2.Parameters.AddWithValue("@reg_id", iid);
                    cmd2.Parameters.AddWithValue("@msg_id", sttr[i]);
                    cmd2.Transaction = transact;
                    cmd2.ExecuteNonQuery();
                }

                for (int j = 0; j < st1; j++)
                {
                    int flag = 0;
                    SqlCommand cmd3;
                    cmd3 = new SqlCommand("insert into tbl_map_hq (reg_id,hq_id) values(@reg_id,@hq_id)", con);
                    cmd3.Parameters.AddWithValue("@reg_id", iid);
                    cmd3.Parameters.AddWithValue("@hq_id", sttr1[j]);
                    cmd3.Transaction = transact;
                    cmd3.ExecuteNonQuery();
                }

                for (int c = 0; c < st2; c++)
                {
                    int flag = 0;
                    SqlCommand cmd4;
                    cmd4 = new SqlCommand("insert into tbl_map_course (reg_id,course_id) values(@reg_id,@c_id)", con);
                    cmd4.Parameters.AddWithValue("@reg_id", iid);
                    cmd4.Parameters.AddWithValue("@c_id", sttr2[c]);
                    cmd4.Transaction = transact;
                    cmd4.ExecuteNonQuery();
                }

                string mailid = "qstudyleads@qstudyabroad.com";
                MailMessage mail = new MailMessage();
                mail.To.Add(mailid);
                //mail.From = new MailAddress(emailid, name);
                mail.From = new MailAddress("qstudyleads@qstudyabroad.com", name);
                mail.Subject = "New Registration";
                string Body = enq(name, gender, phoneno, msg, emailid, country, state, hq, course, txtscore);
                mail.Body = Body;                
                mail.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Port = 25;
                smtp.Host = "mail.qstudyabroad.com";
                smtp.Credentials = new System.Net.NetworkCredential("qstudyleads@qstudyabroad.com", "Qstudyleads@2021");
                //smtp.EnableSsl = true;
                smtp.Send(mail);
                mail.Dispose();               
                

                // student

                mail = new MailMessage();
                mail.To.Add(emailid);
                mail.From = new MailAddress("qstudyevent@qstudyabroad.com", "qstudyevent@qstudyabroad.com");
                mail.Subject = "New Registration";
                string Url = "http://qstudyabroad.com/mailTemplate/Globalmena.html";
                string MeetingId = "9612749677";
                string PlateFormLink = "http://qstudyabroad.com/event";
                Body = ClsStudentMailAck.StudentMailAck(Url, name, RegNo.ToString(), MeetingId, PlateFormLink);                
                mail.Body = Body;
                mail.IsBodyHtml = true;
                smtp = new SmtpClient();
                smtp.Port = 25;
                smtp.Host = "mail.qstudyabroad.com";
                smtp.Credentials = new System.Net.NetworkCredential("qstudyevent@qstudyabroad.com", "Qstudyevent@2021");
                smtp.Send(mail);
                mail.Dispose();

                // end student

                //rlt = "Mail Sent Successfully !!";
                //return rlt;
            }
            str = "S";
            transact.Commit();

        }
        catch (Exception ex)
        {
            transact.Rollback();
            str = ex.Message;
        }
        finally
        {
            con.Close();
        }
        return str;
    }

    private static string enq(string name, string gender, string phoneno, string msg, string emailid, string country, string state, string hq, string course, string txtscore)
    {
        try
        {
            string _url = "";

            _url = "http://qstudyabroad.com/genquiry.htm";
            WebClient webClient = new WebClient();
            byte[] reqHTML;
            reqHTML = webClient.DownloadData(_url);
            UTF8Encoding objUTF8 = new UTF8Encoding();
            string PgStr = objUTF8.GetString(reqHTML);
            PgStr = PgStr.Replace("$name", name);
            PgStr = PgStr.Replace("$gender", gender);
            PgStr = PgStr.Replace("$phone", phoneno);
            PgStr = PgStr.Replace("$enq", msg);
            PgStr = PgStr.Replace("$emailid", emailid);
            PgStr = PgStr.Replace("$country", country);
            PgStr = PgStr.Replace("$st", state);
            PgStr = PgStr.Replace("$hq", hq);
            PgStr = PgStr.Replace("$course", course);
            PgStr = PgStr.Replace("$score", txtscore);
            
            return PgStr;
        }
        catch
        {
            return "";
        }
    }
    public static string GenerateOTP()
    {
        Random r = new Random();

        string OTP = r.Next(100000, 999999).ToString();

        return OTP;
    }
    [System.Web.Services.WebMethod]
    public static int SendOTPEmail(string emailID)
    {
        bool IsSent = false;
        int result = 0;
        string OTP = GenerateOTP();

        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
        cmd.Connection = conn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "usp_CreateOTPAndVerify";
        cmd.Parameters.AddWithValue("@flag", 1);
        cmd.Parameters.AddWithValue("@OTP", OTP);
        cmd.Parameters.AddWithValue("@EmailID", emailID);
        cmd.Parameters.Add("@ErrorMessage", SqlDbType.Int, 100);
        cmd.Parameters["@ErrorMessage"].Direction = ParameterDirection.Output;
        try
        {
            conn.Open();
            
            int i = cmd.ExecuteNonQuery();
            int ErrorMessage = Convert.ToInt32(cmd.Parameters["@ErrorMessage"].Value);
            if (ErrorMessage == 0)
            { //Saved

                IsSent = MailSent("Dear Student," + "<br/>" + " Your one time Email verification code is : " + OTP + ".", emailID, "", "", "QStudy: OTP for Email Verification", "QStudy Expo");
                if (IsSent == true)
                {
                    result = 1;
                }
                else
                {
                    result = 0;
                }
            }
            else if (ErrorMessage == 1)
            {//Already Exists
                result = 3;
            }
            else if (ErrorMessage == -1)
            {//Already Exists
                result = 2;
            }
            //return IsSent;
        }
        catch (Exception ex)
        {
            result = 0;
            //ScriptManager.RegisterStartupScript(this, GetType(), "SomethingWrongMessage", "SomethingWrongMessage();", true);

        }
        finally
        {
            conn.Close();
        }
        return result;
    }

    [System.Web.Services.WebMethod]
    public static bool VerifyOTP(string email,string otp)
    {
        bool result = false;
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
        cmd.Connection = conn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "usp_CreateOTPAndVerify";
        cmd.Parameters.AddWithValue("@flag", 2);
        cmd.Parameters.AddWithValue("@OTP", otp);
        cmd.Parameters.AddWithValue("@EmailID", email);
        cmd.Parameters.Add("@ErrorMessage", SqlDbType.Int, 100);
        cmd.Parameters["@ErrorMessage"].Direction = ParameterDirection.Output;
        try
        {
            conn.Open();
            int i = cmd.ExecuteNonQuery();
            int ErrorMessage = Convert.ToInt32(cmd.Parameters["@ErrorMessage"].Value);
            if (ErrorMessage == 0)
            { //Saved
                result = true;
            }
            else if (ErrorMessage == -1)
            {//Already Exists
                    result = false;
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            conn.Close();
        }
        return result;
    }
    [System.Web.Services.WebMethod]

    public static int ResendOTP(string EmailID)
    {
        int result = 0;
        bool IsSent = false;
        string OTP = GenerateOTP();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
        cmd.Connection = conn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "usp_CreateOTPAndVerify";
        cmd.Parameters.AddWithValue("@flag", 3);
        cmd.Parameters.AddWithValue("@OTP", OTP);
        cmd.Parameters.AddWithValue("@EmailID", EmailID);
        cmd.Parameters.Add("@ErrorMessage", SqlDbType.Int, 100);
        cmd.Parameters["@ErrorMessage"].Direction = ParameterDirection.Output;
        try
        {
            conn.Open();
            int i = cmd.ExecuteNonQuery();
            int ErrorMessage = Convert.ToInt32(cmd.Parameters["@ErrorMessage"].Value);
            if (ErrorMessage == 0)
            { //Saved
                IsSent = MailSent("Dear Student," + "<br/>" + " Your one time Email verification code is : " + OTP + ".", EmailID, "", "", "QStudy: OTP for Email Verification", "QStudy Expo");

                if (IsSent == true)
                {
                    result =1;
                }
                else
                {
                    result =0;
                }
            }
            else if (ErrorMessage == -1)
            {//Already Exists
                result= 2;
            }
        }
        catch (Exception ex)
        {
            result = 0;
        }
        finally
        {
            conn.Close();
        }
        return result;

    }

    public static bool MailSent(string BodyMessage, string EmailId, string CCId, string bccid, string Subj, string displayName)
    {
        try
        {

            string mailid = "qstudyevent@qstudyabroad.com";
            MailMessage mail = new MailMessage();
            mail.To.Add(mailid);
            //mail.From = new MailAddress(emailid, name);
            mail.From = new MailAddress("qstudyevent@qstudyabroad.com", displayName);
            mail.Subject = "New Registration";
            string Body = BodyMessage + "<br>" + "Please do not reply to this auto generated mail.<br>Thank You<br>QStudy Expo<br>";
            mail.Body = Body;
            mail.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient();
            smtp.Port = 25;
            smtp.Host = "mail.qstudyabroad.com";
            smtp.Credentials = new System.Net.NetworkCredential("qstudyevent@qstudyabroad.com", "Qstudyevent@2021");
            //smtp.EnableSsl = true;
            smtp.Send(mail);
            mail.Dispose();

            // student

            mail = new MailMessage();
            mail.To.Add(EmailId);
            mail.From = new MailAddress("qstudyevent@qstudyabroad.com", "qstudyevent@qstudyabroad.com");
            mail.Subject = Subj;            
            mail.Body = Body;
            mail.IsBodyHtml = true;
            smtp = new SmtpClient();
            smtp.Port = 25;
            smtp.Host = "mail.qstudyabroad.com";
            smtp.Credentials = new System.Net.NetworkCredential("qstudyevent@qstudyabroad.com", "Qstudyevent@2021");
            smtp.Send(mail);
            mail.Dispose();


            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string BindCountry()
    {
        string Data = "";
        try
        {
            DataTable dt = new DataTable();
            ClsCommanDataAccess _obj = new ClsCommanDataAccess();
            dt = _obj.BindCountry();
            int len = dt.Rows.Count;

            if (len > 0)
            {
                string Id = string.Empty;
                Data = "<option value ='0' selected ='selected'>-Select Country-</option>";
                for (int i = 0; i < len; i++)
                {
                    Id = dt.Rows[i]["CountryName"].ToString();
                    Data += "<option value='" + Id + "'>" + dt.Rows[i]["CountryName"].ToString() + "</option>";
                }
            }
            else
            {

            }

        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }
}

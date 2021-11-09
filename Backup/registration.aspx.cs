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

public partial class registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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
            cmd.CommandTimeout = 0;
            cmd.Transaction = transact;
            cmd.ExecuteNonQuery();
            intresult = Convert.ToInt32(RValue.Value.ToString());
            if (intresult != 0)
            {
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
                Body = "Dear " + name + ",<br/>";
                Body += "<br/>Thank you for registering for our Study Abroad Expo 2021.</br>";
                Body += "<br/>Use this opportunity to connect and be introduced to our exhibitors and make your dreams of Studying Abroad a reality!<br/>";
                Body += "<br/>Here is your Login Credential for the expo:<br/>";
                Body += "<br/>Registration number: " + RegNo.ToString();
                Body += "<br/>Meeting ID: 9612749677";
                Body += "<br/>Login URL: http://qstudyabroad.com/event <br/>";
                Body += "<br/>Note: You can access the LIVE event only on [6th and 7th August, 2021]<br/>";
                Body += "<br/>During the expo, you can:<br/>";
                Body += "<br/> ";
                Body += "• Chat, voice call or video call with representatives from 20+ universities<br/>";
                Body += "• Check course info such as fees, intakes, requirements, etc.<br/>";
                Body += "• Discuss Tuition fee waivers<br/>";
                Body += "• Prepare for your applications and get an immediate offer letter<br/>";
                Body += "<br/>If you need any assistance, you may reach out to our WhatsApp Helpline at +6012-503 7122.<br/>";
                Body += "<img src='http://qstudyabroad.com/img/timeschedule.jpg' alt='imgs'/>";
                Body += "<br/>Save the date and see you all virtually!<br/>";
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
}
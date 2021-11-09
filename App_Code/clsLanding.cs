using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;


/// <summary>
/// Summary description for clsLanding
/// </summary>
public class clsLanding
{

    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    public clsLanding()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string SaveRecord(string name, string email,string countryCode, string phoneNo,string eventName)
    {
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;

            Qry = @"IF EXISTS (SELECT 1 FROM tblLandingPage WHERE email=@email)                        
                        SELECT 'D'
                        ELSE
                        BEGIN
                        INSERT INTO tblLandingPage(name,email,countryCode,phone,createdOn,eventName) VALUES(@name,@email,@countryCode,@phone,getdate(),@eventName)
                        SELECT 'S';
                        END";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@countryCode", countryCode);
                    cmd.Parameters.AddWithValue("@phone", phoneNo);
                    cmd.Parameters.AddWithValue("@eventName", eventName);
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
}
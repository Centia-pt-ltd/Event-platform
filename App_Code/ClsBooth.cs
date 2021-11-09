using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// Summary description for ClsBooth
/// </summary>
public class ClsBooth
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
	public ClsBooth()
	{
		//
		// TODO: Add constructor logic here
		//
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
                        ELSE IF EXISTS(SELECT 1 FROM Tab_MstBooth WHERE AssignedUniversityId=@AssignedUniversityId AND Id!=@BoothId and AssignedUniversityId!=0)
                        SELECT 'U'
                        ELSE
                        BEGIN
                        UPDATE Tab_MstBooth SET AssignedUniversityId=@AssignedUniversityId,Active=@Active,UpdatedDateTime=getdate(),UpdatedBy=@UserId WHERE Id=@BoothId
                        SELECT '" + BoothId + "' END";
            }
            else
            {
                Qry = @"IF EXISTS (SELECT 1 FROM Tab_MstBooth WHERE BoothName=@BoothName)                        
                        SELECT 'N'
                        ELSE IF EXISTS (SELECT 1 FROM Tab_MstBooth WHERE AssignedUniversityId=@AssignedUniversityId and AssignedUniversityId!=0)
                        SELECT 'U'
                        ELSE
                        BEGIN
                        INSERT INTO Tab_MstBooth(BoothName,BoothPage,BoothImage,AssignedUniversityId,Active,CreatedBy,CreatedDateTime) VALUES(@BoothName,@BoothName+'.aspx',@BoothName+'.png',@AssignedUniversityId,@Active,@UserId,getdate())
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
            qry = @"SELECT ROW_NUMBER() over(order by b.Id DESC)'SNo',COUNT(*) OVER(PARTITION BY 1)TotalRows, b.id,b.BoothName,b.BoothPage,b.Active, u.UniversityName,b.createdDateTime FROM Tab_MstBooth b LEFT OUTER JOIN Tab_University u ON b.AssignedUniversityId=u.Id WHERE 1=1 ";
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

            qry = @"SELECT b.id,b.BoothName,b.BoothImage,b.BoothPage,b.Active,u.UniversityName,isnull(u.Id,'')'UniversityId',b.createdDateTime,(s.FirstName+' '+s.LastName)'CreatedBy',isnull(b.LogoImageFunc,'')LogoImageFunc,
                    isnull(b.BannerImageFunc,'')BannerImageFunc FROM Tab_MstBooth b LEFT OUTER JOIN Tab_University u
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
}
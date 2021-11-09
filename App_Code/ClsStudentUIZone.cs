using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for ClsStudentUIZone
/// </summary>
public class ClsStudentUIZone
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
	public ClsStudentUIZone()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string GetAboutUs(string UniversityId)
    {
        string qry = string.Empty;
        string Rslt = string.Empty;
        qry = @"SELECT Details FROM [dbo].[Tab_Mst_AboutUs] WHERE UploadedSource='University' AND UniversityId=@Uid";
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@Uid", UniversityId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                            Rslt = dt.Rows[0]["Details"].ToString();
                    }
                }
            }
        }
        return Rslt;
    }
    public DataTable GetPhoto(string UniversityId)
    {
        string qry = string.Empty;
        qry = @"SELECT ImageName AS 'DisplayImageName',ImageDuplicateName AS 'DownloadImageName' FROM [dbo].[Tab_Mst_Photo]	WHERE UploadedSource='University' AND UniversityId=@UniversityId ORDER BY Id DESC";
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
    public DataTable GetBrochure(string UniversityId)
    {
        string qry = string.Empty;
        qry = @"SELECT Id,Title AS 'DisplayFileName',FileDuplicateName AS 'DownloadFileName' FROM [dbo].[Tab_Mst_Brochure] WHERE UploadedSource='University' AND UniversityId=@University ORDER BY Id DESC";
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                cmd.Parameters.AddWithValue("@University", UniversityId);
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
    public DataTable GetBrochuresNameById(string BrochureId, string sts, string UniversityId)
    {
        string qry = string.Empty;
        if (sts.Trim().ToUpper()=="SINGLE")
        qry = @"SELECT Id,FilesName AS 'DisplayFileName',FileDuplicateName AS 'DownloadFileName' FROM [dbo].[Tab_Mst_Brochure] WHERE UploadedSource='University' AND Id IN(" + BrochureId + ")";
        else if (sts.Trim().ToUpper() == "ALL")
            qry = @"SELECT Id,FilesName AS 'DisplayFileName',FileDuplicateName AS 'DownloadFileName' FROM [dbo].[Tab_Mst_Brochure] WHERE UploadedSource='University' AND UniversityId=@UniversityId";
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

    public DataTable GetVideo(string UniversityId)
    {
        string qry = string.Empty;
        qry = @"SELECT Id,VideoUrl AS 'Url',isNull(Title,'No Title') as Title FROM [dbo].[Tab_Mst_Videos] WHERE UploadedSource='University' AND UniversityId=@UniversityId ORDER BY Id DESC";
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

    public class Photo
    {
        public string DisplayImageName { set; get; }
        public string DownloadImageName { set; get; }
    }
    public class Brochure
    {
        public string DisplayFileName { set; get; }
        public string DownloadFileName { set; get; }
        public string Id { set; get; }
    }
    public class Video
    {
        public string Id { set; get; }
        public string Url { set; get; }
    }
}
<%@ WebHandler Language="C#" Class="UniversityBrochureUpload" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class UniversityBrochureUpload : IHttpHandler
{

    string dbCon = System.Configuration.ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string UploadedBy = HttpContext.Current.Request.QueryString[0];
        string UniversityId = HttpContext.Current.Request.QueryString[1];

        ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
        string UploadedSource = _obj.Source;

        string dirFullPath = HttpContext.Current.Server.MapPath("../UploadedBrochure/");
        string[] files;
        files = System.IO.Directory.GetFiles(dirFullPath);

        string QryTotalRows = string.Empty;
        QryTotalRows = @"SELECT ISNULL(COUNT(*),0)TOTAL FROM Tab_Mst_Brochure WHERE UniversityId=@UniversityId";
        int TotalRows = 0;
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(QryTotalRows, con))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                con.Open();
                TotalRows = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();
            }
        }
        string FileTitle = string.Empty;
        QryTotalRows = @"SELECT ISNULL(COUNT(*),0)TOTAL FROM Tab_Mst_Brochure WHERE UniversityId=@UniversityId AND Title=@Title";
        int TotalTitle = 0;
        using (SqlConnection con = new SqlConnection(dbCon))
        {
            using (SqlCommand cmd = new SqlCommand(QryTotalRows, con))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                cmd.Parameters.AddWithValue("@Title", HttpContext.Current.Request.Form["Title"].ToString());
                con.Open();
                TotalTitle = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();
            }
        }

        if (TotalTitle > 0)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("EX");
        }

        else if (TotalRows < 15)
        {
            string Qry = string.Empty;
            Qry = @"INSERT INTO Tab_Mst_Brochure(FilesName,Ext,UploadedSource,UploadedBy,UniversityId,Title)
                VALUES(@FilesName,@Ext,@UploadedSource,@UploadedBy,@UniversityId,@Title)
                SELECT SCOPE_IDENTITY();";
            int Rslt = 0;
            foreach (string s in context.Request.Files)
            {
                HttpPostedFile file = context.Request.Files[s];
                int fileSizeInBytes = file.ContentLength;
                string fileName = file.FileName;
                string fileExtension = file.ContentType;

                if (!string.IsNullOrEmpty(fileName))
                {
                    using (SqlConnection con = new SqlConnection(dbCon))
                    {
                        using (SqlCommand cmd = new SqlCommand(Qry, con))
                        {
                            fileExtension = System.IO.Path.GetExtension(fileName);
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@FilesName", fileName.Replace(" ", "_"));
                            cmd.Parameters.AddWithValue("@Ext", fileExtension);
                            cmd.Parameters.AddWithValue("@UploadedSource", UploadedSource);
                            cmd.Parameters.AddWithValue("@UploadedBy", UploadedBy);
                            cmd.Parameters.AddWithValue("@UniversityId", UniversityId);
                            cmd.Parameters.AddWithValue("@Title", HttpContext.Current.Request.Form["Title"].ToString());
                            con.Open();
                            Rslt = Convert.ToInt32(cmd.ExecuteScalar());
                            con.Close();
                        }
                    }

                    // update

                    string tmpUniqueFileName = fileName.Split('.')[0].ToString() + "$" + Rslt.ToString() + "" + fileExtension;

                    using (SqlConnection con = new SqlConnection(dbCon))
                    {
                        using (SqlCommand cmd = new SqlCommand("Update Tab_Mst_Brochure set FileDuplicateName=@FileDuplicateName where Id=@Id", con))
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@FileDuplicateName", tmpUniqueFileName);
                            cmd.Parameters.AddWithValue("@Id", Rslt);
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                    string pathToSave_100 = HttpContext.Current.Server.MapPath("../UploadedBrochure/") + tmpUniqueFileName;
                    file.SaveAs(pathToSave_100);

                    context.Response.ContentType = "text/plain";
                    context.Response.Write("S");
                }
            }
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("L");
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
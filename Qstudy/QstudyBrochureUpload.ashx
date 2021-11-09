<%@ WebHandler Language="C#" Class="QstudyBrochureUpload" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class QstudyBrochureUpload : IHttpHandler
{

    string dbCon = System.Configuration.ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string UploadedBy = HttpContext.Current.Request.QueryString[0];

       ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
        string UploadedSource = _obj.Source;

        string dirFullPath = HttpContext.Current.Server.MapPath("../UploadedBrochure/");
        string[] files;
        files = System.IO.Directory.GetFiles(dirFullPath);

        string Qry = string.Empty;
        Qry = @"INSERT INTO Tab_Mst_Brochure(FilesName,Ext,UploadedSource,UploadedBy)
                VALUES(@FilesName,@Ext,@UploadedSource,@UploadedBy)
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
            }
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
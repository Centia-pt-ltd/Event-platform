<%@ WebHandler Language="C#" Class="BoothHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class BoothHandler : IHttpHandler
{

    string dbCon = System.Configuration.ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string Rslt = string.Empty;
        string UniversityId = HttpContext.Current.Request.QueryString[0];
        string ImgSize = HttpContext.Current.Request.QueryString[1];
        Rslt = UniversityId;
        string Qry = string.Empty;
        string dirFullPath = HttpContext.Current.Server.MapPath("../UploadedBooth/");
        string[] files;
        files = System.IO.Directory.GetFiles(dirFullPath);

        foreach (string s in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files[s];
            int fileSizeInBytes = file.ContentLength;
            string fileName = file.FileName;
            string fileExtension = System.IO.Path.GetExtension(fileName);

            if (!string.IsNullOrEmpty(fileName))
            {
                string tmpUniqueFileName = fileName.Split('.')[0].ToString() + "$" + Rslt.ToString() + "" + fileExtension;
                if (ImgSize.Trim().ToUpper() == "BIG")
                    Qry = @"UPDATE Tab_University SET ImageBig=@BannerImageFunc WHERE Id=@UniversityId";
                else if (ImgSize.Trim().ToUpper() == "SMALL")
                    Qry = @"UPDATE Tab_University SET ImageSmall=@LogoImageFunc WHERE Id=@UniversityId";

                using (SqlConnection con = new SqlConnection(dbCon))
                {
                    using (SqlCommand cmd = new SqlCommand(Qry, con))
                    {

                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@BannerImageFunc", tmpUniqueFileName.Replace(" ", "_"));
                        cmd.Parameters.AddWithValue("@LogoImageFunc", tmpUniqueFileName.Replace(" ", "_"));
                        cmd.Parameters.AddWithValue("@UniversityId", Rslt);
                        con.Open();
                        Rslt = Convert.ToString(cmd.ExecuteNonQuery());
                        con.Close();
                    }
                }
                string pathToSave_100 = HttpContext.Current.Server.MapPath("../UploadedBooth/") + tmpUniqueFileName.Replace(" ", "_");
                file.SaveAs(pathToSave_100);
            }
        }

        context.Response.Write(Rslt);
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
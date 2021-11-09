<%@ WebHandler Language="C#" Class="UniversityHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class UniversityHandler : IHttpHandler
{

    string dbCon = System.Configuration.ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string Rslt = string.Empty;
        string Qry = string.Empty;
        // try
        // {
        context.Response.ContentType = "text/plain";
        string Uid = HttpContext.Current.Request.QueryString[0];
        string Name = HttpContext.Current.Request.QueryString[1];
        string Email = HttpContext.Current.Request.QueryString[2];
        string sts = HttpContext.Current.Request.QueryString[3];
        string UserId = HttpContext.Current.Request.QueryString[4];
        string Region = HttpContext.Current.Request.QueryString[5];

        ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
        Rslt = _obj.SaveUpdateUniversity(Name, Email, Uid, sts, UserId, Region);

        if ((Rslt != "N") || (Rslt != "E") || (Rslt != "ER"))
        {

            string dirFullPath = HttpContext.Current.Server.MapPath("../UploadedLogo/");
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
                    Qry = @"UPDATE Tab_University SET Logo=@Logo WHERE Id=@Uid";

                    using (SqlConnection con = new SqlConnection(dbCon))
                    {
                        using (SqlCommand cmd = new SqlCommand(Qry, con))
                        {

                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@Logo", tmpUniqueFileName.Replace(" ", "_"));
                            cmd.Parameters.AddWithValue("@Uid", Rslt);
                            con.Open();
                            Rslt = Convert.ToString(cmd.ExecuteNonQuery());
                            con.Close();
                        }
                    }
                    string pathToSave_100 = HttpContext.Current.Server.MapPath("../UploadedLogo/") + tmpUniqueFileName.Replace(" ", "_");
                    file.SaveAs(pathToSave_100);
                }
            }
        }
        else
        {
            Rslt = Rslt;
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
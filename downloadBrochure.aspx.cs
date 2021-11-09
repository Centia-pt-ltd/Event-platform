using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.IO;
using Ionic.Zip;

public partial class downloadBrochure : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            // try
            // {
            if (Request.QueryString["Id"] != "" || Request.QueryString["Id"] != null)
            {
                string BroucherId = Request.QueryString["Id"].ToString();
                string UniversityId = Request.QueryString["UniversityId"].ToString();
                string sts = Request.QueryString["sts"].ToString().Trim().ToUpper();
                ClsStudentUIZone _objStudent = new ClsStudentUIZone();
                DataTable dt = new DataTable();
                
                
                string FileName = string.Empty;
                string SavedFileName = string.Empty;
                string sPath = string.Empty;
                if (Request.QueryString["sts"].ToString().Trim().ToUpper() == "SINGLE")
                {
                    dt = _objStudent.GetBrochuresNameById(BroucherId, sts, UniversityId);
                    int len = dt.Rows.Count;
                    for (int i = 0; i < len; i++)
                    {

                        SavedFileName = dt.Rows[i]["DownloadFileName"].ToString();
                        FileName = dt.Rows[i]["DisplayFileName"].ToString();
                        sPath = HttpContext.Current.Server.MapPath("UploadedBrochure/" + SavedFileName);
                        Response.AppendHeader("Content-Disposition", "attachment; filename=" + FileName + "");
                        Response.TransmitFile(sPath);
                        Response.End();
                    }
                }
                else if (Request.QueryString["sts"].ToString().Trim().ToUpper() == "ALL")
                {
                    using (ZipFile zip = new ZipFile())
                    {
                        zip.AlternateEncodingUsage = ZipOption.AsNecessary;
                        zip.AddDirectoryByName("Files");
                        dt = _objStudent.GetBrochuresNameById(BroucherId, sts, UniversityId);
                        foreach (DataRow dr in dt.Rows)
                        {
                            SavedFileName = dr["DownloadFileName"].ToString();
                            FileName = dr["DisplayFileName"].ToString();
                            sPath = HttpContext.Current.Server.MapPath("UploadedBrochure/" + SavedFileName);
                            string filePath = sPath;
                            zip.AddFile(filePath, "Files");
                        }
                        Response.Clear();
                        Response.BufferOutput = false;
                        string zipName = String.Format("Zip_{0}.zip", DateTime.Now.ToString("yyyy-MMM-dd-HHmmss"));
                        Response.ContentType = "application/zip";
                        Response.AddHeader("content-disposition", "attachment; filename=" + zipName);
                        zip.Save(Response.OutputStream);
                        Response.End();
                    }
                }
            }
            // }
            // catch (Exception ex)
            // {

            // }
        }
    }
}
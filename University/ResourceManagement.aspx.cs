using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class University_ResourceManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

        if (!Page.IsPostBack)
        {
            if (Session["UserId"] == null || Session["UserId"] == "")
            {

                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
                Response.Cache.SetNoStore();
                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("login.aspx", false);
            }
            else
            {
                hdfUserId.Value = Session["UserId"].ToString();
                hdfUniversityId.Value = Session["University"].ToString();
                Page.Title = "University::ResourceManagement";
            }
        }

    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string FillResoucresForDelete()
    {
        StringBuilder _SbPhotoL = new StringBuilder();
        StringBuilder _SbBrochure = new StringBuilder();
        StringBuilder _SbVideo = new StringBuilder();
        string Data = "";
        try
        {
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            DataSet ds = new DataSet();
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            ds = _obj.GetResourceList(UniversityId);
            DataTable dtPhoto = new DataTable();
            DataTable dtBrocure = new DataTable();
            DataTable dtVideo = new DataTable();

            dtPhoto = ds.Tables["Table"];
            dtBrocure = ds.Tables["Table1"];
            dtVideo = ds.Tables["Table2"];

            // photo list
            _SbPhotoL.Append("<table style='font-size:12px'>");
            _SbPhotoL.Append("<thead>");
            _SbPhotoL.Append("<tr>");
            _SbPhotoL.Append("<th>SNo.</th><th>Action</th><th>Image Name</th><th>Uploaded DateTime</th><th>UploadedBy</th>");
            _SbPhotoL.Append("</tr>");
            _SbPhotoL.Append("</thead>");
            _SbPhotoL.Append("<tbody>");
            int c = 1;
            string tmpId = string.Empty;
            foreach (DataRow dr in dtPhoto.Rows)
            {
                tmpId = "trPhoto" + dr["Id"].ToString();
                _SbPhotoL.Append("<tr style='background-color:transparent' id=" + tmpId + "><td>" + c.ToString() + "</td><td><a href='javascript:void();' onclick='DeleteResource(this.id,\"photo\");' id=trp" + dr["Id"].ToString() + " data-fileName='" + dr["ImageDuplicateName"].ToString() + "'><i class='fa fa-trash-o fa-lg' aria-hidden='true'></i></a></td><td>" + dr["ImageName"].ToString() + "</td><td>" + dr["UploadedDateTime"].ToString() + "</td><td>" + dr["UploadedBy"].ToString() + "</td></tr>");
                c = c + 1;
            }
           /* _SbPhotoL.Append("</tbody>");
            _SbPhotoL.Append("<tfoot>");
            _SbPhotoL.Append("<tr><td></td><td><input type='submit' value='upload' class='btn btn-succes' id='btnImageUpload' onclick='return UploadImage();'></td><td><input type='file'/></td><td></td><td></td></tr>");
            _SbPhotoL.Append("</tfoot>");
            _SbPhotoL.Append("</table>");
            */

            // brochures list
            c = 1;

            _SbBrochure.Append("<table style='font-size:12px'>");
            _SbBrochure.Append("<thead>");
            _SbBrochure.Append("<tr>");
            _SbBrochure.Append("<th>SNo.</th><th>Action</th><th>Title</th><th>File Name</th><th>Uploaded DateTime</th><th>UploadedBy</th>");
            _SbBrochure.Append("</tr>");
            _SbBrochure.Append("</thead>");
            _SbBrochure.Append("<tbody>");

            foreach (DataRow dr in dtBrocure.Rows)
            {
                tmpId = "trBr" + dr["Id"].ToString();
                _SbBrochure.Append("<tr style='background-color:transparent' id=" + tmpId + "><td>" + c.ToString() + "</td><td><a href='javascript:void();' onclick='DeleteResource(this.id,\"brochure\");' id=trb" + dr["Id"].ToString() + " data-fileName='" + dr["FileDuplicateName"].ToString() + "'><i class='fa fa-trash-o fa-lg' aria-hidden='true'></i></a></td><td>" + dr["Title"].ToString() + "</td><td>" + dr["FilesName"].ToString() + "</td><td>" + dr["UploadedDateTime"].ToString() + "</td><td>" + dr["UploadedBy"].ToString() + "</td></tr>");
                c = c + 1;
            }
            _SbBrochure.Append("</tbody>");
            _SbBrochure.Append("</table>");

            // video list
            c = 1;

            _SbVideo.Append("<table style='font-size:12px'>");
            _SbVideo.Append("<thead>");
            _SbVideo.Append("<tr>");
            _SbVideo.Append("<th>SNo.</th><th>Action</th><th>Title</th><th>Youtube Embed Video URL</th><th>Uploaded DateTime</th><th>UploadedBy</th>");
            _SbVideo.Append("</tr>");
            _SbVideo.Append("</thead>");
            _SbVideo.Append("<tbody>");

            foreach (DataRow dr in dtVideo.Rows)
            {
                tmpId = "trYtb" + dr["Id"].ToString();
                _SbVideo.Append("<tr style='background-color:transparent' id=" + tmpId + "><td>" + c.ToString() + "</td><td><a href='javascript:void();' onclick='DeleteResource(this.id,\"youtube\");' id=trv" + dr["Id"].ToString() + "><i class='fa fa-trash-o fa-lg' aria-hidden='true'></i></a></td><td>" + dr["Title"].ToString() + "</td><td>" + dr["VideoUrl"].ToString() + "</td><td>" + dr["UploadedDateTime"].ToString() + "</td><td>" + dr["UploadedBy"].ToString() + "</td></tr>");
                c = c + 1;
            }
            _SbVideo.Append("</tbody>");
            _SbVideo.Append("</table>");

            Data = _SbPhotoL.ToString() + "^" + _SbBrochure.ToString() + "^" + _SbVideo.ToString();

        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string CheckUniversityUploadLimit()
    {
        string Data = "";
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            string UploadedSource = _obj.Source;
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            Data = _obj.CheckUploadLimit(UniversityId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string DeleteResources(string Id, string Source, string FileName)
    {
        string Data = "";
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            string UploadedSource = _obj.Source;
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            Data = _obj.DeleteResources(Id, Source, FileName);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

   [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string FillAboutUs()
    {
        string Data = "";
        try
        {

            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            string UploadedSource = _obj.Source;
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            Data = _obj.GetAboutUs(UploadedSource, UniversityId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveVideo(string Url, string Title)
    {
        string Data = "";
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            Data = _obj.SaveVideoUrl(Url, _obj.Source, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["University"].ToString(), Title);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveAboutUs(string details)
    {
        string Rslt = string.Empty;
        ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
        string UploadedBy = HttpContext.Current.Session["UserId"].ToString();
        string UniversityId = HttpContext.Current.Session["University"].ToString();
        Rslt = _obj.UploadAbout(details, _obj.Source, UploadedBy, UniversityId);
        return Rslt;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsUniversityDataAccess.Youtube[] FillUploadedYoutube()
    {
        List<ClsUniversityDataAccess.Youtube> details = new List<ClsUniversityDataAccess.Youtube>();
        ClsUniversityDataAccess _objUniversity = new ClsUniversityDataAccess();
        DataTable dt = null;
        try
        {
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            dt = _objUniversity.GetUploadedYoutube(UniversityId);
            foreach (DataRow dr in dt.Rows)
            {
                ClsUniversityDataAccess.Youtube det = new ClsUniversityDataAccess.Youtube();
                det.Id = dr["Id"].ToString();
                det.Url = dr["VideoUrl"].ToString();
                det.TotalRows = dr["TotalRows"].ToString();
                det.Title = dr["Title"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
        }
        return details.ToArray();
    }
    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsUniversityDataAccess.Photo[] FillUploadedPhoto()
    {
        List<ClsUniversityDataAccess.Photo> details = new List<ClsUniversityDataAccess.Photo>();
        ClsUniversityDataAccess _objUniversity = new ClsUniversityDataAccess();
        DataTable dt = null;
        try
        {
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            dt = _objUniversity.GetUploadedPhoto(UniversityId);
            foreach (DataRow dr in dt.Rows)
            {
                ClsUniversityDataAccess.Photo det = new ClsUniversityDataAccess.Photo();
                det.Id = dr["Id"].ToString();
                det.DisplayName = dr["ImageName"].ToString();
                det.TotalRows = dr["TotalRows"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static ClsUniversityDataAccess.Brochure[] FillUploadedBroucher()
    {
        List<ClsUniversityDataAccess.Brochure> details = new List<ClsUniversityDataAccess.Brochure>();
        ClsUniversityDataAccess _objUniversity = new ClsUniversityDataAccess();
        DataTable dt = null;
        try
        {
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            dt = _objUniversity.GetUploadedBrouchers(UniversityId);
            foreach (DataRow dr in dt.Rows)
            {
                ClsUniversityDataAccess.Brochure det = new ClsUniversityDataAccess.Brochure();
                det.Id = dr["Id"].ToString();
                det.DisplayName = dr["FilesName"].ToString();
                det.TotalRows = dr["TotalRows"].ToString();
                details.Add(det);
            }
        }
        catch (Exception ex)
        {
        }
        return details.ToArray();
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string CheckDuplicateImageName(string ImageName)
    {
        string Data = "";
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            string UploadedSource = _obj.Source;
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            Data = _obj.DuplicateImageName(ImageName, UniversityId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string DuplicateBrochureName(string ImageName, string Title)
    {
        string Data = "";
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            string UploadedSource = _obj.Source;
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            Data = _obj.DuplicateBrochureImageName(ImageName, Title, UniversityId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

    [System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string DuplicateVideo(string Url, string Title)
    {
        string Data = "";
        try
        {
            ClsUniversityDataAccess _obj = new ClsUniversityDataAccess();
            string UploadedSource = _obj.Source;
            string UniversityId = HttpContext.Current.Session["University"].ToString();
            Data = _obj.DuplicateVideo(Url, Title, UniversityId);
        }
        catch (Exception ex)
        {
            Data = "ER";
        }
        return Data;
    }

}
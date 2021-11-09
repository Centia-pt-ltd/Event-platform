using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for ClsStudentMailAck
/// </summary>
public class ClsStudentMailAck
{
	public ClsStudentMailAck()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static string StudentMailAck(string Url, string Name, string RegNo, string MeetingId, string PlateFormLink)
    {
        try
        {
            string _url = "";
            _url = Url;
            WebClient webClient = new WebClient();
            byte[] reqHTML;
            reqHTML = webClient.DownloadData(_url);
            UTF8Encoding objUTF8 = new UTF8Encoding();
            string PgStr = objUTF8.GetString(reqHTML);
            PgStr = PgStr.Replace("$Name", Name);
            PgStr = PgStr.Replace("$RegNo", RegNo);
            PgStr = PgStr.Replace("$MeetingId", MeetingId);
            PgStr = PgStr.Replace("$PlateFormLink", PlateFormLink);
            return PgStr;
        }
        catch
        {
            return "";
        }
    }
}
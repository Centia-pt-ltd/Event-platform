using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Xml.Linq;
using System.IO;
using System.Web.Script.Serialization;
using System.Threading.Tasks;

/// <summary>
/// Summary description for IPLocator
/// </summary>
public class clsIPLocator
{
    public string IPaddress = "";

    public clsIPLocator()
    {
        try
        {
            WebRequest request = WebRequest.Create("http://checkip.dyndns.org/");
            using (WebResponse response = request.GetResponse())
            using (StreamReader stream = new StreamReader(response.GetResponseStream()))
            {
                IPaddress = stream.ReadToEnd();
            }

            int first = IPaddress.IndexOf("Address: ") + 9;
            int last = IPaddress.LastIndexOf("</body>");
            IPaddress = IPaddress.Substring(first, last - first);
        }
        catch(Exception ex)
        {

        }
    }
   
    public List<clsLocationList> GetLocation()

    {
        string IPKey = "b0b5c64da4384cc2853df617efe5879fb09bb0bc2cab0261478fb092ac794cfd";
        String url = String.Empty;
        List<clsLocationList> locations = new List<clsLocationList>();
        if (IPaddress != String.Empty)

        {
            ServicePointManager.Expect100Continue = true;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
            ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;
            url = string.Format("http://api.ipinfodb.com/v3/ip-city/?key=b0b5c64da4384cc2853df617efe5879fb09bb0bc2cab0261478fb092ac794cfd&ip={0}&format=json",IPaddress);
            using (WebClient client = new WebClient())
            {
                string json = client.DownloadString(url);
                clsLocationList location = new JavaScriptSerializer().Deserialize<clsLocationList>(json);
                
                locations.Add(location);
                
            }
            
        }
        return locations;
    }
}
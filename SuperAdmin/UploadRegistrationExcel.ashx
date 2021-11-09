<%@ WebHandler Language="C#" Class="UploadRegistrationExcel" %>

using System;
using System.Web;
using System.IO;
using Excel;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;

public class UploadRegistrationExcel : IHttpHandler
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string Rslt = string.Empty;
        string table = string.Empty;
        string dirFullPath = HttpContext.Current.Server.MapPath("../UploadedExcel/");
        string[] files;
        files = System.IO.Directory.GetFiles(dirFullPath);

        SqlTransaction transact = null;
        SqlConnection con = null;
        try
        {
            string Random = string.Empty;
            Random = DateTime.Now.ToString().Replace("/", "_").Replace(":", "_").Replace("-", "_");
            string tmpUniqueFileName = string.Empty;
            string pathToSave = string.Empty;
            string fileExtension = string.Empty;
            foreach (string s in context.Request.Files)
            {
                HttpPostedFile file = context.Request.Files[s];
                int fileSizeInBytes = file.ContentLength;
                string fileName = file.FileName;
                fileExtension = System.IO.Path.GetExtension(fileName);

                if (!string.IsNullOrEmpty(fileName))
                {
                    tmpUniqueFileName = (fileName.Split('.')[0].ToString() + Random + fileExtension).Replace(" ", "_");
                    pathToSave = HttpContext.Current.Server.MapPath("../UploadedExcel/") + tmpUniqueFileName;
                    file.SaveAs(pathToSave);
                }
            }


            using (FileStream stream = File.Open(HttpContext.Current.Server.MapPath("../UploadedExcel/" + tmpUniqueFileName), FileMode.Open, FileAccess.Read))
            {
                string Ext = fileExtension.Replace(".", "");
                DataSet result = new DataSet();
                if (Ext == "xlsx")
                {
                    IExcelDataReader excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                    excelReader.IsFirstRowAsColumnNames = true;
                    result = excelReader.AsDataSet();
                }
                else if (Ext == "xls")
                {
                    IExcelDataReader excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                    excelReader.IsFirstRowAsColumnNames = true;
                    result = excelReader.AsDataSet();
                }
                //if (result.Tables[0].Rows.Count > 0)
                //{
                //  int row = result.Tables[0].Rows.Count;
                //result.Tables[0].Rows[row - 1].Delete();
                DataTable dtimport = result.Tables[0];
                //}
                int len = dtimport.Rows.Count;
                if (len > 0)
                {
                    string Name = string.Empty;
                    string Gender = string.Empty;
                    string CountryCode = string.Empty;
                    string PhoneNo = string.Empty;
                    string Emailid = string.Empty;
                    string Country = string.Empty;
                    string State = string.Empty;
                    string City = string.Empty;
                    string TOEFLScore = string.Empty;
                    string MessagePlateForm = string.Empty;
                    string HighestQualification = string.Empty;
                    string Course = string.Empty;
                    string StudyAbroad = string.Empty;
                    string FeeRange = string.Empty;
                    string Region = string.Empty;
                    string Active = string.Empty;
                    string CreatedOn = string.Empty;
                    SqlParameter RValue;
                    string RegNo = string.Empty;
                    string RegionId = string.Empty;
                    ClsSuperAdminDataAcces _objDac = new ClsSuperAdminDataAcces();
                    string Qry = string.Empty;

                    Qry = "";
                    Qry = @"IF EXISTS(SELECT 1 FROM Tab_Registration WHERE emailid=@emailid)";
                    Qry += @" SELECT 'M'";
                    Qry += @" ELSE IF EXISTS(SELECT 1 FROM Tab_Registration WHERE phone_no=@phone_no)";
                    Qry += @" SELECT 'P'";
                    Qry += @" ELSE BEGIN";
                    Qry += @" INSERT INTO Tab_Registration(Name,Gender,phone_no,emailid,Country,State,TOEFLScore,msg,hq,course,RegistrationNo,StudyAbroad,RegionId,Active,CreatedOn)";
                    Qry += @" VALUES(@Name,@Gender,@phone_no,@emailid,@Country,@State,@TOEFLScore,@msg,@hq,@course,@RegistrationNo,@StudyAbroad,@RegionId,@Active,@CreatedOn)";
                    Qry += @" SELECT 'S'";
                    Qry += @" END";

                    table += "<div style='max-height:300px; overflow-y:scroll'><table id='tblLog'><thead>";
                    table += "<tr><th>SNo</th><th>Name</th><th>Email</th><th>Phone</th><th>Error Descriptions</th></tr></thead><tbody>";
                    int counter = 0;
                    for (int i = 0; i < len; i++)
                    {
                        Name = dtimport.Rows[i]["Name"].ToString();
                        Gender = dtimport.Rows[i]["Gender"].ToString();
                        CountryCode = dtimport.Rows[i]["CountryCode"].ToString();
                        PhoneNo = dtimport.Rows[i]["PhoneNo"].ToString();
                        Emailid = dtimport.Rows[i]["Emailid"].ToString();
                        Country = dtimport.Rows[i]["Country"].ToString();
                        State = dtimport.Rows[i]["State"].ToString();
                        TOEFLScore = dtimport.Rows[i]["TOEFLScore"].ToString();
                        MessagePlateForm = dtimport.Rows[i]["MessagePlateForm"].ToString();
                        HighestQualification = dtimport.Rows[i]["HighestQualification"].ToString();
                        Course = dtimport.Rows[i]["Course"].ToString();
                        StudyAbroad = dtimport.Rows[i]["StudyAbroad"].ToString();
                        FeeRange = dtimport.Rows[i]["FeeRange"].ToString();
                        Region = dtimport.Rows[i]["Region"].ToString();
                        Active = dtimport.Rows[i]["Active"].ToString();
                        CreatedOn = dtimport.Rows[i]["CreatedOn"].ToString();



                        if (Name != "" && PhoneNo != "" && Emailid != "" && Country != "" && State != "" && MessagePlateForm != "" && HighestQualification != "" && Region != "" && Active != "")
                        {
                            // && Course != "" && StudyAbroad != "" && FeeRange != ""

                            RegionId = _objDac.GetRegionByName(Region.Trim());
                            if (RegionId != "0" || RegionId != "")
                            {
                                con = new SqlConnection(dbCon);
                                transact = null;
                                con.Open();
                                transact = con.BeginTransaction();

                                SqlCommand cmd = new SqlCommand("SP_RegSeries", con);
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@RegionId", RegionId);
                                RValue = cmd.Parameters.Add("@RegNo", SqlDbType.NVarChar, 200);
                                RValue.Direction = ParameterDirection.Output;
                                cmd.CommandTimeout = 0;
                                cmd.Transaction = transact;
                                cmd.ExecuteNonQuery();
                                RegNo = RValue.Value.ToString();

                                SqlCommand cmdSave = new SqlCommand(Qry, con);
                                cmdSave.CommandType = CommandType.Text;
                                cmdSave.Parameters.AddWithValue("@Name", Name);
                                cmdSave.Parameters.AddWithValue("@Gender", Gender);
                                cmdSave.Parameters.AddWithValue("@phone_no", PhoneNo);
                                cmdSave.Parameters.AddWithValue("@emailid", Emailid);
                                cmdSave.Parameters.AddWithValue("@Country", Country);
                                cmdSave.Parameters.AddWithValue("@State", State);
                                cmdSave.Parameters.AddWithValue("@CreatedOn", CreatedOn);
                                cmdSave.Parameters.AddWithValue("@TOEFLScore", TOEFLScore);
                                cmdSave.Parameters.AddWithValue("@msg", MessagePlateForm);
                                cmdSave.Parameters.AddWithValue("@hq", HighestQualification);
                                cmdSave.Parameters.AddWithValue("@course", Course);
                                cmdSave.Parameters.AddWithValue("@RegistrationNo", RegNo);
                                cmdSave.Parameters.AddWithValue("@StudyAbroad", StudyAbroad);
                                cmdSave.Parameters.AddWithValue("@RegionId", RegionId);
                                cmdSave.Parameters.AddWithValue("@Active", Active);
                                cmdSave.CommandTimeout = 0;
                                cmdSave.Transaction = transact;
                                Rslt = Convert.ToString(cmdSave.ExecuteScalar());
                            }
                            else
                            {
                                Rslt = "R";
                            }
                            if (Rslt == "M")
                            {
                                counter = counter + 1;
                                table += "<tr><td>" + counter.ToString() + "</td><td>" + Name + "</td><td>" + Emailid + "</td><td>" + PhoneNo + "</td><td style='text-align:center'><img src='img/failed.png' height='20' alt='failed'/> Email Exists.</td>";
                                transact.Rollback();
                            }
                            else if (Rslt == "P")
                            {
                                counter = counter + 1;
                                table += "<tr><td>" + counter.ToString() + "</td><td>" + Name + "</td><td>" + Emailid + "</td><td>" + PhoneNo + "</td><td style='text-align:center'><img src='img/failed.png' height='20' alt='failed'/> Phone Exists.</td>";
                                transact.Rollback();
                            }
                            else if (Rslt == "R")
                            {
                                counter = counter + 1;
                                table += "<tr><td>" + counter.ToString() + "</td><td>" + Name + "</td><td>" + Emailid + "</td><td>" + PhoneNo + "</td><td style='text-align:center'><img src='img/failed.png' height='20' alt='failed'/> Invalid Region.</td>";
                                transact.Rollback();
                            }
                            else if (Rslt == "S")
                            {
                                transact.Commit();
                                con.Close();
                            }
                        }
                        /* else
                         {
                             counter = counter + 1;
                             table += "<tr><td>" + counter.ToString() + "</td><td>" + Name + "</td><td>" + Emailid + "</td><td>" + PhoneNo + "</td><td><img src='img/failed.png' height='20' alt='failed'/></td>";
                         }*/
                    }
                    table += "</tbody></table>";
                    table += "</div>";
                }
            }
            Rslt = "S";
        }
        catch (Exception ex)
        {
            transact.Rollback();
            Rslt = "ER";
        }
        finally
        {
            con.Close();
        }
        Rslt = Rslt + "^" + table;
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
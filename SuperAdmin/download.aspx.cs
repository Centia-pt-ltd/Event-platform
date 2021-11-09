using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SuperAdmin_download : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                string sts = Request.QueryString["Status"].ToString();
                if (sts.Trim().ToUpper() == "UNIVERSITY")
                {
                    string Status = Request.QueryString["Status"].ToString();
                    string SearchValue = Request.QueryString["SearchValue"].ToString();
                    string RowPerPage = Request.QueryString["RowPerPage"].ToString();
                    string PageNumber = Request.QueryString["PageNumber"].ToString();
                    DownloadUniversityList(SearchValue, RowPerPage, PageNumber);
                }
                else if (sts.Trim().ToUpper() == "USERLIST")
                {
                    string SearchValue = Request.QueryString["SearchValue"].ToString();
                    string UserType = Request.QueryString["UserType"].ToString();
                    string RowPerPage = Request.QueryString["RowPerPage"].ToString();
                    string PageNumber = Request.QueryString["PageNumber"].ToString();
                    DownloadUserList(SearchValue, UserType, RowPerPage, PageNumber);
                }
                else if (sts.Trim().ToUpper() == "EVENT")
                {
                    string SearchValue = Request.QueryString["SearchValue"].ToString();
                    string RowPerPage = Request.QueryString["RowPerPage"].ToString();
                    string PageNumber = Request.QueryString["PageNumber"].ToString();
                    DownloadEventList(SearchValue, RowPerPage, PageNumber);
                }
                else if (sts.Trim().ToUpper() == "BOOTH")
                {
                    string Status = Request.QueryString["Status"].ToString();
                    string SearchValue = Request.QueryString["SearchValue"].ToString();
                    string RowPerPage = Request.QueryString["RowPerPage"].ToString();
                    string PageNumber = Request.QueryString["PageNumber"].ToString();
                    DownloadBoothList(SearchValue, RowPerPage, PageNumber);
                }
                else if (sts.Trim().ToUpper() == "REGLIST")
                {
                    string Status = Request.QueryString["Status"].ToString();
                    string RegionId = Request.QueryString["RegionId"].ToString();
                    string RowPerPage = Request.QueryString["RowPerPage"].ToString();
                    string PageNumber = Request.QueryString["PageNumber"].ToString();
                    string Course = Request.QueryString["Course"].ToString();
                    string Qualification = Request.QueryString["Qualification"].ToString();
                    string Country = Request.QueryString["Country"].ToString();
                    string AStatus = Request.QueryString["AStatus"].ToString();
                    string StudentName = Request.QueryString["StudentName"].ToString();
                    string Flag = Request.QueryString["Flag"].ToString();
                    DownloadRegList(RegionId, RowPerPage, PageNumber, Course, Qualification, Country, AStatus, StudentName, Flag);
                }
                else if (sts.Trim().ToUpper() == "REGFORMAT")
                {
                    string Status = Request.QueryString["Status"].ToString();
                    string FileName = Request.QueryString["FileName"].ToString();
                    DownloadRegFormat(FileName);
                }
                else if (sts.Trim().ToUpper() == "PARTIAL")
                {
                    string Status = Request.QueryString["Status"].ToString();
                    string RegionId = Request.QueryString["RegionId"].ToString();
                    string RowPerPage = Request.QueryString["RowPerPage"].ToString();
                    string PageNumber = Request.QueryString["PageNumber"].ToString();
                    string FDate = Request.QueryString["FDate"].ToString();
                    string TDate = Request.QueryString["TDate"].ToString();
                    DownloadPartialData(RegionId, RowPerPage, PageNumber, FDate, TDate);
                }

            }
            catch (Exception ex)
            {

            }

        }
    }
    private void DownloadUniversityList(string SearchValue, string RowPerPage, string PageNumber)
    {
        string Rslt = string.Empty;
        try
        {

            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            GridView gv = new GridView();
            dt = _obj.GetUniversityList(SearchValue, RowPerPage, PageNumber);
            gv.DataSource = dt;
            gv.DataBind();

            string FName = string.Empty;
            FName = "UniversityList";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FName + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                gv.AllowPaging = false;
                gv.GridLines = GridLines.Both;
                gv.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in gv.HeaderRow.Cells)
                {
                    cell.BackColor = gv.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gv.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gv.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gv.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gv.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { border: 1px solid gray } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
            Rslt = "S";
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
    }
    private void DownloadUserList(string SearchValue, string UserType, string RowPerPage, string PageNumber)
    {
        string Rslt = string.Empty;
        try
        {

            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            GridView gv = new GridView();
            dt = _obj.GetUserList(SearchValue, UserType, RowPerPage, PageNumber);
            gv.DataSource = dt;
            gv.DataBind();

            string FName = string.Empty;
            FName = "UserList";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FName + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                gv.AllowPaging = false;
                gv.GridLines = GridLines.Both;
                gv.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in gv.HeaderRow.Cells)
                {
                    cell.BackColor = gv.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gv.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gv.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gv.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gv.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { border: 1px solid gray } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
            Rslt = "S";
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
    }
    private void DownloadEventList(string SearchValue, string RowPerPage, string PageNumber)
    {
        string Rslt = string.Empty;
        try
        {

            ClsEventDataAccess _obj = new ClsEventDataAccess();
            DataTable dt = new DataTable();
            GridView gv = new GridView();
            dt = _obj.GetEventList(SearchValue, RowPerPage, PageNumber);
            gv.DataSource = dt;
            gv.DataBind();

            string FName = string.Empty;
            FName = "EventList";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FName + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                gv.AllowPaging = false;
                gv.GridLines = GridLines.Both;
                gv.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in gv.HeaderRow.Cells)
                {
                    cell.BackColor = gv.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gv.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gv.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gv.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gv.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { border: 1px solid gray } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
            Rslt = "S";
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
    }
    private void DownloadBoothList(string SearchValue, string RowPerPage, string PageNumber)
    {
        string Rslt = string.Empty;
        try
        {

            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            GridView gv = new GridView();
            dt = _obj.GetBoothList(SearchValue, RowPerPage, PageNumber);
            gv.DataSource = dt;
            gv.DataBind();

            string FName = string.Empty;
            FName = "BoothList";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FName + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                gv.AllowPaging = false;
                gv.GridLines = GridLines.Both;
                gv.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in gv.HeaderRow.Cells)
                {
                    cell.BackColor = gv.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gv.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gv.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gv.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gv.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { border: 1px solid gray } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
            Rslt = "S";
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
    }
    private void DownloadRegList(string RegionId, string RowPerPage, string PageNumber, string Course, string Qualification, string Country, string Status,string StudentName, string Flag)
    {
        string Rslt = string.Empty;
        try
        {

            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            GridView gv = new GridView();
            dt = _obj.FillRegGrid(RegionId, RowPerPage, PageNumber, Course, Qualification, Country, Status, StudentName, Flag);
            gv.DataSource = dt;
            gv.DataBind();

            string FName = string.Empty;
            FName = "RegistrationList";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FName + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                gv.AllowPaging = false;
                gv.GridLines = GridLines.Both;
                gv.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in gv.HeaderRow.Cells)
                {
                    cell.BackColor = gv.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gv.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gv.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gv.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gv.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { border: 1px solid gray } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
            Rslt = "S";
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
    }
    private void DownloadRegFormat(string FileName)
    {
        try
        {
            string sPath = HttpContext.Current.Server.MapPath("../DownloadExcelFormat/" + FileName);
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + FileName + "");
            Response.TransmitFile(sPath);
            Response.End();
        }
        catch (Exception ex)
        {

        }
    }

    private void DownloadPartialData(string RegionId, string RowPerPage, string PageNumber, string FDate, string TDate)
    {
        string Rslt = string.Empty;
        try
        {

            ClsSuperAdminDataAcces _obj = new ClsSuperAdminDataAcces();
            DataTable dt = new DataTable();
            GridView gv = new GridView();
            dt = _obj.GetPartialData(RegionId, RowPerPage, PageNumber, FDate, TDate);
            gv.DataSource = dt;
            gv.DataBind();

            string FName = string.Empty;
            FName = "RegistrationPartialData";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FName + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                gv.AllowPaging = false;
                gv.GridLines = GridLines.Both;
                gv.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in gv.HeaderRow.Cells)
                {
                    cell.BackColor = gv.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in gv.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gv.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gv.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                gv.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { border: 1px solid gray } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
            Rslt = "S";
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
    }
}
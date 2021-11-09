using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Qstudy_downloadRegistration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string Rslt = string.Empty;
            try
            {
                string RegionId = Request.QueryString["RegionId"].ToString();
                string RowPerPage = Request.QueryString["RowPerPage"].ToString();
                string PageNumber = Request.QueryString["PageNumber"].ToString();
                string Course= Request.QueryString["PageNumber"].ToString();
                string Qualification = Request.QueryString["Qualification"].ToString();
                string Country = Request.QueryString["Country"].ToString();
                string Status = Request.QueryString["Status"].ToString();
                string StudentName = Request.QueryString["StudentName"].ToString();
                string Flag = Request.QueryString["Flag"].ToString();

                ClsQstudyDataAccess _obj = new ClsQstudyDataAccess();
                DataTable dt = new DataTable();
                GridView gv = new GridView();
                string UserId = HttpContext.Current.Session["UserId"].ToString();
                dt = _obj.GetRegisterList(RegionId, RowPerPage, PageNumber, UserId, Course, Qualification, Country,Status,StudentName,Flag);
                gv.DataSource = dt;
                gv.DataBind();

                string FName = string.Empty;
                FName = RegionId;
                if (FName == "-All Region-")
                    FName = "All";
                else if (FName == "1")
                    FName = "EastNorthAfrica";
                else if (FName == "2")
                    FName = "SouthCentralAsia";
                else if (FName == "3")
                    FName = "GlobalAfrica";
                else if (FName == "4")
                    FName = "GlobalAsia";
                else if (FName == "5")
                    FName = "SouthEastAsia";

                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=" + FName + "-RegistrationList.xls");
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
}
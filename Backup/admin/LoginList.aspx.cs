using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;
using System.Text;
using System.IO;
public partial class admin_LoginList : System.Web.UI.Page
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    string ErMsg = "Something went wrong. Please contact to administrator.";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["UserName"] == null || Session["UserName"].ToString() == "")
            {
                Response.Redirect("sign.aspx", false);
            }
            btnWelcome.Text = "Welcome, " + Session["UserName"];
            bindGrid();
        }
    }

    public void bindGrid()
    {
        try
        {
            string qry = string.Empty;
            qry = @"SELECT Id,FullName [Registration No.],LoginDateTime FROM Tab_StudentLogin ORDER BY Id DESC";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            da.Fill(dt);
                            grdList.DataSource = dt;
                            grdList.DataBind();
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
            btnDownload.Visible = false;
        }

    }
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdList.PageIndex = e.NewPageIndex;
            bindGrid();
        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
            btnDownload.Visible = false;
        }
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=LoginList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                grdList.AllowPaging = false;
                bindGrid();

                grdList.GridLines = GridLines.Both;

                grdList.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in grdList.HeaderRow.Cells)
                {
                    cell.BackColor = grdList.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in grdList.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = grdList.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = grdList.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                grdList.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { border: 1px solid gray } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ErMsg;
            lblmsg.ForeColor = System.Drawing.Color.Red;
            btnDownload.Visible = false;
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
        Response.Cache.SetNoStore();
        Session.Clear();
        Session.RemoveAll();
        Response.Redirect("sign.aspx", false);
    }
    protected void btnRegList_Click(object sender, EventArgs e)
    {
        Response.Redirect("RegList.aspx", false);
    }
}
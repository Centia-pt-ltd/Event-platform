using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.DataVisualization.Charting;

public partial class SuperAdmin_Dashboard : System.Web.UI.Page
{
    public DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetNoStore();

        if (!Page.IsPostBack)
        {
            try
            {
                if (Session["UserId"] == null || Session["UserId"] == "")
                {
                    Session.Clear();
                    Session.RemoveAll();
                    Response.Redirect("login.aspx", false);
                }
                else
                {
                    hdfUserId.Value = Session["UserId"].ToString();
                    Page.Title = "SuperAdmin::Dashboard";
                    ClsCommanDataAccess _objCommon = new ClsCommanDataAccess();
                    dt = _objCommon.BindDashBoardData("0", "0");
                    DataTable ChartData = new DataTable();
                    ChartData = _objCommon.GetChartData();
                    if (ChartData.Rows.Count > 0)
                    {
                        Chart1.DataSource = ChartData;
                        //storing total rows count to loop on each Record  
                        string[] XPointMember = new string[ChartData.Rows.Count];
                        int[] YPointMember = new int[ChartData.Rows.Count];
                        //Chart1.Series.yva
                        for (int count = 0; count < ChartData.Rows.Count; count++)
                        {
                            //storing Values for X axis  
                            XPointMember[count] = ChartData.Rows[count]["Month"].ToString();
                            //storing values for Y Axis  
                            YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["Total"]);
                        }
                        //binding chart control  
                        Chart1.Series[0].Points.DataBindXY(XPointMember, YPointMember);

                        //Setting width of line  
                        Chart1.Series[0].BorderWidth = 10;
                        //setting Chart type   
                        Chart1.Series[0].ChartType = SeriesChartType.RangeColumn;

                        //Hide or show chart back GridLines  
                        // Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;  
                        // Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;  

                        //Enabled 3D  
                        //Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;  
                    }
                    

                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showMsg('ERROR', 'Something went wrong.!');", true);
            }
        }
    }
}
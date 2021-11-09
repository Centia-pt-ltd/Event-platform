using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public partial class UniversityBooth_MoveToCouncilRoom : System.Web.UI.Page
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["Reg_Id"] == null)
            {
                Session.Clear();
                Session.RemoveAll();
                Response.Redirect("../Welcome.aspx", false);
            }
            else
            {
                ValidateCouncil("Yes");
                Response.Redirect("CouncilRoom.aspx?move=yes", false);
            }
        }

    }
    public void ValidateCouncil(string Active)
    {
        try
        {
            string qry = string.Empty;
            string RegNo = Session["FullName"].ToString();
            string name = Session["Name"].ToString();
            string StudentId = Session["Reg_Id"].ToString();
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_StudentCouncil", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@StudentId", StudentId.Trim());
                    cmd.Parameters.AddWithValue("@Flag", "3");
                    SqlParameter sqlParameter = new SqlParameter("@Result", SqlDbType.VarChar, 100)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(sqlParameter);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    string Result = sqlParameter.Value.ToString();

                }
            }
        }
        catch (Exception ex)
        {
            
            //lblmsg.ForeColor = System.Drawing.Color.Red;
        }
        finally
        {

        }
    }
}
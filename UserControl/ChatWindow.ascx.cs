using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Text;
using System.Data.SqlClient;
using System.Data.Sql;
using System.IO;
using System.ComponentModel;

public partial class UserControl_ChatWindow : System.Web.UI.UserControl
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Reg_Id"] == null)
        {
            Session.Clear();
            Session.RemoveAll();
            if (Path.GetFileName(Request.Path) == "reception.aspx")
            {
                Response.Redirect("Welcome.aspx", false);
            }
            else
            {
                Response.Redirect("../Welcome.aspx", false);
            }
            
        }
        else
        {
            hdfSenderId.Value = Session["Reg_Id"].ToString();
            hdfSenderName.Value = Session["Name"].ToString();

            if (Path.GetFileName(Request.Path) == "reception.aspx")
            {
                LoadReceiver();
                hdfSenderType.Value = "QSTUDY";
            }
            else if (Path.GetFileName(Request.Path) == "CouncilRoom.aspx")
            {
                LoadReceiver();
                hdfSenderType.Value = "QSTUDY";
            }
            else
            {
                hdfReceiverId.Value = Session["UniID"].ToString();
                hdfReceiverName.Value = Session["UniName"].ToString();
                hdfSenderType.Value = "UNIVERSITY";
            }

        }
    }

    public void LoadReceiver()
    {
        string Uid = Session["Reg_Id"].ToString();
        string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
        SqlConnection con = new SqlConnection(dbCon);
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand(@"select UserId, UserName from tbl_UserDetails where UserId = (select top 1 AssignedTo from Tab_AssignedLead where LeadId=@Uid)", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@Uid", Uid);
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            hdfReceiverId.Value = dt.Rows[0]["UserId"].ToString();
            hdfReceiverName.Value = dt.Rows[0]["UserName"].ToString();
        }

    }


    protected void btnSendMessage_Click(object sender, EventArgs e)
    {
        /*try
        {
            string SenderId = Session["Reg_Id"].ToString();
            string SenderName = Session["Name"].ToString();
            string ReceiverId = hdfReceiverId.Value;
            string ReceiverName = hdfReceiverName.Value;
            string Message = txtMessage.Value.ToString();

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand("ChatForAll", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SenderId", SenderId);
                    cmd.Parameters.AddWithValue("@SenderName", SenderName);
                    cmd.Parameters.AddWithValue("@ReceiverId", ReceiverId);
                    cmd.Parameters.AddWithValue("@ReceiverName", ReceiverName);
                    cmd.Parameters.AddWithValue("@Message", Message);
                    cmd.Parameters.AddWithValue("@Action", "ADD");
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

                    txtMessage.Value = "";
                }
            }
        }
        catch (Exception ex)
        {

        }*/
    }
}

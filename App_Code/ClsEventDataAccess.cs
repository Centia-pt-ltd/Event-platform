using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// Summary description for ClsEventDataAccess
/// </summary>
public class ClsEventDataAccess
{
    string dbCon = ConfigurationManager.ConnectionStrings["conn"].ToString().Trim();
    public ClsEventDataAccess()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string SaveUpdateEvent(string EventId, string EventName, string EventDetail, string EventURL, string Status, string EventDate, string RegionId, string CreatedBy)
    {

               
        string Rslt = string.Empty;
        try
        {
            string Qry = string.Empty;
            if (!string.IsNullOrEmpty(EventId))
            {
                Qry = @"IF EXISTS (SELECT 1 FROM tbl_EventDetails WHERE EventName=@EventName AND EventId!=@EventId)                        
                        SELECT 1                       
                        ELSE
                        BEGIN
                        UPDATE tbl_EventDetails SET EventName=@EventName,EventDetail=@EventDetail,EventURL=@EventURL,Status=@Status,EventDate=@EventDate,RegionId=@RegionId,UpdatedBy=@CreatedBy,UpdatedOn=getdate() WHERE EventId=@EventId 
                        SELECT 4
                        END";

            }
            else
            {
                Qry = @"IF EXISTS (SELECT 1 FROM tbl_EventDetails WHERE EventName=@EventName)                        
                        SELECT 1
                        ELSE
                        BEGIN
                        INSERT INTO tbl_EventDetails(EventName,EventDetail,EventURL,EventDate,RegionId,Status,CreatedBy,CreatedOn) VALUES(@EventName,@EventDetail,@EventURL,@EventDate,@RegionId,@Status,@CreatedBy,getdate())
                        SELECT 5
                        END";
            }

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@EventName", EventName);
                    cmd.Parameters.AddWithValue("@EventDetail", EventDetail);
                    cmd.Parameters.AddWithValue("@EventURL", EventURL);
                    cmd.Parameters.AddWithValue("@EventDate", EventDate);
                    cmd.Parameters.AddWithValue("@RegionId", RegionId);
                    cmd.Parameters.AddWithValue("@EventId", EventId);
                    cmd.Parameters.AddWithValue("@Status", Status);
                    cmd.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    Rslt = Convert.ToString(cmd.ExecuteScalar());
                    con.Close();
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;
    }
    public DataTable GetEventList(string SearchValue, string RowPerPage, string PageNumber)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"Select ROW_NUMBER() over(order by EventId desc)'SNo', EventId,EventName,EventDetail,EventURL,FORMAT(EventDate, 'dd-MMM-yyyy') as EventDate,TabMst_Region.RName as Region,tbl_EventDetails.Status as Status ,cUser.UserName as 'CreatedBy' , uUser.UserName as 'UpdatedBy',";
            qry += " FORMAT(tbl_EventDetails.CreatedOn, 'dd-MMM-yyyy') as CreatedOn,FORMAT(tbl_EventDetails.UpdatedOn, 'dd-MMM-yyyy') as UpdatedOn FROM tbl_EventDetails ";
            qry += " left join TabMst_Region on TabMst_Region.id = tbl_EventDetails.RegionId ";
            qry += " left join tbl_UserDetails cUser  on cUser.UserId = tbl_EventDetails.CreatedBy ";
            qry += " left join tbl_UserDetails uUser on uUser.UserId = tbl_EventDetails.UpdatedBy ";
            if (SearchValue != "")
            {
                qry += " where EventName like '%" + SearchValue + "%' ";
            }
            qry+= " ORDER BY EventId desc OFFSET " + RowPerPage + " * (" + PageNumber + " - 1) ROWS FETCH NEXT " + RowPerPage + " ROWS ONLY";
           
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public DataTable GetEventDetails(string EventId)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"SELECT EventId,EventName,EventDetail,EventURL,FORMAT (EventDate,'dd-MMM-yyyy') as EventDate,RegionId as Region,Status ";
            qry += " FROM tbl_EventDetails ";
            qry += "  WHERE EventId=@EventId ";
            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@EventId", EventId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
    public string DelEvent(string Eid)
    {
        string Rslt = string.Empty;
        try
        {

            string Qry = string.Empty;
            Qry = @"DELETE FROM tbl_EventDetails WHERE EventId=@Eid";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(Qry, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@Eid", Eid);
                    cmd.CommandTimeout = 0;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Rslt = "D";
                }
            }
        }
        catch (Exception ex)
        {
            Rslt = "ER";
        }
        return Rslt;

    }

    public DataTable ViewEventData(string EventId)
    {
        string qry = string.Empty;
        DataTable dt = new DataTable();
        try
        {
            qry = @"Select ROW_NUMBER() over(order by EventId desc)'SNo', EventId,EventName,EventDetail,EventURL,FORMAT(EventDate, 'dd-MMM-yyyy') as EventDate,TabMst_Region.RName as Region,tbl_EventDetails.Status as Status ,cUser.UserName as 'CreatedBy' , uUser.UserName as 'UpdatedBy',";
            qry += " FORMAT(tbl_EventDetails.CreatedOn, 'dd-MMM-yyyy') as CreatedOn,FORMAT(tbl_EventDetails.UpdatedOn, 'dd-MMM-yyyy') as UpdatedOn FROM tbl_EventDetails ";
            qry += " left join TabMst_Region on TabMst_Region.id = tbl_EventDetails.RegionId ";
            qry += " left join tbl_UserDetails cUser  on cUser.UserId = tbl_EventDetails.CreatedBy ";
            qry += " left join tbl_UserDetails uUser on uUser.UserId = tbl_EventDetails.UpdatedBy ";           
            qry += " ORDER BY EventId desc ";

            using (SqlConnection con = new SqlConnection(dbCon))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
        return dt;
    }

}
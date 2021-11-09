<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        RegisterRoutes(RouteTable.Routes);

    }
    static void RegisterRoutes(RouteCollection routes)
    {
        //routes.MapPageRoute("events", "event", "~/events.aspx");
        //routes.MapPageRoute("MENA", "MENA", "~/MENA.aspx");
        //routes.MapPageRoute("SouthCentralAsia", "SouthCentralAsia", "~/SouthCentralAsia.aspx");
        //routes.MapPageRoute("GlobalAfrica", "Globalmena", "~/GlobalAfrica.aspx");
        //routes.MapPageRoute("GlobalAsia", "GlobalAsia", "~/GlobalAsia.aspx");
        //routes.MapPageRoute("SouthEastAsia", "SouthEastAsia", "~/SouthEastAsia.aspx");

        routes.MapPageRoute("events", "event", "~/events.aspx");
        routes.MapPageRoute("MENA", "MENA", "~/MENA.aspx");
        routes.MapPageRoute("SACA", "SACA", "~/SACA.aspx");
        routes.MapPageRoute("GLOBAL", "GLOBAL", "~/GLOBAL.aspx");
        routes.MapPageRoute("ASIA", "ASIA", "~/ASIA.aspx");
        routes.MapPageRoute("SEA", "SEA", "~/SEA.aspx");
        

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>

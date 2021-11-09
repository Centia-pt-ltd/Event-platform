<%@ Page Title="" Language="C#" MasterPageFile="~/university/MasterPageUniversity.master" AutoEventWireup="true" CodeFile="frmUHomePage.aspx.cs" Inherits="university_frmUHomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script  type="text/javascript" src="https://cdn.plot.ly/plotly-latest.min.js"></script> 
     <link href="css/css-charpage.css" type="text/css" rel="stylesheet" />
    
    <div class="rows d-flex" style="margin-left:20px;"> 
                    <div class="row">
                <div class="col-md-6">
                    <h2 id="universityName" runat="server">Welcome University Name</h2>
                    <h3>Student Contacted</h3>
                    <input type="text"  name="" placeholder="Email sent" />
                    <input type="text"  name="" placeholder="Messages Sent" />
                    <h3>Activity Tracker</h3>
                    <h2>Pie Chart</h2>
                     <div id="piechart"></div>
                 </div>
                 <div class="col-md-6" style="margin-top: 220px;">
                     <h2>Graph</h2>
                     <a href="#"><img src="img/graph.jpg" alt="graph" /></a>
                 </div>
                 </div>
            </div>

    <script type="text/javascript">
// Load google charts
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

// Draw the chart and set the chart values
function drawChart() {
  var data = google.visualization.arrayToDataTable([
  ['Task', 'Hours per Day'],
  ['Work', 8],
  ['Eat', 2],
  ['TV', 4],
  ['Gym', 2],
  ['Sleep', 8]
]);

  // Optional; add a title and set the width and height of the chart
  var options = {'title':'Activity Tracker', 'width':550, 'height':200};

  // Display the chart inside the <div> element with id="piechart"
  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
  chart.draw(data, options);
}
</script>


<script type="text/javascript">
    $(document).on('click','ul li',function() {
        $(this).addClass('active').siblings().removeClass('active')
    })
</script>
</asp:Content>


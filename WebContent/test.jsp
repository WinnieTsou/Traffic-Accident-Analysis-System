<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3 -->
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>
<!-- Select2 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<!-- Chart.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Starter</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
   <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect. -->
  <link rel="stylesheet" href="dist/css/skins/skin-blue.min.css">
  <link rel="stylesheet" href="dist/css/skins/skin-black.min.css">
  <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">


  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-purple sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <header class="main-header">

    <!-- Logo -->
    <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini">TAAS</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>TAAS</b></span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu" data-widget="tree">
        <!-- Optionally, you can add icons to the links -->
        <li id="all"><a href="all"><i class="fa fa-line-chart"></i> <span>All</span></a></li>
        <li class="header">FILTER BY</li>
        <li id="county"><a href="county"><i class="fa fa-location-arrow"></i> <span>County</span></a></li>
        <li id="time"><a href="time"><i class="fa fa-calendar"></i> <span>Year/Month</span></a></li>
        <li id="weather"><a href="weather"><i class="fa fa-sun-o"></i><span>Weather</span></a></li>
        <li id="drugoralcohol"><a href="drugoralcohol"><i class="fa fa-beer"></i> <span>Drug/Alcohol</span></a></li>
        <li id="car"><a href="car"><i class="fa fa-car"></i> <span>Type of Car</span></a></li>
        <li id="deathaccident"><a href="deathaccident"><i class="fa fa-user-times"></i> <span>Death Accident</span></a></li>
        <li id="speed"><a href="speed"><i class="fa fa-dashboard"></i> <span>Speed</span></a></li>
        <li id="factor"><a href="factor"><i class="fa fa-reddit-alien"></i> <span>Factor</span></a></li>
        <li id="age"><a href="age"><i class="fa fa-group"></i> <span>Age</span></a></li>
        <li class="header">ADVANCED</li>
        <li id="multiple"><a href="multiple"><i class="fa fa-sliders"></i> <span>Multiple Select</span></a></li>
        <li id="collision"><a href="collision"><i class="fa fa-exclamation-circle"></i> <span>Manner of Collision</span></a></li>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        <%= request.getAttribute("pageHeader") %>
        <small><%= request.getAttribute("pageDescribtion") %></small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
	      <div class="row">
	              <div class="col-md-6">
			          <!-- BAR CHART -->
			          <div class="box box-success">
			            <div class="box-header with-border">
			              <h3 class="box-title">Bar Chart</h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			              </div>
			            </div>
			            <div class="box-body">
			              <div class="chart">
			                <canvas id="myBarChart"></canvas>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div>
			          <!-- /.box -->
	              	<!-- POLAR AREA -->
			          <div class="box box-success">
			            <div class="box-header with-border">
			              <h3 class="box-title">Polar Chart</h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			              </div>
			            </div>
			            <div class="box-body">
			              <div class="chart">
			                <canvas id="myPolarArea"></canvas>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div>
			          <!-- /.box -->
	              <!-- BAR CHART -->
			          <div class="box box-success">
			            <div class="box-header with-border">
			              <h3 class="box-title">Line Chart</h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			              </div>
			            </div>
			            <div class="box-body">
			              <div class="chart">
			                <canvas id="areaChart"></canvas>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div>
			          <!-- /.box -->
	              </div>
                        <div class="col-md-6">
          <!-- BAR CHART -->
                <div class="box box-success">
                  <div class="box-header with-border">
                    <h3 class="box-title">Radar Chart</h3>
      
                    <div class="box-tools pull-right">
                      <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                      </button>
                      <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                  </div>
                  <div class="box-body">
                    <div class="chart">
                      <canvas id="myRadar"></canvas>
                    </div>
                  </div>
                  <!-- /.box-body -->
                </div>
                <!-- /.box -->

                <!-- BAR CHART -->
                <div class="box box-success">
                  <div class="box-header with-border">
                    <h3 class="box-title">Doughnut Chart</h3>
      
                    <div class="box-tools pull-right">
                      <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                      </button>
                      <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                  </div>
                  <div class="box-body">
                    <div class="chart">
                      <canvas id="myDoughnut"></canvas>
                    </div>
                  </div>
                  <!-- /.box-body -->
                </div>
                <!-- /.box -->

                <!-- BAR CHART -->
                <div class="box box-success">
                  <div class="box-header with-border">
                    <h3 class="box-title">Line Chart</h3>
      
                    <div class="box-tools pull-right">
                      <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                      </button>
                      <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                  </div>
                  <div class="box-body">
                    <div class="chart">
                      <canvas id="myLineChart"></canvas>
                    </div>
                  </div>
                  <!-- /.box-body -->
                </div>
                <!-- /.box -->
        </div>
	      </div>


<script>


var ctx = document.getElementById("myBarChart").getContext("2d");
// var data = {
// 	labels: ["Snowy", "Rainy"],
// 	datasets: [{
// 		// label: "Winnie",
// 		data: [1, 20],
// 		backgroundColor: ["rgba(54, 162, 235, 0.2)", "rgba(54, 162, 235, 0.2)"],
// 		borderColor: ["rgba(54, 162, 235,1)", "rgba(54, 162, 235, 1)"],
// 		borderWidth: 1
// 	}, {
//     // label: "Andy",
//     data: [5, 2],
//     backgroundColor: ["rgba(255, 99, 132, 0.2)", "rgba(255, 99, 132, 0.2)"],
//     borderColor: ["rgba(255,99,132,1)", "rgba(255, 99, 132, 1)"],
//     borderWidth: 1
//   }]
// };
var data = {
 labels: ["Death", "123555"],
 datasets: [{
   label: "Winnie",
   data: [{
    x: "123555",
    y: 12
   }],
   borderWidth: 1
 }, {
    label: "Andy",
    data: [{
      x: "123555",
      y: 1
    }],
    borderWidth: 1
  }]
};
var options = {
	scales:{
		yAxes:[{
			ticks:{
				beginAtZero: true
			}
		}]
	}
};
var myBarChart = new Chart(ctx, {
    type: 'bar',
    data: data,
    options: options
});

var ctxPolarArea = document.getElementById("myPolarArea").getContext("2d");
var dataPolar = {
	labels: ["Snowy", "Rainy", "Cloudy"],
	datasets: [{
		data: [10, 20, 30],
		backgroundColor: ["#ff6384", "#36a2eb", "#cc65fe"],
		borderColor: ["#000", "#000", "#000"],
		borderWidth: 1
	}]
};
var optionsPolar = {
		
};
var myPolarArea = new Chart(ctxPolarArea,{
	type: "polarArea",
	data: dataPolar,
	options: optionsPolar
});


var areaChartCanvas = $('#areaChart').get(0).getContext('2d')
var areaChartData = {
  labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
  datasets: [
    {
      label: 'Electronics',
      backgroundColor: 'rgba(210, 214, 222, 0.4)',
      pointBackgroundColor: 'rgba(210, 214, 222, 0.4)',
      showLines: true,
      data: [65, 59, 80, 81, 56, 55, 40]
    },
    {
      label: 'Digital Goods',
      backgroundColor: 'rgba(60,141,188,0.4)',
      pointBackgroundColor: 'rgba(60,141,188,0.4)',
      showLines: true,
      data: [28, 48, 40, 19, 86, 27, 90]
    }
  ]
};

var areaChartOptions = {
		showLines: true,
		spanGaps: false
};

var areaChart = new Chart(areaChartCanvas, {
	type: "line",
	data: areaChartData,
	options: areaChartOptions
});

var radar = document.getElementById("myRadar").getContext("2d");
var radarData = {
  labels: ["Snowy", "Cloudy", "Rainy"],
  datasets: [{
    label: "Weather",
    data: [20, 10, 4]
  }]
};
var radarOptions = {

};
var myRadar = new Chart(radar, {
  type: "radar",
  data: radarData,
  options: radarOptions
})

var doughnut = document.getElementById("myDoughnut").getContext("2d");

var doughnutData = {
  labels: ["Snowy", "Rainy", "Cloudy"],
  datasets: [{
    label: "Weather",
    data: [10, 20, 30],
    backgroundColor: ["rgba(255, 99, 132, 0.2)", "rgba(54, 162, 235, 0.2)", "rgba(100, 130, 180, 0.2)"]
  }]
};

var doughnutOptions = {

};

var myDoughnut = new Chart(doughnut, {
  type: "doughnut",
  data: doughnutData,
  options: doughnutOptions
});

var lineChart = document.getElementById("myLineChart").getContext("2d");
var lineChartData = {
  labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
  datasets: [{
      label: 'Electronics',
      data: [
      65, 59, 80, 81, 56, 55, 40],
      fill: false
    }]
};
var lineChartOptions = {

};
var myLineChart = new Chart(lineChart, {
  type: "line",
  data: lineChartData,
  options: lineChartOptions
});

</script>


    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">
      Made by Bo-Ting Wu & Ya-Wei Tsou.
    </div>
    <!-- Default to the left -->
    <strong>CS485 ­Traffic Accident Analysis System</strong> 
  </footer>
</div>
<!-- ./wrapper -->

<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>
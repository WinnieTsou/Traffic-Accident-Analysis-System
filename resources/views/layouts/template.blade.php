<!DOCTYPE html>
<html>
<head>
<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3 -->
<script src="{{ URL::asset('bower_components/jquery/dist/jquery.min.js') }}"></script>
<!-- Bootstrap 3.3.7 -->
<script src="{{ URL::asset('bower_components/bootstrap/dist/js/bootstrap.min.js') }}"></script>
<!-- AdminLTE App -->
<script src="{{ URL::asset('dist/js/adminlte.min.js') }}"></script>
<!-- Select2 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<!-- Chart.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>­Traffic Accident Analysis System</title>
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
    <a href="all" class="logo">
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
        <li id="time"><a href="time"><i class="fa fa-calendar"></i> <span>Year</span></a></li>
        <li id="weather"><a href="weather"><i class="fa fa-sun-o"></i><span>Weather</span></a></li>
        <li id="drugoralcohol"><a href="drugalcohol"><i class="fa fa-beer"></i> <span>Drug / Alcohol</span></a></li>
        <li id="car"><a href="car"><i class="fa fa-car"></i> <span>Type of Car</span></a></li>
        <li id="death"><a href="death"><i class="fa fa-user-times"></i> <span>Death Accident</span></a></li>
        <li id="speed"><a href="speed"><i class="fa fa-dashboard"></i> <span>Speed</span></a></li>
        <li id="factor"><a href="factor"><i class="fa fa-reddit-alien"></i> <span>Factor</span></a></li>
        <li id="collision"><a href="collision"><i class="fa fa-exclamation-circle"></i> <span>Manner of Collision</span></a></li>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" id ="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header" id ="content-header">
      <h1>
        @yield('title')
        <small>@yield('description')</small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
      @yield('content')

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <footer class="main-footer" id ="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">
      Made by Bo-Ting Wu & Ya-Wei Tsou.
    </div>
    <!-- Default to the left -->
    <strong>CS485 ­Traffic Accident Analysis System</strong> 
  </footer>
</div>
<!-- ./wrapper -->

<script>
  var id = '#' + '{{$id}}';
  $(document).ready(function(){
    $(id).addClass('active');
  });
</script>
</body>
</html>
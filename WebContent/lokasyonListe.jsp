<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="utils.dbBaglanti"%>

<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
	request.setCharacterEncoding("UTF-8");

String calisanId = "";
String calisanAd = "";
String calisanSoyad = "";
String calisanUnvan = "";

try {
	dbBaglanti connec = new dbBaglanti();
	Statement stmt = connec.getCon().createStatement();

	calisanId = session.getAttribute("calisanId").toString();
	
	session.setAttribute("kullaniciyaMesaj", "Lokasyon Listeden Geldi");

	if (calisanId != null) {
		ResultSet rs = stmt.executeQuery("SELECT * FROM calisan where calisanid='" + calisanId + "' ;");
		if (rs.next()) {

	calisanAd = rs.getString("calisanad");
	calisanSoyad = rs.getString("calisansoyad");
	calisanUnvan = rs.getString("calisanunvan");

	rs.close();
		}
	} else {
		//System.out.print("Böyle bir kayıt yok\n");
		response.sendRedirect("index.jsp");
	}
} catch (Exception a) {
	System.err.println("DB Bağlantı Hatası ! ");
	System.err.println(a.getMessage());
}
%>
<!DOCTYPE html>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>İsmet Yazılım Çalışan Yönetim Sistemi</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet"
	href="bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="bower_components/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="bower_components/Ionicons/css/ionicons.min.css">
<!-- Theme style -->
<!-- DataTables -->
<link rel="stylesheet"
	href="bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
<link rel="stylesheet" href="dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
<!-- Morris chart -->
<link rel="stylesheet" href="bower_components/morris.js/morris.css">
<!-- jvectormap -->
<link rel="stylesheet"
	href="bower_components/jvectormap/jquery-jvectormap.css">
<!-- Date Picker -->
<link rel="stylesheet"
	href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
<!-- Daterange picker -->
<link rel="stylesheet"
	href="bower_components/bootstrap-daterangepicker/daterangepicker.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet"
	href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

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
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<header class="main-header">
			<!-- Logo -->
			<a href="index.jsp" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
				<span class="logo-mini"><b>İ</b>Y</span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg"><b>İSMET</b>YAZILIM</span>
			</a>
			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="push-menu"
					role="button"> <span class="sr-only">Toggle navigation</span>
				</a>

				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- Messages: style can be found in dropdown.less-->
						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <img
								src="dist/img/user2-160x160.jpg" class="user-image"
								alt="User Image"> <span class="hidden-xs">
									<%out.println(calisanAd + " " + calisanSoyad);%>
							</span>
						</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img
									src="dist/img/user2-160x160.jpg" class="img-circle"
									alt="User Image">

									<p>
										<%out.println(calisanAd + " " + calisanSoyad);%><br>
										<%out.println(calisanUnvan);%>
									</p></li>
								<li class="user-footer">
									<div class="pull-left">
										<a href="profil.jsp" class="btn btn-default btn-flat">Profil</a>
									</div>
									<div class="pull-right">
										<a href="index.jsp" class="btn btn-default btn-flat">Çıkış</a>
									</div>
								</li>
							</ul></li>

					</ul>
				</div>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="dist/img/user2-160x160.jpg" class="img-circle"
							alt="User Image">
					</div>
					<div class="pull-left info">
						<p>
							<%out.println(calisanAd + " " + calisanSoyad);%>
						</p>
						<a href="#"><i class="text-success"></i>
							<%out.println(calisanUnvan);%></a>
					</div>
				</div>
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu" data-widget="tree">
					<li class="header"></li>
					<li class="treeview"><a href="#"> <i class="fa fa-user"></i>
							<span>Çalışanlar</span> <span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li><a href="calisanListe.jsp"><i class="fa fa-users"></i>
									Çalışan Listesi</a></li>
							<li><a href="calisanEkle.jsp"><i class="fa fa-user-plus"></i>
									Çalışan Ekle</a></li>
						</ul></li>

					<li class="treeview"><a href="#"> <i
							class="fa-hand-o-right"></i> <span>Departman</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li><a href="departmanListe.jsp"><i
									class="fa-check-square"></i> Departman Listesi</a></li>
							<li><a href="departmanEkle.jsp"><i
									class="fa-plus-square"></i> Departman Ekle</a></li>
						</ul></li>
					<li class="active treeview"><a href="#"> <i
							class=" fa-map-pin"></i> <span>Lokasyon</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li class="active"><a href="lokasyonListe.jsp"><i
									class="fa-map-pin"></i> Lokasyon Listesi</a></li>
							<li><a href="lokasyonEkle.jsp"><i class="fa-plus-square"></i>
									Lokasyon Ekle</a></li>
						</ul></li>
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>Lokasyon Listesi</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Anasayfa</a></li>
					<li class="active">Lokasyon Listesi</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<!-- /.box -->
						<div class="box">
							<div class="box-body">
								<div id="example1_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap">
									<div class="row">
										<div class="col-sm-6"></div>
										<div class="col-sm-6"></div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12">
										<table id="example1"
											class="table table-bordered table-striped dataTable"
											role="grid" aria-describedby="example1_info">
											<thead>
												<tr role="row">
													<th class="sorting_asc" tabindex="0"
														aria-controls="example1" rowspan="1" colspan="1"
														aria-sort="ascending"
														aria-label="Rendering engine: activate to sort column descending"
														style="width: 211.4px;">Lokasyon Adı</th>
													<th class="sorting" tabindex="0" aria-controls="example1"
														rowspan="1" colspan="1"
														aria-label="Browser: activate to sort column ascending"
														style="width: 266.6px;">Adresi</th>
													<th class="sorting" tabindex="0" aria-controls="example1"
														rowspan="1" colspan="1"
														aria-label="Platform(s): activate to sort column ascending"
														style="width: 245.8px;">Posta Kodu</th>
													<th class="sorting" tabindex="0" aria-controls="example1"
														rowspan="1" colspan="1"
														aria-label="Engine version: activate to sort column ascending"
														style="width: 184.2px;">Şehir</th>
													<th class="sorting" tabindex="0" aria-controls="example1"
														rowspan="1" colspan="1"
														aria-label="CSS grade: activate to sort column ascending"
														style="width: 135.6px;">Ülke</th>
													<th class="sorting" tabindex="0" aria-controls="example1"
														rowspan="1" colspan="1"
														aria-label="CSS grade: activate to sort column ascending"
														style="width: 135.6px;">Seçenekler</th>
												</tr>
											</thead>
											<tbody>

												<%
													request.setCharacterEncoding("UTF-8");

												try {
													dbBaglanti connec = new dbBaglanti();
													Statement stmt = connec.getCon().createStatement();

													if (calisanId != null) {
														ResultSet rs1 = stmt.executeQuery("SELECT * FROM lokasyon;");
														while (rs1.next()) {
													out.println("<tr role='row' class='odd'>");
													out.println("<td class='sorting_1'>" + rs1.getString("lokasyonadi") + "</td>");
													out.println("<td>" + rs1.getString("lokasyonadresi") + "</td>");
													out.println("<td>" + rs1.getString("lokasyonpostakodu") + "</td>");
													out.println("<td>" + rs1.getString("lokasyonsehir") + "</td>");
													out.println("<td>" + rs1.getString("lokasyoulke") + "</td>");
													out.println(
															"<td><table><tbody><tr><td style='padding-left: 10px;'><form role='form' action='lokasyonDuzenle.jsp' method='post' id='lokasyonDuzenleForm' name='lokasyonDuzenleForm'>");
													out.println(
															"<button class='btn btn-primary btn-sm' title='Düzenle' class='btn btn-app' name='duzenle' id='duzenle' type='submit' formmethod=vpost' formaction='lokasyonDuzenle.jsp' value='" + rs1.getString("lokasyonid") + "'>");
													out.println(
															"<i class='fa fa-edit'></i></button></form></td><td></td><td style='padding-left: 10px;'><form role='form' action='lokasyonSil.jsp' method='post' id='lokasyonSilForm' name='lokasyonSilForm'>");
													out.println(
															"<button title='Sil' class='btn btn-primary btn-sm' name='sil' id='sil' type='submit' formmethod='post' formaction='lokasyonSil.jsp' value='" + rs1.getString("lokasyonid") + "'>");
													out.println("<i class='fa fa-close'></i></button></form></td></tr></tbody></table></td></tr>");
														}
														rs1.close();
													} else {
														response.sendRedirect("index.jsp");
													}
												} catch (Exception a) {
													System.err.println("DB Bağlantı Hatası! departman liste");
													System.err.println(a.getMessage());
												}
												%>

											</tbody>
											<tfoot>
												<tr>
													<th rowspan="1" colspan="1">Lokasyon Adı</th>
													<th rowspan="1" colspan="1">Adresi</th>
													<th rowspan="1" colspan="1">Posta Kodu</th>
													<th rowspan="1" colspan="1">Şehir</th>
													<th rowspan="1" colspan="1">Ülke
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
								<div class="row"></div>
							</div>
						</div>
						<!-- /.box-body -->
					</div>
				</div>
				<!-- /.col -->
		</div>
		<!-- /.row -->
		</section>
		</section>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->
	<footer class="main-footer">
		<strong>Copyright &copy; 2020 <a
			href="https://www.linkedin.com/in/ismetsandikci/">İsmet Sandıkçı</a>.
		</strong> All rights reserved.
	</footer>

	<!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
	<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

	<!-- jQuery 3 -->
	<script src="bower_components/jquery/dist/jquery.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="bower_components/jquery-ui/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button);
	</script>
	<!-- Bootstrap 3.3.7 -->
	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- Morris.js charts -->
	<script src="bower_components/raphael/raphael.min.js"></script>
	<script src="bower_components/morris.js/morris.min.js"></script>
	<!-- Sparkline -->
	<script
		src="bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
	<!-- jvectormap -->
	<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
	<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
	<!-- jQuery Knob Chart -->
	<script src="bower_components/jquery-knob/dist/jquery.knob.min.js"></script>
	<!-- daterangepicker -->
	<script src="bower_components/moment/min/moment.min.js"></script>
	<script
		src="bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
	<!-- datepicker -->
	<script
		src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
	<!-- Bootstrap WYSIHTML5 -->
	<script
		src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
	<!-- Slimscroll -->
	<script
		src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script src="bower_components/fastclick/lib/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="dist/js/adminlte.min.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="dist/js/pages/dashboard.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="dist/js/demo.js"></script>
	<!-- DataTables -->
	<script
		src="bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<!-- page script -->
	<script>
		$(function() {
			$('#example1').DataTable()
			$('#example2').DataTable({
				'paging' : true,
				'lengthChange' : false,
				'searching' : false,
				'ordering' : true,
				'info' : true,
				'autoWidth' : false
			})
		})
	</script>
</body>
</html>

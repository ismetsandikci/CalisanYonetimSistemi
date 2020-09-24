<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="utils.dbBaglanti"%>

<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%
	request.setCharacterEncoding("UTF-8");

String calisanId = "";
String calisanAd = "";
String calisanSoyad = "";
String calisanUnvan = "";
String departmanTabloYoneticiId = "";

String duzKisiID = "";



String duzenlenecekKisi_ad = "";
String duzenlenecekKisi_soyad = "";
String duzenlenecekKisi_eposta = "";
String duzenlenecekKisi_telefon = "";
String duzenlenecekKisi_iseGirisTarihilk = "";
String duzenlenecekKisi_iseGirisTarih = "";
String duzenlenecekKisi_maas = "";
int duzenlenecekKisi_departmanId = 0;
String duzenlenecekKisi_departmanAdi = "";
String duzenlenecekKisi_unvan = "";
int duzenlenecekKisi_yoneticiId = 0;
String duzenlenecekKisi_yoneticiAd = "";
String duzenlenecekKisi_yoneticiSoyad = "";

String kullaniciyaMesaj="";

try {
	//database bağlantısı için çağırdık
	dbBaglanti connec = new dbBaglanti();
	Statement stmt = connec.getCon().createStatement();
	
	System.out.println("calisanduzenle kullaniciyaMesaj"+kullaniciyaMesaj);
	kullaniciyaMesaj=session.getAttribute("kullaniciyaMesaj").toString();
	System.out.println("calisanduzenle kullaniciyaMesaj2"+kullaniciyaMesaj);
	
	if((kullaniciyaMesaj=="Kullanıcı Güncellendi.") || (kullaniciyaMesaj=="Kullanıcı Güncellenemedi.")){
		System.out.println("calisanduzenle calisanGuncelle");
		duzKisiID = session.getAttribute("duzKisiID").toString();
		System.out.println("calisanduzenlesession duzKisiID" + duzKisiID);
		
		kullaniciyaMesaj=session.getAttribute("kullaniciyaMesaj").toString();
		session.setAttribute("kullaniciyaMesaj", "");
		
	}
	else if(kullaniciyaMesaj=="Listeden Geldi"){
		duzKisiID = request.getParameter("duzenle");
		session.setAttribute("duzKisiID", duzKisiID);
		session.setAttribute("kullaniciyaMesaj", "");
		
	}
	calisanId = session.getAttribute("calisanId").toString();
	departmanTabloYoneticiId = session.getAttribute("departmanTabloYoneticiId").toString();
	

	//Eğer kişi id si boş değilse ekranda gösterilmek için kişinin adı, soyadı gibi bilgileri çekiyoruz.
	if (calisanId != null) {
		ResultSet rs = stmt.executeQuery("SELECT * FROM calisan where calisanid='" + calisanId + "' ;");
		if (rs.next()) {

	calisanAd = rs.getString("calisanad");
	calisanSoyad = rs.getString("calisansoyad");
	calisanUnvan = rs.getString("calisanunvan");

	//düzenlenecek kişinin bilgilerini getiriyorum
	ResultSet rs2 = stmt.executeQuery("SELECT * FROM calisan where calisanid='" + duzKisiID + "' ;");
	if (rs2.next()) {
		duzenlenecekKisi_ad = rs2.getString("calisanad");
		duzenlenecekKisi_soyad = rs2.getString("calisansoyad");
		duzenlenecekKisi_eposta = rs2.getString("calisaneposta");
		duzenlenecekKisi_telefon = rs2.getString("calisantelefon");
		
		duzenlenecekKisi_iseGirisTarihilk = rs2.getString("calisanisegiristarihi");
		duzenlenecekKisi_iseGirisTarihilk = duzenlenecekKisi_iseGirisTarihilk.replace("-", "/");
		String tarih[] = duzenlenecekKisi_iseGirisTarihilk.split("/");
		duzenlenecekKisi_iseGirisTarih=tarih[1]+"/"+tarih[2]+"/"+tarih[0];
		
		duzenlenecekKisi_maas = rs2.getString("calisanmaas");
		duzenlenecekKisi_departmanId = rs2.getInt("calisandepartmanid");
		duzenlenecekKisi_unvan = rs2.getString("calisanunvan");

		ResultSet rs3 = stmt.executeQuery(
				"SELECT * FROM departman where departmanid=(SELECT calisandepartmanid FROM calisan where calisanid='"
						+ rs2.getString("calisanid") + "') ");
		if (rs3.next()) {
			duzenlenecekKisi_departmanAdi = rs3.getString("departmanadi");
			duzenlenecekKisi_yoneticiId = rs3.getInt("departmanyoneticiid");
		}
		else {
			System.out.print("rs3 hata\n");
		}
		rs3.close();

		ResultSet rs4 = stmt
				.executeQuery("SELECT * FROM calisan where calisanid='" + duzenlenecekKisi_yoneticiId + "' ");
		if (rs4.next()) {
			duzenlenecekKisi_yoneticiAd = rs4.getString("calisanad");
			duzenlenecekKisi_yoneticiSoyad = rs4.getString("calisansoyad");
		}
		else {
			System.out.print("rs4 hata\n");
		}
		rs4.close();
	}
	rs2.close();
	rs.close();
		}
	} else {
		//System.out.print("Böyle bir kayıt yok\n");
		response.sendRedirect("index.jsp");
	}
} catch (Exception a) {
	System.err.println("DB Bağlantı Hatası ! calisanDuzenle ilk yükleme");
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
<!-- daterange picker -->
<link rel="stylesheet"
	href="bower_components/bootstrap-daterangepicker/daterangepicker.css">
<!-- bootstrap datepicker -->
<link rel="stylesheet"
	href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
<!-- iCheck for checkboxes and radio inputs -->
<link rel="stylesheet" href="plugins/iCheck/all.css">
<!-- Bootstrap Color Picker -->
<link rel="stylesheet"
	href="bower_components/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css">
<!-- Bootstrap time Picker -->
<link rel="stylesheet"
	href="plugins/timepicker/bootstrap-timepicker.min.css">
<!-- Select2 -->
<link rel="stylesheet"
	href="bower_components/select2/dist/css/select2.min.css">
<!-- Theme style -->
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
								alt="User Image"> <span class="hidden-xs"> <%
 	out.println(calisanAd + " " + calisanSoyad);
 %>
							</span>
						</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img
									src="dist/img/user2-160x160.jpg" class="img-circle"
									alt="User Image">

									<p>
										<%
											out.println(calisanAd + " " + calisanSoyad);
										%>
										<br>
										<%
											out.println(calisanUnvan);
										%>
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
						<a href="#"><i class="text-success"></i> <%out.println(calisanUnvan);%></a>
					</div>
				</div>
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu" data-widget="tree">
					<li class="header"></li>
					<li class="active treeview"><a href="#"> <i
							class="fa fa-user"></i> <span>Çalışanlar</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li class="active"><a href="calisanListe.jsp"><i
									class="fa fa-users"></i> Çalışan Listesi</a></li>
							<li><a href="calisanEkle.jsp"><i class="fa fa-user-plus"></i>
									Çalışan Ekle</a></li>
						</ul></li>
					<li class="treeview"><a href="#"> <i class="fa-map-marker"></i>
							<span>Departman</span> <span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li><a href="departmanListe.jsp"><i
									class="fa-check-square"></i> Departman Listesi</a></li>
							<li><a href="departmanEkle.jsp"><i
									class="fa-plus-square"></i> Departman Ekle</a></li>
						</ul></li>
					<li class="treeview"><a href="#"> <i class=" fa-map-pin"></i>
							<span>Lokasyon</span> <span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li><a href="lokasyonListe.jsp"><i class="fa-map-pin"></i>
									Lokasyon Listesi</a></li>
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
				<h1>Çalışan Düzenle</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Anasayfa</a></li>
					<li>Çalışan Listesi</li>
					<li class="active">Çalışan Düzenle</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-md-6">
						<!-- general form elements -->
						<div class="box box-primary">
						<%
            if((kullaniciyaMesaj!="") || (kullaniciyaMesaj==null)){
            	if(kullaniciyaMesaj.equals("Kullanıcı Güncellendi.")){
            		out.print("<div class='alert alert-success alert-dismissible'>");
            		out.print("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>");
            		out.print("<h4><i class='icon fa fa-check'></i>"+kullaniciyaMesaj+"</h4>");
            		//out.print("Success alert preview. This alert is dismissable.");
            		out.print("</div>");
            		
            	}
            	else if(kullaniciyaMesaj.equals("")){
            		
            	}
            	else if(kullaniciyaMesaj.equals("Kullanıcı Güncellenemedi.")){
            		out.print("<div class='alert alert-danger alert-dismissible'>");
            		out.print("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>");
            		out.print("<h4><i class='icon fa fa-check'></i>"+kullaniciyaMesaj+"</h4>");
            		//out.print("Success alert preview. This alert is dismissable.");
            		out.print("</div>");
            	}
            	session.setAttribute("kullaniciyaMesaj", "");
            }
            %>
							<!-- form start -->
							<form role="form" action="calisanGuncelle.jsp" method="post"
								id="calisanGuncelleForm" name="calisanGuncelleForm">
								<div class="box-body">
									<div class="form-group">
										<label>Ad</label> <input type="text" class="form-control" id="ad" name="ad"
											placeholder="Ad" maxlength="25"
											value="<%out.println(duzenlenecekKisi_ad);%>">
									</div>
									<div class="form-group">
										<label>Soyad</label> <input type="text" class="form-control"
											id="soyad" name="soyad" placeholder="Soyad" maxlength="25"
											value="<%out.println(duzenlenecekKisi_soyad);%>">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">E-Posta</label> <input
											type="email" class="form-control" id="eposta" name="eposta"
											placeholder="Email"
											value="<%out.println(duzenlenecekKisi_eposta);%>">
									</div>
									<div class="form-group">
										<label>Telefon</label> <input type="text" class="form-control"
											id="telefon" name="telefon" pattern="[0-9]{11}"
											maxlength="11" placeholder="Telefon"
											value="<%out.println(duzenlenecekKisi_telefon);%>">
									</div>
									<div class="form-group">
										<label>İşe Giriş Tarihi:</label>

										<div class="input-group date">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right"
												id="datepicker" name="datepicker"
												value="<%out.println(duzenlenecekKisi_iseGirisTarih);%>">
										</div>
										<!-- /.input group -->
									</div>
									<div class="form-group">
										<label>Maaş</label> <input type="text" class="form-control"
											id="maas" name="maas" placeholder="Maaş" maxlength="15"
											value="<%out.println(duzenlenecekKisi_maas);%>">
									</div>
									<div class="form-group">
										<label>Departman</label> <select
											class="form-control select2 select2-hidden-accessible" id="departman"
											name="departman"
											style="width: 100%;" tabindex="-1" aria-hidden="true">
											<%
												request.setCharacterEncoding("UTF-8");
											try {
												//database bağlantısı için çağırdık
												dbBaglanti connec = new dbBaglanti();
												Statement stmt = connec.getCon().createStatement();

												//Eğer kişi id si boş değilse ekranda gösterilmek için kişinin adı, soyadı gibi bilgileri çekiyoruz.
												if (calisanId != null) {
													ResultSet rs11 = stmt.executeQuery("SELECT * FROM departman;");
													while (rs11.next()) {
												if (duzenlenecekKisi_departmanAdi.equals(rs11.getString("departmanadi"))) {
													out.println("<option value='" + rs11.getString("departmanid") + "' selected='selected'>'" + rs11.getString("departmanadi") + "'</option>");
												} else {
													out.println("<option value='" + rs11.getString("departmanid") + "' >'" + rs11.getString("departmanadi") + "'</option>");
												}
													}
													rs11.close();
												} else {
													//System.out.print("Böyle bir kayıt yok\n");
													response.sendRedirect("index.jsp");
												}
											} catch (Exception a) {
												System.err.println("DB Bağlantı Hatası! departman");
												System.err.println(a.getMessage());
											}
											%>
										</select>
									</div>
									<div class="form-group">
										<label>Ünvan</label> <input type="text" class="form-control"
											maxlength="50" id="unvan" name="unvan" placeholder="Ünvan"
											value="<%out.println(duzenlenecekKisi_unvan);%>">
									</div>
								</div>
								<!-- /.box-body -->

								<div class="box-footer">
									<button type="submit" class="btn btn-primary">Güncelle</button>
								</div>
							</form>
						</div>
						<!-- /.box -->

					</div>
					<div class="col-md-6">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-body">
								<div class="form-group">
									<label>Ünvan Değişikliği Geçmişi</label>
									<table class="table table-hover">
										<tbody>
											<tr>
												<th>Başlangıç Tarihi</th>
												<th>Bitiş Tarihi</th>
												<th>Unvan</th>
												<th>Departman</th>
											</tr>
											<%
												request.setCharacterEncoding("UTF-8");
											try {
												//database bağlantısı için çağırdık
												dbBaglanti connec = new dbBaglanti();
												Statement stmt = connec.getCon().createStatement();

												//Eğer kişi id si boş değilse ekranda gösterilmek için kişinin adı, soyadı gibi bilgileri çekiyoruz.
												if (calisanId != null) {
													ResultSet rs22 = stmt.executeQuery("SELECT * FROM unvan where unvancalisanid='" + duzKisiID + "';");
													while (rs22.next()) {
														out.println("<tr>");
														out.println("<td>'" + rs22.getString("unvanbastarih") + "'</td>");
														if(rs22.getString("unvanbittarih")==null){
															out.println("<td>-</td>");
														}
														else{
															out.println("<td>'" + rs22.getString("unvanbittarih") + "'</td>");
														}
														out.println("<td>'" + rs22.getString("unvanadi") + "'</td>");
														
														ResultSet rs222 = stmt.executeQuery("SELECT * FROM departman where departmanid='" + rs22.getString("unvandepartmanid") + "';");
														if(rs222.next()){
															out.println("<td>'" + rs222.getString("departmanadi") + "'</td>");
														}
														
														out.println("</tr>");
													}
													rs22.close();
												}
											} catch (Exception a) {
												System.err.println("DB Bağlantı Hatası! ünvan tablosu");
												System.err.println(a.getMessage());
											}
											%>
										</tbody>
									</table>
								</div>
							</div>

						</div>
						<!-- /.box -->

					</div>
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

	<!-- Bootstrap 3.3.7 -->
	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- Select2 -->
	<script src="bower_components/select2/dist/js/select2.full.min.js"></script>
	<!-- InputMask -->
	<script src="plugins/input-mask/jquery.inputmask.js"></script>
	<script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
	<script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
	<!-- date-range-picker -->
	<script src="bower_components/moment/min/moment.min.js"></script>
	<script
		src="bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
	<!-- bootstrap datepicker -->
	<script
		src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
	<!-- bootstrap color picker -->
	<script
		src="bower_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
	<!-- bootstrap time picker -->
	<script src="plugins/timepicker/bootstrap-timepicker.min.js"></script>
	<!-- SlimScroll -->
	<script
		src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<!-- iCheck 1.0.1 -->
	<script src="plugins/iCheck/icheck.min.js"></script>
	<!-- FastClick -->
	<script src="bower_components/fastclick/lib/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="dist/js/adminlte.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="dist/js/demo.js"></script>
	<!-- Page script -->
	<script>
		$(function() {
			//Initialize Select2 Elements
			$('.select2').select2()

			//Datemask dd/mm/yyyy
			$('#datemask').inputmask('dd/mm/yyyy', {
				'placeholder' : 'dd/mm/yyyy'
			})
			//Datemask2 mm/dd/yyyy
			$('#datemask2').inputmask('mm/dd/yyyy', {
				'placeholder' : 'mm/dd/yyyy'
			})
			//Money Euro
			$('[data-mask]').inputmask()

			//Date range picker
			$('#reservation').daterangepicker()
			//Date range picker with time picker
			$('#reservationtime').daterangepicker({
				timePicker : true,
				timePickerIncrement : 30,
				format : 'MM/DD/YYYY h:mm A'
			})
			//Date range as a button
			$('#daterange-btn').daterangepicker(
					{
						ranges : {
							'Today' : [ moment(), moment() ],
							'Yesterday' : [ moment().subtract(1, 'days'),
									moment().subtract(1, 'days') ],
							'Last 7 Days' : [ moment().subtract(6, 'days'),
									moment() ],
							'Last 30 Days' : [ moment().subtract(29, 'days'),
									moment() ],
							'This Month' : [ moment().startOf('month'),
									moment().endOf('month') ],
							'Last Month' : [
									moment().subtract(1, 'month').startOf(
											'month'),
									moment().subtract(1, 'month')
											.endOf('month') ]
						},
						startDate : moment().subtract(29, 'days'),
						endDate : moment()
					},
					function(start, end) {
						$('#daterange-btn span').html(
								start.format('MMMM D, YYYY') + ' - '
										+ end.format('MMMM D, YYYY'))
					})

			//Date picker
			$('#datepicker').datepicker({
				autoclose : true
			})

			//iCheck for checkbox and radio inputs
			$('input[type="checkbox"].minimal, input[type="radio"].minimal')
					.iCheck({
						checkboxClass : 'icheckbox_minimal-blue',
						radioClass : 'iradio_minimal-blue'
					})
			//Red color scheme for iCheck
			$(
					'input[type="checkbox"].minimal-red, input[type="radio"].minimal-red')
					.iCheck({
						checkboxClass : 'icheckbox_minimal-red',
						radioClass : 'iradio_minimal-red'
					})
			//Flat red color scheme for iCheck
			$('input[type="checkbox"].flat-red, input[type="radio"].flat-red')
					.iCheck({
						checkboxClass : 'icheckbox_flat-green',
						radioClass : 'iradio_flat-green'
					})

			//Colorpicker
			$('.my-colorpicker1').colorpicker()
			//color picker with addon
			$('.my-colorpicker2').colorpicker()

			//Timepicker
			$('.timepicker').timepicker({
				showInputs : false
			})
		})
	</script>
</body>
</html>





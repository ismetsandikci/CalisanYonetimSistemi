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

String alertMesaj = "";

String kullaniciyaMesaj="";

try {
	//database bağlantısı için çağırdık
	dbBaglanti connec = new dbBaglanti();
	Statement stmt = connec.getCon().createStatement();

	calisanId = session.getAttribute("calisanId").toString();
	//System.out.print("calisanekle calisanId:"+calisanId+"\n");
	
	kullaniciyaMesaj = session.getAttribute("kullaniciyaMesaj").toString();
	session.setAttribute("kullaniciyaMesaj", "");
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
	System.err.println("DB Bağlantı Hatası ! calisanekle ilk kısım ");
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
 %></a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img
									src="dist/img/user2-160x160.jpg" class="img-circle"
									alt="User Image">

									<p>
										<%
											out.println(calisanAd + " " + calisanSoyad);
										%><br>
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
							<%
								out.println(calisanAd + " " + calisanSoyad);
							%>
						</p>
						<a href="#"><i class="text-success"></i> <%	out.println(calisanUnvan); %></a>
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
							<li><a href="calisanListe.jsp"><i class="fa fa-users"></i>
									Çalışan Listesi</a></li>
							<li class="active"><a href="calisanEkle.jsp"><i
									class="fa fa-user-plus"></i> Çalışan Ekle</a></li>
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
				<h1>Çalışan Ekle</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Anasayfa</a></li>
					<li class="active">Çalışan Ekle</li>
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
            	if(kullaniciyaMesaj.equals("Kullanıcı Eklendi.")){
            		out.print("<div class='alert alert-success alert-dismissible'>");
            		out.print("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>");
            		out.print("<h4><i class='icon fa fa-check'></i>"+kullaniciyaMesaj+"</h4>");
            		//out.print("Success alert preview. This alert is dismissable.");
            		out.print("</div>");
            		
            	}
            	else if(kullaniciyaMesaj.equals("")){
            		
            	}
            	else if((kullaniciyaMesaj.equals("Aynı emailde başka kayıt var.")) || (kullaniciyaMesaj.equals("Kullanıcı Ekleme Hatası."))){
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
							<form role="form" action="calisanEkle.jsp" method="post"  
								id="calisanEkleForm" name="calisanEkleForm" >
								<div class="box-body">
									<div class="form-group">
										<label>Ad</label> <input type="text" class="form-control"
											id="ad" name="ad" maxlength="15" placeholder="Ad" required="required">
									</div>
									<div class="form-group">
										<label>Soyad</label> <input type="text" class="form-control"
											id="soyad" name="soyad" maxlength="15" placeholder="Soyad" required="required">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">E-Posta</label> <input
											type="email" class="form-control" id="eposta" name="eposta"
											placeholder="Email" required="required">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">Şifre</label> <input
											type="text" class="form-control" id="sifre" name="sifre"
											maxlength="5" placeholder="Şifre" required="required">
									</div>
									<div class="form-group">
										<label>Telefon</label> <input type="text" class="form-control"
											id="telefon" name="telefon" pattern="[0-9]{11}"
											maxlength="11" placeholder="Telefon" required="required">
									</div>
									<div class="form-group">
										<label>İşe Giriş Tarihi:</label>

										<div class="input-group date">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
											<input type="text" class="form-control pull-right"
												id="datepicker" name="datepicker" required="required">
										</div>
										<!-- /.input group -->
									</div>
									<div class="form-group">
										<label>Maaş</label> <input type="text" class="form-control"
											id="maas" name="maas" maxlength="15" pattern="[0-9]{4,15}"
											placeholder="Maaş" required="required">
									</div>
									<div class="form-group">
										<label>Departman</label> <select id="departman"
											name="departman"
											class="form-control select2 select2-hidden-accessible"
											style="width: 100%;" tabindex="-1" aria-hidden="true"  >
											<%
												request.setCharacterEncoding("UTF-8");
											try {
												dbBaglanti connec = new dbBaglanti();
												Statement stmt = connec.getCon().createStatement();

												if (calisanId != null) {
													ResultSet rs11 = stmt.executeQuery("SELECT * FROM departman;");
													while (rs11.next()) {
												out.println("<option value='" + rs11.getString("departmanid") +".//."+rs11.getString("departmanadi") + "' >'" + rs11.getString("departmanadi")
														+ "'</option>");
													}
													rs11.close();
												} else {
													//System.out.print("Böyle bir kayıt yok\n");
													response.sendRedirect("index.jsp");
												}
											} catch (Exception a) {
												System.err.println("DB Bağlantı Hatası! ünvan");
												System.err.println(a.getMessage());
											}
											%>
										</select>
									</div>
									<div class="form-group">
										<label>Ünvan</label> <input type="text" class="form-control"
											maxlength="50" id="unvan" name="unvan" placeholder="Ünvan" required="required">
									</div>
								</div>
								<!-- /.box-body -->

								<div class="box-footer">
									<button type="submit" class="btn btn-primary">Ekle</button>
								</div>
							</form>
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

<%
	request.setCharacterEncoding("UTF-8");

String kisi_adi = request.getParameter("ad");
String kisi_soyadi = request.getParameter("soyad");
String kisi_eposta = request.getParameter("eposta");
String kisi_sifre = request.getParameter("sifre");
String kisi_telefon = request.getParameter("telefon");
String kisi_isGirisTarihilk = request.getParameter("datepicker");
String kisi_isGirisTarihson ="";
String kisi_maas = request.getParameter("maas");

String kisi_departman = request.getParameter("departman");
String kisi_departmanid="";
String kisi_departmanad="";



String kisi_unvani = request.getParameter("unvan");

if ((kisi_adi != null) && (kisi_soyadi != null) && (kisi_eposta != null) && (kisi_sifre != null)
		&& (kisi_telefon != null) && (kisi_isGirisTarihilk != null) && (kisi_maas != null) && (kisi_departman != null)
		&& (kisi_unvani != null)) {
	//System.out.print("kisi_adi: " + kisi_adi + "\n");
	//System.out.print("kisi_soyadi: " + kisi_soyadi + "\n");
	//System.out.print("kisi_eposta: " + kisi_eposta + "\n");
	//System.out.print("kisi_sifre: " + kisi_sifre + "\n");
	//System.out.print("kisi_telefon: " + kisi_telefon + "\n");
		
	String pattern = "yyyy/MM/dd";
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
	kisi_isGirisTarihson = simpleDateFormat.format(new Date(kisi_isGirisTarihilk));
	
	kisi_isGirisTarihson = kisi_isGirisTarihson.replace("/", "-");
	//System.out.print("kisi_isGirisTarihilk: " + kisi_isGirisTarihilk + "\n");
	//System.out.print("kisi_isGirisTarihson: " + kisi_isGirisTarihson + "\n");
	//System.out.print("kisi_maas: " + kisi_maas + "\n");
	//System.out.print("kisi_departman: " + kisi_departman + "\n");
	//System.out.print("kisi_unvani: " + kisi_unvani + "\n");

	try {
		dbBaglanti connec = new dbBaglanti();
		Statement stmt = connec.getCon().createStatement();
		
		if(!kisi_departman.equals(null) || !kisi_departman.equals("")){
			String[] ayir = kisi_departman.split(".//.");
			kisi_departmanid =ayir[0]; 
			kisi_departmanad =ayir[1];
		}

		if (calisanId != null) {
			List<Integer> idList = new ArrayList<Integer>();
			ResultSet rs11 = stmt.executeQuery("SELECT * FROM calisan");
			while(rs11.next()){
				idList.add(rs11.getInt("calisanid"));
			}
			rs11.close();
			int maxId = Collections.max(idList);
			maxId=maxId+1;
			
			ResultSet rs101 = stmt.executeQuery("SELECT * FROM calisan where calisaneposta='" + kisi_eposta + "'");
			if(rs101.next()){
				System.out.println("\nAynı emailde başka kayıt var.");
				session.setAttribute("kullaniciyaMesaj", "Aynı emailde başka kayıt var.");
				response.sendRedirect("calisanEkle.jsp");
			}
			else{
				int calisanEkle = stmt.executeUpdate(
						"INSERT INTO calisan (calisanId,calisanad,calisansoyad,calisaneposta,calisantelefon,calisanisegiristarihi,calisanmaas,calisandepartmanid,calisanunvan,calisansifre) VALUES ('"+ maxId + "','"+ kisi_adi + "','" + kisi_soyadi + "','" + kisi_eposta + "','" + kisi_telefon + "','"+ kisi_isGirisTarihson + "','" + kisi_maas + "','" + kisi_departmanid + "','" + kisi_unvani+ "','" + kisi_sifre + "');");
				if (calisanEkle == 1) {
					
					List<Integer> unvanidList = new ArrayList<Integer>();
					ResultSet rs116 = stmt.executeQuery("SELECT * FROM unvan");
					while(rs116.next()){
						unvanidList.add(rs116.getInt("unvanid"));
					}
					rs116.close();
					int maxunvanId = Collections.max(unvanidList);
					maxunvanId=maxunvanId+1;
					
					int calisanUnvanEkle = stmt.executeUpdate(
							"INSERT INTO unvan (unvanid,unvancalisanid,unvanadi,unvanbastarih,unvanbittarih,unvandepartmanadi) VALUES ('"+ maxunvanId + "','"+ maxId + "','" + kisi_unvani + "','" + kisi_isGirisTarihson + "','" + kisi_isGirisTarihson + "','"+ kisi_departmanad + "');");
					if (calisanUnvanEkle == 1) {
						System.out.println("\nKullanıcı Eklendi");
						session.setAttribute("kullaniciyaMesaj", "Kullanıcı Eklendi.");
						response.sendRedirect("calisanEkle.jsp");
					}
					else{
						int calisanEkleme = stmt.executeUpdate("DELETE FROM calisan WHERE calisanId = '"+ maxunvanId + "'");
						if (calisanEkleme == 1) {
							System.out.println("\nKullanıcı Ekleme Hatası.");
							session.setAttribute("kullaniciyaMesaj", "Kullanıcı Ekleme Hatası.");
							response.sendRedirect("calisanEkle.jsp");
						}
						else{
							System.out.println("\nKullanıcı Ekleme Hatası.(!)");
							session.setAttribute("kullaniciyaMesaj", "Kullanıcı Ekleme Hatası.(!)");
							response.sendRedirect("calisanEkle.jsp");
						}
					}
					
					
				}
				else{
					System.out.println("\nKullanıcı Ekleme Hatası.");
					session.setAttribute("kullaniciyaMesaj", "Kullanıcı Ekleme Hatası.");
					response.sendRedirect("calisanEkle.jsp");
				}
			}

	
	

		} else {
	//System.out.print("Böyle bir kayıt yok\n");
	response.sendRedirect("index.jsp");
		}
	} catch (Exception a) {
		System.err.println("DB Bağlantı Hatası! ünvan");
		System.err.println(a.getMessage());
	}

}
%>


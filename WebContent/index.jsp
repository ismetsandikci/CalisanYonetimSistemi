<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="utils.dbBaglanti" %>

<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
	<title>IS YAZILIM  - CALISAN YONETIM SISTEMI</title>
	<META http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="./login/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./login/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./login/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="./login/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./login/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./login/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="./login/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./login/css/util.css">
	<link rel="stylesheet" type="text/css" href="./login/css/main.css">
<!--===============================================================================================-->
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">
				<form class="login100-form validate-form flex-sb flex-w" action="index.jsp" method="post" id="girisForm" name="girisForm">
					<span class="login100-form-title p-b-32">
						IS YAZILIM <br> ÇALISAN YÖNETİM SİSTEMİ
					</span>
					<span class="txt1 p-b-11">
						Eposta
					</span>
					<div class="wrap-input100 validate-input m-b-36" data-validate = "Username is required">
						<input class="input100" type="text" name="eposta" >
						<span class="focus-input100"></span>
					</div>
					<span class="txt1 p-b-11">
						Şifre
					</span>
					<div class="wrap-input100 validate-input m-b-12" data-validate = "Password is required">
						<span class="btn-show-pass">
							<i class="fa fa-eye"></i>
						</span>
						<input class="input100" type="password" name="sifre" >
						<span class="focus-input100"></span>
					</div>
					<div class="flex-sb-m w-full p-b-48">
					<!--
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
							<label class="label-checkbox100" for="ckb1">
								Remember me
							</label>
						</div>
						<div>
							<a href="#" class="txt3">
								Forgot Password?
							</a>
						</div>
						-->
					</div>
					
					<div class="container-login100-form-btn">
						<button class="login100-form-btn">
							GİRİŞ
						</button>
					</div>
					
					<br><br><br>
					
					
					<strong>Copyright &copy; 2020 <a href="https://www.linkedin.com/in/ismetsandikci/">İsmet Sandıkçı</a>.
					</strong> All rights reserved.
					
				</form>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="./login/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="./login/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="./login/vendor/bootstrap/js/popper.js"></script>
	<script src="./login/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="./login/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="./login/vendor/daterangepicker/moment.min.js"></script>
	<script src="./login/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="./login/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="./login/js/main.js"></script>

</body>
</html>

<% request.setCharacterEncoding("UTF-8");
try
{
//database bağlantısı için çağırdık
  dbBaglanti connec = new dbBaglanti();
  Statement stmt = connec.getCon().createStatement();
  
  //kullanıcının girdiği email ve şifreyi aldık
  String Email = request.getParameter("eposta");
  String Password = request.getParameter("sifre");
  
  //System.out.println("Eposta:" + Email);
  //System.out.println("Şifre:" + Password);
  
  String calisanId = "";
  String departmanTabloYoneticiId ="";
		  
  //Eğer email ve şifre alanı boş değilse kaydetme işmelini yapıyoruz
  if ((Email!=null) && (Password!=null)){
	  ResultSet rs = stmt.executeQuery("SELECT * FROM calisan where calisaneposta='" + Email + "' and calisansifre= '" + Password + "' ;");
	  if (rs.next()){
		  
		  //giriş yapan kişinin kişi id ve seviyesini aldık.Bu bilgileri aldık çünkü gerekli sayfalarda bu bilgileri çekerek ona göre işlem yapıcaz
		  calisanId = rs.getString("calisanid");
		  
		//kişi idsini tüm sayfalardan rahatça ulaşabilmek için session a attık
	      session.setAttribute("calisanId", calisanId);
	      System.out.print("calisanId: " + calisanId + "\n");
	      
		  //Eğer kişi yönetici ise yönetici tablosunda yönetici id sini çekiyoruz
		  ResultSet rs2 = stmt.executeQuery("SELECT * FROM departman where departmanyoneticiid='" + calisanId + "' ;");
	      if(rs2.next()){
	    	  departmanTabloYoneticiId = rs2.getString("departmanYoneticiid");
	    	  System.out.print("departmanTabloYoneticiId: " + departmanTabloYoneticiId + "\n");
	    	  //System.out.print("departman yönetici sorgu başarılı kullanıcı yönetici\n");

		      //Bunu yapmamın amacı aynı sayfada farklı bir kaç mesaj olabilir. Verilecek olan uyarıyı bu sessiona atarak göstermek daha kolay olabilir.
		      session.setAttribute("departmanTabloYoneticiId", departmanTabloYoneticiId);
	      }
	      

	      //kişinin seviyesine göre oturum açıldığında yönlendirilecek sayfalar
   		  if(calisanId!=null){
   			response.sendRedirect("calisanListe.jsp");
   		  }
   		  else{
   			response.sendRedirect("index.jsp");
   		  }
	      
	      rs.close();
	  }
	  //Eğer bilgiler yanlış girildiyse kullanıcıya bunu alert yardımıyla söylüyoruz
	  else {
		  //System.out.print("Böyle bir kayıt yok\n");
		  
		  out.println("<script type=\"text/javascript\">");
	      out.println("alert('Böyle bir kayıt yok');");
	      out.println("</script>");
		  //response.sendRedirect("index.jsp");
	  }
  }
  //Eğer bilgiler tam girilmediyse uyarı veriyoruz.
  //Ama template de bu uyarıyı verdiği için alert koymadım.
  else{
	  System.out.print("Eksik veri girişi\n");
  }
  
}
//Eğer bağlantıda bir hata varsa göster.
catch (Exception a)
{
  System.err.println("DB Bağlantı Hatası! Login Sayfası");
  System.err.println(a.getMessage());
}
%>

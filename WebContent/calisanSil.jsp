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
String duzCalisanID = "";
//eğer silinen çalışan yönetici ise vekil atama için
String vekilAtama ="";
//unvan tablosundaki çalışan kaydı sorgu için
String unvanTabloCalisanKaydi = "";

if ((duzCalisanID != null)) {

	try {
		calisanId = session.getAttribute("calisanId").toString();
		System.out.println("calisanId:" + calisanId);
		
		duzCalisanID = request.getParameter("sil");
		System.out.println("duzCalisanID:" + duzCalisanID);

		if (calisanId != null) {
			//database bağlantısı için çağırdık
			dbBaglanti connec = new dbBaglanti();
			Statement stmt = connec.getCon().createStatement();
			
			ResultSet rs2121 = stmt.executeQuery("SELECT * FROM departman where departmanyoneticiid='" + duzCalisanID + "';");
			if(rs2121.next()){
				System.out.println("Yönetici");
				int departmanCalisanAtama = stmt.executeUpdate(
						"UPDATE departman SET departmanyoneticiid='1' WHERE departmanyoneticiid='" + duzCalisanID + "'");
				if (departmanCalisanAtama == 1) {
					vekilAtama = "Vekil Atandı";
				}
				else{
					System.out.println("Vekil atanamadı");
					session.setAttribute("kullaniciyaMesaj", "Çalışan Silinemedi.");
					session.setAttribute("duzCalisanID", duzCalisanID);
					response.sendRedirect("calisanListe.jsp");
				}
			}
			else{
				System.out.println("Yönetici Değil");
				vekilAtama = "Departman Yöneticisi Değil";
			}
			
			ResultSet rs99 = stmt.executeQuery("SELECT * FROM unvan where unvancalisanid='" + duzCalisanID + "';");
			if(rs99.next()){
				//ünvan tablosunda kaydı varsa sil
				System.out.println("Unvan Tablo Kayıt Var");
				int unvanCalisanSil =stmt.executeUpdate("DELETE FROM unvan WHERE unvancalisanid='" + duzCalisanID + "'");
				if(unvanCalisanSil==1){
					unvanTabloCalisanKaydi ="Unvan Tablo Kayıt Silindi";
					System.out.println("Unvan Tablo Kayıt Silindi");
				}
				else{
					System.out.println("Unvan Tablo Silinemedi");
					session.setAttribute("kullaniciyaMesaj", "Çalışan Silinemedi.");
					session.setAttribute("duzCalisanID", duzCalisanID);
					response.sendRedirect("calisanListe.jsp");
				}
				rs99.close();
			}
			else{
				//ünvan tablosunda kaydı yok
				System.out.println("Unvan Tablo Kayıt Yok");
				unvanTabloCalisanKaydi ="Unvan Tablo Kayıt Yok";
			}
			
			if(((vekilAtama.equals("Vekil Atandı"))&&(unvanTabloCalisanKaydi.equals("Unvan Tablo Kayıt Silindi")))
					|| ((vekilAtama.equals("Vekil Atandı"))&&(unvanTabloCalisanKaydi.equals("Unvan Tablo Kayıt Yok")))
					 || ((vekilAtama.equals("Departman Yöneticisi Değil"))&&(unvanTabloCalisanKaydi.equals("Unvan Tablo Kayıt Silindi")))
					 	|| ((vekilAtama.equals("Departman Yöneticisi Değil"))&&(unvanTabloCalisanKaydi.equals("Unvan Tablo Kayıt Yok")))
					){
				
				System.out.println("Silme işlemi için şartlar uygun");
				int calisanSil = stmt.executeUpdate("DELETE FROM calisan WHERE calisanid='" + duzCalisanID + "'");
				if (calisanSil == 1) {
					System.out.println("\nÇalışan Silindi.");
					session.setAttribute("kullaniciyaMesaj", "Çalışan Silindi.");
					session.setAttribute("duzCalisanID", duzCalisanID);
					response.sendRedirect("calisanListe.jsp");
				} else {
					System.out.println("\nÇalışan Silinemedi.");
					session.setAttribute("kullaniciyaMesaj", "Çalışan Silinemedi.");
					session.setAttribute("duzCalisanID", duzCalisanID);
					response.sendRedirect("calisanListe.jsp");
				}
			}
			else {
				System.out.println("\nÇalışan Silinemedi.");
				session.setAttribute("kullaniciyaMesaj", "Çalışan Silinemedi.");
				session.setAttribute("duzCalisanID", duzCalisanID);
				response.sendRedirect("calisanListe.jsp");
			}
		} else {
			//System.out.print("Böyle bir kayıt yok\n");
			response.sendRedirect("index.jsp");
		}
	} catch (Exception a) {
		System.err.println("DB Bağlantı Hatası! calisansil");
		System.err.println(a.getMessage());
	}
}
%>
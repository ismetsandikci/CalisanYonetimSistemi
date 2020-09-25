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
String duzDepartmanID = "";

String duzdepartmanAd = request.getParameter("departmanAd");
String duzdepartmanYonetici = request.getParameter("departmanYonetici");
String duzdepartmanLokasyon = request.getParameter("departmanLokasyon");

if ((duzdepartmanAd != null) && (duzdepartmanYonetici != null) && (duzdepartmanLokasyon != null)) {

	try {
		
		calisanId = session.getAttribute("calisanId").toString();System.out.println("calisanId" + calisanId);
		duzDepartmanID = session.getAttribute("duzDepartmanID").toString();
		
		if (calisanId != null) {
			dbBaglanti connec = new dbBaglanti();
			Statement stmt = connec.getCon().createStatement();
			
			System.out.println("duzDepartmanID: " + duzDepartmanID);
			System.out.println("departmanAd: " + duzdepartmanAd);
			System.out.println("duzdepartmanYonetici: " + duzdepartmanYonetici);
			System.out.println("duzdepartmanLokasyon: " + duzdepartmanLokasyon);
			
			int departmanGüncelle = stmt.executeUpdate("UPDATE departman SET departmanadi='"+ duzdepartmanAd + "', departmanyoneticiid='"+ duzdepartmanYonetici + "', departmanlokasyonid='"+ duzdepartmanLokasyon + "' WHERE departmanid='"+ duzDepartmanID + "'");
			if (departmanGüncelle == 1) {
				int departmanYoneticiGuncelle = stmt.executeUpdate("UPDATE calisan SET calisandepartmanid='"+ duzDepartmanID + "' WHERE calisanid='"+ duzdepartmanYonetici + "'");
				if(departmanYoneticiGuncelle == 1) {
					System.out.println("\nDepartman Güncellendi.");
					session.setAttribute("kullaniciyaMesaj", "Departman Güncellendi.");
					session.setAttribute("duzDepartmanID", duzDepartmanID);
					//System.out.println("Departmanguncellesession duzDepartmanID" + session.getAttribute("duzDepartmanID").toString());
					response.sendRedirect("departmanDuzenle.jsp");
				}
				else{
					System.out.println("\nDepartman Güncellenemedi.");
					session.setAttribute("kullaniciyaMesaj", "Departman Güncellenemedi.");
					session.setAttribute("duzDepartmanID", duzDepartmanID);
					//System.out.println("Departmanguncellesession duzDepartmanID" + session.getAttribute("duzDepartmanID").toString());
					response.sendRedirect("departmanDuzenle.jsp");
				}
			}
			else{
				System.out.println("\nDepartman Güncellenemedi.");
				session.setAttribute("kullaniciyaMesaj", "Departman Güncellenemedi.");
				session.setAttribute("duzDepartmanID", duzDepartmanID);
				//System.out.println("Departmanguncellesession duzDepartmanID" + session.getAttribute("duzDepartmanID").toString());
				response.sendRedirect("departmanDuzenle.jsp");
			}

		} else {
		//System.out.print("Böyle bir kayıt yok\n");
		response.sendRedirect("index.jsp");
		}
	} catch (Exception a) {
		System.err.println("DB Bağlantı Hatası! departmanguncelle");
		System.err.println(a.getMessage());
	}
}
%>
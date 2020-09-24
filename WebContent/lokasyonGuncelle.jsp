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
String duzLokasyonID = "";

String duzlokasyonAd = request.getParameter("lokasyonAd");
String duzlokasyonAdresi = request.getParameter("lokasyonAdresi");
String duzlokasyonPostaKodu = request.getParameter("lokasyonPostaKodu");
String duzlokasyonSehir = request.getParameter("lokasyonSehir");
String duzlokasyonUlke = request.getParameter("lokasyonUlke");

if ((duzlokasyonAd != null) && (duzlokasyonAdresi != null) && (duzlokasyonPostaKodu != null) && (duzlokasyonSehir != null) && (duzlokasyonUlke != null)) {

	try {
		
		calisanId = session.getAttribute("calisanId").toString();System.out.println("calisanId" + calisanId);
		duzLokasyonID = session.getAttribute("duzLokasyonID").toString();
		
		if (calisanId != null) {
			//database bağlantısı için çağırdık
			dbBaglanti connec = new dbBaglanti();
			Statement stmt = connec.getCon().createStatement();
			
			System.out.println("duzlokasyonAd: " + duzlokasyonAd);
			System.out.println("duzlokasyonAdresi: " + duzlokasyonAdresi);
			System.out.println("duzlokasyonPostaKodu: " + duzlokasyonPostaKodu);
			duzlokasyonSehir = duzlokasyonSehir.replace("'", "");
			System.out.println("duzlokasyonSehir: " + duzlokasyonSehir);
			duzlokasyonUlke = duzlokasyonUlke.replace("'", "");
			System.out.println("duzlokasyonUlke: " + duzlokasyonUlke);
			
			int lokasyonnGüncelle = stmt.executeUpdate("UPDATE lokasyon SET lokasyonadi='"+ duzlokasyonAd + "', lokasyonadresi='"+ duzlokasyonAdresi + "', lokasyonpostakodu='"+ duzlokasyonPostaKodu + "', lokasyonsehir='"+ duzlokasyonSehir + "', lokasyoulke='"+ duzlokasyonUlke + "' WHERE lokasyonid='"+ duzLokasyonID + "'");
			if (lokasyonnGüncelle == 1) {
					System.out.println("\nLokasyon Güncellendi.");
					session.setAttribute("kullaniciyaMesaj", "Lokasyon Güncellendi.");
					session.setAttribute("duzLokasyonID", duzLokasyonID);
					response.sendRedirect("lokasyonDuzenle.jsp");
			}
			else{
					System.out.println("\nLokasyon Güncellenemedi.");
					session.setAttribute("kullaniciyaMesaj", "Lokasyon Güncellenemedi.");
					session.setAttribute("duzLokasyonID", duzLokasyonID);
					response.sendRedirect("lokasyonDuzenle.jsp");
			}
		} else {
		//System.out.print("Böyle bir kayıt yok\n");
		response.sendRedirect("index.jsp");
		}
	} catch (Exception a) {
		System.err.println("DB Bağlantı Hatası! lokasyonguncelle");
		System.err.println(a.getMessage());
	}
}
%>
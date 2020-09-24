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

if ((duzLokasyonID != null) ) {

	try {
		calisanId = session.getAttribute("calisanId").toString();System.out.println("calisanId" + calisanId);
		duzLokasyonID = session.getAttribute("duzLokasyonID").toString();
		
		if (calisanId != null) {
			//database bağlantısı için çağırdık
			dbBaglanti connec = new dbBaglanti();
			Statement stmt = connec.getCon().createStatement();
			
			int lokasyonSil = stmt.executeUpdate("DELETE FROM lokasyon WHERE lokasyonid='"+ duzLokasyonID + "'");
			if (lokasyonSil == 1) {
					System.out.println("\nLokasyon Silindi.");
					session.setAttribute("kullaniciyaMesaj", "Lokasyon Silindi.");
					session.setAttribute("duzLokasyonID", duzLokasyonID);
					response.sendRedirect("lokasyonListe.jsp");
			}
			else{
					System.out.println("\nLokasyon Silindi.");
					session.setAttribute("kullaniciyaMesaj", "Lokasyon Silindi.");
					session.setAttribute("duzLokasyonID", duzLokasyonID);
					response.sendRedirect("lokasyonListe.jsp");
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
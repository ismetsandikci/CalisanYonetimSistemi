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

if ((duzDepartmanID != null)) {

	try {
		calisanId = session.getAttribute("calisanId").toString();
		System.out.println("calisanId:" + calisanId);
		
		duzDepartmanID = request.getParameter("sil");
		System.out.println("duzLokasyonID:" + duzDepartmanID);

		if (calisanId != null) {
			//database bağlantısı için çağırdık
			dbBaglanti connec = new dbBaglanti();
			Statement stmt = connec.getCon().createStatement();
			
			ResultSet rs2121 = stmt.executeQuery("SELECT * FROM calisan where calisandepartmanid='" + duzDepartmanID + "';");
			if(rs2121.next()){
				int calisanDepartmanAtama = stmt.executeUpdate(
						"UPDATE calisan SET calisandepartmanid='1' WHERE calisandepartmanid='" + duzDepartmanID + "'");
					if (calisanDepartmanAtama == 1) {
						int departmanSil = stmt.executeUpdate("DELETE FROM departman WHERE departmanid='" + duzDepartmanID + "'");
							if (departmanSil == 1) {
								System.out.println("\nDepartman Silindi.");
								session.setAttribute("kullaniciyaMesaj", "Departman Silindi.");
								session.setAttribute("duzDepartmanID", duzDepartmanID);
								response.sendRedirect("departmanListe.jsp");
							} else {
								System.out.println("\nDepartman Silinemedi.");
								session.setAttribute("kullaniciyaMesaj", "Departman Silinemedi.");
								session.setAttribute("duzDepartmanID", duzDepartmanID);
								response.sendRedirect("departmanListe.jsp");
							}
					} else {
						System.out.println("\nDepartman Silinemedi.");
						session.setAttribute("kullaniciyaMesaj", "Departman Silinemedi.");
						session.setAttribute("duzDepartmanID", duzDepartmanID);
						response.sendRedirect("departmanListe.jsp");
					}
				rs2121.close();
			}
			else{
				int lokasyonSil = stmt.executeUpdate("DELETE FROM departman WHERE departmanid='" + duzDepartmanID + "'");
				if (lokasyonSil == 1) {
					System.out.println("\nDepartman Silindi.");
					session.setAttribute("kullaniciyaMesaj", "Departman Silindi.");
					session.setAttribute("duzDepartmanID", duzDepartmanID);
					response.sendRedirect("departmanListe.jsp");
				} else {
					System.out.println("\nDepartman Silinemedi.");
					session.setAttribute("kullaniciyaMesaj", "Departman Silinemedi.");
					session.setAttribute("duzDepartmanID", duzDepartmanID);
					response.sendRedirect("departmanListe.jsp");
				}
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
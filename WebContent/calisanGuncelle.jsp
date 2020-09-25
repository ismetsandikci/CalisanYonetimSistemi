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
String duzKisiID = "";

String kisi_adi = request.getParameter("ad");
String kisi_soyadi = request.getParameter("soyad");
String kisi_eposta = request.getParameter("eposta");
String kisi_telefon = request.getParameter("telefon");
String kisi_isGirisTarihilk = request.getParameter("datepicker");
String kisi_isGirisTarihson ="";
String kisi_maas = request.getParameter("maas");

String kisi_departman = request.getParameter("departman");
String kisi_departmanid="";
String kisi_departmanad="";

String kisi_unvani = request.getParameter("unvan");
String kisi_ilkunvani ="";
String kisi_ilkdepartmanid ="";
String guncelenecekUnvanid ="";


if ((kisi_adi != null) && (kisi_soyadi != null) && (kisi_eposta != null) && (kisi_telefon != null) && (kisi_isGirisTarihilk != null) && (kisi_maas != null) && (kisi_departman != null)
		&& (kisi_unvani != null)) {

	try {
		//database bağlantısı için çağırdık
		dbBaglanti connec = new dbBaglanti();
		Statement stmt = connec.getCon().createStatement();
		
		String[] ayir = kisi_departman.split(".//.");
		kisi_departmanid =ayir[0]; 
		kisi_departmanad =ayir[1];

		calisanId = session.getAttribute("calisanId").toString();
		duzKisiID = session.getAttribute("duzKisiID").toString();
		
		System.out.println("calisanguncelle duzKisiID" + duzKisiID);
		
		//Eğer kişi id si boş değilse ekranda gösterilmek için kişinin adı, soyadı gibi bilgileri çekiyoruz.
		if (calisanId != null) {
			ResultSet rs11 = stmt.executeQuery("SELECT * FROM calisan where calisanid='" + duzKisiID + "'");
			if(rs11.next()){
				if(!rs11.getString("calisanisegiristarihi").equals(kisi_isGirisTarihilk)){
					String pattern = "yyyy/MM/dd";
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
					kisi_isGirisTarihson = simpleDateFormat.format(new Date(kisi_isGirisTarihilk));
					
					kisi_isGirisTarihson = kisi_isGirisTarihson.replace("/", "-");
					
					kisi_ilkunvani=rs11.getString("calisanunvan");
					kisi_ilkdepartmanid=rs11.getString("calisandepartmanid");
				}
				
				int calisanGüncelle = stmt.executeUpdate("UPDATE calisan SET calisanad='"+ kisi_adi + "',calisansoyad='" + kisi_soyadi + "',calisaneposta='" + kisi_eposta + "',calisantelefon='" + kisi_telefon + "',calisanisegiristarihi='"+ kisi_isGirisTarihson + "',calisanmaas='" + kisi_maas + "',calisandepartmanid='" + kisi_departmanid + "',calisanunvan='" + kisi_unvani+ "' where calisanid='" + duzKisiID + "'");
				if (calisanGüncelle == 1) {
					//kullanıcının departmanı değişti mi
					if(!kisi_ilkdepartmanid.equals(kisi_departmanid)){
						//kullanıcının departmanı değişti
						//kullanıcının ünvanı değişti mi
						System.out.println("kisi_ilkdepartmanid: "+kisi_ilkdepartmanid);
						System.out.println("kisi_departmanid: "+kisi_departmanid);
						System.out.println("kisi_departmanad: "+kisi_departmanad);
						if(!kisi_ilkunvani.equals(kisi_unvani)){
							//kullanıcının ünvanı değişti
							//kullanıcının departman ve ünvan güncelle
							ResultSet rs222 = stmt.executeQuery("SELECT * FROM unvan where unvancalisanid='" + duzKisiID + "' and unvanbastarih=unvanbittarih");
							if(rs222.next()){
								guncelenecekUnvanid = rs222.getString("unvanid");
							}
							rs222.close();
							Date bugun = new Date();
							String bugunTarihi= new SimpleDateFormat("yyyy/MM/dd").format(bugun);
							int unvanBitTarihGüncelle = stmt.executeUpdate("UPDATE unvan SET unvanbittarih='" + bugunTarihi + "' where unvanid='" + guncelenecekUnvanid + "' ");
							if(unvanBitTarihGüncelle==1){
								List<Integer> unvanidList = new ArrayList<Integer>();
								ResultSet rs116 = stmt.executeQuery("SELECT * FROM unvan");
								while(rs116.next()){
									unvanidList.add(rs116.getInt("unvanid"));
								}
								rs116.close();
								int maxunvanId = Collections.max(unvanidList);
								maxunvanId=maxunvanId+1;
								int unvanDegisiklikEkle = stmt.executeUpdate("INSERT INTO unvan (unvanid,unvancalisanid,unvanadi,unvanbastarih,unvanbittarih,unvandepartmanadi) VALUES ('"+ maxunvanId + "','"+ duzKisiID + "','"+ kisi_unvani + "','"+ bugunTarihi + "','"+ bugunTarihi + "','"+ kisi_departmanad + "')");
								if(unvanBitTarihGüncelle==1){
									System.out.println("\nKullanıcı Güncellendi.");
									session.setAttribute("kullaniciyaMesaj", "Kullanıcı Güncellendi.");
									session.setAttribute("duzKisiID", duzKisiID);
									System.out.println("calisanguncellesession duzKisiID" + session.getAttribute("duzKisiID").toString());
									response.sendRedirect("calisanDuzenle.jsp");
								}
								else{
									System.out.println("\nKullanıcı Güncellenemedi.");
									session.setAttribute("kullaniciyaMesaj", "Kullanıcı Güncellenemedi.");
									session.setAttribute("duzKisiID", duzKisiID);
									System.out.println("calisanguncellesession duzKisiID" + session.getAttribute("duzKisiID").toString());
									response.sendRedirect("calisanDuzenle.jsp");
								}
							}
							
						}
						else{
							//kullanıcının ünvanı değişmedi
							//sadece unvan tablosunda yeni kayıt ile departman değişecek
							
							ResultSet rs2222 = stmt.executeQuery("SELECT * FROM unvan where unvancalisanid='" + duzKisiID + "' and unvanbastarih=unvanbittarih and unvandepartmanadi=(SELECT departmanadi FROM departman WHERE departmanid='" + kisi_ilkdepartmanid + "')");
							if(rs2222.next()){
								guncelenecekUnvanid = rs2222.getString("unvanid");
								String unvanSonKayitunvancalisanid=rs2222.getString("unvancalisanid");
								String unvanSonKayitunvanadi=rs2222.getString("unvanadi");
								String unvanSonKayitunvanbastarih=rs2222.getString("unvanbastarih");
								String unvanSonKayitunvanbittarih=rs2222.getString("unvanbittarih");
								rs2222.close();
								
								List<Integer> unvanidList2 = new ArrayList<Integer>();
								ResultSet rs1162 = stmt.executeQuery("SELECT * FROM unvan");
								while(rs1162.next()){
									unvanidList2.add(rs1162.getInt("unvanid"));
								}
								rs1162.close();
								int maxunvanId2 = Collections.max(unvanidList2);
								maxunvanId2=maxunvanId2+1;
								
								
								guncelenecekUnvanid = guncelenecekUnvanid +1;
								int unvanYeniKayitEkle = stmt.executeUpdate("INSERT INTO unvan (unvanid,unvancalisanid,unvanadi,unvanbastarih,unvanbittarih,unvandepartmanadi) VALUES ('"+ maxunvanId2 + "','"+ unvanSonKayitunvancalisanid + "','"+ unvanSonKayitunvanadi + "','"+ unvanSonKayitunvanbastarih + "','"+ unvanSonKayitunvanbittarih + "','"+ kisi_departmanad + "')"); 
								if (unvanYeniKayitEkle == 1) {
									System.out.println("\nKullanıcı Güncellendi.");
									session.setAttribute("kullaniciyaMesaj", "Kullanıcı Güncellendi.");
									session.setAttribute("duzKisiID", duzKisiID);
									System.out.println("calisanguncellesession duzKisiID" + session.getAttribute("duzKisiID").toString());
									response.sendRedirect("calisanDuzenle.jsp");
								}
								else{
									System.out.println("\nKullanıcı ünvan son departman id ile eklenemedi");
									session.setAttribute("kullaniciyaMesaj", "Kullanıcı Güncellenemedi.");
									session.setAttribute("duzKisiID", duzKisiID);
									System.out.println("calisanguncellesession duzKisiID" + session.getAttribute("duzKisiID").toString());
									response.sendRedirect("calisanDuzenle.jsp");
								}
							}
							
							else{
								System.out.println("\nKullanıcı ünvan tablosu son kayıt getirilemedi.");
								session.setAttribute("kullaniciyaMesaj", "Kullanıcı Güncellenemedi.");
								session.setAttribute("duzKisiID", duzKisiID);
								System.out.println("calisanguncellesession duzKisiID" + session.getAttribute("duzKisiID").toString());
								response.sendRedirect("calisanDuzenle.jsp");
							}
						}
					}
					else if(!kisi_ilkunvani.equals(kisi_unvani)){
						//kullanıcının departmanı değişmedi
						//sadece ünvan değişecek
						ResultSet rs222 = stmt.executeQuery("SELECT * FROM unvan where unvancalisanid='" + duzKisiID + "' and unvanbastarih=unvanbittarih");
						if(rs222.next()){
							guncelenecekUnvanid = rs222.getString("unvanid");
						}
						rs222.close();
						
						Date bugun = new Date();
						String bugunTarihi= new SimpleDateFormat("yyyy/MM/dd").format(bugun);
						
						int unvanBitTarihGüncelle = stmt.executeUpdate("UPDATE unvan SET unvanbittarih='" + bugunTarihi + "' where unvanid='" + guncelenecekUnvanid + "' ");
						if(unvanBitTarihGüncelle==1){
							List<Integer> unvanidList = new ArrayList<Integer>();
							ResultSet rs116 = stmt.executeQuery("SELECT * FROM unvan");
							while(rs116.next()){
								unvanidList.add(rs116.getInt("unvanid"));
							}
							rs116.close();
							int maxunvanId = Collections.max(unvanidList);
							maxunvanId=maxunvanId+1;
							int unvanDegisiklikEkle = stmt.executeUpdate("INSERT INTO unvan (unvanid,unvancalisanid,unvanadi,unvanbastarih,unvanbittarih,unvandepartmanadi) VALUES ('"+ maxunvanId + "','"+ duzKisiID + "','"+ kisi_unvani + "','"+ bugunTarihi + "','"+ bugunTarihi + "','"+ kisi_departmanad + "')");
							if(unvanBitTarihGüncelle==1){
								System.out.println("\nKullanıcı Güncellendi.");
								session.setAttribute("kullaniciyaMesaj", "Kullanıcı Güncellendi.");
								session.setAttribute("duzKisiID", duzKisiID);
								System.out.println("calisanguncellesession duzKisiID" + session.getAttribute("duzKisiID").toString());
								response.sendRedirect("calisanDuzenle.jsp");
							}
							else{
								System.out.println("\nKullanıcı Güncellenemedi.");
								session.setAttribute("kullaniciyaMesaj", "Kullanıcı Güncellenemedi.");
								session.setAttribute("duzKisiID", duzKisiID);
								System.out.println("calisanguncellesession duzKisiID" + session.getAttribute("duzKisiID").toString());
								response.sendRedirect("calisanDuzenle.jsp");
							}
						}
						else{
							System.out.println("\nKullanıcı Güncellenemedi.");
							session.setAttribute("kullaniciyaMesaj", "Kullanıcı Güncellenemedi.");
							session.setAttribute("duzKisiID", duzKisiID);
							System.out.println("calisanguncellesession duzKisiID" + session.getAttribute("duzKisiID").toString());
							response.sendRedirect("calisanDuzenle.jsp");
						}
					}
					else{
						System.out.println("\nKullanıcı Güncellendi.");
						session.setAttribute("kullaniciyaMesaj", "Kullanıcı Güncellendi.");
						session.setAttribute("duzKisiID", duzKisiID);
						System.out.println("calisanguncellesession duzKisiID" + session.getAttribute("duzKisiID").toString());
						response.sendRedirect("calisanDuzenle.jsp");
					}
					
				}
				else{
					System.out.println("\nKullanıcı Güncellenemedi.");
					session.setAttribute("kullaniciyaMesaj", "Kullanıcı Güncellenemedi.");
					session.setAttribute("duzKisiID", duzKisiID);
					System.out.println("calisanguncellesession duzKisiID" + session.getAttribute("duzKisiID").toString());
					response.sendRedirect("calisanDuzenle.jsp");
				}
			}
			

		} else {
	//System.out.print("Böyle bir kayıt yok\n");
	response.sendRedirect("index.jsp");
		}
	} catch (Exception a) {
		System.err.println("DB Bağlantı Hatası! calisanguncelle ünvan");
		System.err.println(a.getMessage());
	}

}
%>
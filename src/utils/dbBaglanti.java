package utils;

import java.sql.*;

public class dbBaglanti {

	private Connection con = null;

	public dbBaglanti() {
		try {
			String url = "jdbc:postgresql://localhost:5432/calisanyonetimi";
			String user = "postgres";
			String password = "12345";

			try 
			{
				Class.forName("org.postgresql.Driver");
			} 
			catch(java.lang.ClassNotFoundException e) 
			{
				System.err.print("ClassNotFoundException: ");
				System.err.println(e.getMessage());
			}
			
			this.con = DriverManager.getConnection(url, user, password);
			//System.out.println("PostgreSQL DB baþarýlý! dbBaglanti.java");
		} catch (SQLException ex) {
			System.err.println("DB Baglanti Hatasi! dbBaglanti.java ");
			System.err.println("SQLException: " + ex.getMessage());
		}
	}

	public Connection getCon() {
		return this.con;
	}

	public void closeCon() {
		if (this.con != null) {
			try {
				this.con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * try (
	 * 
	 * 
	 * ResultSet rs = st.executeQuery("SELECT * FROM actor")) {
	 * 
	 * if (rs.next()) { System.out.println(rs.getString(1)); }
	 * 
	 * } catch (SQLException ex) {
	 * 
	 * System.err.println("SQLException: " + ex.getMessage()); }
	 */

}

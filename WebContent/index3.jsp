<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("UTF-8");

try {
    Class.forName("org.postgresql.Driver");
} catch (ClassNotFoundException e) {
    System.out.println("Class not found " + e);
}
try {
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/dvdrental", "postgres","12345");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM actor");
    System.out.println("111ğ");

    while (rs.next()) {
    	String id = rs.getString("first_name");
        String name = rs.getString("last_name");
        out.println(id);
        System.out.println(id + "   " + name);

    }
} catch (SQLException e) {
    System.out.println("SQL exception occured" + e);
}

%>

</body>
</html>
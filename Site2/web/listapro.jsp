<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listagem de produtos</title>
    </head>
    <body>
        <%
            Connection conecta = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsite", "root", "Kamenriderv3");

                pst = conecta.prepareStatement("select * from produto");
                rs = pst.executeQuery();
        %>
        <table border="1">
            <tr>
                <th>Código</th><th>Nome</th><th>Marca</th><th>Preço</th>
            </tr>
            <%
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("codigo")%></td>
                <td><%= rs.getString("nome")%></td>
                <td><%= rs.getString("marca")%></td>
                <td><%= rs.getString("preco")%></td>
            </tr>         
            <%
                    }

                } catch (SQLException e) {
                    out.print("Erro: " + e);
                } finally {
                    rs.close();
                    pst.close();
                    conecta.close();
                }
            %>
        </table>   
        <%

        %>
    </body>
</html>

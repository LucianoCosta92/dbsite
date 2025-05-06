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
        <title>Consulta de produtos</title>
        <link rel="stylesheet" href="tabela.css">
    </head>
    <body>
        <%
            Connection conecta = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            
            String nome = request.getParameter("txtNome");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsite", "root", "Kamenriderv3");

                pst = conecta.prepareStatement("select * from produto where nome like ? order by nome");
                pst.setString(1, "%" + nome + "%");
                rs = pst.executeQuery();
        %>
        <table>
            <tr>
                <th>Código</th><th>Nome</th><th>Marca</th><th>Preço</th><th>Exclusão</th>
            </tr>
            <%
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("codigo")%></td>
                <td><%= rs.getString("nome")%></td>
                <td><%= rs.getString("marca")%></td>
                <td><%= rs.getString("preco")%></td>
                <td><a href="excluir_produtos.jsp?txtCod=<%= rs.getString("codigo")%>">Excluir</td>
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
    </body>
</html>

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
        <title>Carregamento de produto</title>
    </head>
    <body>
        <%
            int codigo = Integer.parseInt(request.getParameter("txtCod"));
            Connection conecta = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsite", "root", "Kamenriderv3");

                pst = conecta.prepareStatement("select * from produto where codigo = ?");
                pst.setInt(1, codigo);
                rs = pst.executeQuery();
                if (!rs.next()) {
                    out.print("<p style='color:blue'; font-size:15px>Este produto não foi encontrado!</p>");
                } else {
        %>
        <form method="post" action="alterar_produtos.jsp">
            <p>
                <label for="txtCod">Código:</label>
                <input type="number" name="txtCod" id="txtCod" value="<%= rs.getInt("codigo")%>" readonly>
            </p>
            <p>
                <label for="txtNome">Nome do produto:</label>
                <input type="text" name="txtNome" id="txtNome" size="50" maxlength="50" value="<%= rs.getString("nome")%>">
            </p>
            <p>
                <label for="txtMarca">Marca do produto:</label>
                <input type="text" name="txtMarca" id="txtMarca" maxlength="50" value="<%= rs.getString("marca")%>">
            </p>
            <p>
                <label for="txtPreco">Preço:</label>
                <input type="number" step="0.1" name="txtPreco" id="txtPreco" value="<%= rs.getBigDecimal("preco")%>">
            </p>
            <p>
                <input type="submit" value="Salvar alterações">
            </p>      
        </form>
        <%
                }
            } catch (SQLException e) {
                String erro = e.getMessage();
                out.print("<p style='color:blue'; font-size:15px>Entre em contato com o suporte e informe o erro: " + erro + "</p>");
            } finally {
                pst.close();
                rs.close();
                conecta.close();
            }
        %>
    </body>
</html>

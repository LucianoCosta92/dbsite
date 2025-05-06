<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir produtos</title>
    </head>
    <body>
        <%
            int codigo;
            codigo = Integer.parseInt(request.getParameter("txtCod"));

            Connection conecta = null;
            PreparedStatement pst = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsite", "root", "Kamenriderv3");

                pst = conecta.prepareStatement("delete from produto where codigo=?");
                pst.setInt(1, codigo);

                int resultado = pst.executeUpdate();
                if (resultado == 1) {
                    out.print("<p style='color:blue'; font-size:15px>Produto de código " + codigo + " foi excluído com sucesso!</p>");
                } else {
                    out.print("<p style='color:blue'; font-size:15px>Produto não cadastrado!</p>");
                }
            } catch (SQLException e) {
                String erro = e.getMessage();
                out.print("<p style='color:blue'; font-size:15px>Entre em contato com o suporte e informe o erro: " + erro + "</p>");
            } finally {
                pst.close();
                conecta.close();
            }


        %>
    </body>
</html>

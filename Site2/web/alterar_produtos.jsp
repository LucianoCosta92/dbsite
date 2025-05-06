<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alteração de produto</title>
    </head>
    <body>
        <%
            int codigo;
            String nome, marca;
            BigDecimal preco;

            codigo = Integer.parseInt(request.getParameter("txtCod"));
            nome = request.getParameter("txtNome").trim();
            marca = request.getParameter("txtMarca").trim();
            preco = new BigDecimal(request.getParameter("txtPreco"));

            Connection conecta = null;
            PreparedStatement pst = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsite", "root", "Kamenriderv3");

                pst = conecta.prepareStatement("update produto set nome=?, marca=?, preco=? where codigo=?");
                pst.setString(1, nome);
                pst.setString(2, marca);
                pst.setBigDecimal(3, preco);
                pst.setInt(4, codigo);

                pst.executeUpdate();
                out.print("<p style='color:blue'; font-size:15px>Produto de código " + codigo + " alterado com sucesso!</p>");
            } catch (Exception e) {
                String erro = e.getMessage();
                out.print("<p style='color:blue'; font-size:15px>Entre em contato com o suporte e informe o erro: " + erro + "</p>");
            } finally{
                pst.close();
                conecta.close();
            }
        %>
    </body>
</html>

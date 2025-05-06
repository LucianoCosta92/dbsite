<%@page import="java.math.BigDecimal"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de produtos</title>
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

                pst = conecta.prepareStatement("insert into produto(codigo, nome, marca, preco) values(?, ?, ?, ?)");
                pst.setInt(1, codigo);
                pst.setString(2, nome);
                pst.setString(3, marca);
                pst.setBigDecimal(4, preco);

                pst.executeUpdate();
                out.print("<p style='color:blue'; font-size:15px>Produto cadastrado com sucesso!</p>");
            } catch (SQLException e) {
                String erro = e.getMessage();
                if (erro.contains("Duplicate entry")) {
                    out.print("<p style='color:blue'; font-size:15px>Este produto já está cadastrado!</p>");
                } else {
                    out.print("<p style='color:blue'; font-size:15px>Entre em contato com o suporte e informe o erro: " + erro + "</p>");
                }
            } finally{
                pst.close();
                conecta.close();
            }
        %>
    </body>
</html>

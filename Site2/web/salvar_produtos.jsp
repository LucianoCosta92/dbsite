<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            int codigo;
            String nome, marca;
            double preco;

            codigo = Integer.parseInt(request.getParameter("txtCod"));
            nome = request.getParameter("txtNome");
            marca = request.getParameter("txtMarca");
            preco = Double.parseDouble(request.getParameter("txtPreco"));

            try {
                Connection conecta;
                PreparedStatement pst;

                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsite", "root", "Kamenriderv3");

                pst = conecta.prepareStatement("insert into produto(codigo, nome, marca, preco) values(?, ?, ?, ?)");
                pst.setInt(1, codigo);
                pst.setString(2, nome);
                pst.setString(3, marca);
                pst.setDouble(4, preco);

                pst.executeUpdate();
                out.print("Produto cadastrado com sucesso!");
            } catch (Exception e) {
                out.print("Erro:" + e);
            }


        %>
    </body>
</html>

<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro via Excel</title>
    </head>
    <body>
        <%
            Connection conecta = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            String sql;
            int codigo = 0;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsite", "root", "Kamenriderv3");

                // lendo o arquivo excel
                FileReader arquivo = new FileReader("/home/luciano/NetBeansProjects/Site2/web/Planilha - Página1.csv");
                BufferedReader br = new BufferedReader(arquivo);
                String linha, nome, marca;
                BigDecimal preco;

                while ((linha = br.readLine()) != null) {
                    String[] dados = linha.split(",");
                    String codString = dados[0].replaceAll("[^0-9]", "");
                    codigo = Integer.parseInt(codString);
                    nome = dados[1];
                    marca = dados[2];
                    String precoString = dados[3].replaceAll("[\"\\s]", "");// remove aspas duplas e espaços extras
                    preco = new BigDecimal(precoString);

                    sql = "select * from produto where codigo = ?";
                    pst = conecta.prepareStatement(sql);
                    pst.setInt(1, codigo);
                    rs = pst.executeQuery();
                    if (!rs.next()) {
                        sql = "insert into produto(codigo, nome, marca, preco) values(?,?,?,?)";
                        pst = conecta.prepareStatement(sql);
                        pst.setInt(1, codigo);
                        pst.setString(2, nome);
                        pst.setString(3, marca);
                        pst.setBigDecimal(4, preco);

                        pst.executeUpdate();
                        out.print("<p style='color:blue'; font-size:15px>Produto de código <strong>" + codigo + "</strong> cadastrado com sucesso!</p>");
                    } else {
                        out.print("<p style='color:blue'; font-size:15px>Este produto de código <strong>" + codigo + "</strong> já está cadastrado!</p>");
                    }
                }
                arquivo.close();
                br.close();
            } catch (Exception e) {
                out.print("<p style='color:blue'; font-size:15px>Entre em contato com o suporte e informe o erro: " + e + "</p>");
            } finally {
                pst.close();
                rs.close();
                conecta.close();
            }

        %>


    </body>
</html>

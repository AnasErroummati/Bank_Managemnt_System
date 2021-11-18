<%-- 
    Document   : Transaction
    Created on : May 1, 2021, 7:40:30 PM
    Author     : Anas ER
--%>

<%@page import="java.io.IOException"%>
<%@page import="com.mycompany.clientbankwebsystem.Login"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.PrintWriter"%>

<html>
    <style>
        .table{
            margin-top: 40px;
        }
      </style>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

</head>
<body >
<nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
              <a class="navbar-brand" href="#">iBank</a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                  <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index.html">Home</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="Transaction.jsp">MyTransactions</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="PersonalInfo.jsp">Personal Information</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
    <% 
    try {
 Context ctx = new InitialContext();
            if (ctx == null) {
            throw new Exception("Error - No Context");
            }
 // /jdbc/postgres is the name of the resource in context.xml
 DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/postgres");
 if (ds != null) {
 Connection conn = ds.getConnection();
if (conn != null) {
  out.println("<table class=\"table table-striped\">");
Statement stmt = conn.createStatement();
ResultSet rst = stmt.executeQuery("SELECT transaction_id , transaction_type , description, amount ,transactiondate  from transaction where cust_id="+Login.CustomerID);
out.println("<thead>");
out.println("<tr> <th scope=\"col\">transaction_id</th> <th scope=\"col\">transaction_type</th> <th scope=\"col\">description</th> <th scope=\"col\">amount</th> <th scope=\"col\">Date</th></tr> </thead>");
                                        
out.println("<tbody>");
    while (rst.next()) {
      out.print("<tr>");
      out.print("<td>" + rst.getInt(1) + "</td>");
      out.print("<td>" + rst.getString(2) + "</td>");
      out.print("<td>" + rst.getString(3) + "</td>");
      out.print("<td >" + rst.getDouble(4) + "</td>");
      out.print("<td>" + rst.getDate(5) + "</td>"); 
      out.print("</tr>\n");
    } 
        conn.close();
        out.println("</tbody>");
        out.println("</table>");
         } else {
         out.println("Error: conn is null ");
         }
         }
 } catch (Exception e) {
 //e.printStackTrace();
 out.println("Exception caught");
 out.println(e.toString());
    }
    %>
</body>

</html>

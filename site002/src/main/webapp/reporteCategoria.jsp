<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Soccer Shoes Categoría</title>
		<link href="css/estilo.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<main>
		     <header>
		       <h1>Soccer Shoes</h1>
		       <h2 class="destacado">Zapatos para deportistas</h2>
		       <h4 id="favorito">Carrera hacia tus sueños</h4>
		     </header>
		     <nav>
		     <a a href="index.jsp"><img src= "iconos/home.png" width = "60" height = "60" alt = "Pagina Principal"/>
		        </a>
		       <a href="consulta.jsp">Ver Productos</a>
		       <a href="login.jsp">Login</a>
		     </nav>
		     <div class="agrupar">
		       <section> 
		       		<form action="reporteCategoria.jsp" method="post" >
						<% 
							Categoria ca=new Categoria();
							out.print(ca.mostrarCategoria());						
						%>	
						<input type="submit" name="btnEnviar" id="btnEnviar" value="Enviar"/>
					</form>
			      <%
					Producto pr = new Producto();
		          	int cat = Integer.parseInt(request.getParameter("cmbCategoria"));
		          	String tabla = pr.buscarProductoCategoria(cat);
		          	out.print(tabla);
					%>
		      </section>
		   </div>
		   <footer>
		      <ul>
		         <h2>Gracias por visitar S&S</h2>
		     </ul>
		   </footer>
		</main>

	</body>
</html>
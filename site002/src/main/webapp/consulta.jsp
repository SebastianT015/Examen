<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Soccer Shoes Consulta</title>
		<link href="css/estilo.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<main>
		     <header>
		       <h1>E-commerce</h1>
		       <h2 class="destacado">Moda casual sostenible</h2>
		       <h4 id="favorito">Consumir la moda de manera consciente e intencionada</h4>
		     </header>
		     <nav>
		      <a a href="index.jsp"><img src= "iconos/home.png" width = "60" height = "60" alt = "Pagina Principal"/>
		        </a>
		       <a href="categoria.jsp">Buscar Por Categoria</a>
		       <a href="login.jsp">Login</a>
		     </nav>
		     <div class="agrupar">
		       <section> 
				<%
		        	Producto pr=new Producto();
		        	out.print(pr.consultarTodo());
		        %>
		      </section>
		      <aside>
		        <a href="https://www.linkedin.com/in/sebastian-tipantu%C3%B1a-bb611235a/">Ver más información sobre los desarrolladores   
				</a> <br/>
				<iframe src="https://www.google.com/maps/d/u/0/embed?mid=13sZXbrb9_stTOxckKMGTwOWKAFjhAxo&ehbc=2E312F" width="160" height="120"> 
				</iframe>
		      </aside>
		   </div>
		   <footer>
		      <ul>
		         <li>Facebook</li>
		         <li>Instagram</li>
		         <li>Tiktok</li>
		     </ul>
		   </footer>
		</main>

	</body>
</html>
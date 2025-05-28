<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.productos.seguridad.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Respuesta</title>
		<link href="css/estilo.css" rel="stylesheet" type="text/css">
		
	</head>
	<body>
		<header>
			<h1>Datos del usuario Nuevo</h1>
		</header>
		<nav>
			<a href="login.jsp">Login</a>
		</nav>
		<p>
			<%
				
				
				String nombre = request.getParameter("txtNombre");
				String cedula = request.getParameter("txtCedula");
				String Ecivil = request.getParameter("cmbECivil");
				String residencia = request.getParameter("rdResidencia");
				String foto = request.getParameter("fileFoto");
				String fecha = request.getParameter("fecha");
				String color = request.getParameter("cColor");
				String email = request.getParameter("txtEmail");
				String clave = request.getParameter("txtClave");
				int ecivil = Integer.parseInt(Ecivil);
				usuarios user = new usuarios(2,nombre,cedula,ecivil,email,clave);
				user.ingresarCliente();
				
			%>
			<section>
			<br/> Bienvenido:
				<%=nombre %>
			<br/> Su número de cédula es:
				<%=cedula %>
			<br/> Su Estado civil es:
				<%=ecivil %>
			<br/> Su lugar de residencia es:
				<%=residencia %>
			<br/> El archivo seleccionado para foto del perfil es:
				<u><%=foto %></u>
			<br/> Su año y mes de nacimiento son:
				<strong><%=fecha %></strong>
			<br/> Su color favorito es:
				<font color="<%=color %>"><%=color %></font>
			<br/> Su correo electrónico es:
				<em><%=email %></em>
			</section>
			
		</p>

	</body>
	<footer>
		<ul>
			<h2>Gracias por usar S&S</h2>
		</ul>
	</footer>
</html>
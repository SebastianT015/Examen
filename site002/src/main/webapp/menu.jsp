<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session = "true" import = "com.productos.seguridad.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="css/estilo.css" rel="stylesheet" type="text/css">
		
	</head>
	<body>
		<nav>
			<%
			    String usuario;
			    HttpSession sesion = request.getSession();
			    if (sesion.getAttribute("usuario") == null){   //Se verifica si existe la variable     
				     %>
				     <jsp:forward page="login.jsp">
				     <jsp:param name="error" value="Debe registrarse en el sistema."/>
				     </jsp:forward>
				     <%
			    }
			    else{
				    usuario=(String)sesion.getAttribute("usuario"); //Se devuelve los valores de atributos
				    int perfil=(Integer)sesion.getAttribute("perfil");
				    %>
						
					<%  
						Pagina pag=new Pagina(); 
						String menu=pag.mostrarMenu(perfil); 
						out.print(menu); 
					%> 
			    	<%	
			    }
			%>
		</nav>
		<section>
			
			<%
				    if (sesion.getAttribute("usuario") == null){   //Se verifica si existe la variable     
					     %>
					     <jsp:forward page="login.jsp">
					     <jsp:param name="error" value="Debe registrarse en el sistema."/>
					     </jsp:forward>
					     <%
				    }
				    else{
					    usuario=(String)sesion.getAttribute("usuario"); //Se devuelve los valores de atributos
					    int perfil=(Integer)sesion.getAttribute("perfil");
					    %>
							<h1>Sitio Privado de Productos</h1>  
							<h2>Bienvenido  
								<%  
									out.println(usuario); 
						 		 %> 
				 			</h2> 
				    	<%	
				    }
				%>
		</section>
		
	</body>
</html>
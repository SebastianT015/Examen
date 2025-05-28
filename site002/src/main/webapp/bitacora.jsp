<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.productos.negocio.*,com.productos.seguridad.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Bitácora</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <link href="css/estilo.css" rel="stylesheet" type="text/css">
</head>
<body>
    <main class="container my-5">
        <header class="mb-4">
            <h1 class="text-center text-primary">Bitácora de Productos</h1>
        </header>
			
        <nav class="mb-4">
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

   
            
        
    </main>
	<div class="card-body">
                <%
                    Producto pr = new Producto();
                    out.print(pr.reporteBitacora());
                %>
            </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
</body>
</html>

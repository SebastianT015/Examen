<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="com.productos.negocio.*,com.productos.seguridad.*"%>
<%
    String mensaje = "";
    int idProducto = 0;
    String nombreProducto = "";
    String categoria = "";

    // Si llega por GET
    if (request.getParameter("id") != null) {
        idProducto = Integer.parseInt(request.getParameter("id"));
        Producto pr = new Producto();
        Object[] datos = pr.obtenerProductoPorId(idProducto);

        if (datos != null) {
            nombreProducto = (String) datos[0];
            categoria = (String) datos[1];
        } else {
            mensaje = "❌ Producto no encontrado.";
        }
    }

    // Si el usuario confirma la eliminación (POST)
    if (request.getParameter("confirmar") != null && request.getParameter("id") != null) {
        idProducto = Integer.parseInt(request.getParameter("id"));
        Producto pr = new Producto();
        mensaje = pr.eliminarProductoPorId(idProducto);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Soccer Shoes</title>
    <link href="css/estilo.css" rel="stylesheet" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body>
    <main>
        <header>
           <h1>Soccer Shoes</h1>
        </header>
        
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
        
        <div class="agrupar">
            <section>
                
				<div class="container mt-5">
				    <div class="row justify-content-center">
				        <div class="col-md-8">
				            <div class="card">
				                <div class="card-header bg-danger text-white">
				                    <h2 class="h4 mb-0">Eliminar Producto</h2>
				                </div>
				                
				                <div class="card-body">
				                    <% if (!mensaje.equals("")) { %>
				                        <div class="alert alert-success">
				                            <strong><%= mensaje %></strong>
				                        </div>
				                        <a href="producto.jsp" class="btn btn-primary">Volver a la lista de productos</a>
				                    
				                    <% } else if (nombreProducto != null && !nombreProducto.equals("")) { %>
				                        <div class="alert alert-warning">
				                            <p class="mb-0">¿Estás seguro de que deseas eliminar el siguiente producto?</p>
				                        </div>
				                        
				                        <div class="mb-4">
				                            <ul class="list-group">
				                                <li class="list-group-item"><strong>ID:</strong> <%= idProducto %></li>
				                                <li class="list-group-item"><strong>Nombre:</strong> <%= nombreProducto %></li>
				                                <li class="list-group-item"><strong>Categoría:</strong> <%= categoria %></li>
				                            </ul>
				                        </div>
				                        
				                        <form method="post" action="eliminar.jsp">
				                            <input type="hidden" name="id" value="<%= idProducto %>">
				                            <div class="d-flex gap-2">
				                                <button type="submit" name="confirmar" class="btn btn-danger">
				                                    <i class="bi bi-trash"></i> Sí, eliminar
				                                </button>
				                                <a href="productos.jsp" class="btn btn-secondary">Cancelar</a>
				                            </div>
				                        </form>
				                    
				                    <% } else { %>
				                        <div class="alert alert-danger">
				                            <p class="mb-0">No se ha especificado un producto válido para eliminar.</p>
				                        </div>
				                        <a href="productos.jsp" class="btn btn-primary">Volver</a>
				                    <% } %>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>
				
            </section>
            
            
        </div>
        
        <footer>
            <ul>
                
            </ul>
            
        </footer>
    </main>
</body>
</html>
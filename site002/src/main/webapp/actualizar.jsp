<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="com.productos.negocio.*"	import = "com.productos.seguridad.*"%>
<%
    String mensaje = "";
    Producto pr = new Producto();

    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendRedirect("producto.jsp");
        return;
    }
    int idProducto = Integer.parseInt(idStr);

    // Variables para formulario
    String nombre = "";
    int idCat = 0;
    int cantidad = 0;
    double precio = 0.0;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            nombre = request.getParameter("txtNombre");
            idCat = Integer.parseInt(request.getParameter("cmbCategoria"));
            cantidad = Integer.parseInt(request.getParameter("cantidad"));
            precio = Double.parseDouble(request.getParameter("precio"));

            mensaje = pr.actualizarProducto(idProducto, nombre, idCat, cantidad, precio);

            if (!mensaje.startsWith("❌")) {
                mensaje = "✔ Se ha actualizado el producto.";
            }

        } catch (Exception e) {
            mensaje = "❌ El producto: " + e.getMessage() + "No se puede actualizar.";
        }
    }

    if (!"POST".equalsIgnoreCase(request.getMethod()) || mensaje.startsWith("❌")) {
        Object[] datos = pr.obtenerProductoCompletoPorId(idProducto);
        if (datos != null) {
            nombre = (String) datos[0];
            idCat = (Integer) datos[1];
            cantidad = (Integer) datos[2];
            precio = (Double) datos[3];
        } else {
            response.sendRedirect("producto.jsp");
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Activo Sportwear</title>
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
				Pagina pag=new Pagina(); 
				String menu=pag.mostrarMenu(3); 
				out.print(menu); 
			%> 
        </nav>
        
        <div class="agrupar">
            <section>
                
				<div class="container mt-5">
				    <div class="row justify-content-center">
				        <div class="col-md-8">
				            <div class="card">
				                <div class="card-header bg-primary text-white">
				                    <h2 class="h4 mb-0">Actualizar Producto</h2>
				                </div>
				                
				                <div class="card-body">
				                    <% if (!mensaje.isEmpty()) { %>
				                        <div class="alert <%= mensaje.startsWith("❌") ? "alert-danger" : "alert-success" %>">
				                            <strong><%= mensaje %></strong>
				                        </div>
				                    <% } %>
				                    
				                    <form action="actualizar.jsp?id=<%= idProducto %>" method="post">
				                        <div class="mb-3">
				                            <label for="txtNombre" class="form-label">Nombre:</label>
				                            <input type="text" class="form-control" name="txtNombre" id="txtNombre" value="<%= nombre %>" required>
				                        </div>
				                        
				                        <div class="mb-3">
				                            <label for="Categoria" class="form-label" >Categoria</label>
											<select class="form-select" name="cmbCategoria">
											  <option selected>Seleccione una opción</option>
											  <option value="1">Pupos</option>
											  <option value="2">Micros</option>
											  <option value="3">Lisos</option>
											  <option value="3">Mixtos</option>
											</select>
				                        </div>
				                        
				                        <div class="row">
				                            <div class="col-md-6 mb-3">
				                                <label for="cantidad" class="form-label">Cantidad:</label>
				                                <input type="number" class="form-control" name="cantidad" id="cantidad" min="1" value="<%= cantidad %>" required>
				                            </div>
				                            
				                            <div class="col-md-6 mb-3">
				                                <label for="precio" class="form-label">Precio (USD):</label>
				                                <div class="input-group">
				                                    <span class="input-group-text">$</span>
				                                    <input type="number" class="form-control" name="precio" id="precio" step="0.01" min="0" value="<%= precio %>" required>
				                                </div>
				                            </div>
				                        </div>
				                        
				                        <div class="d-flex justify-content-between mt-4">
				                            <button type="submit" class="btn btn-primary">
				                                <i class="bi bi-check-circle"></i> Confirmar
				                            </button>
				                            <button type="button" class="btn btn-outline-secondary" onclick="window.location='productos.jsp'">
				                                <i class="bi bi-x-circle"></i> Cancelar
				                            </button>
				                        </div>
				                    </form>
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
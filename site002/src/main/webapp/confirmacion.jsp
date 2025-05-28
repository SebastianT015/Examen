<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.productos.negocio.*,com.productos.seguridad.*, java.text.NumberFormat" %>
<%
    // Obtener información de la última compra si es necesario
    Carrito carrito = (Carrito) session.getAttribute("carrito");
    NumberFormat formatoMoneda = NumberFormat.getCurrencyInstance();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Soccer Shoes</title>
    <link href="css/estiloAdmin.css" rel="stylesheet" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body>
    <main>
        <header>
            <h1>Soccer Shoes</h1>
            <h2 class="destacado">Zapatos deportivos</h2>
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
			    <div class="container py-5">
			        <div class="row justify-content-center">
			            <div class="col-lg-8">
			                <div class="card confirmation-card mb-4">
			                    <div class="card-header confirmation-header text-center py-4">
			                        <i class="bi bi-check-circle check-icon"></i>
			                        <h2 class="mt-3 mb-0">¡Gracias por tu compra!</h2>
			                    </div>
			                    <div class="card-body p-5">
			                        <div class="text-center mb-4">
			                            <p class="lead">Tu pedido ha sido procesado exitosamente.</p>
			                            <p>Hemos enviado los detalles de tu compra al correo electrónico registrado.</p>
			                        </div>
			                        
			                        <% if (carrito != null && !carrito.getItems().isEmpty()) { %>
			                        <div class="mt-4">
			                            <h5 class="mb-3"><i class="bi bi-receipt"></i> Resumen de tu compra</h5>
			                            <div class="bg-light p-3 rounded-3">
			                                <% for (ItemCarrito item : carrito.getItems()) { %>
			                                <div class="d-flex justify-content-between summary-item">
			                                    <span><%= item.getProducto().getNombre() %> x <%= item.getCantidad() %></span>
			                                    <strong><%= formatoMoneda.format(item.getProducto().getPrecio() * item.getCantidad()) %></strong>
			                                </div>
			                                <% } %>
			                                <div class="d-flex justify-content-between mt-3 pt-2">
			                                    <span class="fw-bold">Total:</span>
			                                    <span class="fw-bold fs-5 text-success"><%= formatoMoneda.format(carrito.getTotal()) %></span>
			                                </div>
			                            </div>
			                        </div>
			                        <% } %>
			                        
			                        <div class="d-flex flex-column flex-md-row justify-content-center gap-3 mt-5 pt-3">
			                            <a href="historial.jsp" class="btn btn-outline-primary action-btn">
			                                <i class="bi bi-clock-history"></i> Ver Historial de Compras
			                            </a>
			                            <a href="carrito.jsp" class="btn btn-success action-btn">
			                                <i class="bi bi-cart-plus"></i> Continuar Comprando
			                            </a>
			                        </div>
			                        
			                        <div class="text-center mt-4 pt-3">
			                            <p class="text-muted small">
			                                <i class="bi bi-info-circle"></i> ¿Necesitas ayuda? 
			                                <a href="contacto.jsp">Contáctanos</a> y con gusto te atenderemos.
			                            </p>
			                        </div>
			                    </div>
			                </div>
			                
			                <div class="text-center">
			                    <a href="menu.jsp" class="text-decoration-none">
			                        <i class="bi bi-arrow-left"></i> Volver al inicio
			                    </a>
			                </div>
			            </div>
			        </div>
			    </div>
			
			    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
			</section>

        </div>
        
        <footer>
            <ul>
                <h1>S&S</h1>
            </ul>
        </footer>
    </main>
</body>
</html>
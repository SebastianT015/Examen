<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.productos.negocio.*, com.productos.seguridad.*,java.util.*, java.text.*" %>
<%
    List<Compra> historial = (List<Compra>) session.getAttribute("historialCompras");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Soccer Shoes</title>
    <link href="css/estiloAdmin.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light text-dark">
    <main class="container my-4">
        <header class="text-center mb-4">
            <h1 class="display-5 fw-bold">Soccer Shoes</h1>
            <h2 class="h5 text-primary">Zapatos para deportistas</h2>
        </header>

        <nav class="mb-4">
            <%
                String usuario;
                HttpSession sesion = request.getSession();
                if (sesion.getAttribute("usuario") == null){   
            %>
                <jsp:forward page="login.jsp">
                    <jsp:param name="error" value="Debe registrarse en el sistema."/>
                </jsp:forward>
            <%
                } else {
                    usuario = (String)sesion.getAttribute("usuario"); 
                    int perfil = (Integer)sesion.getAttribute("perfil");
                    Pagina pag = new Pagina(); 
                    String menu = pag.mostrarMenu(perfil); 
                    out.print(menu); 
                }
            %>
        </nav>

        <section>
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white text-center">
                    <h2 class="h4 mb-0">Historial de Compras</h2>
                </div>

                <div class="card-body">
                    <% if (historial == null || historial.isEmpty()) { %>
                        <div class="text-center py-5">
                            <i class="bi bi-cart-x fs-1 text-muted"></i>
                            <h3 class="mt-3">No has realizado ninguna compra aún</h3>
                            <p class="text-muted">Comienza a explorar nuestros productos</p>
                            <a href="consulta.jsp" class="btn btn-primary mt-2">
                                <i class="bi bi-shop"></i> Ir a la tienda
                            </a>
                        </div>
                    <% } else { %>
                        <div class="accordion" id="historialAccordion">
                            <% for (int i = 0; i < historial.size(); i++) {
                                Compra compra = historial.get(i);
                            %>
                            <div class="accordion-item mb-3">
                                <h2 class="accordion-header" id="heading<%= i %>">
                                    <button class="accordion-button collapsed" type="button"
                                            data-bs-toggle="collapse" data-bs-target="#collapse<%= i %>"
                                            aria-expanded="false" aria-controls="collapse<%= i %>">
                                        <div class="d-flex justify-content-between w-100">
                                            <span><i class="bi bi-receipt"></i> Compra #<%= i + 1 %></span>
                                            <span class="badge rounded-pill <%= compra.getEstado().equals("Completado") ? "bg-success" : "bg-warning text-dark" %>">
                                                <%= compra.getEstado() %>
                                            </span>
                                        </div>
                                    </button>
                                </h2>
                                <div id="collapse<%= i %>" class="accordion-collapse collapse"
                                     aria-labelledby="heading<%= i %>" data-bs-parent="#historialAccordion">
                                    <div class="accordion-body">
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <strong>Fecha:</strong> <%= sdf.format(compra.getFecha()) %>
                                            </div>
                                            <div class="col-md-6 text-md-end">
                                                <strong>Total:</strong> $<%= String.format("%.2f", compra.getTotal()) %>
                                            </div>
                                        </div>

                                        <div class="table-responsive">
                                            <table class="table table-bordered table-hover table-sm align-middle">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Producto</th>
                                                        <th class="text-end">Precio Unitario</th>
                                                        <th class="text-center">Cantidad</th>
                                                        <th class="text-end">Subtotal</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (ItemCarrito item : compra.getItems()) { %>
                                                    <tr>
                                                        <td><%= item.getProducto().getNombre() %></td>
                                                        <td class="text-end">$<%= String.format("%.2f", item.getProducto().getPrecio()) %></td>
                                                        <td class="text-center"><%= item.getCantidad() %></td>
                                                        <td class="text-end">$<%= String.format("%.2f", item.getProducto().getPrecio() * item.getCantidad()) %></td>
                                                    </tr>
                                                    <% } %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>

                        <div class="text-center mt-4">
                            <a href="carrito.jsp" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left"></i> Volver a la tienda
                            </a>
                        </div>
                    <% } %>
                </div>
            </div>
        </section>

        <footer class="text-center mt-5">
            <hr>
            <p class="text-muted mb-0">© 2025 <strong>S&S</strong>. Todos los derechos reservados.</p>
        </footer>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.productos.negocio.*,com.productos.seguridad.*,java.util.*,java.text.NumberFormat" %>
<%
    Carrito carrito = (Carrito) session.getAttribute("carrito");
    if (carrito == null) {
        carrito = new Carrito();
        session.setAttribute("carrito", carrito);
    }

    String action = request.getParameter("action");
    if (action != null) {
        int idProducto = Integer.parseInt(request.getParameter("id"));
        Producto product = new Producto().obtenerProducto(idProducto);

        switch (action) {
            case "add":
                int cantidad = Integer.parseInt(request.getParameter("cantidad"));
                carrito.agregarItem(product, cantidad);
                break;
            case "remove":
                carrito.eliminarItem(idProducto);
                break;
            case "update":
                int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));
                carrito.actualizarCantidad(idProducto, nuevaCantidad);
                break;
        }
    }

    NumberFormat formatoMoneda = NumberFormat.getCurrencyInstance();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras</title>
    <link href="css/estilo.css" rel="stylesheet" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-..." crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <div class="container my-5">
        <header class="mb-4">
            <h1 class="text-primary">Soccer Shoes</h1>
            <p class="lead text-muted">Zapatos para deportistas</p>
        </header>

        <nav class="mb-4">
            <%
                HttpSession sesion = request.getSession();
                if (sesion.getAttribute("usuario") == null) {
            %>
                <jsp:forward page="login.jsp">
                    <jsp:param name="error" value="Debe registrarse en el sistema."/>
                </jsp:forward>
            <%
                } else {
                    String usuario = (String) sesion.getAttribute("usuario");
                    int perfil = (Integer) sesion.getAttribute("perfil");
                    Pagina pag = new Pagina();
                    String menu = pag.mostrarMenu(perfil);
                    out.print(menu);
                }
            %>
        </nav>

        <section>
            <h2 class="mb-4">Tu Carrito de Compras</h2>

            <% if (carrito.getItems().isEmpty()) { %>
                <div class="alert alert-info text-center">
                    <i class="bi bi-cart-x display-4 text-secondary"></i>
                    <h4 class="mt-3">Tu carrito está vacío</h4>
                    <p>Agrega productos para comenzar tu compra</p>
                    <a href="carrito.jsp" class="btn btn-primary mt-2">
                        <i class="bi bi-bag"></i> Ver Productos
                    </a>
                </div>
            <% } else { %>
                <div class="card shadow">
                    <div class="card-header bg-light">
                        <h3 class="mb-0">Mi Carrito</h3>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Producto</th>
                                        <th class="text-end">Precio</th>
                                        <th class="text-center">Cantidad</th>
                                        <th class="text-end">Subtotal</th>
                                        <th class="text-center">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (ItemCarrito item : carrito.getItems()) {
                                        Producto producto = item.getProducto();
                                        double subtotal = producto.getPrecio() * item.getCantidad();
                                    %>
                                    <tr>
                                        <td><%= producto.getNombre() %></td>
                                        <td class="text-end"><%= formatoMoneda.format(producto.getPrecio()) %></td>
                                        <td class="text-center">
                                            <form method="post" action="carritoResumen.jsp" class="d-flex justify-content-center align-items-center gap-2">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="id" value="<%= producto.getId() %>">
                                                <input type="number" name="cantidad" value="<%= item.getCantidad() %>"
                                                       min="1" max="<%= producto.getCantidad() %>" 
                                                       class="form-control form-control-sm text-center" style="width: 70px;">
                                                <button type="submit" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-arrow-clockwise"></i>
                                                </button>
                                            </form>
                                        </td>
                                        <td class="text-end"><%= formatoMoneda.format(subtotal) %></td>
                                        <td class="text-center">
                                            <a href="carritoResumen.jsp?action=remove&id=<%= producto.getId() %>"
                                               class="btn btn-sm btn-outline-danger">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <tr class="table-secondary">
                                        <td colspan="3" class="text-end"><strong>Total a Pagar:</strong></td>
                                        <td class="text-end"><strong><%= formatoMoneda.format(carrito.getTotal()) %></strong></td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="carrito.jsp" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left"></i> Seguir Comprando
                            </a>
                            <a href="checkout.jsp" class="btn btn-success">
                                <i class="bi bi-credit-card"></i> Proceder al Pago
                            </a>
                        </div>
                    </div>
                </div>
            <% } %>
        </section>

        <footer class="mt-5 text-center text-muted border-top pt-4">
            <h5>Gracias por comprar en <span class="text-primary">S&S</span></h5>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-..." crossorigin="anonymous"></script>
</body>
</html>

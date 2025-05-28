<%@ page import="com.productos.negocio.*,com.productos.seguridad.*, java.util.*" %>
<%
    // 1. Obtener los parámetros enviados desde el formulario
	int idProducto = Integer.parseInt(request.getParameter("id"));
	String nombreProducto = request.getParameter("nombre");
	int cantidad = Integer.parseInt(request.getParameter("cantidad"));

    // 2. Obtener el producto desde la base de datos mediante su ID
    Producto producto = new Producto().obtenerProducto(idProducto);
    
    // 3. Validar si el producto existe
    if (producto == null) {
        response.sendRedirect("error.jsp?mensaje=El producto no existe");
        return;
    }
    
    // 4. Validar si hay suficiente stock para la cantidad solicitada
    if (cantidad > producto.getCantidad()) {
        response.sendRedirect("error.jsp?mensaje=No hay suficiente stock");
        return;
    }
    
    // 5. Recuperar o crear el carrito en la sesión del usuario
    Carrito carrito = (Carrito) session.getAttribute("carrito");
    if (carrito == null) {
        carrito = new Carrito();
        session.setAttribute("carrito", carrito);
    }
    
    // 6. Agregar el producto con la cantidad deseada al carrito
    carrito.agregarItem(producto, cantidad);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Productos Elegidos</title>
    <!-- Estilos propios del proyecto y Bootstrap -->
    <link href="css/estiloAdmin.css" rel="stylesheet" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<main>
    <header>
        <h1>Soccer Shoes</h1>
        <h2 class="destacado">Zapatos para deportistas</h2>
    </header>

    <!-- Verificación de sesión iniciada -->
    <nav>
        <%
            String usuario;
            HttpSession sesion = request.getSession();
            if (sesion.getAttribute("usuario") == null) {
        %>
                <!-- Redirecciona al login si no hay usuario en sesión -->
                <jsp:forward page="login.jsp">
                    <jsp:param name="error" value="Debe registrarse en el sistema."/>
                </jsp:forward>
        <%
            } else {
                // Recupera el usuario y el perfil
                usuario = (String) sesion.getAttribute("usuario");
                int perfil = (Integer) sesion.getAttribute("perfil");

                // Muestra el menú según el perfil del usuario
                Pagina pag = new Pagina();
                String menu = pag.mostrarMenu(perfil);
                out.print(menu);
            }
        %>
    </nav>

    <!-- Mensaje de confirmación -->
    <div class="agrupar">
        <section>
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-6">
                        <div class="card text-center border-success">
                            <div class="card-header bg-success text-white">
                                <h2 class="h4 mb-0"><i class="bi bi-check-circle-fill"></i> ¡Producto agregado al carrito!</h2>
                            </div>

                            <div class="card-body">
                                <div class="alert alert-success" role="alert">
                                    <p class="mb-0">
                                        Has agregado <strong><%= cantidad %></strong> unidad(es) de
                                        <strong>"<%= nombreProducto %>"</strong> a tu carrito.
                                    </p>
                                </div>

                                <!-- Botones para seguir comprando o ver el carrito -->
                                <div class="d-flex justify-content-center gap-3 mt-4">
                                    <a href="carrito.jsp" class="btn btn-outline-primary">
                                        <i class="bi bi-arrow-left"></i> Seguir comprando
                                    </a>
                                    <a href="carritoResumen.jsp" class="btn btn-primary">
                                        <i class="bi bi-cart-check"></i> Ver carrito
                                    </a>
                                </div>
                            </div>

                            <div class="card-footer text-muted">
                                <small>¿Necesitas ayuda? <a href="#">Contáctanos</a></small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <footer>
        <ul>
            <h1>Gracias por comprar en S&S</h1>
        </ul>
    </footer>
</main>
</body>
</html>

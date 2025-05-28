<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.productos.negocio.*" %>
<%@ page import="java.util.List, java.util.ArrayList, java.sql.ResultSet, com.productos.datos.Conexion, com.productos.seguridad.*, java.net.URLDecoder" %>

<%
    Producto producto = new Producto();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Categorías - Soccer Shoes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">	
    <link href="css/estilo.css" rel="stylesheet" type="text/css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        header {
            background: #0d6efd;
            color: white;
            padding: 1rem 0;
            text-align: center;
        }
        footer {
            background: #343a40;
            color: white;
            text-align: center;
            padding: 1rem;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
<main>
    <header>
        <h1 class="mb-0">Soccer Shoes</h1>
        <p class="lead mb-0">Zapatos para deportistas</p>
    </header>

    <nav>
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
                usuario = (String) sesion.getAttribute("usuario");
                int perfil = (Integer) sesion.getAttribute("perfil");
                Pagina pag = new Pagina();
                out.print(pag.mostrarMenu(perfil));
            }
        %>
    </nav>

    <div class="container my-5">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h4 class="mb-0">Nuestros Productos</h4>
                <a href="carritoResumen.jsp" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-cart"></i> Ver Carrito (<%= session.getAttribute("carrito") != null ? ((Carrito)session.getAttribute("carrito")).getItems().size() : 0 %>)
                </a>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle">
                        <thead class="table-dark text-center">
                            <tr>
                                <th>Imagen</th>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Precio</th>
                                <th>Disponibles</th>
                                <th>Cantidad</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            String sql = "SELECT * FROM tb_productos ORDER BY id_pr ASC";
                            Conexion con = new Conexion();
                            ResultSet rs = con.Consulta(sql);

                            while(rs.next()) {
                                int id = rs.getInt("id_pr");
                                String nombre = rs.getString("nombre_pr");
                                int cantidad = rs.getInt("cantidad_pr");
                                double precio = rs.getDouble("precio_pr");
                                String foto = rs.getString("foto_pr");
                                String decodedFoto = URLDecoder.decode(foto.replace("\"", " "), "UTF-8");
                                String rutaImagen = decodedFoto;
                                String imgTag = "<img src='" + rutaImagen + "' alt='" + nombre.replace("'", "%20") + "' " +
                                               "class='img-thumbnail border border-2 border-primary' " +
                                               "style='width:100px;height:100px;object-fit:contain;' " +
                                               "onerror=\"this.onerror=null;this.src='../images/productos/default.jpg';\">";
                        %>
                            <tr class="text-center">
                                <td><%= imgTag %></td>
                                <td><%= id %></td>
                                <td><%= nombre %></td>
                                <td>$<%= String.format("%.2f", precio) %></td>
                                <td><%= cantidad %></td>
                                <td>
                                    <form action="agregarCarrito.jsp" method="post" class="d-flex justify-content-center align-items-center gap-2" id="form-<%= id %>">
                                        <input type="hidden" name="id" value="<%= id %>">
                                        <input type="hidden" name="nombre" value="<%= nombre %>">
                                        <input type="hidden" name="precio" value="<%= precio %>">
                                        <input type="hidden" name="foto" value="<%= foto %>">
                                        <input type="number" name="cantidad" class="form-control form-control-sm text-center" min="1" max="<%= cantidad %>" value="1" style="width: 70px;">
                                </td>
                                <td>
                                        <button type="submit" class="btn btn-success btn-sm">
                                            <i class="bi bi-cart-plus"></i> Agregar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <%
                            }
                            rs.close();
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <h5 class="mb-0">Gracias por comprar en <strong>S&S</strong></h5>
    </footer>
</main>

<script>
    // Asegurar que cada formulario tenga ID único
    document.querySelectorAll('form').forEach(form => {
        if (!form.id) {
            form.id = 'form-' + form.querySelector('input[name="id"]').value;
        }
    });
</script>
</body>
</html>

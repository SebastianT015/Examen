<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.productos.seguridad.*" import ="java.util.*"%>
<%
    

    // Procesar acciones
    String accion = request.getParameter("accion");
    if(accion != null) {
        switch(accion) {
            case "cambiarEstado":
                int idUsuario = Integer.parseInt(request.getParameter("id"));
                boolean nuevoEstado = request.getParameter("estado").equals("activar");
                usuarios.cambiarEstadoUsuario(idUsuario, nuevoEstado);
                break;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Soccer Shoes - Gestión de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="css/estilo.css" rel="stylesheet" type="text/css">
   
</head>
<body class="bg-light">
    <div class="container-fluid p-0">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <i class="bi bi-tsunami"></i> Soccer Shoes
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <%
                        String usuario;
                        HttpSession sesion = request.getSession();
                        if (sesion.getAttribute("usuario") == null) {
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
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="container py-4">
            <div class="row mb-4">
                <div class="col-12">
                    <h2 class="page-title">Gestión de Usuarios</h2>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center py-3">
                            <h5 class="mb-0"><i class="bi bi-people-fill me-2"></i>Lista de Usuarios</h5>
                            <a href="nuevoUsuario.jsp" class="btn btn-primary btn-sm">
                                <i class="bi bi-plus-circle me-1"></i> Nuevo Usuario
                            </a>
                        </div>
                        
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="text-nowrap">ID</th>
                                            <th>Nombre</th>
                                            <th>Cédula</th>
                                            <th>Correo</th>
                                            <th>Perfil</th>
                                            <th>Estado</th>
                                            <th class="text-end">Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                        List<usuarios> us = usuarios.obtenerTodosUsuarios();
                                        for(usuarios usuarios : us) {
                                        %>
                                        <tr>
                                            <td class="fw-semibold"><%= usuarios.getId() %></td>
                                            <td><%= usuarios.getNombre() %></td>
                                            <td><%= usuarios.getCedula() %></td>
                                            <td><%= usuarios.getCorreo() %></td>
                                            <td>
                                                <span class="badge 
                                                    <% switch(usuarios.getPerfil()) {
                                                        case 1: out.print("bg-danger"); break;
                                                        case 2: out.print("bg-success"); break;
                                                        case 3: out.print("bg-warning text-dark"); break;
                                                        default: out.print("bg-secondary");
                                                    } %>">
                                                    <% 
                                                        switch(usuarios.getPerfil()) {
                                                            case 1: out.print("Admin"); break;
                                                            case 2: out.print("Cliente"); break;
                                                            case 3: out.print("Empleado"); break;
                                                            default: out.print("Desconocido");
                                                        }
                                                    %>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge rounded-pill <%= usuarios.isActivo() ? "bg-success" : "bg-secondary" %>">
                                                    <%= usuarios.isActivo() ? "Activo" : "Inactivo" %>
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <div class="d-flex justify-content-end gap-2">
                                                    <% if(usuarios.isActivo()) { %>
                                                        <a href="gestionUsuario.jsp?accion=cambiarEstado&id=<%= usuarios.getId() %>&estado=bloquear" 
                                                           class="btn btn-sm btn-outline-danger btn-action" title="Bloquear">
                                                            <i class="bi bi-lock"></i>
                                                        </a>
                                                    <% } else { %>
                                                        <a href="gestionUsuario.jsp?accion=cambiarEstado&id=<%= usuarios.getId() %>&estado=activar" 
                                                           class="btn btn-sm btn-outline-success btn-action" title="Activar">
                                                            <i class="bi bi-unlock"></i>
                                                        </a>
                                                    <% } %>
                                                    <a href="editarUsuario.jsp?id=<%= usuarios.getId() %>" 
                                                       class="btn btn-sm btn-outline-primary btn-action" title="Editar">
                                                        <i class="bi bi-pencil-square"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class="d-flex justify-content-between mt-4">
                                <a href="menu.jsp" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-1"></i> Volver al Menú
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer class="bg-dark text-white py-4 mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-12 text-center">
                        <h5 class="mb-3"><i class="bi bi-heart-fill text-danger"></i> Gracias por usar Soccer Shoes</h5>
                        <p class="mb-0 small">© 2023 Soccer Shoes. Todos los derechos reservados.</p>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
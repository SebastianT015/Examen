<%@page import="com.productos.seguridad.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Procesar nuevo usuario
    if(request.getParameter("guardar") != null) {
    	usuarios nuevoUsuario = new usuarios();
        nuevoUsuario.setNombre(request.getParameter("nombre"));
        nuevoUsuario.setCedula(request.getParameter("cedula"));
        nuevoUsuario.setCorreo(request.getParameter("correo"));
        nuevoUsuario.setClave(request.getParameter("clave"));
        nuevoUsuario.setPerfil(Integer.parseInt(request.getParameter("perfil")));
        nuevoUsuario.setEstadoCivil(Integer.parseInt(request.getParameter("estadoCivil")));
        nuevoUsuario.setActivo(true); // Asumimos que el usuario está activo al crearlo
        if(nuevoUsuario.ingresarEmpleado(
            nuevoUsuario.getPerfil(),
            nuevoUsuario.getEstadoCivil(),
            nuevoUsuario.getCedula(),
            nuevoUsuario.getNombre(),
            nuevoUsuario.getCorreo(),
            nuevoUsuario.isActivo())) {
            
            response.sendRedirect("usuarios.jsp?mensaje=Usuario+creado+exitosamente");
            return;
        } else {
            out.print("<div class='alert alert-danger'>Error al crear usuario</div>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Soccer Shoes - Nuevo Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="css/estiloAdmin.css" rel="stylesheet" type="text/css">
</head>
<body class="bg-light">
    <div class="container-fluid p-0">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <i class="bi bi-tsunami"></i> Soccer Shoes
                </a>
                <span class="navbar-text">Zapatos para deportistas</span>
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
                    <h2 class="border-bottom pb-2">Agregar Nuevo Usuario</h2>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0"><i class="bi bi-person-plus"></i> Registro de Usuario</h4>
                        </div>
                        
                        <div class="card-body">
                            <form method="post" action="guardarUsuario.jsp">
                                <input type="hidden" name="guardar" value="true">
                                
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="nombre" class="form-label">Nombre:</label>
                                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="cedula" class="form-label">Cédula:</label>
                                        <input type="text" class="form-control" id="cedula" name="cedula" required>
                                    </div>
                                    
                                    <div class="col-12">
                                        <label for="correo" class="form-label">Correo electrónico:</label>
                                        <input type="email" class="form-control" id="correo" name="correo" required>
                                    </div>
                                    
                                    <div class="col-12">
                                        <label for="clave" class="form-label">Contraseña:</label>
                                        <input type="password" class="form-control" id="clave" name="clave" required>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="perfil" class="form-label">Perfil:</label>
                                        <select class="form-select" id="perfil" name="perfil">
                                            <option value="1">Administrador</option>
                                            <option value="2" selected>Cliente</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="estadoCivil" class="form-label">Estado Civil:</label>
                                        <select class="form-select" id="estadoCivil" name="estadoCivil" required>
                                            <option value="1">Soltero/a</option>
                                            <option value="2">Casado/a</option>
                                            <option value="3">Divorciado/a</option>
                                            <option value="4">Viudo/a</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-12 mt-4">
                                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                            <a href="usuarios.jsp" class="btn btn-outline-secondary me-md-2">
                                                <i class="bi bi-x-circle"></i> Cancelar
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-save"></i> Guardar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer class="bg-dark text-white py-3 mt-5">
            <div class="container">
                <div class="text-center">
                    <h5 class="mb-3">Gracias por usar S&S</h5>
                </div>
            </div>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
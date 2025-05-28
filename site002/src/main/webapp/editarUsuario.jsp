<%@page import="com.productos.seguridad.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Obtener usuario a editar
    int idUsuario = Integer.parseInt(request.getParameter("id"));
    usuarios usuarioEditar = null;
    List<usuarios> us = usuarios.obtenerTodosUsuarios();
    
    for(usuarios u : us) {
        if(u.getId() == idUsuario) {
            usuarioEditar = u;
            break;
        }
    }
    
    if(usuarioEditar == null) {
        response.sendRedirect("gestionUsuario.jsp?mensaje=Usuario+no+encontrado");
        return;
    }
    
    // Procesar actualización
    if(request.getParameter("actualizar") != null) {
        usuarioEditar.setNombre(request.getParameter("nombre"));
        usuarioEditar.setCedula(request.getParameter("cedula"));
        usuarioEditar.setCorreo(request.getParameter("correo"));
        usuarioEditar.setPerfil(Integer.parseInt(request.getParameter("perfil")));
        usuarioEditar.setEstadoCivil(Integer.parseInt(request.getParameter("estadoCivil")));
        
        if(usuarios.actualizarUsuario(usuarioEditar)) {
            response.sendRedirect("gestionUsuario.jsp?mensaje=Usuario+actualizado");
            return;
        } else {
            out.print("<p style='color:red;'>Error al actualizar usuario</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Activo Sportwear</title>
    <link href="css/estiloAdmin.css" rel="stylesheet" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body>
    <main>
        <header>
            <h1>Soccer Shoes</h1>
            <h2 class="destacado">Zapatos para deportistas</h2>
        </header>
        
        <nav>
            <a href="../index.jsp">Home</a>
            <a href="../consulta.jsp">Ver Productos</a>
            <a href="../categoria.jsp">Buscar Por Categoría</a>
        </nav>
        
        <div class="agrupar">
            <section> 
			    <div class="container mt-4">
				    <div class="row justify-content-center">
				        <div class="col-md-8 col-lg-6">
				            <div class="card shadow">
				                <div class="card-header bg-primary text-white">
				                    <h1 class="h4 mb-0">Editar Usuario</h1>
				                </div>
				                
				                <div class="card-body">
				                    <form method="post">
				                        <input type="hidden" name="actualizar" value="true">
				                        
				                        <div class="mb-3">
				                            <label for="nombre" class="form-label">Nombre:</label>
				                            <input type="text" class="form-control" id="nombre" name="nombre" 
				                                   value="<%= usuarioEditar.getNombre() %>" required>
				                        </div>
				                        
				                        <div class="mb-3">
				                            <label for="cedula" class="form-label">Cédula:</label>
				                            <input type="text" class="form-control" id="cedula" name="cedula" 
				                                   value="<%= usuarioEditar.getCedula() %>" required>
				                        </div>
				                        
				                        <div class="mb-3">
				                            <label for="correo" class="form-label">Correo:</label>
				                            <input type="email" class="form-control" id="correo" name="correo" 
				                                   value="<%= usuarioEditar.getCorreo() %>" required>
				                        </div>
				                        
				                        <div class="mb-3">
				                            <label for="perfil" class="form-label">Perfil:</label>
				                            <select class="form-select" id="perfil" name="perfil">
				                                <option value="1" <%= usuarioEditar.getPerfil() == 1 ? "selected" : "" %>>Administrador</option>
				                                <option value="2" <%= usuarioEditar.getPerfil() == 2 ? "selected" : "" %>>Cliente</option>
				                            </select>
				                        </div>
				                        
				                        <div class="mb-3">
				                            <label for="estadoCivil" class="form-label">Estado Civil:</label>
				                            <select class="form-select" id="estadoCivil" name="estadoCivil" required>
				                                <option value="1" <%= usuarioEditar.getEstadoCivil() == 1 ? "selected" : "" %>>Casado/a</option>
				                                <option value="2" <%= usuarioEditar.getEstadoCivil() == 2 ? "selected" : "" %>>Soltero/a</option>
				                                <option value="3" <%= usuarioEditar.getEstadoCivil() == 3 ? "selected" : "" %>>Divorciado/a</option>
				                                <option value="4" <%= usuarioEditar.getEstadoCivil() == 4 ? "selected" : "" %>>Viudo/a</option>
				                            </select>
				                        </div>
				                        
				                        <div class="d-flex justify-content-between mt-4">
				                            <button type="submit" class="btn btn-primary">
				                                <i class="bi bi-save"></i> Guardar Cambios
				                            </button>
				                            <a href="usuarios.jsp" class="btn btn-outline-secondary">
				                                <i class="bi bi-x-circle"></i> Cancelar
				                            </a>
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
                <h1>S&S</h1>
            </ul>
        </footer>
    </main>
</body>
</html>l>
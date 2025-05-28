<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Soccer Shoes Login</title>
		<link href="css/estilo.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<main>
		     <header>
		       <h1>Soccer Shoes</h1>
		       <h2 class="destacado">Zapatos para deportistas</h2>
		       <h4 id="favorito">Carrera hacia tus sueños</h4>
		     </header>
		     <nav>
		      <a a href="index.jsp"><img src= "iconos/home.png" width = "60" height = "60" alt = "Pagina Principal"/>
		        </a>
		       <a href="consulta.jsp">Ver Productos</a>
		       <a href="categoria.jsp">Buscar Por Categoria</a>
		     </nav>
		     <div class="agrupar">
		       <section> 
		         <h2>Login del sistema</h2>
		         <form action ="validarLogin.jsp" method="post">
			          <table border="1">
						<tr> <td>Correo Electronico</td> <td><input type="email" id="email" name="usuario" placeholder="usuario@Proveedor.dominio" required />*</td> </tr>
						<tr> <td>Clave</td> <td> <input type="password" id="clave" name="clave" required/></td></tr>
						<tr> <td colspan="2">*Campo Obligatorio</td></tr>
						<tr><td colspan="2" style="text-align: center;"><input type ="submit" name="btnEnviar" id="btnEnviar" value="Ingresar"/></td> </tr>
			          </table>
          		</form>
          		<h4> Añadir Usuario</h4>
          		 <a href="registro.jsp"><img src= "iconos/adUsuario.png" width = "60" height = "60" alt = "Añadir Usuario"/>
				</a>   
		      </section>
		       
		   </div>
		   <footer>
		      <ul>
		         <h2>Gracias por visitar S&S</h2>
		     </ul>
		   </footer>
		</main>

	</body>
</html>
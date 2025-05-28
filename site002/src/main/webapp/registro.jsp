<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Registro de usuario</title>
		<link href="css/estilo.css" rel="stylesheet" type="text/css">
	</head>
	
	<body>	
		<header>
			<h1>Registro Nuevo Cliente</h1>
		</header>
		<nav> 
			<a href="login.jsp">Login</a>
		</nav>
		<section>
			<form action = "nuevoCliente.jsp" method = "post">
			    <table border = "1"> 
			    	<tr> <td>Nombre</td> <td> <input type = "text" name ="txtNombre" required/>*</td></tr>
			    	<tr> <td>Cedula</td> <td> <input type = "text" name ="txtCedula" maxlength="10" required/>*</td></tr>
			    	<tr> <td>Estado Civil</td> <td><select name="cmbECivil"> 
														<option value="2">Soltero</option>
														<option value="1">Casado</option>
														<option value="3">Divorciado</option>
														<option value="4">Viudo</option>
													</select></td></tr>
					<tr> <td>Lugar de residencia</td> <td> <input type="radio" name="rdResidencia" value="Sur"/>Sur  
															<input type="radio" name="rdResidencia" value="Norte"/>Norte
															<input type="radio" name="rdResidencia" value="Centro"/>Centro</td></tr>
					<tr> <td>Foto</td> <td><input type="file" name="fileFoto" accept=".jpg, .jpeg, .png"  /> </td></tr>
					<tr> <td>Mes y año de nacimiento</td> <td><input type="month" name="fecha"/></td></tr>
					<tr> <td>Color favorito</td> <td> <input type="color" id="color" name="cColor"/>*</td></tr>
					<tr> <td>Correo Electronico</td> <td><input type="email" id="email" name="txtEmail" placeholder="usuario@nombreProveedor.dominio" required />*</td> </tr>
					<tr> <td>Clave</td> <td> <input type="password" id="clave" name="txtClave" maxlength="8" required/></td></tr>
					<tr> <td colspan="2">*Campo Obligatorio</td></tr>
			    	<tr><td><input type = "submit" name = "btnEnviar" id = "btnEnviar" value = "Enviar registro"/></td> <td><input type = "reset"/></td></tr>
			    </table>
			</form>
		</section>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.productos.negocio.*" import = "com.productos.seguridad.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="css/estilo.css" rel="stylesheet" type="text/css">
		<title>Insert title here</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	</head>
	<body>
	
		<header>
			<h1>Consulta de productos</h1>
		</header>
		<nav>
			<%  
						Pagina pag=new Pagina(); 
						String menu=pag.mostrarMenu(3); 
						out.print(menu); 
					%> 
		</nav>
		 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
		<div class="agrupar">
			<section >
				<form action="ingresarProducto.jsp" method = "get">
					<div class="mb-3">
					  <label for="nombre" class="form-label">Nombre</label>
					  <input type="text" class="form-control" name="nombre" placeholder="Ingrese su nombre">
					</div>
					<div>
						<label for="Categoria" class="form-label" >Categoria</label>
						<select class="form-select" name="cmbCategoria">
						  <option selected>Seleccione una opción</option>
						  <option value="1">Pupos</option>
						  <option value="2">Micros</option>
						  <option value="3">Lisos</option>
						  <option value="4">Mixtos</option>
						</select>
					</div>
						
					<div class="mb-3">
					  <label for="Precio" class="form-label">Precio</label>
					  <input type="text" class="form-control" name="precio" placeholder="Precio">
					</div>
					<div class="mb-3">
					  <label for="cantidad" class="form-label">Cantidad</label>
					  <input type="text" class="form-control" name="cantidad" placeholder="Cantidad">
					</div>
					<div class="mb-3">
					  <label for="foto" class="form-label">Foto</label>
					  <input type="text" class="form-control" name="foto" placeholder="Ingrese la foto"> 
					</div>
					<button type="SUBMIT" class="btn btn-primary">Ingresar Producto</button>
					<button type="RESET" class="btn btn-secondary">Limpiar</button>		  
				</form>
				<div>
					<h2>Lista de productos</h2>
					<%
						Producto pr = new Producto();
						out.print(pr.reporteProducto());
					%>
				</div>
				
			</section>
		</div>
	</body>
</html>
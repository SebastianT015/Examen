<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.productos.negocio.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3> Ingreso de productos</h3>
				<%
				
				    String nombre = request.getParameter("nombre");
                    String categoria = request.getParameter("cmbCategoria");
                    int id_categoria = Integer.parseInt(categoria);
                    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
                    float precio = Float.parseFloat(request.getParameter("precio"));
                    String foto = request.getParameter("foto");
                    
                    Producto pr = new Producto ();
                    pr.setNombre(nombre);
                    pr.setId_cat(id_categoria);
                    pr.setCantidad(cantidad);
                    pr.setPrecio(precio);
                    out.println(pr.agregarProducto());
				
				%>
</body>
</html>
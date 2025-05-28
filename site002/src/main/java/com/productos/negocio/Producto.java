package com.productos.negocio;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.productos.datos.Conexion;


public class Producto {
	private int id;
	private int idcat;
	private String nombre;
	private int cantidad;
	private float precio;
	private String directorio;
	
	
	public int getIdcat() {
		return idcat;
	}

	public void setIdcat(int id_cat) {
		this.idcat = id_cat;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public float getPrecio() {
		return precio;
	}

	public void setPrecio(float precio) {
		this.precio = precio;
	}

	public String getDirectorio() {
		return directorio;
	}

	public void setDirectorio(String directorio) {
		this.directorio = directorio;
	}
	
	public Producto() {
		//TODO Auto-generated constructor stub
	}
	
	public String consultarTodo(){
		String sql="SELECT * FROM tb_productos ORDER BY id_pr"; 
		Conexion con=new Conexion(); 
		String tabla="<table border=2><th>ID</th><th>Producto</th><th>Cantidad</th><th>Precio</th>";
		ResultSet rs=null; 
		rs=con.Consulta(sql); 
		try { 
			while(rs.next()) { 
				tabla+="<tr><td>"+rs.getInt(1)+"</td>" 
						+ "<td>"+rs.getString(3)+"</td>" 
						+ "<td>"+rs.getInt(4)+"</td>" 
						+ "<td>"+rs.getDouble(5)+"</td>" 
						+ "</td></tr>"; 
			} 
		} catch (SQLException e) { 
			// TODO Auto-generated catch block 
			e.printStackTrace(); 
			System.out.print(e.getMessage()); 
		} 
		tabla+="</table>"; 
		return tabla; 
	}
	public String buscarProductoCategoria(int cat){
		String sentencia="SELECT nombre_pr, precio_pr FROM tb_productos WHERE id_cat="+cat;
		Conexion con=new Conexion();
		ResultSet rs=null;
		String resultado="<table border=3>";
		try
		{
		rs=con.Consulta(sentencia);
		while(rs.next())
		{
		resultado+="<tr><td>"+ rs.getString(1)+"</td>"
		 + "<td>"+rs.getDouble(2)+"</td></tr>";
		}
		resultado+="</table>";
		}
		catch(SQLException e)
		{
		System.out.print(e.getMessage());
		}
		System.out.print(resultado);
		return resultado;
	}
	
	public String reporteProducto() {
	    String sql = "SELECT pr.id_pr, pr.nombre_pr, cat.descripcion_cat, pr.cantidad_pr, pr.precio_pr " + 
	                 "FROM tb_productos pr, tb_categoria cat WHERE pr.id_cat = cat.id_cat";
	    Conexion con = new Conexion();
	    ResultSet rs = null;
	    rs = con.Consulta(sql);
	    String tabla = "<table class='table'><thead><tr>"
	                    + "<th scope='col'>Id</th>"
	                    + "<th scope='col'>Descripcion</th>"
	                    + "<th scope='col'>Categoria</th>"
	                    + "<th scope='col'>Cantidad</th>"
	                    + "<th scope='col'>Precio</th>"
	                    + "<th scope='col'>Modificar</th>"
	                    + "<th scope='col'>Eliminar</th>"
	                    + "</tr>"
	                    + "</thead>"
	                    + "<tbody>";

	    try {
	        while(rs.next()) {
	            tabla += "<tr>"
	            + "<th scope='row'>" + rs.getInt(1) + "</th>"
	            + "<td>" + rs.getString(2) + "</td>"
	            + "<td>" + rs.getString(3) + "</td>"
	            + "<td>" + rs.getInt(4) + "</td>"
	            + "<td>" + rs.getDouble(5) + "</td>"
	            + "<td><a href='actualizar.jsp?id=" + rs.getInt(1) + "'>"
	                + "Actualizar</a></td>"
	            + "<td><a href='eliminar.jsp?id=" + rs.getInt(1) + "'>"
	                + "Eliminar</a></td>"
	            + "</tr>";
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.print(e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            // Aquí deberías cerrar también la conexión si es posible
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    tabla += "</tbody></table>";
	    return tabla;
	}
	public String reporteBitacora() {
	    String sql = "SELECT id_aud, tabla_aud,operacion_aud , valoranterior_aud, " +
	                 "valornuevo_aud, fecha_aud, usuario_aud FROM auditoria.tb_auditoria ORDER BY fecha_aud DESC";
	    
	    Conexion con = new Conexion();
	    ResultSet rs = null;
	    rs = con.Consulta(sql);
	    
	    String tabla = "<table class='table'><thead><tr>"
	                 + "<th scope='col'>Id</th>"
	                 + "<th scope='col'>Tabla</th>"
	                 + "<th scope='col'>Operación</th>"
	                 + "<th scope='col'>Datos Anteriores</th>"
	                 + "<th scope='col'>Datos Nuevos</th>"
	                 + "<th scope='col'>Fecha</th>"
	                 + "<th scope='col'>Usuario</th>"
	                 + "</tr></thead><tbody>";

	    try {
	        while(rs.next()) {
	        	tabla += "<tr>"
	                    + "<td>" + rs.getInt("id_aud") + "</td>"
	                    + "<td>" + rs.getString("tabla_aud") + "</td>"
	                    + "<td>" + rs.getString("operacion_aud") + "</td>"
	                    + "<td>" + (rs.getString("valoranterior_aud") != null ? rs.getString("valoranterior_aud") : "-") + "</td>"
	                    + "<td>" + (rs.getString("valornuevo_aud") != null ? rs.getString("valornuevo_aud") : "-") + "</td>"
	                    + "<td>" + rs.getTimestamp("fecha_aud") + "</td>"
	                    + "<td>" + rs.getString("usuario_aud") + "</td>"
	                    + "</tr>";
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.print(e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            // Cerrar la conexión si es necesario
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    tabla += "</tbody></table>";
	    return tabla;
	}
	 public String agregarProducto ()
	    {
	    	String sqlSetVal = "SELECT setval(pg_get_serial_sequence('tb_productos', 'id_pr'), (SELECT MAX(id_pr) FROM tb_productos))";

	    	try (Connection con = new Conexion().getConexion();
	    	     PreparedStatement ps = con.prepareStatement(sqlSetVal)) {
	    	    ps.execute();
	    	} catch (SQLException e) {
	    	    e.printStackTrace();
	    	}

	    	String result = "";
	    	Conexion con = new Conexion ();
	    	PreparedStatement pr = null;
	    	String sql = "INSERT INTO tb_productos (id_cat, nombre_pr, cantidad_pr, precio_pr)\n"
	    			+ "VALUES (?, ?, ?, ?);";
	    	try
	    	{
	    		pr = con.getConexion().prepareStatement(sql);
	    		pr.setInt(1, this.getIdcat());
	    		pr.setString(2, this.getNombre());
	    		pr.setInt(3, this.getCantidad());
	    		pr.setDouble(4, this.getPrecio());
	    		
	    		if (pr.executeUpdate() == 1)
	    		{
	    			result = "Inserción Correcta";
	    		}
	    		else
	    		{
	    			result = "Error en la inserción";
	    		}
	    	} catch (Exception ex) {
		        result = ex.getMessage();
		        System.out.print(result);
		    } finally {
		        try {
		            pr.close();
		            con.getConexion().close();
		        } catch (Exception ex) {
		            System.out.print(ex.getMessage());
		        }
		    }
		    return result;
	    }
	 public String actualizarProducto(int id, String nombre, int idCategoria, int cantidad, double precio) {
	        String sql = "UPDATE tb_productos SET "
	                   + "nombre_pr = '" + nombre + "', "
	                   + "id_cat = " + idCategoria + ", "
	                   + "cantidad_pr = " + cantidad + ", "
	                   + "precio_pr = " + precio + " "
	                   + "WHERE id_pr = " + id;
	        Conexion con = new Conexion();
	        return con.Ejecutar(sql);
	    }
	    public Object[] obtenerProductoCompletoPorId(int id) {
	        String sql = "SELECT nombre_pr, id_cat, cantidad_pr, precio_pr FROM tb_productos WHERE id_pr = " + id;
	        Conexion con = new Conexion();
	        ResultSet rs = con.Consulta(sql);
	        try {
	            if (rs.next()) {
	                return new Object[]{
	                    rs.getString("nombre_pr"),
	                    rs.getInt("id_cat"),
	                    rs.getInt("cantidad_pr"),
	                    rs.getDouble("precio_pr")
	                };
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return null;
	    }
	    public String eliminarProductoPorId(int id) {
	        String sql = "DELETE FROM tb_productos WHERE id_pr = " + id;
	        Conexion con = new Conexion();
	        return con.Ejecutar(sql);
	    }

	    public Object[] obtenerProductoPorId(int id) {
	        String sql = "SELECT pr.nombre_pr, cat.descripcion_cat " +
	                     "FROM tb_productos pr, tb_categoria cat " +
	                     "WHERE pr.id_cat = cat.id_cat AND pr.id_pr = " + id;
	        Conexion con = new Conexion();
	        ResultSet rs = con.Consulta(sql);
	        try {
	            if (rs.next()) {
	                return new Object[]{ rs.getString(1), rs.getString(2) };
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return null;
	    }
	 
	    public Producto obtenerProducto(int id) {
	        String sql = "SELECT * FROM tb_productos WHERE id_pr = " + id;
	        Conexion con = new Conexion();
	        ResultSet rs = con.Consulta(sql);
	        try {
	            if (rs.next()) {
	                Producto producto = new Producto();
	                producto.setId(rs.getInt("id_pr"));
	                producto.setIdcat(rs.getInt("id_cat"));
	                producto.setNombre(rs.getString("nombre_pr"));
	                producto.setCantidad(rs.getInt("cantidad_pr"));
	                producto.setPrecio(rs.getFloat("precio_pr"));
	                return producto;
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return null;
	    }
	    // Método para actualizar el stock después de una compra
	    public boolean actualizarStock(int idProducto, int cantidadVendida) {
	        String sql = "UPDATE tb_productos SET cantidad_pr = cantidad_pr - " + cantidadVendida + 
	                    " WHERE id_pr = " + idProducto;
	        Conexion con = new Conexion();
	        String resultado = con.Ejecutar(sql);
	        return resultado.equals("Ok");
	    }
	    
}

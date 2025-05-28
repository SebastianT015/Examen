package com.productos.negocio;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.productos.datos.Conexion;

public class Categoria {
	
	
	
	public Categoria() {
		// TODO Auto-generated constructor stub
	}
	
	public String mostrarCategoria(){ 
		String combo="<select class= form-select name=cmbCategoria>"; 
		String sql="SELECT * FROM tb_categoria";
		ResultSet rs=null; 
		Conexion con=new Conexion(); 
		try { 
			rs=con.Consulta(sql); 
			while(rs.next()) 
		{ 
		combo+="<option value="+rs.getInt(1)+ ">"+rs.getString(2)+"</option>"; 
		} 
		combo+="</select>"; 
		} 
		catch(SQLException e){ 
		System.out.print(e.getMessage()); 
		} 
		return combo; 
		}
	public String mostrarCategoria(int idCatActual) { 
	    String combo = "<select class='form-select' name='cmbCategoria'>"; 
	    String sql = "SELECT * FROM tb_categoria";
	    ResultSet rs = null; 
	    Conexion con = new Conexion(); 
	    try { 
	        rs = con.Consulta(sql); 
	        while(rs.next()) { 
	            int idCat = rs.getInt(1);
	            String selected = (idCat == idCatActual) ? "selected" : "";
	            combo += "<option value='" + idCat + "' " + selected + ">" + rs.getString(2) + "</option>"; 
	        } 
	        combo += "</select>"; 
	    } 
	    catch(SQLException e) { 
	        System.out.print(e.getMessage()); 
	    } 
	    return combo; 
	}
	
	public String nombreCat(int id_cat) {
	    String result = "";
	    String sql = "SELECT descripcion_cat FROM tb_categoria WHERE id_categoria=?";
	    Conexion con = new Conexion();
	    try {
	        PreparedStatement ps = con.getConexion().prepareStatement(sql);
	        ps.setInt(1, id_cat);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            result = rs.getString("descripcion_cat");
	        } else {
	            result = "Categoría no encontrada";
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        result = "Error en la búsqueda";
	    }
	    return result;
	}
	
}

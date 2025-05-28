package com.productos.seguridad;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.productos.datos.Conexion;

public class Pagina {
	
	private int id;
	private String nombre;
	private String path;
	public Pagina() {
		// TODO Auto-generated constructor stub
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
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String mostrarMenu(Integer nperfil){ 
		String menu=""; 
		String sql="SELECT * FROM tb_pagina pag, tb_perfil per, " 
		+ "tb_perfilpagina pper " + 
		"WHERE pag.id_pag=pper.id_pag AND pper.id_per=per.id_per " 
		+ "AND pper.id_per= "+nperfil;  
		Conexion con = new Conexion(); 
		ResultSet rs=null; 
		try { 
			rs=con.Consulta(sql); 
			while(rs.next()) { 
				menu+="<a href="+rs.getString(3)+"accesskey="+rs.getInt(1)+">"+rs.getString(2)+"</a>";
			}  	 
		}catch(SQLException e){ 
			System.out.print(e.getMessage()); 
		}  
		return menu; 
	 }
}

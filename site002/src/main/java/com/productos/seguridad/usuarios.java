package com.productos.seguridad;

import java.sql.*;
import java.util.*;

import com.productos.datos.Conexion;


public class usuarios {
	private int id;
	private int perfil;
	private int estadoCivil;
	private String cedula;
	private String nombre;
	private String correo;
	private String Clave;
	private boolean activo;
	public usuarios() {
		// TODO Auto-generated constructor stub
	
	}
	
	public usuarios(int nperfiles, String nnombre, String ncedula, int nestado, String ncorreo, String nclave) {
		// TODO Auto-generated constructor stub
		this.nombre = nnombre;
		this.cedula = ncedula;
		this.estadoCivil = nestado;
		this.correo = ncorreo;
		this.Clave = nclave;
		this.perfil = nperfiles;
	}
	public usuarios(int nperfiles, String nnombre, String ncedula, int nestado, String ncorreo) {
		// TODO Auto-generated constructor stub
		this.nombre = nnombre;
		this.cedula = ncedula;
		this.estadoCivil = nestado;
		this.correo = ncorreo;
		this.perfil = nperfiles;
	}
	public boolean isActivo() {
		return activo;
	}
	public void setActivo(boolean estado) {
		this.activo = estado;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPerfil() {
		return perfil;
	}
	public void setPerfil(int perfil) {
		this.perfil = perfil;
	}
	public int getEstadoCivil() {
		return estadoCivil;
	}
	public void setEstadoCivil(int estadoCivil) {
		this.estadoCivil = estadoCivil;
	}
	public String getCedula() {
		return cedula;
	}
	public void setCedula(String cedula) {
		this.cedula = cedula;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getCorreo() {
		return correo;
	}
	public void setCorreo(String correo) {
		this.correo = correo;
	}
	public String getClave() {
		return Clave;
	}
	public void setClave(String clave) {
		Clave = clave;
	}
	public boolean verificarUsuario(String ncorreo, String nclave){ 
		boolean respuesta=false; 
		String sentencia= "Select * from tb_usuario where correo_us='"+ncorreo+ 
		"' and clave_us='"+nclave+"';"; 
		//System.out.print(sentencia); 
		try { 
			ResultSet rs; 
			Conexion clsCon=new Conexion(); 
			rs=clsCon.Consulta(sentencia); 
			if(rs.next()){  
				respuesta=true; 
				this.setCorreo(ncorreo); 
				this.setClave(nclave); 
				this.setPerfil(rs.getInt(2));  		 
				this.setNombre(rs.getString(4)); 
			}else{ 
				respuesta=false; 
				rs.close(); 
			} 
		}catch(Exception ex){ 
			System.out.println( ex.getMessage()); 
		} 
		return respuesta; 
	}
	public String ingresarCliente(){
		String result="";
		Conexion con=new Conexion();
		PreparedStatement pr=null;
		String sql="INSERT INTO tb_usuario (id_per, id_est, nombre_us, cedula_us, correo_us, clave_us, activo_us) "
				+ "VALUES(?,?,?,?,?,?,?)";
		try{
			pr=con.getConexion().prepareStatement(sql);
			pr.setInt(1,2);
			pr.setInt(2, this.getEstadoCivil());
			pr.setString(3, this.getNombre());
			pr.setString(4, this.getCedula());
			pr.setString(5, this.getCorreo());
			pr.setString(6, this.getClave());
			pr.setBoolean(7, true);
			if(pr.executeUpdate()==1){
				result="Insercion correcta";
			}
			else
			{
				result="Error en insercion";
			}
		}catch(Exception ex){
			result=ex.getMessage();
			System.out.print(result);
		}
		finally{
			try{
			 pr.close();
			 con.getConexion().close();
			}catch(Exception ex){
			 System.out.print(ex.getMessage());
			}
		}
		return result;
	}
	public Boolean ingresarEmpleado(Integer nperfil, int nestado, String ncedula, String nnombre, String ncorreo, boolean activo) {
		String result="";
		Boolean respuesta=false;
		Conexion con=new Conexion();
		PreparedStatement pr=null;
		String sql="INSERT INTO tb_usuario (id_per, id_est, nombre_us, cedula_us, correo_us, clave_us, activo_us) "
				+ "VALUES(?,?,?,?,?,?,?)";
		try{
			pr=con.getConexion().prepareStatement(sql);
			pr.setInt(1,nperfil);
			pr.setInt(2, nestado);
			pr.setString(3, nnombre);
			pr.setString(4, ncedula);
			pr.setString(5, ncorreo);
			pr.setString(6, this.getClave());
			pr.setBoolean(7, activo);
			if(pr.executeUpdate()==1){
				System.out.println("Insercion correcta");
				respuesta=true;
			}else{
				System.out.println("Error en insercion");
				respuesta=false;
			}
		}catch(Exception ex){
			result=ex.getMessage();
			System.out.print(result);
		}finally{
			try{
				pr.close();
			 	con.getConexion().close();
			}catch(Exception ex){
				System.out.print(ex.getMessage());
			}
		}
		return respuesta;
	}
	public boolean verificarClave(String aClave) {
		boolean flag= false;
		return flag;
		
	}
	public static List<usuarios> obtenerTodosUsuarios() {
	    List<usuarios> usuarios = new ArrayList<>();
	    String sql = "SELECT * FROM tb_usuario";
	    
	    try (Connection conn = Conexion.getCon();
	         Statement stmt = conn.createStatement();
	         ResultSet rs = stmt.executeQuery(sql)) {
	        
	        while(rs.next()) {
	        	usuarios usuario = new usuarios();
	            usuario.setId(rs.getInt("id_us"));
	            usuario.setPerfil(rs.getInt("id_per"));
	            usuario.setEstadoCivil(rs.getInt("id_est"));
	            usuario.setCedula(rs.getString("cedula_us"));
	            usuario.setNombre(rs.getString("nombre_us"));
	            usuario.setCorreo(rs.getString("correo_us"));
	            usuario.setActivo(rs.getBoolean("activo_us")); // Asume que el campo se llama "activo"
	            usuarios.add(usuario);
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return usuarios;
	}
	public static boolean cambiarEstadoUsuario(int idUsuario, boolean activo) {
	    String sql = "UPDATE tb_usuario SET activo_us = ? WHERE id_us = ?";
	    
	    try (Connection conn = Conexion.getCon();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setBoolean(1, activo);
	        pstmt.setInt(2, idUsuario);
	        
	        return pstmt.executeUpdate() > 0;
	    } catch(Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	// Método para actualizar la información de un usuario
	public static boolean actualizarUsuario(usuarios usuario) {
	    String sql = "UPDATE tb_usuario SET id_per = ?, id_est = ?, nombre_us = ?, " +
	                 "cedula_us = ?, correo_us = ? WHERE id_us = ?";
	    
	    try (Connection conn = Conexion.getCon();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setInt(1, usuario.getPerfil());
	        pstmt.setInt(2, usuario.getEstadoCivil());
	        pstmt.setString(3, usuario.getNombre());
	        pstmt.setString(4, usuario.getCedula());
	        pstmt.setString(5, usuario.getCorreo());
	        pstmt.setInt(6, usuario.getId());
	        
	        return pstmt.executeUpdate() > 0;
	    } catch(Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public usuarios buscarUsuarioPorCorreo(String correo) {
		usuarios usuario = null;
	    String sql = "SELECT * FROM tb_usuario WHERE correo_us = ?";
	    
	    try (Connection conn = Conexion.getCon();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setString(1, correo);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if(rs.next()) {
	                usuario = new usuarios();
	                usuario.setId(rs.getInt("id_us"));
	                usuario.setPerfil(rs.getInt("id_per"));
	                usuario.setEstadoCivil(rs.getInt("id_est"));
	                usuario.setCedula(rs.getString("cedula_us"));
	                usuario.setNombre(rs.getString("nombre_us"));
	                usuario.setCorreo(rs.getString("correo_us"));
	                usuario.setActivo(rs.getBoolean("activo_us"));
	            }
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return usuario;
	}
	
}


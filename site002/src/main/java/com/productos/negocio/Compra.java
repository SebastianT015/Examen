
// Compra.java
package com.productos.negocio;

import java.util.Date;
import java.util.List;

public class Compra {
    private int id;
    private Date fecha;
    private List<ItemCarrito> items;
    private double total;
    private String estado;
    private int idUsuario;
    
    // Constructor, getters y setters
    public Compra() {
        this.fecha = new Date();
        this.estado = "Pendiente";
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	public List<ItemCarrito> getItems() {
		return items;
	}

	public void setItems(List<ItemCarrito> items) {
		this.items = items;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
    
}

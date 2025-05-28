// Carrito.java
package com.productos.negocio;

import java.util.ArrayList;
import java.util.List;

public class Carrito {
    private List<ItemCarrito> items;
    private double total;
    
    public Carrito() {
        items = new ArrayList<>();
        total = 0.0;
    }
    
    public void agregarItem(Producto producto, int cantidad) {
        // Verificar si el producto ya está en el carrito
        for (ItemCarrito item : items) {
            if (item.getProducto().getId() == producto.getId()) {
                item.setCantidad(item.getCantidad() + cantidad);
                calcularTotal();
                return;
            }
        }
        
        // Si no está, agregarlo como nuevo ítem
        items.add(new ItemCarrito(producto, cantidad));
        calcularTotal();
    }
    
    public void eliminarItem(int idProducto) {
        items.removeIf(item -> item.getProducto().getId() == idProducto);
        calcularTotal();
    }
    
    public void actualizarCantidad(int idProducto, int nuevaCantidad) {
        for (ItemCarrito item : items) {
            if (item.getProducto().getId() == idProducto) {
                item.setCantidad(nuevaCantidad);
                break;
            }
        }
        calcularTotal();
    }
    
    private void calcularTotal() {
        total = 0.0;
        for (ItemCarrito item : items) {
            total += item.getProducto().getPrecio() * item.getCantidad();
        }
    }
    
    // Getters
    public List<ItemCarrito> getItems() { return items; }
    public double getTotal() { return total; }
}
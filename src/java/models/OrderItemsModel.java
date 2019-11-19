/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author adrian
 */
public class OrderItemsModel {
    
    DBModel db;
    
    public OrderItemsModel() throws ClassNotFoundException, SQLException {
        db = new DBModel();
    }
    
    /**
     * 
     * @param order_id
     * @return Result
     * @throws java.sql.SQLException
     */
    public ResultSet countOrderItems(String order_id) throws SQLException {
        String query = "SELECT SUM(quantity) as total_items FROM order_items WHERE orders_id=" + order_id;
        //System.out.println(query);
        return db.result(query);
    }
    
    /**
     * 
     * @param orders_id
     * @param products_id
     * @return 
     */
    public ResultSet getOrderByIds(String orders_id, String products_id) {
        String query = "SELECT * FROM order_items WHERE orders_id="
                + orders_id + " AND products_id="
                + products_id + ";";
        return db.query(query);
    }
    
    /**
     * 
     * @param orders_id
     * @return 
     * @throws java.sql.SQLException 
     */
    public ResultSet getShoppingCart(String orders_id) throws SQLException {
        String query = "SELECT * FROM order_items oi, products pro WHERE pro.id = oi.products_id"
                + " AND oi.orders_id=" + orders_id;
        System.out.println(query);
        ResultSet r = db.result(query);
        return r;
   
    }
    
    /**
     * 
     * @param orders_id
     * @param products_id
     * @param price
     * @return
     * @throws SQLException 
     */
    public boolean insert(String orders_id, String products_id, String price) throws SQLException {
        String query = "INSERT INTO order_items(price, quantity, orders_id, products_id) "
                + "VALUES("
                + price + ", "
                + 1 + ","
                + orders_id + ", "
                + products_id + ");";
        //System.out.println(query);
        /*if (db.execute(query) == false) {
            String query_update = "UPDATE products SET stock = stock - 1 WHERE id=" + products_id;
            System.out.println(query_update);
            return db.execute(query_update);
        } else {
             return true;
        }*/
        return db.execute(query);
    }
    
    /**
     * 
     * @param id
     * @param quantity
     * @param price_pro
     * @return 
     * @throws java.sql.SQLException 
     */
    public boolean updateQuantity(String id, int quantity, int price_pro) throws SQLException {
        String query = "UPDATE order_items SET quantity=" + quantity + ","
                + "price =" + price_pro + "*" + quantity + ""  
                + " WHERE id="+id;
        System.out.println(query);
        return db.execute(query);
    }
    
    /**
     * 
     * @param id
     * @return
     * @throws SQLException 
     */
    public boolean deleteOrderItem(String id) throws SQLException {
        String query = "DELETE FROM order_items WHERE id=" + id;
        return db.execute(query);
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author adrian
 */
public class OrderModel {

    DBModel db;

    public OrderModel() throws ClassNotFoundException, SQLException {
        db = new DBModel();
    }
    
    /**
     * 
     * @param id_user
     * @return
     * @throws SQLException 
     */
    public ResultSet getOrderByUser(String id_user) throws SQLException {
        String query = "SELECT * FROM orders WHERE users_id=" + id_user;
        ResultSet rs = db.result(query);
        return rs;
    }
    
    /**
     * 
     * @return ResulSet
     * @throws SQLException 
     */
    public ResultSet getAll() throws SQLException {
        String query = "SELECT * FROM orders ors "
                + "LEFT JOIN users us ON us.id = ors.users_id "
                + "LEFT JOIN status_order st_ors ON st_ors.id = ors.status_order_id "
                + "WHERE st_ors.id != 1 ORDER BY ors.id DESC";
        ResultSet rs = db.result(query);
        return rs;
    }
    
    public ResultSet getByUser(int id) throws SQLException {
        String query = "SELECT * FROM orders ors "
                + "LEFT JOIN users us ON us.id = ors.users_id "
                + "LEFT JOIN status_order st_ors ON st_ors.id = ors.status_order_id "
                + "WHERE us.id=" + id + " AND st_ors.id != 1 ORDER BY ors.id DESC  ";
        ResultSet rs = db.result(query);
        return rs;
    }
    
    /**
     * 
     * @param id
     * @return
     * @throws SQLException 
     */
    public ResultSet getByOrderId(int id) throws SQLException {
        String query = "SELECT * FROM orders ors "
                + "LEFT JOIN users us ON us.id = ors.users_id "
                + "LEFT JOIN status_order st_ors ON st_ors.id = ors.status_order_id "
                + "LEFT JOIN addresses addr ON addr.orders_id = ors.id "
                + "LEFT JOIN payments pay ON pay.id = ors.payments_id "
                + "WHERE ors.id=" + id + " AND st_ors.id != 1 ORDER BY ors.id DESC  ";
        ResultSet rs = db.result(query);
        return rs;
    }

    /**
     * Creacion de orden incial
     *
     * @param user_id
     * @return boolean
     * @throws SQLException
     */
    public boolean insert(String user_id) throws SQLException {
        //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //String created_at = sdf.format(new Date());
        String query = "INSERT INTO orders (subtotal, shipping, created_at, updated_at, users_id, status_order_id, payments_id) "
                + "VALUES (0, 0, "
                + null + ", "
                + null + ", "
                + user_id + ","
                + 1 + ","
                + 1 + ");";
        //System.out.println(query);
        //return false;
        return db.execute(query);
    }
    
    /**
     * 
     * @param id
     * @param shipping
     * @param payments_id
     * @return
     * @throws SQLException 
     */
    public boolean updated(int id, int shipping, int payments_id) throws SQLException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String created_at = sdf.format(new Date());
        String updated_at = sdf.format(new Date());
        String query = "UPDATE orders SET subtotal=" + shipping + ""
                + ", shipping=" + shipping + ""
                + ", status_order_id=" + 2 + ""
                + ", payments_id=" + payments_id + ""
                + ", created_at='" + created_at + "', "
                + "updated_at='" + updated_at + "'"
                + " WHERE id=" + id;
        return db.execute(query);
    }
    
    /**
     * 
     * @param id
     * @param status
     * @return
     * @throws SQLException 
     */
    public boolean updateStatusOrder(int id, int status) throws SQLException {
        String query = "UPDATE orders SET status_order_id=" + status + " "
                + "WHERE id=" + id;
        return db.execute(query);
        //return false;
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.SQLException;

/**
 *
 * @author adrian
 */
public class AddressModel {
    
    DBModel db;
    
    public AddressModel() throws ClassNotFoundException, SQLException {
        db = new DBModel();
    }
    
    public boolean insert(int orders_id, String region, String comuna, String address, String num, String phone) throws SQLException {
        String query = "INSERT INTO addresses(orders_id, region, comuna, address, num, phone)"
                + " VALUES("
                + orders_id + ", "
                + "'" + region + "', "
                + "'" + comuna + "', '"
                + address + "', '"
                + num + "', '"
                + phone + "');";
        System.out.println(query);
        return db.execute(query);
    }
    
}

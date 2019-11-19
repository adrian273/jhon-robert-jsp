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
public class CategoryModel {
    
    DBModel db;
    public CategoryModel() throws ClassNotFoundException, SQLException {
        db = new DBModel();
    }
    
    public ResultSet getCategories() throws SQLException {
        String query = "SELECT * FROM categories";
        ResultSet rs = db.result(query);
        return rs;
    }
}

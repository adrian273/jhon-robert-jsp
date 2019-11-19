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
import java.util.Hashtable;
import javax.persistence.Lob;

/**
 *
 * @author adrian
 */
public class ProductModel {

    DBModel db;
      
    @Lob
    private byte[] image_file;

    public byte[] getImage_file() {
        return image_file;
    }

    public void setImage_file(byte[] image_file) {
        this.image_file = image_file;
    }
    
    public ProductModel() throws ClassNotFoundException, SQLException {
        db = new DBModel();
    }

    /**
     *
     * @param limit {true or false}
     * @param numLimit {N( > 0 ... 99999}
     * @return @throws SQLException
     */
    public ResultSet getProduct(boolean limit, int numLimit) throws SQLException {
        String query = "SELECT *, categories.name as name_c FROM products "
                + "LEFT JOIN categories ON products.categories_id = categories.id ";
        if (limit == true)
            query += "WHERE visible=" + 1;
        query += " ORDER BY products.created_at DESC, products.id DESC";
        if (limit == true)
            query += " LIMIT " + numLimit;
        System.out.println(query);
        ResultSet rs = db.result(query);
        return rs;
    }

    /**
     * 
     * @param id
     * @return ResultSet
     * @throws SQLException 
     */
    public ResultSet getProductById(String id) throws SQLException {
        String query = "SELECT *, categories.name as name_c FROM products "
                + "LEFT JOIN categories ON products.categories_id = categories.id "
                + "WHERE products.id = " + id + " ORDER BY products.created_at DESC";
        System.out.println(query);
        ResultSet rs = db.result(query);
        return rs;
    }
    
    /**
     * 
     * @return
     * @throws SQLException 
     */
    public ResultSet getLatestProducts() throws SQLException {
        String query = "SELECT *, categories.name as name_c FROM products "
                + "LEFT JOIN categories ON products.categories_id = categories.id "
                + "ORDER BY products.created_at DESC limit ";
        ResultSet rs = db.result(query);
        return null;
    }
    
    public ResultSet getProdByCategory(int categories_id) throws SQLException {
         String query = "SELECT *, categories.name as name_c FROM products "
                + "LEFT JOIN categories ON products.categories_id = categories.id"
                 + " WHERE products.categories_id=" + categories_id 
                + " AND products.visible = 1 ORDER BY products.created_at DESC ";
        ResultSet rs = db.result(query);
        return rs;
    }

    /**
     *
     * @param name
     * @param slug
     * @param description
     * @param price
     * @param img
     * @param visible
     * @param stock
     * @param categories_id
     * @return boolean
     * @throws SQLException
     */
    public boolean insert(String name, String slug, String description, String price, String img, String visible, String stock, String categories_id) throws SQLException {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String date = df.format(new Date());
        String query = "INSERT INTO products(name, slug, description, price, image, visible, stock, created_at, updated_at, categories_id)"
                + "VALUES("
                + "'" + name + "', "
                + "'" + slug + "', "
                + "'" + description + "', "
                + "'" + price + "',"
                + "'" + img + "',"
                + "'" + visible + "', "
                + "'" + stock + "',"
                + "'" + date + "',"
                + "'" + date + "',"
                + "'" + categories_id + "'"
                + ");";

        System.out.println(query);
        return db.execute(query);
    }

    public boolean delete(String id) throws SQLException {
        String query = "DELETE FROM products WHERE id=" + id + ";";
        return db.execute(query);
    }

    public boolean update(String id, String name, String slug, String description, String price, String img, String visible, String stock, String categories_id, String updated_at) throws SQLException {
        String query = "UPDATE products SET name='"
                + name + "', slug='"
                + slug + "', description='"
                + description + "', price='"
                + price + "', image='"
                + img + "', visible="
                + visible + ", categories_id="
                + categories_id + ", updated_at='"
                + updated_at + "', stock="
                + stock + " WHERE id="
                + id + ";";
        //System.out.println(query);
        return db.execute(query);
    }
}

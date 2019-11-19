/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author adrian
 */
public class DBModel {

    private Connection conn;
    private Statement st;
    private ResultSet rs;
  
    private static final String HOST = "localhost";
    private static final String DB = "jhon_robert_v1";
    private static final String USER = "root";
    private static final String PASS = "";
    private static final String DRIVER = "org.gjt.mm.mysql.Driver";

    public DBModel() throws ClassNotFoundException, SQLException {
        try {
            Class.forName(DRIVER);
            conn = (Connection) DriverManager.getConnection("jdbc:mysql://" + HOST + ":3306/" + DB, USER, PASS);
            st = (Statement) conn.createStatement();
        } catch (SQLException sql) {
            System.out.println("Error en Coneccion");
        }
    }

    /**
     * update, delete, insert
     * @param sql
     * @return 
     * @throws java.sql.SQLException 
     */
    public boolean execute(String sql) throws SQLException {
        boolean result = true;
        try {
            result = st.execute(sql);
        } catch (SQLException e) {
            System.out.println("error al ejecutar: " + e.getMessage());
        }
        return result;
    }

    /**
     * static SQL SELECT statement
     * @param sql
     * @return 
     */
    public ResultSet query(String sql) {
        try {
            rs = st.executeQuery(sql);
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return rs;
    }
    
    /**
     * Verificar email
     * @param email
     * @param pass
     * @return
     * @throws SQLException 
     */
    public boolean verificAccount(String email, String pass) throws SQLException {
        String query = "SELECT email, password FROM users"
                    + " WHERE email= '" + email + "'"
                    + " AND password= '" + pass + "'";
        PreparedStatement ps = conn.prepareStatement(query);
        ResultSet rr = ps.executeQuery();
        return rr.next();
    }
    
    /**
     * Extraer resultados con PreoaredStatement
     * @param query
     * @return
     * @throws SQLException 
     */
    public ResultSet result(String query) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(query);
        ResultSet res = ps.executeQuery();
        return res;
    }
    
    /**
     * FASE DE TEST;;;
     * @param query_insert
     * @param data
     * @throws SQLException 
     */
   public void insert (String query_insert, HashMap<String, String> data) throws SQLException {
       PreparedStatement ps = conn.prepareStatement(query_insert);
       int index = 1;
       for (Map.Entry<String, String> e : data.entrySet()) {
           ps.setString(index, e.getValue());
           ps.executeUpdate();
           index++;
           System.out.println(e.getKey() + "__" +e.getValue());
       }
   }
    
    

}

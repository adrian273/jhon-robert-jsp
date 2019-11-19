/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author adrian
 */
public class UserModel {

    private DBModel db;

    public UserModel() throws ClassNotFoundException, SQLException {
        db = new DBModel();
    }

    /**
     *
     * @param email
     * @param pass
     * @return data users
     * @throws SQLException
     */
    public ResultSet getUserByEmail(String email, String pass) throws SQLException {
        String query = "SELECT * FROM users"
                + " WHERE email= '" + email + "'"
                + " AND password= '" + pass + "'";
        ResultSet rs = db.result(query);
        return rs;
    }

    /**
     * get data by id's users
     *
     * @param id
     * @return
     * @throws SQLException
     */
    public ResultSet getUserById(String id) throws SQLException {
        String query = "SELECT * FROM users WHERE id='"
                + id + "';";
        ResultSet rs = db.result(query);
        return rs;
    }

    public ResultSet getAll() throws SQLException {
        String query = "SELECT * FROM users ORDER BY id DESC , created_at DESC";
        ResultSet rs = db.result(query);
        return rs;
    }

    /**
     * insert new record user
     *
     * @param name
     * @param email
     * @param username
     * @param pass
     * @param adress
     * @return
     * @throws SQLException
     */
    public boolean insert(String name, String email, String username, String pass) throws SQLException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String type = "general";
        String created_at = sdf.format(new Date());
        String updated_at = sdf.format(new Date());
        System.out.println(created_at);
        String query = "INSERT INTO users(name, email, user, password, type, adress, created_at, updated_at) VALUES ('"
                + name + "',"
                + "'" + email + "',"
                + "'" + username + "', "
                + "'" + pass + "', "
                + "'" + type + "', "
                + "'" + null + "',"
                + "'" + created_at + "',"
                + "'" + updated_at + "');";
        boolean execute = db.execute(query);
        return execute;
    }

    public boolean verificEmail(String email) {
        return false;
    }

    /**
     * Edicion de tipo de perfil del admin o user
     *
     * @param id
     * @param type
     * @return
     * @throws SQLException
     */
    public boolean updateProfile(int id, String type) throws SQLException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String updated_at = sdf.format(new Date());
        String query = "UPDATE users SET type='"
                + type + "', updated_at='" + updated_at + "' WHERE id=" + id;
        return db.execute(query);
    }

    /**
     * updated users info;; with id's session get atribbute
     * @param name
     * @param email
     * @param username
     * @param pass
     * @param id
     * @return boolean
     * @throws SQLException 
     */
    public boolean update(String name, String email, String username, String pass, int id) throws SQLException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String updated_at = sdf.format(new Date());
        String query = "UPDATE users SET name='" + name + "', "
                + "email='" + email + "', "
                + "user='" + username + "', "
                + "password='" + pass + "', "
                + "updated_at='" + updated_at + "' "
                + "WHERE id=" + id;
        return db.execute(query);
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.DBModel;
import models.OrderModel;
import models.UserModel;

/**
 *
 * @author adrian
 */
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DBModel db = new DBModel();
            String email = request.getParameter("email");
            String pass = request.getParameter("pass");

            HttpSession session = request.getSession();

            String login;
            login = db.verificAccount(email, pass) ? "true" : "false";
            String nameUser = "";
            String id = "";
            String type = "";
            if (login.equals("true")) {
                UserModel user = new UserModel();
                ResultSet userData = user.getUserByEmail(email, pass);
                userData.first();
                nameUser = userData.getString("name");
                id = userData.getString("id");
                type = userData.getString("type");
                System.out.println(login + " : " + nameUser + "; id=" + id);
                //--------------------------------------------------------------
                // SESSIONES
                session.setAttribute("login", login);
                session.setAttribute("username", nameUser);
                session.setAttribute("id_user", id);
                //--------------------------------------------------------------
                // Verificacion de orden
                OrderModel order = new OrderModel();
                ResultSet order_row = order.getOrderByUser(id);
                String orders_id = "";
                if (!order_row.next()) {
                    System.out.println("Nada Creado");
                    boolean new_order = order.insert(id);
                    if (new_order == false) {
                        ResultSet new_order_row = order.getOrderByUser(id);
                        if (new_order_row.next()) {
                            orders_id = new_order_row.getString("id");
                        }
                        System.out.println("order id: " + orders_id);
                    }
                } else {
                    System.out.println("con orden creada");
                    order_row.last();
                    orders_id = order_row.getString("id");
                    System.out.println("ordder id: " + orders_id);
                }
                session.setAttribute("order_id", orders_id);
                session.setAttribute("typeProfile", type);
                //--------------------------------------------------------------
                //response.sendRedirect("index.jsp");
                request.setAttribute("msg-log", "Bienvenid@: <b>" + nameUser.toUpperCase() + " <i class=\"far fa-laugh-beam\"></i></b>");
                request.setAttribute("color", "success");
                getServletConfig().getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            } else {
                String message = "Error en ingreso de credenciales";
                request.setAttribute("message_auth", message);
                getServletConfig().getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
                //response.sendRedirect("login.jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

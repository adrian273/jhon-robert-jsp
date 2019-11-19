/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.UserModel;

/**
 *
 * @author adrian
 */
public class UserController extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

        }
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    protected void viewGridUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            UserModel user = new UserModel();
            ResultSet rs = user.getAll();
            request.setAttribute("data", rs);
            RequestDispatcher rq = request.getRequestDispatcher("/user/");
            rq.forward(request, response);
        }
    }

    /**
     * 
     * @param request
     * @param response
     * @param id
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    protected void viewInfoModal(HttpServletRequest request, HttpServletResponse response, String id)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            UserModel user = new UserModel();
            ResultSet rs = user.getUserById(id);
            rs.first();

            JsonObjectBuilder data = Json.createObjectBuilder();
            data.add("id", rs.getString("id"));
            data.add("name", rs.getString("name"));
            data.add("email", rs.getString("email"));
            data.add("created_at", rs.getString("created_at"));
            data.add("type", rs.getString("type"));
            out.print(data.build());
        }
    }

    /**
     * 
     * @param request
     * @param response
     * @param id
     * @param type
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    protected void changeType(HttpServletRequest request, HttpServletResponse response, String id, String type)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            UserModel user = new UserModel();
            boolean up = user.updateProfile(Integer.parseInt(id), type);
            JsonObjectBuilder data = Json.createObjectBuilder();
            if (up == false) {
                data.add("type", "success");
                data.add("class_", "success");
                data.add("msg", "Editado con exito");
            } else {
                data.add("type", "error");
                data.add("class_", "danger");
                data.add("msg", "Error al editar");
            }
            out.print(data.build());
        }
    }

    /**
     *
     * @param request
     * @param response
     * @param id
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    protected void viewInfoUser(HttpServletRequest request, HttpServletResponse response, String id)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession ses = request.getSession();
            String id_auth = (String) ses.getAttribute("id_user");
            String type = (String) ses.getAttribute("typeProfile");

            if (id.equals(id_auth) || type.equals("admin")) {
                UserModel userData = new UserModel();
                ResultSet rs = userData.getUserById(id);
                ArrayList row = new ArrayList<>();
                rs.first();

                row.add(rs.getString("name"));
                row.add(rs.getString("email"));
                row.add(rs.getString("user"));
                row.add(rs.getString("password"));
                row.add(rs.getString("adress"));

                request.setAttribute("data", row);
                RequestDispatcher rq = request.getRequestDispatcher("/user/info.jsp");
                rq.forward(request, response);
            } else {
                RequestDispatcher rq = request.getRequestDispatcher("/errors/error_401.jsp");
                rq.forward(request, response);
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
        //processRequest(request, response);
        String view = request.getParameter("view");
        switch (view) {
            case "create":
                response.sendRedirect("user/create.jsp");
                break;
            case "info":
                String id = request.getParameter("id");
                try {
                    viewInfoUser(request, response, id);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (SQLException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "grid": {
                try {
                    viewGridUser(request, response);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;
            case "view-info":
                String i = request.getParameter("i");
                 {
                    try {
                        viewInfoModal(request, response, i);
                    } catch (ClassNotFoundException | SQLException ex) {
                        Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                break;
            case "change-type":
                String id_ = request.getParameter("i");
                String type = request.getParameter("type");
                 {
                    try {
                        changeType(request, response, id_, type);
                    } catch (ClassNotFoundException ex) {
                        Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (SQLException ex) {
                        Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                break;
            default:
                break;
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

        String type = request.getParameter("type");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("user");
        String pass = request.getParameter("pass");
        //String adress = request.getParameter("adress");
        // ---------------------------------------------------------------------
        // para crear nuevos registros
        // ---------------------------------------------------------------------
        if (type.equals("create")) {
            UserModel userData = null;
            try {
                userData = new UserModel();
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                boolean insert = userData.insert(name, email, username, pass);
                if (insert == false) {
                    request.setAttribute("msg-log", "Registrado con exito, <b>inicie session <i class=\"far fa-grin-beam\"></i></b>");
                    request.setAttribute("color", "success");
                    RequestDispatcher rq = request.getRequestDispatcher("/index.jsp");
                    //response.sendRedirect("index.jsp");
                    rq.forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
            }
        // Edicion del usuario;;
        } else if (type.equals("update")) {
            try {
                UserModel usermdl = new UserModel();
                HttpSession session = request.getSession();
                int id = Integer.parseInt(String.valueOf(session.getAttribute("id_user")));
                boolean update = usermdl.update(name, email, username, pass, id);
                if (update == false) {
                    request.setAttribute("message_edit", "Editado con exito");
                    viewInfoUser(request, response, String.valueOf(session.getAttribute("id_user")));
                }
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
            }
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

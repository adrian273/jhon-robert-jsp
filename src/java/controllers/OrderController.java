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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.AddressModel;
import models.OrderItemsModel;
import models.OrderModel;

/**
 *
 * @author adrian
 */
public class OrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String type = request.getParameter("type");

            switch (type) {
                case "checkout":
                    int orders_id = Integer.parseInt(String.valueOf(request.getParameter("orders_id")));
                    int shipping = Integer.parseInt(String.valueOf(request.getParameter("shipping")));
                    int payments_id = Integer.parseInt(String.valueOf(request.getParameter("payments_type")));
                    OrderModel order = new OrderModel();
                    boolean updated_order = order.updated(orders_id, shipping, payments_id);
                    if (updated_order == false) {
                        String region = request.getParameter("region");
                        String comuna = request.getParameter("comuna");
                        String num = request.getParameter("num");
                        String phone = request.getParameter("phone");
                        String adrs = request.getParameter("address");
                        AddressModel adress = new AddressModel();
                        boolean insert_adress = adress.insert(orders_id, region, comuna, adrs, num, phone);
                        if (insert_adress == false) {
                            HttpSession ses = request.getSession();
                            String id_user = (String) ses.getAttribute("id_user");
                            boolean insert_new_order = order.insert(id_user);

                            if (insert_new_order == false) {
                                ResultSet order_row = order.getOrderByUser(id_user);
                                order_row.last();
                                //out.print(order_row.getString("id"));
                                ses.setAttribute("order_id", order_row.getString("id"));
                                out.print("success," + order_row.getString("id"));
                            } else {
                                out.print("fail_new_order");
                            }

                        } else {
                            out.print("fail_insert_adress");
                        }
                    } else {
                        out.print("fail_updated_order");
                    }
                    break;
                case "all_orders":
                    viewAllOrders(request, response);
                    break;
                case "view_order":
                    String id = request.getParameter("i");
                    out.print(id);
                    break;
                case "my_order":
                    viewMyOrder(request, response);
                    break;
                case "order_info":
                    String i = request.getParameter("i");
                    orderInfo(request, response, i);
                    break;
                case "change_status":
                    String ident = request.getParameter("i");
                    String idStatus = request.getParameter("status");
                    changeStatusOrder(request, response, ident, idStatus);
                    break;
            }
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
    protected void viewAllOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            OrderModel order = new OrderModel();
            ResultSet row = order.getAll();
            request.setAttribute("data", row);
            RequestDispatcher rq = request.getRequestDispatcher("/orders/");
            rq.forward(request, response);
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
    protected void viewMyOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        OrderModel ord = new OrderModel();
        HttpSession session = request.getSession();

        ResultSet rs = ord.getByUser(Integer.parseInt(String.valueOf(session.getAttribute("id_user"))));
        request.setAttribute("data", rs);

        RequestDispatcher rq = request.getRequestDispatcher("/orders/my-order.jsp");
        rq.forward(request, response);
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
    protected void orderInfo(HttpServletRequest request, HttpServletResponse response, String id)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        OrderModel ord = new OrderModel();
        OrderItemsModel items = new OrderItemsModel();

        ResultSet order_data = ord.getByOrderId(Integer.parseInt(id));
        ResultSet product_data = items.getShoppingCart(id);
        HttpSession ses = request.getSession();

        try (PrintWriter out = response.getWriter()) {

            JsonObjectBuilder json = Json.createObjectBuilder();
            JsonObjectBuilder productJson = Json.createObjectBuilder();
            JsonArrayBuilder arrJson = Json.createArrayBuilder();

            order_data.next();
            json.add("id", order_data.getString("ors.id"));

            while (product_data.next()) {
                productJson.add("id", product_data.getString("pro.id"));
                productJson.add("name", product_data.getString("pro.name"));
                productJson.add("price", product_data.getString("pro.price"));
                productJson.add("quantity", product_data.getString("oi.quantity"));
                productJson.add("subtotal", product_data.getString("oi.price"));
                arrJson.add(productJson);
            }

            json.add("id", order_data.getString("ors.id"));
            json.add("shipping", order_data.getString("ors.shipping"));
            json.add("created_at", order_data.getString("ors.created_at"));
            json.add("shipping", order_data.getString("ors.shipping"));
            json.add("status", order_data.getString("st_ors.status"));
            json.add("color", order_data.getString("st_ors.color"));

            json.add("type", order_data.getString("pay.type"));
            json.add("region", order_data.getString("addr.region"));
            json.add("comuna", order_data.getString("addr.comuna"));
            json.add("address", order_data.getString("addr.address"));
            json.add("phone", order_data.getString("addr.phone"));

            json.add("type_profile", (String) ses.getAttribute("typeProfile"));

            json.add("products", arrJson);

            out.print(json.build());
        }
    }

    /**
     *
     * @param request
     * @param response
     * @param id
     * @param status
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    protected void changeStatusOrder(HttpServletRequest request, HttpServletResponse response, String id, String status)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            OrderModel ordmdl = new OrderModel();
            boolean up = ordmdl.updateStatusOrder(Integer.parseInt(id), Integer.parseInt(status));
            JsonObjectBuilder conf = Json.createObjectBuilder();
            if (up == false) {
                conf.add("type", "success");
                conf.add("msg", "Editado con exito");
                conf.add("class_", "success");
            } else {
                conf.add("type", "error");
                conf.add("msg", "Error Al editar");
            }
            out.print(conf.build());
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
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

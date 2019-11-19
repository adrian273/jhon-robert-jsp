/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import helpers.AppHelpers;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.OrderItemsModel;

/**
 *
 * @author adrian
 */
public class OrderItemsController extends HttpServlet {

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
            String type = request.getParameter("type");
            if (type.equals("load_counter")) {
                String orders_id = request.getParameter("orders_id");
                loadCounter(response, orders_id);
            } 
            else if (type.equals("verific_product")) {
                String orders_id = request.getParameter("orders_id");
                String products_id = request.getParameter("products_id");
                String price = request.getParameter("price");
                verificProducts(response, orders_id, products_id, price);
            } 
            else if (type.equals("shopping_cart")) {
                String orders_id = request.getParameter("i");
                shopping_cart_view(request, response, orders_id);
            }
            else if (type.equals("update_quantity")) {
                String orders_id = request.getParameter("id");
                String quantity = request.getParameter("quantity");
                int price_pro = Integer.parseInt(String.valueOf(request.getParameter("price_pro")));
                update_quantity(response, orders_id, quantity, price_pro);
            } 
            else if (type.equals("delete_order")) {
                String id = request.getParameter("id");
                deleteOrder(response, id);
            }
            else if (type.equals("total_shopping_cart")) {
                String id = request.getParameter("id");
                totalShoppingCart(response, id);
            }
        }
    }

    /**
     *
     * @param request
     * @param response
     * @param orders_id
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    protected void shopping_cart_view(HttpServletRequest request, HttpServletResponse response, String orders_id)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            OrderItemsModel shop = new OrderItemsModel();

            ResultSet rows = shop.getShoppingCart(orders_id);
           
            request.setAttribute("rows_cart", rows);
            RequestDispatcher rq = request.getRequestDispatcher("/shopping_cart/");
            rq.forward(request, response);
        }
    }
    
    /**
     * 
     * @param response
     * @param orders_id
     * @param quantity
     * @param price_pro
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    protected void update_quantity(HttpServletResponse response, String orders_id, String quantity, int price_pro)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            OrderItemsModel shop = new OrderItemsModel();
            int quan = Integer.parseInt(quantity);
            boolean update = shop.updateQuantity(orders_id, quan, price_pro);
            if (update == false) {
                int oi_price = price_pro * quan;
                AppHelpers help = new AppHelpers();
                out.print(help.priceFormat(String.valueOf(oi_price)));
            }
        }
    }
    
    /**
     * 
     * @param response
     * @param orders_id
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    protected void deleteOrder(HttpServletResponse response, String orders_id)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            OrderItemsModel shop = new OrderItemsModel();
            if (shop.deleteOrderItem(orders_id) == false)
                out.print("true");
        }
    }
    
    /**
     * 
     * @param response
     * @param orders_id
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    protected void totalShoppingCart(HttpServletResponse response, String orders_id)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            OrderItemsModel shop = new OrderItemsModel();
            ResultSet data = shop.getShoppingCart(orders_id);
            int total = 0;
            int op = 0;
            while(data.next()) {
                total += Integer.parseInt(String.valueOf(data.getString("oi.price"))); 
            }
            out.print(total);
        }
    }

    /**
     *
     * @param response
     * @param orders_id
     * @param products_id
     * @param price
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SQLException verificar el producto para que no se agrege de nuevo
     * en la orden
     */
    protected void verificProducts(HttpServletResponse response, String orders_id, String products_id, String price)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            OrderItemsModel order = new OrderItemsModel();
            ResultSet rs = order.getOrderByIds(orders_id, products_id);
            if (rs.next()) {
                out.print("false");
            } else {
                if (order.insert(orders_id, products_id, price) == false) {
                    out.print("true");
                } else {
                    out.print("null");
                }
            }
        }
    }

    /**
     *
     * @param response
     * @param order_id
     * @throws ServletException
     * @throws IOException
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException contador de productos en el carrito
     */
    protected void loadCounter(HttpServletResponse response, String order_id)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            OrderItemsModel order_item = new OrderItemsModel();
            ResultSet rs = order_item.countOrderItems(order_id);
            if (rs.next()) {
                if (rs.getString("total_items").equals(null))
                    out.print("0");
                else
                    out.print(rs.getString("total_items"));
            } else {
                out.print("0");
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
            Logger.getLogger(OrderItemsController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(OrderItemsController.class.getName()).log(Level.SEVERE, null, ex);
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

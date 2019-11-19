<%-- 
    Document   : index
    Created on : 24-10-2019, 15:33:39
    Author     : adrian
--%>
<%@page import="helpers.AppHelpers"%>
<%@page import="java.sql.ResultSet"%>
<%
    HttpSession ses = request.getSession();
    String order_id = "";
    order_id = String.valueOf(ses.getAttribute("order_id"));
    AppHelpers help = new AppHelpers();
%>
<jsp:include page="../layouts/header.jsp"></jsp:include>
    <style>
        .table-hover > tbody > tr:hover {
            color: #007bff;
        }
    </style>
    <div class="row">
        <input type="hidden" id="orders_id" value="<%= order_id%>">
    <div class="col-8">  
        <div class="card">
            <div class="card-header text-white jr-primary text-center text-uppercase">
                Total de productos Agregados: 
                <span class="count-shopping-cart">0</span> 
                <i class="fas fa-shopping-bag"></i>
            </div>
            <div class="card-body">
                <table class="table table-hover table-borderless" style="color:black;"> 
                    <thead>
                        <tr>
                            <th colspan="4">
                                <div id="msg-shooping-cart"> </div>
                            </th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <thead class="jr-primary text-white">
                        <tr>
                            <th>Nombre</th>
                            <th>Precio</th>
                            <th>Cantidad</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody class="">
                        <%
                            ResultSet r = (ResultSet) request.getAttribute("rows_cart");
                            while (r.next()) {
                        %>
                        <tr id="row_order<%= r.getString("oi.id")%>">
                    <input type="hidden" id="stock<%= r.getString("oi.id")%>" value="<%= r.getString("pro.stock")%>">
                    <td>
                        <label for=""> <%= r.getString("pro.name")%> </label>
                        <input type="hidden" name="name" id="name<%= r.getString("oi.id")%>" disabled="" 
                               class="form-control" value="<%= r.getString("pro.name")%>">
                    </td>
                    <td>
                        <%
                            int oi_price = (int) Double.parseDouble((String) r.getString("pro.price"));
                            int quantity = Integer.parseInt(r.getString("oi.quantity"));
                            int sub_total_pro = oi_price * quantity;
                        %>
                        <label for="" id="sub_total_pro<%= r.getString("oi.id")%>label" > 
                            <%= help.priceFormat(String.valueOf(sub_total_pro))%>
                        </label>
                        <input type="hidden" name="price_pro" id="price_pro<%= r.getString("oi.id")%>" 
                               disabled="" class="form-control" value="<%= r.getString("pro.price")%>">
                    </td>
                    <td>
                        <input style="width:100px;" min="1" onchange="updateQuantity(this, <%= r.getString("oi.id")%>)" 
                               type="number" name="quantity" class="form-control" value="<%= quantity%>">
                    </td>
                    <td>
                        <button class="btn btn-danger" onclick="deleteOrder(<%= r.getString("oi.id")%>)"> 
                            <i class="fas fa-trash-alt"></i> 
                        </button>
                    </td>
                    </tr>

                    <% }%>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="4">
                                <div class="msg-empty-cart">
                                </div> 
                            </th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </tfoot>
                </table>

            </div>
        </div>
    </div>
    <!-- monto total ---------------------------------------------------------->                
    <div class="col-4"> 
        <div class="card">
            <div class="card-header jr-primary text-white text-center text-uppercase">
                <h1> Orden N° <%= order_id%>  </h1>
            </div>
            <div class="card-body">
                <p> Total Productos: <span class="count-shopping-cart"></span> </p>
                <p>Monto Total: <span class="monto_total">0</span></p>
            </div>
            <div class="card-footer">
                <!--<button class="btn btn-outline-info btn-block" id="checkout-shopping-cart"> Realizar pedido </button>-->
                <button class="btn btn-info btn-block" id="checkout-shopping-cart"> Realizar pedido </button>
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------ --------->
</div>
<jsp:include page="../shopping_cart/checkout-modal.jsp"></jsp:include>
<div id="debug"></div>
<jsp:include page="../layouts/footer.jsp"></jsp:include>
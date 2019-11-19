<%-- 
    Document   : checkout-modal
    Created on : 04-11-2019, 14:07:57
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
<!-- MODAL CheckOut -->
<div class="modal bd-example-modal-xl" style="color:white;background-color: #4492e033;" id="myModal" role="dialog">
    <div class="modal-dialog modal-xl bg-dark" tabindex="-1">
        <button type="button" class="btn btn-outline-info" style="float:right;border-radius: 0px;cursor: pointer !important;" 
                data-dismiss="modal">&times;</button>
                
        <!-- Modal content-->
        <div class="modal-content bg-dark">
            <div class="modal-header">
                <h4 class="modal-title">
                    Datos para el envio y confirmacion de la compra
                </h4>
                <p>Total: <span class="monto_total">0</span></p>
            </div>
            <form id="checkout-cart">
                <input type="hidden" name="type" value="checkout">
                <input type="hidden" name="shipping" value="" id="shipping">
                <input type="hidden" name="orders_id" value="<%= order_id %>">
                <div class="modal-body">
                    <div class="msg-checkout-cart"></div>
                    <h4>Direccion</h4>
                    <hr>
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="form-check-label"><b>Region</b></label>
                                <select name="region" onchange="changeTerritory(this.value)" id="region" class="form-control">
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="form-check-label"><b>Comuna</b></label>
                                <select name="comuna" id="comuna" class="form-control">
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="row">
                                <div class="col-9">
                                    <div class="form-group">
                                        <label for="" class="form-check-label">Direccion</label>
                                        <input type="text" class="form-control" id="address" name="address">
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="form-group">
                                        <label for="" class="form-check-label">Num Casa</label>
                                        <input type="text" class="form-control" name="num">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="" class="form-check-label">Telefono</label>
                                <input type="text" class="form-control" name="phone">
                            </div> 
                        </div>
                    </div>
                    <h4>Metodo de pago</h4>
                    <hr>
                    <div class="col-12">
                        <div class="form-check form-check-inline">
                            <label style="cursor: pointer;">
                                <input class="form-check-input payments_type" type="radio" 
                                       name="payments_type" id="caja-vecina" value="2">
                                <!-- <label class="form-check-label" for="caja-vecina">Caja Vecina</label> -->
                                <img src="https://d31dn7nfpuwjnm.cloudfront.net/images/valoraciones/0028/4494/como-funcionan-depositos-otros-servicios-caja-vecina.png?1508325636" 
                                     width="35%;" class="img-responsive img-fluid img-thumbnail" alt=""></label>
                            <label style="cursor:pointer;">
                                <input class="form-check-input payments_type" type="radio" 
                                       name="payments_type" id="web-pay" value="3">
                                <%--<label class="form-check-label" for="web-pay">Web Pay</label> &nbsp; --%>
                                <img src="https://cdn.shopify.com/s/files/1/0013/9935/7503/files/webpay-logo1_faf9fd07-8683-4715-a39b-e990828e3703_large.png?v=1522242608"
                                     width="35%;" class="img-responsive img-fluid img-thumbnail mb-2" alt=""> </label>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    <button type="button" id="confirm-order" class="btn btn-outline-success"> Confirmar <i class="fas fa-check"></i> </button>
                </div>
            </form>
        </div>
    </div>
</div>
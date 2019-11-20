<%-- 
    Document   : prod-category
    Created on : 22-10-2019, 21:04:45
    Author     : adrian
--%>

<%-- 
    Document   : index
    Created on : 12-10-2019, 16:32:19
    Author     : adrian
--%>

<%@page import="helpers.AppHelpers"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="models.ProductModel"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="layouts/header.jsp"></jsp:include>
<%
    HttpSession ses = request.getSession();
    boolean login = false;
    login = Boolean.parseBoolean(String.valueOf(ses.getAttribute("login")));
    String order_id = "";
    order_id = String.valueOf(ses.getAttribute("order_id"));
%>
<div class="col-12">
    <!-- Start: MUSA_carousel-product-cart-slider --><div class="container">

        <div class="row">
            <div class="row">
                <div class="col-md-9">
                    <h3>
                        <%= request.getAttribute("title").toString().toUpperCase()%>
                    </h3>
                </div>
                <div class="col-md-3">
                    <!-- Controls -->
                    <!--<div class="controls pull-right hidden-xs">
                        <a class="left fa fa-chevron-left btn btn-primary" href="#carousel-example-generic"
                           data-slide="prev"></a><a class="right fa fa-chevron-right btn btn-primary" href="#carousel-example-generic"
                           data-slide="next"></a>
                    </div>-->
                </div>
            </div>
            <div id="carousel-example-generic" class="carousel slide hidden-xs" data-ride="carousel">
                <!-- Wrapper for slides -->
                <div class="carousel-inner">
                    <div class="item active">
                        <div class="row">
                            <%
                                ResultSet rs = (ResultSet) request.getAttribute("data");
                                AppHelpers help = new AppHelpers();
                                int count = 0;
                                while (rs.next()) {

                            %>
                            <!-- panel del producto -->
                            <div class="col-setting wow animated fadeInLeft col-md-4 mb-5 mt-5 col-sm-4 col-xs-12">
                                <div class="col-item">
                                    <div class="photo">
                                        <% if (rs.getString("image").equals("null") || rs.getString("image") == "" || rs.getString("image").equals(null)) { %>
                                        <img src="assets/img/default.jpg" class="img-responsive" alt="a" />
                                        <% } else {%>
                                        <img src="<%= rs.getString("image")%>" class="img-responsive" alt="a" />
                                        <% }%>
                                    </div>
                                    <div class="info">
                                        <div class="row">
                                            <div class="price col-md-6" style="color:black;">
                                                <h5>
                                                    <%= rs.getString("name")%></h5>
                                                <h5 class="price-text-color">
                                                    <%= help.priceFormat(rs.getString("price"))%>

                                            </div>
                                            <div class="rating hidden-sm col-md-6">
                                                <i class="price-text-color fa fa-star"></i><i class="price-text-color fa fa-star">
                                                </i><i class="price-text-color fa fa-star"></i><i class="price-text-color fa fa-star">
                                                </i><i class="fa fa-star"></i>
                                            </div>
                                        </div>
                                        <div class="separator clear-left">
                                            <p class="btn-add">
                                                <c:choose>
                                                    <c:when test="${login == true}">
                                                        <button class="hidden-sm btn btn-dark" onclick="add_cart(this, <%= rs.getString("id")%>, <%= order_id%>, <%= rs.getString("price")%>, <%= rs.getString("stock")%>)">Agregar <i class="fa fa-shopping-cart"></i></button>
                                                        </c:when>
                                                        <c:when test="${login != true}">
                                                        <button type="button" class="hidden-sm btn btn-dark" disabled="disabled" title="Inicie session, para agregar productos"> Agregar <i class="fa fa-shopping-cart"></i></button>
                                                        </c:when>
                                                    </c:choose>
                                            </p>
                                            <p class="btn-details">
                                                <input type="hidden" class="id-prod-val" value="">
                                                <a href="#!" class="hidden-sm btn btn-dark" id="more-info-prod<%= rs.getString("id")%>" 
                                                   onclick="moreInfo(this, <%= rs.getString("id")%>, <%= order_id%>)">
                                                    Mas detalles <i class="fa fa-list"></i>
                                                </a>
                                            </p>
                                        </div>
                                        <div class="clearfix">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% count += 1;
                                }

                            %>
                            <input type="hidden" value="<%= count%>" id="col-size">
                            <!-- panel del producto -->


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End: MUSA_carousel-product-cart-slider -->
</div>
<jsp:include page="product/more-info-product.jsp"></jsp:include>
<jsp:include page="layouts/footer.jsp"></jsp:include>

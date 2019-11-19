<%-- 
    Document   : header
    Created on : 14-10-2019, 15:59:27
    Author     : adrian
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <%
        HttpSession ses = request.getSession();
        boolean login = false;
        String username = "";
        String type = "";
        String id = "";
        String order_id = "";
        //----------------------------------------------------------------------
        login = Boolean.parseBoolean(String.valueOf(ses.getAttribute("login")));
        username = String.valueOf(ses.getAttribute("username"));
        type = String.valueOf(ses.getAttribute("typeProfile"));
        id = String.valueOf(ses.getAttribute("id_user"));
        order_id = String.valueOf(ses.getAttribute("order_id"));
    %>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>
            Don Jhon Robert
        </title>
        <c:set var="path" value="<%= request.getContextPath()%>"></c:set>
        <link rel="stylesheet" href="${path}/assets/css/bootstrap.css">
        <script src="https://kit.fontawesome.com/e53674a86e.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="${path}/assets/css/aclonica-font.css">
        <link rel="stylesheet" href="${path}/assets/css/animated.css">
        <link rel="stylesheet" href="${path}/assets/css/styles.min.css">
    </head>

    <body>
        <input type="hidden" name="base" id="base" value="${path}">
        <input type="hidden" name="type_profile" id="type_profile" value="<%= type%>">
        <div class="container">
            <div class="col-12">
                <!-- Start: Navbar -->
                <header>
                    <nav class="navbar navbar-dark navbar-size-lg jr-primary-gra navbar-expand-md fixed-top">
                        <div class="container">
                            <a class="navbar-brand" href="${path}/index.jsp">
                                <img src="${path}/assets/img/logos/black.png" 
                                     width="40" height="40" 
                                     class="d-inline-block align-top" alt="">
                                Jhon Robert <sup> <small>24K</small> </sup>
                            </a>
                            <button data-toggle="collapse" class="navbar-toggler" 
                                    data-target="#menu">
                                <span class="sr-only">
                                    Toggle navigation
                                </span>
                                <span class="navbar-toggler-icon">
                                    <i class="la la-navicon"></i>
                                </span>
                            </button>
                            <div class="collapse navbar-collapse"
                                 id="menu">
                                <ul class="nav navbar-nav flex-grow-1 justify-content-between">
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link" 
                                           href="<%=request.getContextPath()%>/producto?action=prod&category=cadenas">
                                            Cadenas
                                        </a>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link" 
                                           href="<%=request.getContextPath()%>/producto?action=prod&category=pulseras">
                                            Pulseras
                                        </a>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link" 
                                           href="<%=request.getContextPath()%>/producto?action=prod&category=anillos">
                                            Anillos
                                        </a>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link" 
                                           href="<%=request.getContextPath()%>/producto?action=prod&category=aros">
                                            Aros
                                        </a>
                                    </li>
                                    <li class="nav-item" role="presentation"></li>
                                    <li class="nav-item" id="nav-shopping-cart" role="presentation">
                                        <% String or_id = order_id.equals("") ? "" : order_id; %> 
                                        <% String url_cart = login == true ? request.getContextPath() + "/order_items?type=shopping_cart&i=" + or_id : "#!";%>
                                        <a class="nav-link btn btn-outline-info" href="<%= url_cart%>">
                                            <c:if test="${login}">
                                                <%--N° Orden: <%= or_id%> --%>
                                                <input type="hidden" value="<%= order_id%>" name="orders_id" id="orders_id">
                                            </c:if>
                                            <i class="fa fa-shopping-cart"></i> 
                                            <span class="badge badge-dark count-shopping-cart" id="count-shopping-cart">0</span>
                                            <!-- [ <span id="count-shopping-cart"></span> ] -->
                                        </a>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link" href="#">
                                            <i class="fa fa-search"></i>
                                        </a>
                                    </li>
                                    <c:if test="${login}"> 
                                        <li class="nav-item" role="presentation">
                                            <a class="nav-link" href="${path}/userc?view=info&id=<%= id%>">
                                                <c:out value="${username}"></c:out> 
                                                <% if (type.equals("general")) {%>
                                                <i class="fa fa-star"></i>
                                                <% } else { %>
                                                [admin]
                                                <i class="fas fa-crown"></i>
                                                <% } %>
                                            </a>
                                        </li>
                                        <% if (type.equals("admin")) {%>
                                        <li class="nav-item dropdown d-flex float-none">
                                            <a class="dropdown-toggle text-uppercase d-lg-flex align-items-lg-center nav-link" 
                                               data-toggle="dropdown" aria-expanded="false" 
                                               href="#">
                                                Panel de ADM
                                            </a>
                                            <div class="dropdown-menu" role="menu">
                                                <a class='dropdown-item' role='presentation' 
                                                   href="${path}/producto?action=view">Productos  
                                                    <i class="fas fa-store"></i> </a>
                                                <a class='dropdown-item' role='presentation' 
                                                   href="<%=request.getContextPath()%>/userc?view=grid">Usuarios 
                                                    <i class="fa fa-user"></i> </a>
                                                <a class='dropdown-item' role='presentation' 
                                                   href="<%=request.getContextPath()%>/order?type=all_orders">Ventas 
                                                    <i class="fas fa-cash-register"></i> </a>
                                                <!--<a class='dropdown-item' role='presentation' href="<%=request.getContextPath()%>/login.jsp">Categorias <i class="fas fa-clipboard-list"></i></a>-->
                                            </div>
                                        </li>
                                        <% } %>
                                    </c:if>
                                    <li class="nav-item d-none d-xs-block d-md-block" role="presentation">
                                    <li class="nav-item dropdown d-flex float-none" role="presentation">
                                        <a class="dropdown-toggle text-uppercase d-lg-flex align-items-lg-center nav-link" 
                                           data-toggle="dropdown" aria-expanded="false" href="#">Cuenta</a>
                                        <div class="dropdown-menu" role="menu">
                                            <%
                                                if (login != false) {
                                                    out.print("<a class='dropdown-item' role='presentation' href='" + request.getContextPath() + "/userc?view=info&id=" + id + "'>Editar <i class='fas fa-tools'></i> </a>");
                                                    out.print("<a class='dropdown-item' role='presentation' href='" + request.getContextPath() + "/order?type=my_order'> Mis Ordenes <i class='fas fa-truck-moving'></i> </a>");
                                                    out.print("<a class='dropdown-item' role='presentation' href='" + request.getContextPath() + "/logout'>Cerrar Session <i class='fas fa-sign-out-alt'></i> </a>");

                                                } else {
                                                    out.print("<a class='dropdown-item' role='presentation' href='" + request.getContextPath() + "/login.jsp'>Login <i class='fas fa-sign-in-alt'></i> </a>");
                                                    out.print("<a class='dropdown-item' role='presentation' href='" + request.getContextPath() + "/userc?view=create'>Registrarse <i class='fas fa-plus'></i> </a>");
                                                }
                                            %> 
                                        </div>
                                    </li>
                                    </li>
                                    <li class="nav-item d-none d-xs-block d-md-block" role="presentation"></li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </header>
                <!-- End: Navbar - Apple -->
            </div>
        </div>
        <div class="container-fluid border-primary shadow" style="margin-top:6%;" id="app">

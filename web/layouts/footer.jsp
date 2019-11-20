<%-- 
    Document   : footer
    Created on : 14-10-2019, 15:59:40
    Author     : adrian
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    HttpSession ses = request.getSession();
    boolean login = false;
    String id = "";
    login = Boolean.parseBoolean(String.valueOf(ses.getAttribute("login")));
    id = String.valueOf(ses.getAttribute("id_user"));
%>
<c:set var="path" value="<%= request.getContextPath()%>"></c:set>
<footer class="footer mt-auto py-3 jr-primary-gra text-white"  style="" id="footer-primary">
        <div class="container-fluid">
            <div class="col-12">
                <div class="row">  
                    <div class="col-3">
                        <h4>Menu</h4>
                        <ul class="nav flex-column">
                            <li class="nav-item d-none d-xs-block d-md-block" role="presentation">
                                <a class="nav-link text-uppercase" href="${path}/index.jsp" 
                               style="font-family: Aclonica, sans-serif;">Inicio</a></li>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>/producto?action=prod&category=cadenas">Cadenas</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>/producto?action=prod&category=pulseras">Pulseras</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>/producto?action=prod&category=anillos">Anillos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>/producto?action=prod&category=aros">Aros</a>
                        </li>
                    </ul>
                </div>
                <div class="col-3">
                    <h4>Ayuda</h4>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>/help/contact.jsp">Contacto</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>">Quienes Somos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>">Como Comprar</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>">Politica de Seguridad</a>
                        </li>
                    </ul>
                </div>
                <div class="col-3">
                    <h4>Mi Cuenta</h4>
                    <ul class="nav flex-column">
                        <%if (login != false) {%>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>/userc?view=info&id=<%= id%>">Editar</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>/logout">Cerrar Session</a>
                        </li>
                        <% } else {%>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>/login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="<%=request.getContextPath()%>/userc?view=create">Registrarse</a>
                        </li>
                        <% }%>

                    </ul>
                </div>
                <div class="col-3">
                    <h4> Medios de pago </h4>
                    <img src="https://cdn.shopify.com/s/files/1/0013/9935/7503/files/webpay-logo1_faf9fd07-8683-4715-a39b-e990828e3703_large.png?v=1522242608"
                         width="50%;" class="img-responsive img-fluid img-thumbnail mb-2" alt=""> 
                    <img src="https://d31dn7nfpuwjnm.cloudfront.net/images/valoraciones/0028/4494/como-funcionan-depositos-otros-servicios-caja-vecina.png?1508325636" 
                         width="50%;" class="img-responsive img-fluid img-thumbnail" alt="">
                </div>
            </div>
        </div>
    </div>
</footer>
<footer class="footer mt-auto py-1" style="">
    <div class="col-12"> 
        <p class="text-center">
            Joyeria Jhon Robert &reg; 2019 - Desarrollado por <a href="https://github.com/adrian273" target="blank"> Adrian </a>
        </p>
    </div>
</footer>
</div>


<script src="${path}/assets/js/jquery.js"></script>
<script src="${path}/assets/js/bootstrap.js"></script>
<script src="${path}/assets/js/wow.min.js"></script>
<script src="${path}/assets/js/script.min.js"></script>
<script>
    
    new WOW().init();

    function load_count_shopping() {
        var count = "0";
        var orders_id = $("#orders_id").val();

        if (orders_id != undefined) {
            $.ajax({
                url: "${path}/order_items",
                data: {
                    "type": "load_counter",
                    "orders_id": orders_id
                },
                type: "GET",
                dataType: "html"
            }).done(function (res) {
                count = res;
                //alert(count)
                //$(".count-shopping-cart").html(count)
                count === '' ? "0" : $(".count-shopping-cart").html(count);
            }).fail(function (jqXHR, textStatus, error) {
                alert(textStatus);
            });
        } else {
            $(".count-shopping-cart").html(count);
        }
    }

    $(window).scroll(function () {
        //console.log($("header").offset().top);
        start = $(this).scrollTop();
        if (start > $("header").offset().top) {
            $(".navbar").removeClass("navbar-size-lg");
            //$(".navbar").addClass("animated fadeOut");
            //$(".navbar").removeClass("fadeIn");
        }
        else {
            $(".navbar").addClass("navbar-size-lg");
            //$(".navbar").removeClass("animated fadeOut");
        }
    });

</script>
</body>
</html>
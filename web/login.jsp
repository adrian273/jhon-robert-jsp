
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    HttpSession ses = request.getSession();
    boolean login = false;
    login = Boolean.parseBoolean(String.valueOf(ses.getAttribute("login")));
    if (login) {
        response.sendRedirect("index.jsp");
    }
%>
<jsp:include page="layouts/header.jsp"></jsp:include>
<%-- ----------------------------------------------------------------------|
|||||               Mensaje de error de ingreso                            |
--------------------------------------------------------------------------%>
<% if (request.getAttribute("message_auth") != null) {%>
<div class="alert alert-danger text-center" role="alert">
    <b> 
        <i class="fas fa-2x fa-ban"></i> 
        <%= request.getAttribute("message_auth")%> 
        <i class="far fa-2x fa-tired"></i> 
    </b>
</div>
<% }%>
<!-- Start: Login Form Clean -->
<form class="" action="login" method="post">
    <h2 class="sr-only"></h2>

    <div class="col-6 animated fadeInDown offset-3 mt-5 mb-5">
        <div class="card">
            <div class="card-header jr-primary">
                <h1 class="text-white text-center">Login <i class="fas fa-sign-in-alt"></i></h1>
            </div>
            <div class="card-body" style="color:black;">
                <div class="form-group">
                    <label for="email" class="form-check-label">
                        <b>Email <i class="fas fa-envelope"></i></b> ( para probar administrador: <b>admin@djr.cl</b> )
                    </label>
                    <input class="form-control" type="email" name="email" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <label for="pass" class="form-check-label">
                        <b>Contraseña <i class="fas fa-key"></i></b> ( para probar administrador: <b>123</b> )
                    </label>
                    <input class="form-control" type="password" name="pass" placeholder="Contraseña" required="">
                </div>
                <div class="form-group">
                    <button class="btn btn-info btn-block text-white" type="submit">Ingresar</button>
                </div>
            </div>
        </div>
    </div>

</form>
<jsp:include page="layouts/footer.jsp"></jsp:include>

</body>
</html>
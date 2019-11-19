
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html style="background-color: #444f51;">
<%
        HttpSession ses = request.getSession();
        boolean login = false;
        login = Boolean.parseBoolean(String.valueOf(ses.getAttribute("login")));
        if (login) {
            response.sendRedirect("index.jsp");
        }
%>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>velosiped</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.1.1/aos.css">
    <link rel="stylesheet" href="assets/css/login.styles.min.css?h=78c120b717a463955fac6a0f77d52876">
</head>
<body style="width: 100%;">
    <%-- ----------------------------------------------------------------------|
    |||||               Mensaje de error de ingreso                            |
    --------------------------------------------------------------------------%>
    <% if (request.getAttribute("message_auth") != null) { %>
        <div class="alert alert-danger text-center" role="alert">
            <b> 
                <i class="fas fa-2x fa-ban"></i> 
                    <%= request.getAttribute("message_auth") %> 
                <i class="far fa-2x fa-tired"></i> 
            </b>
        </div>
    <% } %>
    <!-- Start: Login Form Clean -->
    <div data-bs-parallax-bg="true" class="login-clean" style="background-color: #444f51;background-size: cover;background-repeat: no-repeat;background-image: url(assets/img/background-login.jpg?h=7b362439fd3a08507f2b4c1016fce2c5);background-position: left;width: 100%;">
        <form class="pulse animated" action="login" method="post" style="background-color: #565959;background-position: top;background-size: cover;filter: contrast(91%) saturate(163%);">
            <h2 class="sr-only"></h2>
            <div data-bs-hover-animate="bounce" class="illustration">
                <i class="icon ion-android-bicycle border-dark jello animated infinite" style="color:white;"></i>
                <h1 style="color:white;">Bienvenido</h1>
                <h1 style="color:white;"><small>Velociped</small></h1>
            </div>
            <div class="form-group">
                <input class="form-control" type="email" name="email" placeholder="Email" required>
            </div>
            <div class="form-group">
                <input class="form-control" type="password" name="pass" placeholder="Contraseña" required="">
            </div>
            <div class="form-group">
                <button class="btn btn-outline-dark active btn-block text-white" type="submit">Ingresar</button>
            </div>
        </form>
    </div>
    <!-- End: Login Form Clean -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.1.1/aos.js"></script>
    <script src="assets/js/script.min.js?h=b402b77bba6981bcbca2e2c72263497d"></script>
</body>
</html>
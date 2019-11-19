<%-- 
    Document   : create
    Created on : 15-10-2019, 16:51:06
    Author     : adrian
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layouts/header.jsp"></jsp:include>
<c:set var="path" value="<%= request.getServletContext().getContextPath()%>"></c:set>
    <div class="col-12 mb-5">
        <div class="card bg-dark text-white mb-5"> 
            <div class="card card-header">
                <h1 class="text-center">Ingreso</h1>
            </div>
            <form action="${path}/userc" method="post">
                <input type="hidden" value="create" name="type">
                <div class="card card-body bg-dark">
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="name" class="form-check-label">Nombre</label>
                                <input type="text" name="name" class="form-control" required="required">
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="email" class="form-check-label">Email</label>
                                <input type="email" name="email" class="form-control" required="required">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="user" class="form-check-label">Nombre de usuario</label>
                                <input type="text" name="user" class="form-control">
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="pass" class="form-check-label">Contraseña</label>
                                <input type="password" name="pass" class="form-control" required="required">
                            </div>
                        </div>
                    </div>
                    <!--<div class="row">
                        <div class="col-12">
                            <div class="form-group">
                                <label for="adress" class="form-check-label">Direccion</label>
                                <input type="text" name="adress" class="form-control" required="required">
                            </div>
                        </div>
                    </div> -->
                </div>
                <div class="card card-footer">
                    <div class="col-12">
                        <button class="btn btn-info btn-block">Registrarse</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
<jsp:include page="../layouts/footer.jsp"></jsp:include>
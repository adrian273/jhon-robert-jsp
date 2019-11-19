<%-- 
    Document   : info
    Created on : 16-10-2019, 12:16:15
    Author     : adrian
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layouts/header.jsp"></jsp:include>

<%
    ArrayList data = (ArrayList) request.getAttribute("data");
    String msg = "";
    msg = String.valueOf(request.getAttribute("msg"));
%>  

<c:set var="path" value="<%= request.getServletContext().getContextPath()%>"></c:set>
<% if (request.getAttribute("message_edit") != null) {%>
<div class="alert alert-success text-center" role="alert">
    <b> 
        <%= request.getAttribute("message_edit")%> 
        <i class="fas fa-2x fa-save"></i> 
    </b>
</div>
<% }%>
<div class="col-12 mb-5">
    <div class="card bg-dark mb-5 text-white"> 
        <div class="card card-header">
            <h1 class="text-center">Edicion <i class="fa fa-pencil"></i> </h1>
        </div>
        <form action="${path}/userc" method="post">
            <input type="hidden" value="update" name="type">
            <div class="card-body">
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="name" class="form-check-label">Nombre</label>
                            <input type="text" name="name" class="form-control" required="required" value="<%= data.get(0)%>">
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group">
                            <label for="email" class="form-check-label">Email</label>
                            <input type="email" name="email" class="form-control" required="required" value="<%= data.get(1)%>">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="user" class="form-check-label">Nombre de usuario</label>
                            <input type="text" name="user" class="form-control" value="<%= data.get(2)%>">
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group">
                            <label for="pass" class="form-check-label">Contraseña</label>
                            <input type="password" name="pass" class="form-control" required="required" value="<%= data.get(3)%>">
                        </div>
                    </div>
                </div>
                <!--<div class="row">
                    <div class="col-12">
                        <div class="form-group">
                            <label for="adress" class="form-check-label">Direccion</label>
                            <input type="text" name="adress" class="form-control" required 
                                   value="<% String adress = data.get(4) == null ? "" : (String) data.get(4);%> <%= adress%>">
                        </div>
                    </div>
                </div> -->

            </div>
            <div class="card card-footer">
                <div class="col-12">
                    <button class="btn btn-info btn-block">Guardar <i class="fas fa-save"></i> </button>
                </div>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../layouts/footer.jsp"></jsp:include>
<%-- 
    Document   : edit
    Created on : 21-10-2019, 22:21:50
    Author     : adrian
--%>

<%@page import="java.text.DecimalFormat"%>
<%-- 
    Document   : create
    Created on : 16-10-2019, 17:46:52
    Author     : adrian
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="models.CategoryModel"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layouts/header.jsp"></jsp:include>
<c:set var="path" value="<%= request.getServletContext().getContextPath()%>"></c:set>
<%
    ResultSet data = (ResultSet) request.getAttribute("data");
    data.first();
    //System.out.println(data);
%>
<div class="card bg-dark text-white">

    <form action="<%=request.getContextPath()%>/producto" method="post">

        <input type="hidden" name="type" value="update">
        <input type="hidden" name="id" value="<%= data.getString("id")%>">
        <div class="card-header ">
            <h1 class="text-center"> <a href="<%=request.getContextPath()%>/producto?action=view" class="btn btn-info">Volver <i class="fas fa-arrow-alt-circle-left"></i> </a> Editar Nuevo Producto </h1>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-4">
                    <label for="">Name</label>
                    <input type="text" name="name" class="form-control" required="" value="<%= data.getString("name")%>">
                </div>
                <div class="col-4">
                    <label for="">Slug</label>
                    <input type="text" name="slug" class="form-control" value="<%= data.getString("slug")%>">
                </div>
                <div class="col-4">
                    <label for="">Precio</label>
                    <% DecimalFormat df = new DecimalFormat("###");%>
                    <input type="number" name="precio" class="form-control" required="" value="<%= df.format(Double.parseDouble(data.getString("price")))%>">
                </div>
            </div>

            <div class="row">
                <div class="col-6">
                    <div class="row">
                        <div class="col-6">

                        </div>
                        <div class="col-6">

                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-12">
                            <%
                                String imagen = "";
                                if (data.getString("image") != null || data.getString("image") != "" || data.getString("image") != "null") {
                                    imagen = data.getString("image").toString();

                                }

                            %>
                            <label for="" class="form-check-label">Imagen</label>
                            <div class="input-group mb-3">
                                
                                <div class="input-group-prepend">
                                    <button type="button" class="btn btn-outline-secondary">Opciones</button>
                                    <button type="button" class="btn btn-outline-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="#" onclick="changeUploadImage('default')">Por defecto</a>
                                        <a class="dropdown-item" href="#" onclick="changeUploadImage('url')">Url</a>
                                        <a class="dropdown-item" href="#" onclick="changeUploadImage('upload-file')">Subir Archivo</a>   
                                    </div>
                                </div>
                                <input type="hidden" name="img-temp" id="img-temp" value="<%= imagen %>">
                                <input type="text" name="image" class="form-control image-product" value="<%= imagen %>" aria-label="Text input with segmented dropdown button">
                            </div>
                            <!--<label for="image">Imagen</label> -->
                            <!--<input type="file" class="form-control-file" name="image">-->
                            
                            <!--<input type="text" class="form-control" name="image" value="">
                            <a href="#!">Subir Archivo</a> -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-6">
                    <label for="stock">Stock</label>
                    <input type="number" name="stock" class="form-control" required=""  value="<%= data.getString("stock")%>">
                </div>

                <div class="col-6">
                    <label for="categories_id">Categoria</label>
                    <select name="categories_id" id="categories_id" class="form-control" required="" >
                        <option value=""></option>
                        <%
                            CategoryModel c = new CategoryModel();
                            ResultSet rs = c.getCategories();
                            while (rs.next()) {
                                if (data.getString("categories_id").equals(rs.getString("id"))) {
                        %>
                        <option value="<%= rs.getString("id")%>" selected=""><%= rs.getString("name")%></option>                                
                        <% } else {%>
                        <option value="<%= rs.getString("id")%>"><%= rs.getString("name")%></option>      
                        <% }
                            }%>
                    </select>
                </div>

            </div>
            <div class="row">
                <div class="col-6">
                    <label for="">Description</label>
                    <textarea name="description" id="" cols="30" rows="5" class="form-control"><%= data.getString("description")%></textarea>
                </div>
            </div>
            <div class="row">
                <div class="col-6">
                    <div class="custom-control custom-switch">

                        <input type="hidden" name="visible" value="<%= data.getString("visible")%>" id="visible">
                        <% if (data.getString("visible").equals("1")) { %>
                        <input type="checkbox" class="custom-control-input" id="visible-input" checked="checked" value="" onchange="isVisible(this)">
                        <% } else { %>
                        <input type="checkbox" class="custom-control-input" id="visible-input" value="" onchange="isVisible(this)">
                        <% }%>
                        <label class="custom-control-label" for="visible-input" style="cursor:pointer;">Estado de producto: <span class="visible-input-msg"></span> </label>
                    </div>
                </div>
            </div>

        </div>
        <div class="card-footer">
            <button class="btn btn-info btn-block" type="submit">Agregar</button>
        </div>
    </form>
</div>

<jsp:include page="../layouts/footer.jsp"></jsp:include>
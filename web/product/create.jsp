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
    <div class="card bg-dark text-white">
        <form action="<%=request.getContextPath()%>/test" id="product-store" method="post" enctype="multipart/form-data">
        <input type="hidden" name="type" value="store">
        <div class="card-header ">
            <h1 class="text-center">Agregar Nuevo Producto</h1>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-6">
                    <label for="">Nombre</label>
                    <input type="text" name="name" class="form-control" required="">
                </div>
                <div class="col-6">
                    <label for="">Slug</label>
                    <input type="text" name="slug" class="form-control">
                </div>

            </div>

            <div class="row">
                <div class="col-6">
                    <label for="">Precio</label>
                    <input type="number" name="precio" class="form-control" required="">
                </div>
                <div class="col-6">
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
                        <input type="hidden" name="img-temp" id="img-temp" value="">
                        <input type="text" name="image" class="form-control image-product" value="" aria-label="Text input with segmented dropdown button">
                    </div>
                    <jsp:include page="../layouts/btn-information.jsp">
                        <jsp:param name="msg-information" value="Dejar en blanco para imagen por defecto"></jsp:param>
                    </jsp:include>
                    <!--<label for="image">Imagen
                    </label> -->
                    <!--<input type="file" class="form-control-file" name="image">-->
                    <!--<span>
                        <input type="text" name="image" class="form-control">
                        
                    </span> -->
                </div>
            </div>
            <div class="row">
                <div class="col-6">
                    <label for="stock">Stock</label>
                    <input type="text" name="stock" class="form-control" required="">
                </div>

                <div class="col-6">
                    <label for="categories_id">Categoria</label>
                    <select name="categories_id" id="categories_id" class="form-control" required="">
                        <option value=""></option>
                        <%
                            CategoryModel c = new CategoryModel();
                            ResultSet rs = c.getCategories();
                            while (rs.next()) {
                        %>
                        <option value="<%= rs.getString("id")%>"><%= rs.getString("name")%></option>                                
                        <% }%>
                    </select>
                </div>

            </div>
            <div class="row">
                <div class="col-6">
                    <label for="">Descripcion</label>
                    <textarea name="description" id="" cols="30" rows="5" class="form-control"></textarea>
                </div>


            </div>
            <div class="row">
                <div class="col-6">
                    <div class="custom-control custom-switch">
                        <input type="hidden" name="visible" value="1" id="visible">
                        <input type="checkbox" class="custom-control-input" id="visible-input" checked="checked" value="" onchange="isVisible(this)">
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
<script>
    window.onload = function () {
        changeUploadImage('default');
    }
</script>
<jsp:include page="../layouts/footer.jsp"></jsp:include>
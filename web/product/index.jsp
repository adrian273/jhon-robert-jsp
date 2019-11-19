<%-- 
    Document   : index
    Created on : 16-10-2019, 16:58:16
    Author     : adrian
    View       : mantenedor de productos
--%>

<%@page import="helpers.AppHelpers"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<jsp:include page="../layouts/header.jsp"></jsp:include>

<% if (request.getAttribute("msg") != null) {%> 
<div class="alert alert-<%= request.getAttribute("color")%> alert-dismissible text-center animated fadeInDown show" role="alert">
    <%= request.getAttribute("msg")%>
    <a href="<%=request.getContextPath()%>/producto?action=view" class="close" >
        <span aria-hidden="true">&times;</span>
    </a>
</div>
<% }%>

<div class="col-12">
    <a href="<%=request.getContextPath()%>/product/create.jsp" class="btn btn-info mb-1" 
   style="float:right;">Agregar nuevo <i class="fas fa-plus"></i> </a>
</div>

<jsp:include page="../layouts/show-hide-btn.jsp"></jsp:include>             
<div class="table-fixed col-12">
    <table class="table table-hover table-active">
        <thead class="text-white">
            <tr>
                <th>Id</th>
                <th>Nombre</th>
                <th>Codigo</th>
                <%-- <th>Descripcion</th> --%>
            <th>Precio</th>
            <th>Visible</th>
            <th>Stock</th>
            <th class="t-hidden d-none">Creacion</th>
            <th class="t-hidden d-none">Edicion</th>
            <th>Categoria</th>
            <th> Acciones </th>
        </tr>
    </thead>
    <tbody>
        <%
            ResultSet rs = (ResultSet) request.getAttribute("product_list");
            AppHelpers help = new helpers.AppHelpers();
            while (rs.next()) {
        %>
        <tr>
            <td> <%= rs.getString("id")%>  </td>
            <td> <%= rs.getString("name")%> </td>
            <td> <%= rs.getString("slug")%> </td>
            <%--<td> <%= rs.getString("description")  %> </td> --%>
            <td>
                <%= help.priceFormat(rs.getString("price")) %>
            </td>
            <td>
                <% String visible = rs.getString("visible").equals("1") ? "Visible <i class='far fa-eye'></i>" : "No visible <i class='far fa-eye-slash'></i>";%> 
                <%= visible%>
            </td>
            <td>
                <%= rs.getString("stock")%>
            </td>
            <td class="t-hidden d-none">
                <%= rs.getString("created_at")%>
            </td>
            <td class="t-hidden d-none">
                <%= rs.getString("updated_at")%>
            </td>
            <td>
                <%= rs.getString("name_c")%>
            </td>
            <td>
                <a href="<%=request.getContextPath()%>/producto?action=delete&id=<%= rs.getString("id")%>" 
                   class="btn btn-danger" title="Eliminar <%= rs.getString("name")%>">
                    <i class="fas fa-trash"></i>   
                </a>  
                <a href="<%=request.getContextPath()%>/producto?action=edit&id=<%= rs.getString("id")%>"
                   class="btn btn-warning" title="Editar <%= rs.getString("name")%>"> <i class="fa fa-pencil"></i>  </a>
            </td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>
</div>
<jsp:include page="../layouts/footer.jsp"></jsp:include>

<%-- 
    Document   : index
    Created on : 03-11-2019, 1:15:58
    Author     : adrian
--%>

<%@page import="helpers.AppHelpers"%>
<%@page import="java.sql.ResultSet"%>
<jsp:include page="../layouts/header.jsp"></jsp:include>
    <style>
        tr {
            cursor: pointer;
        }

        .helpme {
            float: right;
        }

    </style>
    <button type="button" class="btn btn-secondary helpme mb-3" 
            data-toggle="tooltip" data-placement="bottom" 
            title="Presiona la celda para editar o ver informacion">
        <i class="far fa-question-circle"></i>
    </button>

    <div class="table-fixed">
        <table class="table table-hover table-dark">
            <h4> Lista de usuarios </h4>
            <thead>
                <tr> 
                    <th>Id</th>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Creacion</th>
                    <th>Edicion</th>
                    <th>Tipo</th>
                </tr>
            </thead>
            <tbody>
            <%
                ResultSet row = (ResultSet) request.getAttribute("data");
                int num = 0;
                while (row.next()) {
                    num += 1;

            %>
            <tr onclick="viewInfoUser(<%= row.getString("id") %>)" title="Presiona para mostrar información">
                <td> <%= row.getString("id") %> </td>
                <td> <%= row.getString("name") %> </td>
                <td> <%= row.getString("email") %> </td>
                <td> <%= row.getString("created_at") %> </td>
                <td> <%= row.getString("updated_at") %> </td>
                <td <% String color = row.getString("type").equals("admin") ? "primary" : "warning"; %> > 
                    <span class="badge badge-<%= color %> pt-3 pb-3">
                        <%= row.getString("type") %> 
                    </span>
                </td>
            </tr>
            <%}%>
        <caption>Lista de Usuarios <b><%= num%></b> </caption>
        </tbody>
    </table>
</div>
<jsp:include page="../user/modal-info.jsp"></jsp:include>        
<jsp:include page="../layouts/footer.jsp"></jsp:include>

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
            <h4> Lista de Ordenes </h4>
            <thead>
                <tr> 
                    <th>Id</th>
                    <th>Nombre Cliente</th>
                    <th>Total</th>
                    <th>Creada</th>
                    <th>Edicion</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
            <%
                AppHelpers help = new AppHelpers();
                ResultSet row = (ResultSet) request.getAttribute("data");
                int num = 0;
                while (row.next()) {
                    num += 1;

            %>
            <tr onclick="viewOrder(<%= row.getString("ors.id")%>)" title="Presiona para editar o ver info">
                <td> <a href="order?type=view_order&i=<%= row.getString("ors.id")%>"><%=  row.getString("ors.id")%> </a></td>
                <td> <%= row.getString("us.name")%> </td>
                <td> <%= help.priceFormat(row.getString("ors.shipping"))%> </td>
                <td> <%= row.getString("ors.created_at")%> </td>
                <td> <%= row.getString("ors.updated_at")%> </td>
                <td>  
                    <span class="badge badge-<%= row.getString("st_ors.color")%>"><%= row.getString("st_ors.status")%></span>
                </td>
            </tr>
            <%}%>
        <caption>Lista de Ventas/Total: <b><%= num%></b> </caption>
        </tbody>
    </table>
</div>
<%-- modal de informacion de las ordenes --%>
<jsp:include page="../orders/info.jsp"></jsp:include>
<%-- ------------------------------------ ----%>
<jsp:include page="../layouts/footer.jsp"></jsp:include>
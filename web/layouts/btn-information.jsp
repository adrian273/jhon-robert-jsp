<%-- 
    Document   : btn-information
    Created on : 11-11-2019, 11:52:45
    Author     : adrian
--%>

<%
    String msg = request.getParameter("msg-information");
%>

<button type="button" class="btn btn-secondary helpme mb-3" 
        data-toggle="tooltip" data-placement="bottom" 
        title="<%= msg %>">
    <i class="far fa-question-circle"></i>
</button>

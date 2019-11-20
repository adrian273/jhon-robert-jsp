<%-- 
    Document   : contact
    Created on : 20-11-2019, 11:23:14
    Author     : adrian
--%>


<div class="">
    <div class="card" style="border:none;">
        <div class="card-body">
            <div class="row">
                <div class="col-7">
                    <jsp:include page="../help/contact-info.jsp">
                        <jsp:param name="animated" value="true"></jsp:param>
                    </jsp:include>
                </div>
                <div class="col-5">
                    <jsp:include page="../help/contact-form.jsp">
                        <jsp:param name="animated" value="true"></jsp:param>
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
<%-- 
    Document   : contact-form
    Created on : 20-11-2019, 11:40:31
    Author     : adrian
--%>
<%
    String ani = "";
    if (request.getParameter("animated").equals("true")) {
        ani = "wow animated fadeInRight";
    }
%>
<div class="card <%= ani %>">
    <div class="card-header text-center jr-primary text-white">
        <h4>Contáctanos</h4>
    </div>
    <div class="card-body">
        <form action="" method="post">
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="name-customer" class="form-check-label">Tu Nombre</label>
                        <input type="text" name="name-customer" class="form-control" required="">
                    </div>
                </div>
                <div class="col">
                    <div class="form-group">
                        <label for="email-customer" class="form-check-label">Tu Email</label>
                        <input type="text" name="email-customer" class="form-control" required="">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="subject-customer" class="form-check-label">Asunto</label>
                <input type="text" name="subject-customer" class="form-control" required="">
            </div>
            <div class="form-group">
                <label for="message-customer" class="form-check-label">Mensaje</label>

                <textarea name="message-customer" class="form-control" id="" cols="30" rows="10" required=""></textarea>
            </div>
            <button class="btn btn-dark btn-block">Contactar</button>
        </form>
    </div>
</div>

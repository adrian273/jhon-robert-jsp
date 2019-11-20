<%-- 
    Document   : contact-info
    Created on : 20-11-2019, 11:47:14
    Author     : adrian
--%>

<%
    String ani = "";
    if (request.getParameter("animated").equals("true")) {
        ani = "wow animated fadeInLeft";
    }
%>

<div class="container">
    <div class="card <%= ani %>" style="border:none;">
    <div class="card-header text-center" style="background-color: #fff;">
        <h4>Información</h4>
    </div>
    <div class="card-body" style="margin:50px;">
        <h3><i class="fas fa-street-view fa-2x"></i> Dirección</h3>
        <p>Talca Region del Maule</p>
        
        <h3><i class="fab fa-whatsapp fa-2x"></i> Whatsapp</h3>
        <p>+569 37391841</p>
        
        <h3><i class="far fa-clock fa-2x"></i> Horario de Atención</h3>
        <p>Horario de atención 09:00am hasta las 19:00pn</p>
    </div>
</div>
</div>

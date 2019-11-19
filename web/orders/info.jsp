<%-- 
    Document   : info
    Created on : 04-11-2019, 14:01:31
    Author     : adrian
--%>
<!-- MODAL Informacion de la orden -->
<div class="modal bd-example-modal-xl animated fadeInLeft" style="color:white;background-color: #4492e033;" id="myModalOrder" role="dialog">
    <div class="modal-dialog modal-xl jr-primary" tabindex="-1">
        <button type="button" class="btn btn-outline-info" style="float:right;border-radius: 0px;cursor: pointer !important;" 
                data-dismiss="modal">&times;</button>
                
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header jr-primary">
                <h4 class="modal-title">
                    Informacion de La orden N°<i class="idOrder"></i>
                    <input type="hidden" id="idOrderInput" value="">
                </h4>
                <p>Total: <span class="monto_total">0</span></p>
            </div>
            <form id="edit-status-form" style="color:black;">
                 <div class="update-alert"></div>
                 <input type="hidden" name="status_reload" value="0">
                <div class="modal-body" id="info-order-list">
                   
                    
                </div>
            </form>
        </div>
    </div>
</div>
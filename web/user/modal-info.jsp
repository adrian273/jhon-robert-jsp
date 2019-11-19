<%-- 
    Document   : modal-info
    Created on : 05-11-2019, 11:41:51
    Author     : adrian
--%>

<!-- MODAL Informacion de la orden -->

<div class="modal bd-example-modal-xl animated fadeInLeft" style="color:white;background-color: #4492e033;" id="myModalUser" role="dialog">
    <div class="modal-dialog modal-xl bg-dark" tabindex="-1">
        <button type="button" class="btn btn-outline-info" style="float:right;border-radius: 0px;cursor: pointer !important;" 
                data-dismiss="modal">&times;</button>
        <!-- Modal content-->
        <div class="modal-content bg-dark">
            <div class="modal-header">
                <h4 class="modal-title">
                    Datos del Usuario
                </h4>
            </div>
            <form id="user-form">
                <div class="modal-body" id="info-user-list">
                    <div class="update-alert"></div>
                    <div class="jumbotron bg-dark">
                        <input type="hidden" value="0" id="id-user">
                        <input type="hidden" value="0" class="status-reload" name="status_reload"> <!-- Para ver si lo recargo o nop -->
                        <h1 class="display-4" id="name"></h1>
                        <p class="lead">
                            <b> Email: </b> <span id="correo"></span>
                        </p>
                        <hr class="my-4">
                        <p> Fecha Creacion: <span id="date-created"></span>  </p>
                        <p id="content-type-pro"> Tipo de Perfil: <span id="type-profile" ondblclick="changeSelectType(this);"></span> 
                            <a href="#!" class="btn btn-dark" data-toggle="tooltip" data-placement="bottom" 
                                    title="Doble Click en el tipo de perfil para editar">
                                <i class="far fa-question-circle"></i>
                            </a>
                        </p>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
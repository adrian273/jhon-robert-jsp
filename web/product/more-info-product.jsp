<%-- 
    Document   : more-info-product
    Created on : 19-11-2019, 21:39:32
    Author     : adrian
--%>

<!-- MODAL Informacion de la orden -->
<div class="modal bd-example-modal-xl animated fadeInLeft" style="color:white;background-color: #4492e033;" id="myModalMoreInfo" role="dialog">
    <div class="modal-dialog modal-xl jr-primary" tabindex="-1">
        <button type="button" class="btn btn-outline-info" style="float:right;border-radius: 0px;cursor: pointer !important;" 
                data-dismiss="modal">&times;</button>

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header jr-primary">
                <h4 class="modal-title text-center text-uppercase">
                    <span class="name-prod"></span>
                </h4>
                <span class="price-prod" style="float:right;"></span>
            </div>
            <div class="modal-body" style="color:black;">
                <div class="row">
                    <div class="col-4">
                        <span class="image-prod"></span>
                    </div>
                    <div class="col-8">
                        <p class="text-center text-uppercase"><b><span class="name-prod"></span></b></p>
                        <span class="description-prod text-justify"></span>
                        
                        <p class="text-primary"><b> <span class="price-prod" style="float:right;"></span> </b> </p>

                        <span class="category-name-prod badge badge-secondary text-uppercase"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4">
                        <div class="btn-cart-shopping"></div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
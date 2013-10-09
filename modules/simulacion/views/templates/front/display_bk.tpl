{*<link href="modules/simulacion/css/bootstrap.min.css" rel="stylesheet">
<link href="modules/simulacion/css/bootstrap-theme.min.css" rel="stylesheet">
<link href="modules/simulacion/css/jquery.fileupload-ui.css" rel="stylesheet">
<link href="js/jquery/plugins/fancybox/jquery.fancybox.css" rel="stylesheet">
<link href="modules/simulacion/css/simulacion_style.css" rel="stylesheet">*}
<div class="row">
    {*<form enctype="multipart/form-data" method="post" action="{$link->getPageLink('cart')|escape:'html'}?from=customize" id="buy_block">*}
        <p style="display: none">
            {*Variable needed for add to cart form*}
            {*<input type="hidden" name="token" value="{$static_token}"/>
            <input type="hidden" name="id_product" value="{$product_id}" id="product_page_product_id"/>
            <input type="hidden" name="add" value="1"/>
            <input type="hidden" name="id_product_attribute" id="idCombination" value=""/>*}

            {*Width and Height from admin*}
            <input type="hidden" name="width" id="width" value="{$width}"/>
            <input type="hidden" name="height" id="height" value="{$height}"/>

            {*Hidden Language*}
            <input type="hidden" value="{l s='File Uploaded' mod='simulacion'}" id="file_upload_lang" name="file_upload_lang">
            <input type="hidden" value="{l s='Upload Another File' mod='simulacion'}" id="file_upload_another_lang" name="file_upload_another_lang">

            {*Frame and customize id*}
            <input type="hidden" value="{$frame}" name="frame_number" id="frame_number">
            <input type="hidden" value="" name="customize_id" id="customize_id">
        </p>

        <!-- Left Column -->
        <div class="col-md-2">
            <h4>{l s='Upload The Artwork' mod='simulacion'}!</h4>

            <div id="upload_box">
                <div class="input-group input-group-sm">
                    <input type="text" name="fileuploadtext" id="fileuploadtext" class='form-control' disabled>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <span class="btn btn-success btn-sm fileinput-button">
                            <i class="glyphicon glyphicon-plus"></i>
                            <span id="browse_text">Browse</span>
                            <!-- The file input field used as target for the file upload widget -->
                            <input id="fileupload" type="file" name="files">
                        </span>
                        <button type="button" class="btn btn-sm" id="upload_btn" disabled>{l s='Upload' mod='simulacion'}</button>
                    </div>
                </div>
            </div>
            {l s='Dimensiones' mod='simulacion'}<br>
            <br>
            {$width}x{$height}
            <br>
            {$text}
        </div>

        <!-- Center Column -->
        <div class="col-md-6">
            <canvas width="655" height="530" id="c"></canvas>
            <span id="quality_text" class="col-md-4 col-md-offset-4"></span>
        </div>

        <div class="col-md-3 sections">
            <div id="control_container" class="col-md-12">
                <div class="control_group row">
                    <div class="col-md-3 sections">
                        <a id="undo" class="state_change">{l s='Undo' mod='simulacion'}
                            <span class="glyphicon glyphicon-step-backward"></span></a>
                    </div>
                    <div class="col-md-3 sections pull-right">
                        <a id="redo" class="state_change"><span class="glyphicon glyphicon-step-forward"></span>{l s='Redo' mod='simulacion'}
                        </a>
                    </div>
                </div>
                <div class="control_group row title">
                    <span>{l s='Fit to' mod='simulacion'}</span>
                </div>
                <div class="control_group row">
                    <div class="col-md-3 sections">
                            <a href="#" id="fit_width" class="fit_to"><span class="col-md-7 col-md-offset-1">{l s='Width' mod='simulacion'}</span></a>
                            <span class="glyphicon glyphicon-resize-horizontal col-md-4 col-md-offset-3"></span>
                    </div>
                    <div class="col-md-2 sections">
                            <a href="#" id="fit_center" class="fit_to"><span class="col-md-7 col-md-offset-1">{l s='Center' mod='simulacion'}</span></a>
                            <span class="glyphicon glyphicon-screenshot col-md-4 col-md-offset-3"></span>
                    </div>
                    <div class="col-md-3 sections">
                            <a href="#" id="fit_height" class="fit_to"><span class="col-md-7 col-md-offset-1">{l s='Height' mod='simulacion'}</span></a>
                            <span class="glyphicon glyphicon-resize-vertical col-md-4 col-md-offset-3"></span>
                    </div>
                </div>
                <div class="control_group border_top row">
                    <div class="col-md-1 col-md-offset-1 pull-left sections"><a href='#' id="scale_plus" class="scale_btn do-icon"></a></div>
                    <div class="col-md-2 pull-left col-md-offset-0 sections" style="margin-left: 40px">
                        <div class="scale_center">
                            <span class="title">{l s='Scale' mod='simulacion'}</span>
                            <span class="scale_value" data-count="100">100%</span>
                        </div>
                    </div>
                    <div class="col-md-1 col-md-offset-1 pull-left sections"><a href='#' id="scale_minus" class="scale_btn do-icon"></a></div>
                </div>
                <div class="control_group border_top row">
                    <div class="col-md-1 col-md-offset-1 pull-left sections">
                        <span>+90</span><a href="#" id="plus" class="rotate_btn do-icon"></a></div>
                    <div class="col-md-2 pull-left col-md-offset-1 sections rotate_center">
                        <span class="title">{l s='Rotate' mod='simulacion'}</span></div>
                    <div class="col-md-1 col-md-offset-1 pull-left sections">
                        <span>-90</span><a href="#" id="minus" class="rotate_btn do-icon"></a></div>
                </div>
                <div class="control_group border_top row">
                    <div id="pad_control" class="col-md-11">
                        <div class="col-md-2 sections">
                            <div id="pad_left">
                                <a href="#" id="left" class="move_btn">
                                    <span class="arrow-left"></span>
                                    <span>{l s='Left' mod='simulacion'}</span></a>
                            </div>
                        </div>
                        <div class="col-md-4 sections">
                            <div>
                                <a href="#" id="up" class="move_btn">
                                    <span>{l s='Up' mod='simulacion'}</span>
                                    <span class="arrow-up col-md-offset-5"></span></a>
                            </div>
                            <div id="move_pad">{l s='Move' mod='simulacion'}</div>
                            <div>
                                <a href="#" id="down" class="move_btn">
                                    <span class="arrow-down col-md-offset-5"></span>
                                    <span>{l s='Down' mod='simulacion'}</span>
                                </a>
                            </div>
                        </div>

                        <!-- Right Column -->
                        <div class="sections">
                            <div id="pad_right">
                                <a href="#" id="right" class="move_btn">
                                    <span class="arrow-right"></span>
                                    <span>{l s='Right' mod='simulacion'}</span></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="control_group row border_top title">
                    <span>{l s='Filter' mod='simulacion'}</span>
                </div>
                <div class="control_group border_top row">
                        <span class="btn btn-default" style="margin-top: 5px">
                            <a href="#" id="sepia_filter">{l s='Sepia' mod='simulacion'}</a>
                        </span>
                        <span class="btn btn-default" style="margin-top: 5px">
                            <a href="#" id="gray_filter">{l s='Grayscale' mod='simulacion'}</a>
                        </span>
                </div>
                <div class="control_group border_top row">
                    {*<span><button id="add_cart" class="state_change btn btn-primary">Add To Cart</button></span>*}
                    <div class="col-md-12" style="margin-top: 10px">
                        {*<input type="submit" class="exclusive" value="Add to cart" name="Submit">*}
                        <button onclick="javascript:$.fancybox.close(true);" type="button" class="btn btn-primary" id="cancel_canvas">{l s='Cancel' mod='simulacion'}</button>
                        <button type="button" class="btn btn-primary" id="save_canvas">{l s='Save' mod='simulacion'}</button>
                    </div>
                </div>
            </div>
        </div>
    {*</form>*}
</div>

{*Javascript*}
{*
<script src="modules/simulacion/js/all.js"></script>
<script src="modules/simulacion/js/fabric_init.js"></script>
<script src="js/jquery/plugins/fancybox/jquery.fancybox.js"></script>
<script type="text/javascript">
    {literal}
    $('#save_canvas').click(function (e) {
        e.preventDefault();
        var frame = canvas.item(1);
        var img = canvas.item(0);
        img.opacity = 1;
        canvas.remove(frame);
        var dataURL = canvas.toDataURL('jpeg', 1);
        var file = dataURLtoBlob(dataURL);
//        var form = document.getElementById('buy_block');
        // Create new form data
        var fd = new FormData();
        // Append our Canvas image file to the form data
        fd.append("files_new", file);

        $.ajax({
            url: '/prestashop_simulacion/index.php?fc=module&module=simulacion&controller=display&upload=1&id_product='+$('#product_page_product_id').val(),
            type: "POST",
            data: fd,
            processData: false,
            contentType: false,
            beforeSend: function(){
                $.fancybox( '<h5>Processing...</h5>', {modal: true});
            }
        }).done(function (respond) {
//                    alert(respond); return false;
                    $('#customize_id').val(respond);
                    $.fancybox( '<h1>Save Completed</h1>' );
                    $('#buy_block').submit();
                });
    });
    {/literal}
</script>
*}

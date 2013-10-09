<p style="display: none">
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
    {*<span id="quality_text" class="col-md-4 col-md-offset-4"></span>*}
</div>

<div class="col-md-3 sections pull-right">
    <div id="control_container">
        <div class="control_group clearfix">
            <div class="col-md-3 sections">
                <a id="undo" class="state_change">{l s='Undo' mod='simulacion'}
                    <span class="glyphicon glyphicon-step-backward"></span></a>
            </div>
            <div class="col-md-3 sections pull-right">
                <a id="redo" class="state_change"><span class="glyphicon glyphicon-step-forward"></span>{l s='Redo' mod='simulacion'}
                </a>
            </div>
        </div>
        <div class="control_group title clearfix">
            <span>{l s='Fit to' mod='simulacion'}</span>
        </div>
        <div class="control_group clearfix">
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
        <div class="control_group border_top clearfix">
            <div class="col-md-1 col-md-offset-1 pull-left sections">
                <a href='#' id="scale_plus" class="scale_btn do-icon"></a></div>
            <div class="col-md-2 pull-left col-md-offset-0 sections" style="margin-left: 40px">
                <div class="scale_center">
                    <span class="title">{l s='Scale' mod='simulacion'}</span>
                    <span class="scale_value" data-count="100">100%</span>
                </div>
            </div>
            <div class="col-md-1 col-md-offset-1 pull-left sections">
                <a href='#' id="scale_minus" class="scale_btn do-icon"></a></div>
        </div>
        <div class="control_group border_top clearfix">
            <div class="col-md-1 col-md-offset-1 pull-left sections">
                <span>+90</span><a href="#" id="plus" class="rotate_btn do-icon"></a></div>
            <div class="col-md-2 pull-left col-md-offset-1 sections rotate_center">
                <span class="title">{l s='Rotate' mod='simulacion'}</span></div>
            <div class="col-md-1 col-md-offset-1 pull-left sections">
                <span>-90</span><a href="#" id="minus" class="rotate_btn do-icon"></a></div>
        </div>
        <div class="control_group border_top clearfix">
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
        <div class="control_group border_top title clearfix">
            <span>{l s='Filter' mod='simulacion'}</span>
        </div>
        <div class="control_group border_top clearfix">
                        <span class="btn btn-default" style="margin-top: 5px">
                            <a href="#" id="sepia_filter">{l s='Sepia' mod='simulacion'}</a>
                        </span>
                        <span class="btn btn-default" style="margin-top: 5px">
                            <a href="#" id="gray_filter">{l s='Grayscale' mod='simulacion'}</a>
                        </span>
        </div>
        <div class="control_group border_top clearfix">
            {*<span><button id="add_cart" class="state_change btn btn-primary">Add To Cart</button></span>*}
            <div class="col-md-12" style="margin-top: 10px">
                {*<input type="submit" class="exclusive" value="Add to cart" name="Submit">*}
                <button onclick="javascript:$.fancybox.close(true);" type="button" class="btn btn-primary" id="cancel_canvas">{l s='Cancel' mod='simulacion'}</button>
                <button type="button" class="btn btn-primary" id="save_canvas">{l s='Save' mod='simulacion'}</button>
            </div>
        </div>
    </div>
</div>

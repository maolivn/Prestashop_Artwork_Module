<fieldset id="fieldset_0">
    <legend>
        Settings
    </legend>
    <label>Enale Module On This Product</label>
    {*{$module_product}*}
    <div class="margin-form">
        <input type="radio" {if $status == 1}checked='checked'{/if} value="1" name="{$module_name}_status" id="{$module_name}_status_true">True
        <input type="radio" {if $status == 0}checked='checked'{/if} value="0" name="{$module_name}_status" id="{$module_name}_status_false">False
    </div>
    <div class="clear"></div>
    <label>Optional Text </label>

    <div class="margin-form">
        <textarea rows="5" cols="60" id="{$module_name}_text" name="{$module_name}_text">{$product.text}</textarea>
        <sup>*</sup>
    </div>
    <div class="clear"></div>
    <label>Width </label>

    <div class="margin-form">
        <input type="text" size="20" class="" value="{$product.width}" id="{$module_name}_width" name="{$module_name}_width">
        <sup>*</sup>
    </div>
    <div class="clear"></div>
    <label>Height </label>

    <div class="margin-form">
        <input type="text" size="20" class="" value="{$product.height}" id="{$module_name}_height" name="{$module_name}_height">
        <sup>*</sup>
    </div>
    <div class="clear"></div>
    <label>Frame </label>

    <div class="margin-form">
        <input type="text" size="20" class="" value="{$product.frame}" id="{$module_name}_frame" name="{$module_name}_frame">
        <sup>*</sup>
    </div>
    <div class="clear"></div>
    <div class="small"><sup>*</sup> Required field</div>
</fieldset>
<script type="text/javascript">
    if (jQuery) {
        $('form').submit(function () {
            var status, text, width, height, frame;
            status = $('#simulacion_status_true');
            text = $('#simulacion_text').val();
            width = $('#simulacion_width').val();
            height = $('#simulacion_height').val();
            frame = $('#simulacion_frame').val();

            if (status.is(':checked')) {
                if (text == '' || width == '' || height == '' || frame == '') {
                    alert('Please enter required fields.');
                    return false;
                }
                $('#uploadable_files').val('1');
            }
        });
    }
</script>

{counter start=0 assign='customizationField'}
{foreach from=$customizationFields item='field' name='customizationFields'}
    {if $field.type == 0}
        <div class="customizationUploadLine{if $field.required} required{/if}">
            {assign var='key' value='pictures_'|cat:$product->id|cat:'_'|cat:$field.id_customization_field}
            {if isset($pictures.$key)}
                <div class="customizationUploadBrowse">
                    <img src="{$pic_dir}{$pictures.$key}" alt="" style="width: 150px;" />
                    {*<a href="{$link->getProductDeletePictureLink($product, $field.id_customization_field)|escape:'html'}" title="{l s='Delete'}" >
                        <img src="{$img_dir}icon/delete.gif" alt="{l s='Delete'}" class="customization_delete_icon" width="11" height="13" />
                    </a>*}
                </div>
            {/if}
        </div>
        {counter}
    {/if}
{/foreach}
<input type="hidden" value="{$module_link}" name="module_link" id="module_link">
{literal}
<script type="text/javascript">
    $(function () {
        $('#save_canvas').click(function (e) {
            e.preventDefault();
            var frame = canvas.item(1);
            var frame_obj = frame.getObjects();
            var img = canvas.item(0);
            var file, dataURL, newdataURL;
            var owidth = $('#simulacion_form').find('#width').val();
            var oheight = $('#simulacion_form').find('#height').val();

            //Export image with frame
            dataURL = canvas.toDataURL();
            file = dataURLtoBlob(dataURL);

            //Set opacity and set size for image before export
            img.opacity = 1;
            img.scaleToWidth(owidth);
            img.scaleToHeight(oheight);
            canvas.renderAll();
            //alert(original_img.getWidth()); return false;
            //Export image only
            newdataURL = img.toDataURL();
//            var newfile = dataURLtoBlob(img.toDataURL());
            var newfile = dataURLtoBlob(newdataURL);

            /*$.colorbox.close();
            $('#image-block').html('<img src="'+dataURL+'">');
            return false;*/

            // Create new form data
            var fd = new FormData();
            var name = $('.customizationUploadBrowse').find('input[type="file"]').attr('name');

            // Append Canvas image file to the form data
            fd.append(name, file);
            fd.append('simulation_image', newfile);

            //Send canvas image file to server
            $.ajax({
                url: '{/literal}{$module_link}{literal}&upload=1&id_product=' + $('#product_page_product_id').val() +'&img_width='+ owidth + '&img_heigth='+ oheight,
                type: "POST",
                data: fd,
                processData: false,
                contentType: false,
                beforeSend: function () {
                    $.colorbox.close();
                    $.fancybox('<div id="loading_container"><h5>Processing...</h5><div id="loading"></div></div>', {modal: true});
                }
            }).done(function (response) {
                        $.fancybox('<h5>' + response + '</h5>', {modal: true});
                        location.replace('{/literal}{$link->getProductLink($id_product)}{literal}');
                    });
        });
    });
</script>
{/literal}

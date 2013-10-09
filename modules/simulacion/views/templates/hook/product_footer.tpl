{counter start=0 assign='customizationField'}
{foreach from=$customizationFields item='field' name='customizationFields'}
    {if $field.type == 0}
        <div class="customizationUploadLine{if $field.required} required{/if}">
            {assign var='key' value='pictures_'|cat:$product->id|cat:'_'|cat:$field.id_customization_field}
            {*{$pictures|print_r}*}
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
{literal}
<script type="text/javascript">
    $(document).ready(function () {
        $('#save_canvas').click(function (e) {
            e.preventDefault();
            var frame = canvas.item(1);
            var img = canvas.item(0);
            img.opacity = 1;
            canvas.remove(frame);
            var dataURL = img.toDataURL({format: 'png', quality: 1});
            var file = dataURLtoBlob(dataURL);
            /*alert(img.width / canvas.getWidth());
            return false;*/
            // Create new form data
            var fd = new FormData();
            var name = $('.customizationUploadBrowse').find('input[type="file"]').attr('name');

            // Append Canvas image file to the form data
            fd.append(name, file);

            //Send canvas image file to server
            $.ajax({
                url: '{/literal}{$module_link}{literal}&upload=1&id_product=' + $('#product_page_product_id').val() +' &img_width = '+ img.width + ' &img_heigth = '+ img.height,
                type: "POST",
                data: fd,
                processData: false,
                contentType: false,
                beforeSend: function () {
                    $.colorbox.close();
                    $.fancybox('<h5>Processing...</h5>', {modal: true});
                }
            }).done(function (respond) {
                        $.fancybox('<h5>Save Completed</h5>', {modal: true});
                        location.replace('{/literal}{$link->getProductLink($id_product)}{literal}');
                    });
        });
    });
</script>
{/literal}

{foreach from=$products item=product key=k}
    {foreach $product['customizedDatas'] as $customizationPerAddress}
        {foreach $customizationPerAddress as $customizationId => $customization}
            {foreach $customization.datas as $type => $datas}
                {if ($type == Product::CUSTOMIZE_FILE)}
                    {foreach from=$datas item=data}
                        <input type="hidden" value="{$data['value']}" id="hid_img">
                    {/foreach}
                {/if}
            {/foreach}
        {/foreach}
    {/foreach}
{/foreach}
<script type="text/javascript">
    if (jQuery) {
        $('#current_obj').find('.breadcrumb').html('Order#' + $('#hid_img').val());
    }
</script>

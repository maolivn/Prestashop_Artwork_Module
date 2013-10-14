{foreach from=$products item=product key=k}
    {foreach $product['customizedDatas'] as $customizationPerAddress}
        {foreach $customizationPerAddress as $customizationId => $customization}
            {foreach $customization.datas as $type => $datas}
                {if ($type == Product::CUSTOMIZE_FILE)}
                    {foreach from=$datas item=data}
                        <input type="hidden" value="{$data['value']}" id="hid_img">
                        <input type="hidden" value="{$products.module_img}&name={$order->id|intval}-file{$data@iteration}" id="hid_val">
                    {/foreach}
                {/if}
            {/foreach}
        {/foreach}
    {/foreach}
{/foreach}
<script type="text/javascript">
    {literal}
    if (jQuery) {
        $(document).ready(function() {
            var img = $('#hid_img').val();
            var customize_img = $('#orderProducts').find('img[src="{/literal}{$smarty.const._THEME_PROD_PIC_DIR_}{literal}'+ img +'_small"]');
            $('#current_obj').find('.breadcrumb').html('Order#' + img);
            //customize_img.attr('src', '{/literal}{$site}{literal}/upload/{/literal}{$products.module_img}{literal}');
            customize_img.parent().attr('href','displayImage.php?img=' + $('#hid_val').val());
        });
    }
    {/literal}
</script>

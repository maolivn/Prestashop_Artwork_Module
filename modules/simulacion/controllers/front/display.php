<?php
class SimulacionDisplayModuleFrontController extends ModuleFrontController
{
    protected $product;
    public function init()
    {
        parent::init();

        if ($id_product = (int)Tools::getValue('id_product'))
            $this->product = new Product($id_product, true, $this->context->language->id, $this->context->shop->id);

        if (!Validate::isLoadedObject($this->product))
        {
            echo 'Product not found';
            exit;
        }
    }

    public function initContent()
    {
        parent::initContent();
        //Saving product customize
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            if ((int)Tools::getValue('upload') == 1) {
                // If cart has not been saved, we need to do it so that customization fields can have an id_cart
                // We check that the cookie exists first to avoid ghost carts
                if (!$this->context->cart->id && isset($_COOKIE[$this->context->cookie->getName()])) {
                    $this->context->cart->add();
                    $this->context->cookie->id_cart = (int)$this->context->cart->id;
                }
                if($this->pictureUpload((int)Tools::getValue('img_width'), (int)Tools::getValue('img_heigth'))){
                    print('file uploaded');
                    exit;
                }
            }
        }
    }

    protected function pictureUpload($width, $heigth)
    {
        if (!$field_ids = $this->product->getCustomizationFieldIds())
            return false;

        $authorized_file_fields = array();
        foreach ($field_ids as $field_id) {
            if ($field_id['type'] == Product::CUSTOMIZE_FILE){
                $authorized_file_fields[(int)$field_id['id_customization_field']] = 'file'.(int)$field_id['id_customization_field'];
            }
        }

        $indexes = array_flip($authorized_file_fields);

        foreach ($_FILES as $field_name => $file) {
            if (in_array($field_name, $authorized_file_fields) && isset($file['tmp_name']) && !empty($file['tmp_name']))
            {
                $file_name = md5(uniqid(rand(), true));

                $product_picture_width = (int)Configuration::get('PS_PRODUCT_PICTURE_WIDTH');
                $product_picture_height = (int)Configuration::get('PS_PRODUCT_PICTURE_HEIGHT');
                $tmp_name = tempnam(_PS_TMP_IMG_DIR_, 'PS');
                if (!$tmp_name || !move_uploaded_file($file['tmp_name'], $tmp_name))
                    return 'Can not upload file';

                /* Original file */
                if (!ImageManager::resize($tmp_name, _PS_UPLOAD_DIR_.$file_name, $width, $heigth)){
                    return 'An error occurred during the image upload process.';
                }
                /* A smaller one */
                elseif (!ImageManager::resize($tmp_name, _PS_UPLOAD_DIR_.$file_name.'_small', $product_picture_width, $product_picture_height)){
                    return 'An error occurred during the image upload process.';
                }
                elseif (!chmod(_PS_UPLOAD_DIR_.$file_name, 0777) || !chmod(_PS_UPLOAD_DIR_.$file_name.'_small', 0777)){
                    return 'An error occurred during the image upload process.';
                }
                else
                    $this->context->cart->addPictureToProduct($this->product->id, $indexes[$field_name], Product::CUSTOMIZE_FILE, $file_name);
                unlink($tmp_name);
            }
        }
        return true;
    }
}

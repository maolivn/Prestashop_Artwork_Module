<?php
if (!defined('_PS_VERSION_')) exit;

class Simulacion extends Module
{
    public function __construct()
    {
        $this->name          = 'simulacion';
        $this->tab           = 'front_office_features';
        $this->version       = '1.0';
        $this->author        = 'Tan Phan - tanitct89@gmail.com';
        $this->need_instance = 0;

        parent::__construct();

        $this->displayName = $this->l('Simulacion');
        $this->description = $this->l('Description of Simulacion.');

        $this->confirmUninstall = $this->l('Are you sure you want to uninstall?');

        if (!Configuration::get('PS_SIMULACION')) $this->warning = $this->l('No name provided');
    }

    //BOF Display Content in Admin
    public function getContent()
    {
        $output = NULL;

        if (Tools::isSubmit('submit' . $this->name)) {
            $text    = strval(Tools::getValue('PS_SIMULACION_OPTIONAL_TEXT'));
            $width   = strval(Tools::getValue('PS_SIMULACION_WIDTH'));
            $height  = strval(Tools::getValue('PS_SIMULACION_HEIGHT'));
            $frame   = strval(Tools::getValue('PS_SIMULACION_FRAME'));
            $product = strval(Tools::getValue('PS_SIMULACION_PRODUCT'));
            if ((!$text || empty($text) || !Validate::isGenericName($text)) && !$width || empty($width) || !Validate::isGenericName($width)) $output .= $this->displayError($this->l('Invalid Configuration value')); else {
                Configuration::updateValue('PS_SIMULACION_OPTIONAL_TEXT', $text);
                Configuration::updateValue('PS_SIMULACION_WIDTH', $width);
                Configuration::updateValue('PS_SIMULACION_HEIGHT', $height);
                Configuration::updateValue('PS_SIMULACION_FRAME', $frame);
                Configuration::updateValue('PS_SIMULACION_PRODUCT', $product);
                $output .= $this->displayConfirmation($this->l('Settings updated'));
            }
        }

        return $output . $this->displayForm();
    }

    public function displayForm()
    {
        // Get default Language
        $default_lang = (int)Configuration::get('PS_LANG_DEFAULT');

        // Init Fields form array
        $fields_form[0]['form'] = array('legend' => array('title' => $this->l('Settings'),),
                                        'input'  => array(array('type'     => 'textarea',
                                                                'label'    => $this->l('Optional Text'),
                                                                'name'     => 'PS_SIMULACION_OPTIONAL_TEXT',
                                                                'cols'     => 60,
                                                                'rows'     => 5,
                                                                'required' => TRUE),
                                                          array('type'     => 'text',
                                                                'label'    => $this->l('Width'),
                                                                'name'     => 'PS_SIMULACION_WIDTH',
                                                                'size'     => 20,
                                                                'required' => TRUE),
                                                          array('type'     => 'text',
                                                                'label'    => $this->l('Height'),
                                                                'name'     => 'PS_SIMULACION_HEIGHT',
                                                                'size'     => 20,
                                                                'required' => TRUE),
                                                          array('type'     => 'text',
                                                                'label'    => $this->l('Frame'),
                                                                'name'     => 'PS_SIMULACION_FRAME',
                                                                'size'     => 20,
                                                                'required' => TRUE),
                                                          array('type'     => 'select',
                                                                'label'    => $this->l('Product'),
                                                                'name'     => 'PS_SIMULACION_PRODUCT',
                                                                'required' => TRUE,
                                                                'desc'     => $this->l('Please select product.'),
                                                                'options'  => array('query' => Product::getSimpleProducts($this->context->language->id),
                                                                                    'id'    => 'id_product',
                                                                                    'name'  => 'name'))),
                                        'submit' => array('title' => $this->l('Save'),
                                                          'class' => 'button'));

        $helper = new HelperForm();

        // Module, token and currentIndex
        $helper->module          = $this;
        $helper->name_controller = $this->name;
        $helper->token           = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex    = AdminController::$currentIndex . '&configure=' . $this->name;

        // Language
        $helper->default_form_language    = $default_lang;
        $helper->allow_employee_form_lang = $default_lang;

        // Title and toolbar
        $helper->title          = $this->displayName;
        $helper->show_toolbar   = TRUE; // false -> remove toolbar
        $helper->toolbar_scroll = TRUE; // yes - > Toolbar is always visible on the top of the screen.
        $helper->submit_action  = 'submit' . $this->name;
        $helper->toolbar_btn    = array('save' => array('desc' => $this->l('Save'),
                                                        'href' => AdminController::$currentIndex . '&configure=' . $this->name . '&save' . $this->name . '&token=' . Tools::getAdminTokenLite('AdminModules'),),
                                        'back' => array('href' => AdminController::$currentIndex . '&token=' . Tools::getAdminTokenLite('AdminModules'),
                                                        'desc' => $this->l('Back to list')));

        // Load current value
        $helper->fields_value['PS_SIMULACION_OPTIONAL_TEXT'] = Configuration::get('PS_SIMULACION_OPTIONAL_TEXT');
        $helper->fields_value['PS_SIMULACION_WIDTH']         = Configuration::get('PS_SIMULACION_WIDTH');
        $helper->fields_value['PS_SIMULACION_HEIGHT']        = Configuration::get('PS_SIMULACION_HEIGHT');
        $helper->fields_value['PS_SIMULACION_FRAME']         = Configuration::get('PS_SIMULACION_FRAME');
        $helper->fields_value['PS_SIMULACION_PRODUCT']       = Configuration::get('PS_SIMULACION_PRODUCT');

        return $helper->generateForm($fields_form);
    }

    //EOF Display Content in Admin

    public function install()
    {
        if (Shop::isFeatureActive()) Shop::setContext(Shop::CONTEXT_ALL);

        //BOF Create table
        $sql = "CREATE TABLE IF NOT EXISTS `" . _DB_PREFIX_ . "simulacion_product`(
            `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
            `product_id` INT(11) NOT NULL,
            `value` TEXT NOT NULL,
            `status` INT(11) NOT NULL)";

        if (!$result = Db::getInstance()->Execute($sql)) return FALSE;

        //EOF Create table
        return parent::install() && $this->registerHook('header') && $this->registerHook('displayLeftColumnProduct') && $this->registerHook('displayFooterProduct') && $this->registerHook('displayAdminProductsExtra') && $this->registerHook('displayAdminOrder') && $this->registerHook('actionProductSave') && Configuration::updateValue('PS_SIMULACION', 'simulacion');
    }

    public function uninstall()
    {
        //BOF Delete Table
        $sql = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'simulacion_product`';
        Db::getInstance()->Execute($sql);

        //EOF Delete Table
        return parent::uninstall() && Configuration::deleteByName('PS_SIMULACION') && Configuration::deleteByName('PS_SIMULACION_OPTIONAL_TEXT') && Configuration::deleteByName('PS_SIMULACION_WIDTH') && Configuration::deleteByName('PS_SIMULACION_HEIGHT') && Configuration::deleteByName('PS_SIMULACION_FRAME') && Configuration::deleteByName('PS_SIMULACION_PRODUCT');
    }

    public function hookDisplayHeader()
    {
        $page = $this->context->controller->php_self;
        if ($page == 'product') {
            $this->registerHook('displayFooter');
            $this->context->controller->addCSS($this->_path . 'css/bootstrap.css', 'all');
            $this->context->controller->addCSS($this->_path . 'css/jquery.fileupload-ui.css', 'all');
            $this->context->controller->addCSS($this->_path . 'css/simulacion_style.css', 'all');
            $this->context->controller->addCSS($this->_path . 'css/colorbox.css', 'all');
            $this->context->controller->addJS($this->_path . 'js/fabric.all.1.3.min.js');
            $this->context->controller->addJS($this->_path . 'js/fabric_init.js');
            $this->context->controller->addJS($this->_path . 'js/jquery.colorbox-min.js');
        }
    }

    public function hookDisplayFooter()
    {
        return $this->display(__FILE__, 'footer.tpl');
    }

    public function hookDisplayFooterProduct($params)
    {
        //Get customize picture
        $id_product = (int)Tools::getValue('id_product');
        $product    = new Product($id_product, TRUE, $this->context->language->id, $this->context->shop->id);

        //Get modue product
        $module_product = $this->getProduct();
        $values         = unserialize($module_product['value']);

        //Assign variables
        $this->context->smarty->assign(array('module_link'         => $this->context->link->getModuleLink('simulacion', 'display'),
                                             'id_product'          => (int)Tools::getValue('id_product'),
                                             'text'                => $values['text'],
                                             'width'               => $values['width'],
                                             'frame'               => $values['frame'],
                                             'height'              => $values['height'],
                                             'product_id'          => (int)Tools::getValue('product_id'),
                                             'product'             => $product,
                                             'customizationFields' => ($product->customizable) ? $product->getCustomizationFields($this->context->language->id) : FALSE));

        return $this->display(__FILE__, 'product_footer.tpl');
    }

    public function hookDisplayLeftColumnProduct($params)
    {
        //Get module product
        $module_product = $this->getProduct();
        $this->context->smarty->assign(array('module_link' => $this->context->link->getModuleLink('simulacion', 'display'),
                                             'module_name' => $this->name,
                                             'status'      => $module_product['status'],
                                             'id_product'  => (int)Tools::getValue('id_product')));

        return $this->display(__FILE__, 'product.tpl');
    }

    public function hookDisplayAdminProductsExtra($params)
    {
        $module_product = $this->getProduct();
        $this->context->smarty->assign(array('module_name' => $this->name,
                                             'status'      => $module_product['status'],
                                             'product'     => unserialize($module_product['value'])));

        return $this->display(__FILE__, 'admin-tab-body.tpl');
    }

    public function hookDisplayAdminOrder($params)
    {
//        echo Tools::getValue('id_order');
        $order = new Order(Tools::getValue('id_order'));
        if (!Validate::isLoadedObject($order))
            throw new PrestaShopException('object can\'t be loaded');
        $products = $this->getAdminOrderProducts($order);
        $this->context->smarty->assign(array('products' => $products));

        return $this->display(__FILE__, 'admin-order-detail.tpl');
    }

    public function hookActionProductSave($params)
    {
        // Get default Language
        $default_lang = (int)Configuration::get('PS_LANG_DEFAULT');

        $id_product = (int)Tools::getValue('id_product');
        $status     = (int)Tools::getValue($this->name . '_status');

        if ($status == 1) {
            $values = serialize(array('text'   => Tools::getValue($this->name . '_text'),
                                      'width'  => (int)Tools::getValue($this->name . '_width'),
                                      'height' => (int)Tools::getValue($this->name . '_height'),
                                      'frame'  => (int)Tools::getValue($this->name . '_frame')));

            //Check if module is applied
            $product_module = Db::getInstance()->getRow('SELECT id FROM ' . _DB_PREFIX_ . 'simulacion_product WHERE product_id = ' . $id_product);

            if ($product_module) {
                //Update module row
                Db::getInstance()->update('simulacion_product', array('value'  => $values,
                                                                      'status' => $status), 'id = ' . (int)$product_module['id']);
            } else {
                //Insert new module row
                Db::getInstance()->insert('simulacion_product', array('product_id' => $id_product,
                                                                      'value'      => $values,
                                                                      'status'     => $status));
            }
        } else {
            //Set product module status to false
            Db::getInstance()->update('simulacion_product', array('status' => $status), 'product_id = ' . $id_product);

            //Delete customize fields
            $product_field = Db::getInstance()->getRow('SELECT id_customization_field FROM ' . _DB_PREFIX_ . 'customization_field WHERE id_product = ' . $id_product);
            if ($product_field) {
                Db::getInstance()->delete('customization_field', 'id_customization_field = ' . $product_field['id_customization_field']);
                Db::getInstance()->delete('customization_field_lang', 'id_customization_field = ' . $product_field['id_customization_field']);
            }
        }
    }

    protected function getProduct($id_product = NULL)
    {
        //Get module product
        if (!isset($id_product)) $id_product = (int)Tools::getValue('id_product');

        $sql            = 'SELECT * FROM `' . _DB_PREFIX_ . 'simulacion_product` WHERE product_id = ' . $id_product;
        $module_product = Db::getInstance()->getRow($sql);

        return $module_product;
    }

    protected function getAdminOrderProducts($order)
    {
        $products = $order->getProducts();

        foreach ($products as &$product)
        {
            if ($product['image'] != null)
            {
                $name = 'product_mini_'.(int)$product['product_id'].(isset($product['product_attribute_id']) ? '_'.(int)$product['product_attribute_id'] : '').'.jpg';
                // generate image cache, only for back office
                $product['image_tag'] = ImageManager::thumbnail(_PS_IMG_DIR_.'p/'.$product['image']->getExistingImgPath().'.jpg', $name, 45, 'jpg');
                if (file_exists(_PS_TMP_IMG_DIR_.$name))
                    $product['image_size'] = getimagesize(_PS_TMP_IMG_DIR_.$name);
                else
                    $product['image_size'] = false;
            }
        }

        return $products;
    }
}

?>

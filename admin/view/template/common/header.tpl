<?php
//------------------------------------------------------------------------------
define('P3_THEME_VER', '1.2.0');
//------------------------------------------------------------------------------

@require_once DIR_TEMPLATE . 'helper/p3html.php';

if (!defined('P3_CKEDITOR_DIR'))
    define('P3_CKEDITOR_DIR', $this->config->get('p3adminrebooted_ckeditor4') ? 'view/js/ckeditor' : 'view/javascript/ckeditor');

if (!defined('P3_UPDATED'))
    define('P3_UPDATED', 1359608423); // CHANGE THIS TO LAST UPDATED *nix time()

if ($this->config->get('p3adminrebooted_select2')) {
    // DISABLE SELECT2 WHEN MOBILE OS/USER AGENT IS DETECTED
    if (p3html::is_mobile()) {
        $this->config->set('p3adminrebooted_select2', 0);
    }
}
// DISABLE ERROR DISPLAY
$this->config->set('config_error_display', 0);

function fixMenu($menu) {
    $menu = preg_replace('%\s+%m', ' ', $menu);
    $menu = preg_replace('% (<(\/*)ul>) %iU', '\\1', $menu);
    $menu = preg_replace('% (<li(.*)/li>) %iU', '\\1', $menu);
    $menu = preg_replace('% (<a(.*)/a>) %iU', '\\1', $menu);

    $regex_array = array('%<li([^>]*)><a href=""(.*)</a></li>%iU',
        '%<ul([^>]*)>(\s*)</ul>%iU',
            //'%<li class="dropdown-submenu"><a href="#"(.*?)href="#"(.*?)</a></li>%i'
    );

    do {
        $change = false;
        foreach ($regex_array as $regex) {
            if (preg_match($regex, $menu)) {
                $change = true;
                $menu = preg_replace($regex, '', $menu);
            }
        }
    } while ($change);

    return $menu;
}
?><!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">

    <head>
        <meta charset="UTF-8">
        <title><?php echo $title; ?></title>
        <base href="<?php echo $base; ?>">

        <?php if ($description) { ?>
            <meta name="description" content="<?php echo $description; ?>">
        <?php } ?>
        <?php if ($keywords) { ?>
            <meta name="keywords" content="<?php echo $keywords; ?>">
        <?php } ?>
        <?php foreach ($links as $link) { ?>
            <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>">
        <?php } ?>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" type="text/css" href="view/css/<?php echo p3html::p3_stylesheet($this->config->get('p3adminrebooted_flavour')); ?>.min.css?t=<?php echo P3_UPDATED; ?>">
        <link type="text/css" href="view/js/jqueryui/1.8.24/themes/flick/jquery-ui.css" rel="stylesheet">

        <?php foreach ($styles as $style) { ?>
            <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>">
        <?php } ?>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script>
            window.jQuery || document.write('<script src="view/js/jquery/jquery-1.7.2.min.js"><\/script>');
        </script>

        <?php if ($this->config->get('p3adminrebooted_jui_full')) { ?>
            <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/jquery-ui.min.js"></script>
            <script>
                (typeof jQuery.ui != 'undefined') || document.write('<script src="view/js/jqueryui/1.8.24/jquery-ui.min.js"><\/script>');
            </script>
        <?php } else { ?>
            <script src="view/js/jqueryui/1.8.24/jquery-ui.p3.autocomplete.min.js?t=<?php echo P3_UPDATED; ?>"></script>
        <?php } ?>

        <script src="view/js/scripts.min.js?t=<?php echo P3_UPDATED; ?>"></script>

        <?php foreach ($scripts as $script) { ?>
            <script src="<?php echo $script; ?>"></script>
        <?php } ?>
    </head>

    <body class="<?php if (isset($_REQUEST['route'])) echo p3html::slugify($_REQUEST['route']); ?><?php if (isset($body_css_class)) echo ' ' . $body_css_class; ?>">

        <div id="page-wrapper">

            <div id="header">

                <?php if ($logged) { ?>
                    <div id="header-top" class="hidden-collapsed">
                        <div class="container">
                            <div class="row">
                                <div class="span12">
                                    <a class="brand hidden-phone" href="<?php echo $home; ?>" title="<?php echo $heading_title; ?>">
                                        <i class="icon-basket-alt"></i>
                                        <?php echo $this->config->get('config_name'); ?> / <?php echo $heading_title; ?>
                                    </a>
                                    <div class="pull-right"><?php echo $this->user->getUserName(); ?> <i class="icon-user"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="navbar navbar-inverse navbar-fixed-top" id="header-navbar" data-spy="affix" data-offset-top="43">
                        <div class="navbar-inner">
                            <div class="container">
                                <a class="brand brand-small hidden-desktop" href="<?php echo $home; ?>" title="<?php echo $heading_title; ?>">
                                    <i class="icon-basket-alt"></i>
                                    <?php echo $this->config->get('config_name'); ?>
                                </a>

                                <button class="btn btn-navbar" data-toggle="collapse" data-target="#nav-top">
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <div class="nav-collapse collapse navbar-inverse-collapse" id="nav-top">
                                    <?php
                                    ob_start("fixMenu");
                                    ?>
                                    <ul class="nav">

                                        <li id="dashboard">
                                            <a href="<?php echo $home; ?>" class="top" title="<?php echo $text_dashboard; ?>" data-hint="tooltip" data-placement="bottom">
                                                <i class="icon-home icon-large"></i> <span class="visible-collapsed"><?php echo $text_dashboard; ?></span>
                                            </a>
                                        </li>

                                        <li id="cms" class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-sitemap"></i> <?php echo $text_cms; ?> <i class="icon-down-open hidden-collapsed"></i></a>
                                            <a href="#" class="visible-collapsed dropdown-toggle" data-toggle="dropdown"><i class="icon-down-open"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="<?php echo $information; ?>"><?php echo $text_information; ?></a></li>
                                                <li><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>
                                                <li><a href="<?php echo $welcome; ?>"><?php echo $text_welcome; ?></a></li>	
                                                <li><a href="<?php echo $news; ?>"><?php echo $text_news; ?></a></li>	
                                                <li><a href="<?php echo $store_locations; ?>"><?php echo $text_store_locations; ?></a></li>	
                                                <li><a href="<?php echo $event; ?>"><?php echo $text_event; ?></a></li>
                                            </ul>
                                        </li>


                                        <li id="catalog" class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-sitemap"></i> <?php echo $text_catalog; ?> <i class="icon-down-open hidden-collapsed"></i></a>
                                            <a href="#" class="visible-collapsed dropdown-toggle" data-toggle="dropdown"><i class="icon-down-open"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="<?php echo $category; ?>"><?php echo $text_category; ?></a></li>
                                                <li><a href="<?php echo $product; ?>"><?php echo $text_product; ?></a></li>
                                                <li class="dropdown-submenu">
                                                    <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_attribute; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                    <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="<?php echo $attribute; ?>"><?php echo $text_attribute; ?></a></li>
                                                        <li><a href="<?php echo $attribute_group; ?>"><?php echo $text_attribute_group; ?></a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="<?php echo $option; ?>"><?php echo $text_option; ?></a></li>
                                                <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
                                                <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
                                                <li><a href="<?php echo $review; ?>"><?php echo $text_review; ?></a></li>
                                                <li><a href="<?php echo $information; ?>"><?php echo $text_information; ?></a></li>
                                                <li><a href="<?php echo $event; ?>"><?php echo $text_event; ?></a></li>	
                                            </ul>
                                        </li>

                                        <li id="extension" class="dropdown">
                                            <a href="#" class="top dropdown-toggle" data-toggle="dropdown"><i class="icon-cogs"></i> <?php echo $text_extension; ?> <i class="icon-down-open hidden-collapsed"></i></a>
                                            <a href="#" class="visible-collapsed dropdown-toggle" data-toggle="dropdown"><i class="icon-down-open"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="<?php echo $module; ?>"><?php echo $text_module; ?></a></li>
                                                <li><a href="<?php echo $shipping; ?>"><?php echo $text_shipping; ?></a></li>
                                                <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
                                                <li><a href="<?php echo $total; ?>"><?php echo $text_total; ?></a></li>
                                                <li><a href="<?php echo $feed; ?>"><?php echo $text_feed; ?></a></li>
                                                <li><a href="<?php echo $amazon; ?>"><?php echo $text_amazon; ?></a></li>
                                            </ul>
                                        </li>

                                        <li id="sale" class="dropdown">
                                            <a href="#" class="top dropdown-toggle" data-toggle="dropdown"><i class="icon-dollar"></i> <?php echo $text_sale; ?> <i class="icon-down-open hidden-collapsed"></i></a>
                                            <a href="#" class="visible-collapsed dropdown-toggle" data-toggle="dropdown"><i class="icon-down-open"></i></a>
                                            <ul class="dropdown-menu" role="menu">
                                                <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                                                <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
                                                <li class="dropdown-submenu">
                                                    <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_customer; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                    <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="<?php echo $customer; ?>"><?php echo $text_customer; ?></a></li>
                                                        <li><a href="<?php echo $customer_group; ?>"><?php echo $text_customer_group; ?></a></li>
                                                        <li><a href="<?php echo $customer_blacklist; ?>"><?php echo $text_customer_blacklist; ?></a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
                                                <li><a href="<?php echo $coupon; ?>"><?php echo $text_coupon; ?></a></li>
                                                <li><a href="<?php echo $advanced_coupon; ?>"><?php echo $text_advanced_coupon; ?></a></li>
                                                <li class="dropdown-submenu">
                                                    <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_voucher; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                    <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
                                                        <li><a href="<?php echo $voucher_theme; ?>"><?php echo $text_voucher_theme; ?></a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
                                            </ul>
                                        </li>

                                        <li id="system" class="dropdown">
                                            <a href="#" class="top dropdown-toggle" data-toggle="dropdown"><i class="icon-cog"></i> <?php echo $text_system; ?> <i class="icon-down-open hidden-collapsed"></i></a>
                                            <a href="#" class="visible-collapsed dropdown-toggle" data-toggle="dropdown"><i class="icon-down-open"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
                                                <li class="dropdown-submenu">
                                                    <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_design; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                    <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="<?php echo $layout; ?>"><?php echo $text_layout; ?></a></li>
                                                        <li><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>
                                                    </ul>
                                                </li>
                                                <li class="dropdown-submenu">
                                                    <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_users; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                    <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
                                                        <li><a href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
                                                    </ul>
                                                </li>
                                                <li class="dropdown-submenu">
                                                    <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_localisation; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                    <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="<?php echo $language; ?>"><?php echo $text_language; ?></a></li>
                                                        <li><a href="<?php echo $currency; ?>"><?php echo $text_currency; ?></a></li>
                                                        <li><a href="<?php echo $stock_status; ?>"><?php echo $text_stock_status; ?></a></li>
                                                        <li><a href="<?php echo $order_status; ?>"><?php echo $text_order_status; ?></a></li>
                                                        <li><a href="<?php echo $this->url->link('localisation/order_status_label', 'token=' . $this->session->data['token'], 'SSL');
                                ; ?>"><?php echo $text_order_status; ?> - Labels</a></li>
                                                        <li class="dropdown-submenu">
                                                            <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_return; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                            <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                            <ul class="dropdown-menu">
                                                                <li><a href="<?php echo $return_status; ?>"><?php echo $text_return_status; ?></a></li>
                                                                <li><a href="<?php echo $return_action; ?>"><?php echo $text_return_action; ?></a></li>
                                                                <li><a href="<?php echo $return_reason; ?>"><?php echo $text_return_reason; ?></a></li>
                                                            </ul>
                                                        </li>
                                                        <li><a href="<?php echo $country; ?>"><?php echo $text_country; ?></a></li>
                                                        <li><a href="<?php echo $zone; ?>"><?php echo $text_zone; ?></a></li>
                                                        <li><a href="<?php echo $geo_zone; ?>"><?php echo $text_geo_zone; ?></a></li>
                                                        <li class="dropdown-submenu">
                                                            <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_tax; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                            <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                            <ul class="dropdown-menu">
                                                                <li><a href="<?php echo $tax_class; ?>"><?php echo $text_tax_class; ?></a></li>
                                                                <li><a href="<?php echo $tax_rate; ?>"><?php echo $text_tax_rate; ?></a></li>
                                                            </ul>
                                                        </li>
                                                        <li><a href="<?php echo $length_class; ?>"><?php echo $text_length_class; ?></a></li>
                                                        <li><a href="<?php echo $weight_class; ?>"><?php echo $text_weight_class; ?></a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="<?php echo $error_log; ?>"><?php echo $text_error_log; ?></a></li>
                                                <li><a href="<?php echo $backup; ?>"><?php echo $text_backup; ?></a></li>
                                                <li><a href="<?php echo $sage; ?>"><?php echo $text_sage; ?></a></li>
                                                <li><a href="<?php echo $syspro; ?>"><?php echo $text_syspro; ?></a></li>
                                                <li><a href="<?php echo $zencart; ?>"><?php echo $text_zencart; ?></a></li>
                                            </ul>
                                        </li>

                                        <li id="reports" class="dropdown">
                                            <a href="#" class="top dropdown-toggle" data-toggle="dropdown"><i class="icon-chart-bar"></i> <?php echo $text_reports; ?> <i class="icon-down-open hidden-collapsed"></i></a>
                                            <a href="#" class="visible-collapsed dropdown-toggle" data-toggle="dropdown"><i class="icon-down-open"></i></a>
                                            <ul class="dropdown-menu">
                                                <li class="dropdown-submenu">
                                                    <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_sale; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                    <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="<?php echo $report_sale_order; ?>"><?php echo $text_report_sale_order; ?></a></li>
                                                        <li><a href="<?php echo $report_sale_tax; ?>"><?php echo $text_report_sale_tax; ?></a></li>
                                                        <li><a href="<?php echo $report_sale_shipping; ?>"><?php echo $text_report_sale_shipping; ?></a></li>
                                                        <li><a href="<?php echo $report_sale_return; ?>"><?php echo $text_report_sale_return; ?></a></li>
                                                        <li><a href="<?php echo $report_sale_coupon; ?>"><?php echo $text_report_sale_coupon; ?></a></li>
                                                        <li><a href="<?php echo $report_sale_advanced_coupon; ?>"><?php echo $text_report_sale_advanced_coupon; ?></a></li>
                                                    </ul>
                                                </li>
                                                <li class="dropdown-submenu">
                                                    <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_product; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                    <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="<?php echo $report_product_viewed; ?>"><?php echo $text_report_product_viewed; ?></a></li>
                                                        <li><a href="<?php echo $report_product_purchased; ?>"><?php echo $text_report_product_purchased; ?></a></li>
                                                    </ul>
                                                </li>
                                                <li class="dropdown-submenu">
                                                    <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_customer; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                    <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                    <ul class="dropdown-menu">
                                                        <?php if (VERSION >= '1.5.4') { ?>
                                                            <li><a href="<?php echo $report_customer_online; ?>"><?php echo $text_report_customer_online; ?></a></li>
    <?php } ?>
                                                        <li><a href="<?php echo $report_customer_order; ?>"><?php echo $text_report_customer_order; ?></a></li>
                                                        <li><a href="<?php echo $report_product_stock; ?>"><?php echo $text_report_product_stock; ?></a></li>
                                                        <li><a href="<?php echo $report_customer_reward; ?>"><?php echo $text_report_customer_reward; ?></a></li>
                                                        <li><a href="<?php echo $report_customer_credit; ?>"><?php echo $text_report_customer_credit; ?></a></li>
                                                        <li><a href="<?php echo $report_register_your_product; ?>"><?php echo $text_report_register_your_product; ?></a></li>
                                                    </ul>
                                                </li>
                                                <li class="dropdown-submenu">
                                                    <a href="#" class="parent submenu-toggle" data-toggle="submenu"><?php echo $text_affiliate; ?> <i class="icon-right-open hidden-collapsed"></i></a>
                                                    <a href="#" class="visible-collapsed submenu-toggle" data-toggle="submenu"><i class="icon-down-open"></i></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="<?php echo $report_affiliate_commission; ?>"><?php echo $text_report_affiliate_commission; ?></a></li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </li>

    <?php if (!$this->config->get('p3adminrebooted_hide_helpmenu')) : ?>
                                            <li id="help" class="dropdown">
                                                <a href="#" class="top dropdown-toggle" data-toggle="dropdown"><i class="icon-help-circled"></i> <?php echo $text_help; ?></a>
                                                <ul class="dropdown-menu">
                                                    <li><a href="http://www.opencart.com" target="_blank"><?php echo $text_opencart; ?></a></li>
                                                    <li><a href="http://www.opencart.com/index.php?route=documentation/introduction" target="_blank"><?php echo $text_documentation; ?></a></li>
                                                    <li><a href="http://forum.opencart.com" target="_blank"><?php echo $text_support; ?></a></li>
                                                </ul>
                                            </li>
                                    <?php endif; ?>
                                    </ul>
                                    <?php
                                    ob_end_flush();
                                    ?>
                                    <ul class="nav pull-right">
                                        <li id="store" class="dropdown">
                                            <a href="<?php echo $store; ?>" target="_blank" title="<?php echo $text_front; ?>"<?php if (!$stores) { ?> data-hint="tooltip" data-placement="bottom"<?php } ?>
                                               class="top<?php if ($stores) { ?> dropdown-toggle<?php } ?>"<?php if ($stores) { ?> data-toggle="dropdown"<?php } ?>>
                                                <i class="icon-eye-open"></i><span class="visible-collapsed"> <?php echo $text_front; ?></span>
                                            <?php if ($stores) { ?><i class="icon-down-open hidden-collapsed"></i><?php } ?>
                                            </a>
    <?php if ($stores) { ?>
                                                <a href="#" class="visible-collapsed dropdown-toggle" data-toggle="dropdown"><i class="icon-down-open"></i></a>
                                                <ul class="dropdown-menu">
                                                    <li><a href="<?php echo $store; ?>" target="_blank"><?php echo $this->config->get('config_name'); ?></a></li>
                                                    <?php foreach ($stores as $store) { ?>
                                                        <li><a href="<?php echo $store['href']; ?>" target="_blank"><?php echo $store['name']; ?></a></li>
                                                <?php } ?>
                                                </ul>
    <?php } ?>
                                        </li>
                                        <li id="logout"><a class="top" href="<?php echo $logout; ?>"><i class="icon-signout"></i> <?php echo $text_logout; ?></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
<?php } ?>
            </div>

            <div id="main">
                <div class="container">

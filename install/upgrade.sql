# OPENCART UPGRADE SCRIPT v1.5.x
# WWW.OPENCART.COM
# Qphoria

# THIS UPGRADE ONLY APPLIES TO PREVIOUS 1.5.x VERSIONS. DO NOT RUN THIS SCRIPT IF UPGRADING FROM v1.4.x

# DO NOT RUN THIS ENTIRE FILE MANUALLY THROUGH PHPMYADMIN OR OTHER MYSQL DB TOOL
# THIS FILE IS GENERATED FOR USE WITH THE UPGRADE.PHP SCRIPT LOCATED IN THE INSTALL FOLDER
# THE UPGRADE.PHP SCRIPT IS DESIGNED TO VERIFY THE TABLES BEFORE EXECUTING WHICH PREVENTS ERRORS

# IF YOU NEED TO MANUALLY RUN THEN YOU CAN DO IT BY INDIVIDUAL VERSIONS. EACH SECTION IS LABELED.
# BE SURE YOU CHANGE THE PREFIX "oc_" TO YOUR PREFIX OR REMOVE IT IF NOT USING A PREFIX

#### START 1.5.1

ALTER TABLE `oc_affiliate` MODIFY `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_affiliate` MODIFY `approved` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_banner` MODIFY `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_category` MODIFY `top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_category` MODIFY `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_country` MODIFY `postcode_required` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_country` MODIFY `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '';
ALTER TABLE `oc_coupon` MODIFY `logged` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_coupon` MODIFY `shipping` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_coupon` MODIFY `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_currency` MODIFY `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_customer` MODIFY `newsletter` tinyint(1) NOT NULL DEFAULT '0' COMMENT '';
ALTER TABLE `oc_customer`  MODIFY `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_customer`  MODIFY `approved` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_information` MODIFY `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '';
ALTER TABLE `oc_language` MODIFY `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_order_history` MODIFY `notify` tinyint(1) NOT NULL DEFAULT '0' COMMENT '';
ALTER TABLE `oc_product` MODIFY `shipping` tinyint(1) NOT NULL DEFAULT '1' COMMENT '';
ALTER TABLE `oc_product` MODIFY `subtract` tinyint(1) NOT NULL DEFAULT '1' COMMENT '';
ALTER TABLE `oc_product` MODIFY `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '';
ALTER TABLE `oc_product_option` MODIFY `required` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_product_option_value` MODIFY `subtract` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_return_history` MODIFY `notify` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_return_product` MODIFY `opened` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_review` MODIFY `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '';
ALTER TABLE `oc_user` MODIFY `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_voucher` MODIFY `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '';
ALTER TABLE `oc_zone`  MODIFY `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '';
ALTER TABLE `oc_setting` ADD `serialized` tinyint(1) NOT NULL DEFAULT 0 COMMENT '' AFTER value;


#### START 1.5.1.3

CREATE TABLE IF NOT EXISTS oc_tax_rate_to_customer_group (
    tax_rate_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    customer_group_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    PRIMARY KEY (tax_rate_id, customer_group_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS oc_tax_rule (
    tax_rule_id int(11) NOT NULL DEFAULT 0 COMMENT '' auto_increment,
    tax_class_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    tax_rate_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    based varchar(10) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    priority int(5) NOT NULL DEFAULT '1' COMMENT '',
    PRIMARY KEY (tax_rule_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE oc_customer ADD token varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER approved;
ALTER TABLE oc_option_value ADD image varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER option_id;
ALTER TABLE oc_order MODIFY invoice_prefix varchar(26) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin;
ALTER TABLE oc_product_image ADD sort_order int(3) NOT NULL DEFAULT '0' COMMENT '' AFTER image;
ALTER TABLE oc_tax_rate ADD name varchar(32) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER geo_zone_id;
ALTER TABLE oc_tax_rate ADD type char(1) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER rate;
ALTER TABLE oc_tax_rate DROP tax_class_id;
ALTER TABLE oc_tax_rate DROP priority;
ALTER TABLE oc_tax_rate MODIFY rate decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '';
ALTER TABLE oc_tax_rate DROP description;



#### START 1.5.2
CREATE TABLE IF NOT EXISTS oc_customer_ip_blacklist (
    customer_ip_blacklist_id int(11) NOT NULL DEFAULT 0 COMMENT '' auto_increment,
    ip varchar(15) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    PRIMARY KEY (customer_ip_blacklist_id),
    INDEX ip (ip)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS oc_order_fraud (
    order_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    customer_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    country_match varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    country_code varchar(2) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    high_risk_country varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    distance int(11) NOT NULL DEFAULT 0 COMMENT '',
    ip_region varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_city varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_latitude decimal(10,6) NOT NULL DEFAULT '' COMMENT '',
    ip_longitude decimal(10,6) NOT NULL DEFAULT '' COMMENT '',
    ip_isp varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_org varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_asnum int(11) NOT NULL DEFAULT 0 COMMENT '',
    ip_user_type varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_country_confidence varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_region_confidence varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_city_confidence varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_postal_confidence varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_postal_code varchar(10) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_accuracy_radius int(11) NOT NULL DEFAULT 0 COMMENT '',
    ip_net_speed_cell varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_metro_code int(3) NOT NULL DEFAULT 0 COMMENT '',
    ip_area_code int(3) NOT NULL DEFAULT 0 COMMENT '',
    ip_time_zone varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_region_name varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_domain varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_country_name varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_continent_code varchar(2) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ip_corporate_proxy varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    anonymous_proxy varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    proxy_score int(3) NOT NULL DEFAULT 0 COMMENT '',
    is_trans_proxy varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    free_mail varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    carder_email varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    high_risk_username varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    high_risk_password varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    bin_match varchar(10) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    bin_country varchar(2) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    bin_name_match varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    bin_name varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    bin_phone_match varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    bin_phone varchar(32) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    customer_phone_in_billing_location varchar(8) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ship_forward varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    city_postal_match varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    ship_city_postal_match varchar(3) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    score decimal(10,5) NOT NULL DEFAULT '' COMMENT '',
    explanation text NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    risk_score decimal(10,5) NOT NULL DEFAULT '' COMMENT '',
    queries_remaining int(11) NOT NULL DEFAULT 0 COMMENT '',
    maxmind_id varchar(8) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    error text NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    date_added datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '',
    PRIMARY KEY (order_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS oc_order_voucher (
    order_voucher_id int(11) NOT NULL DEFAULT 0 COMMENT '' auto_increment,
    order_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    voucher_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    description varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    code varchar(10) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    from_name varchar(64) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    from_email varchar(96) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    to_name varchar(64) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    to_email varchar(96) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    voucher_theme_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    message text NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    amount decimal(15,4) NOT NULL DEFAULT '' COMMENT '',
    PRIMARY KEY (order_voucher_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE oc_order ADD shipping_code varchar(128) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER shipping_method;
ALTER TABLE oc_order ADD payment_code varchar(128) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER payment_method;
ALTER TABLE oc_order ADD forwarded_ip varchar(15) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER ip;
ALTER TABLE oc_order ADD user_agent varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER forwarded_ip;
ALTER TABLE oc_order ADD accept_language varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER user_agent;
ALTER TABLE oc_order DROP reward;

ALTER TABLE oc_order_product ADD reward int(8) NOT NULL DEFAULT 0 COMMENT '' AFTER tax;

ALTER TABLE oc_product MODIFY `weight` decimal(15,8) NOT NULL DEFAULT '0.00000000' COMMENT '';
ALTER TABLE oc_product MODIFY `length` decimal(15,8) NOT NULL DEFAULT '0.00000000' COMMENT '';
ALTER TABLE oc_product MODIFY `width` decimal(15,8) NOT NULL DEFAULT '0.00000000' COMMENT '';
ALTER TABLE oc_product MODIFY `height` decimal(15,8) NOT NULL DEFAULT '0.00000000' COMMENT '';

ALTER TABLE `oc_return` ADD `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '' AFTER `order_id`;
ALTER TABLE `oc_return` ADD `product` varchar(255) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER `telephone`;
ALTER TABLE `oc_return` ADD `model` varchar(64) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER `product`;
ALTER TABLE `oc_return` ADD `quantity` int(4) NOT NULL DEFAULT '0' COMMENT '' AFTER `model`;
ALTER TABLE `oc_return` ADD `opened` tinyint(1) NOT NULL DEFAULT '0' COMMENT '' AFTER `quantity`;
ALTER TABLE `oc_return` ADD `return_reason_id` int(11) NOT NULL DEFAULT '0' COMMENT '' AFTER `opened`;
ALTER TABLE `oc_return` ADD `return_action_id` int(11) NOT NULL DEFAULT '0' COMMENT '' AFTER `return_reason_id`;

DROP TABLE IF EXISTS oc_return_product;

ALTER TABLE oc_tax_rate_to_customer_group DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

# Disable Category Module to force user to reenable with new settings to avoid php error
UPDATE `oc_setting` SET `value` = replace(`value`, 's:6:"status";s:1:"1"', 's:6:"status";s:1:"0"') WHERE `key` = 'category_module';

#### Start 1.5.2.2

# Disable UPS Extension to force user to reenable with new settings to avoid php error
UPDATE `oc_setting` SET `value` = 0 WHERE `key` = 'ups_status';

CREATE TABLE IF NOT EXISTS oc_customer_group_description (
    customer_group_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    language_id int(11) NOT NULL DEFAULT 0 COMMENT '',
    name varchar(32) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    description text NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin,
    PRIMARY KEY (customer_group_id, language_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE oc_address ADD company_id varchar(32) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER company;
ALTER TABLE oc_address ADD tax_id varchar(32) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER company_id;
ALTER TABLE oc_address DROP company_no;
ALTER TABLE oc_address DROP company_tax;

ALTER TABLE oc_customer_group ADD approval int(1) NOT NULL DEFAULT 0 COMMENT '' AFTER customer_group_id;
ALTER TABLE oc_customer_group ADD company_id_display int(1) NOT NULL DEFAULT 0 COMMENT '' AFTER approval;
ALTER TABLE oc_customer_group ADD company_id_required int(1) NOT NULL DEFAULT 0 COMMENT '' AFTER company_id_display;
ALTER TABLE oc_customer_group ADD tax_id_display int(1) NOT NULL DEFAULT 0 COMMENT '' AFTER company_id_required;
ALTER TABLE oc_customer_group ADD tax_id_required int(1) NOT NULL DEFAULT 0 COMMENT '' AFTER tax_id_display;
ALTER TABLE oc_customer_group ADD sort_order int(3) NOT NULL DEFAULT 0 COMMENT '' AFTER tax_id_required;

### This line is executed using php in the upgrade model file so we dont lose names
#ALTER TABLE oc_customer_group DROP name;

ALTER TABLE `oc_order` ADD payment_company_id varchar(32) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER payment_company;
ALTER TABLE `oc_order` ADD payment_tax_id varchar(32) NOT NULL DEFAULT '' COMMENT '' COLLATE utf8_bin AFTER payment_company_id;
ALTER TABLE `oc_information` ADD bottom int(1) NOT NULL DEFAULT '1' COMMENT '' AFTER information_id;

#### Start 1.5.4
CREATE TABLE IF NOT EXISTS `oc_customer_online` (
  `ip` varchar(40) COLLATE utf8_bin NOT NULL,
  `customer_id` int(11) NOT NULL,
  `url` text COLLATE utf8_bin NOT NULL,
  `referer` text COLLATE utf8_bin NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`ip`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

UPDATE `oc_setting` set `group` = replace(`group`, 'alertpay', 'payza');
UPDATE `oc_setting` set `key` = replace(`key`, 'alertpay', 'payza');
UPDATE `oc_order` set `payment_method` = replace(`payment_method`, 'AlertPay', 'Payza');
UPDATE `oc_order` set `payment_code` = replace(`payment_code`, 'alertpay', 'payza');
ALTER TABLE `oc_affiliate` ADD `salt` varchar(9) COLLATE utf8_bin NOT NULL DEFAULT '' after `password`;
ALTER TABLE `oc_customer` ADD `salt` varchar(9) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `password`;
ALTER TABLE `oc_customer` MODIFY `ip` varchar(40) NOT NULL;
ALTER TABLE `oc_customer_ip` MODIFY `ip` varchar(40) NOT NULL;
ALTER TABLE `oc_customer_ip_blacklist` MODIFY `ip` varchar(40) NOT NULL;
ALTER TABLE `oc_order` MODIFY `ip` varchar(40) NOT NULL;
ALTER TABLE `oc_order` MODIFY `forwarded_ip` varchar(40) NOT NULL;
ALTER TABLE `oc_order_product` MODIFY `model` varchar(64) NOT NULL;
ALTER TABLE `oc_product` ADD `ean` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `upc`;
ALTER TABLE `oc_product` ADD `jan` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `ean`;
ALTER TABLE `oc_product` ADD `isbn` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `jan`;
ALTER TABLE `oc_product` ADD `mpn` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `isbn`;
ALTER TABLE `oc_product_description` ADD `tag` text COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `meta_keyword`;
ALTER TABLE `oc_product_description` ADD FULLTEXT (`description`);
ALTER TABLE `oc_product_description` ADD FULLTEXT (`tag`);
ALTER TABLE `oc_user` ADD `salt` varchar(9) COLLATE utf8_bin NOT NULL DEFAULT '' after `password`;
ALTER TABLE `oc_user` MODIFY `password` varchar(40) NOT NULL;
ALTER TABLE `oc_user` MODIFY `ip` varchar(40) NOT NULL;

###########################################################
#### Start 1.5.4:BC1
ALTER TABLE `oc_user` MODIFY `code` VARCHAR(64) COLLATE utf8_bin NOT NULL;
ALTER TABLE `oc_user_group` ADD `superuser` TINYINT DEFAULT 0;
UPDATE `oc_user_group` SET `superuser` = 1 WHERE `user_group_id` = 1;
ALTER TABLE `oc_information` ADD image varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '' AFTER status;

CREATE TABLE IF NOT EXISTS `oc_advanced_coupon` (
  `advanced_coupon_id` int(11) NOT NULL auto_increment,
  `name` varchar(64) NOT NULL,
  `code` varchar(32) NOT NULL,
  `options` text NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  `status` int(11) NOT NULL,
  `date_added` date NOT NULL,
  PRIMARY KEY  (`advanced_coupon_id`),
  UNIQUE KEY `name` (`code`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

CREATE TABLE IF NOT EXISTS `oc_advanced_coupon_history` (
  `advanced_coupon_history_id` int(11) NOT NULL auto_increment,
  `advanced_coupon_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`advanced_coupon_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `oc_ncategory` (
  `ncategory_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `top` tinyint(1) NOT NULL,
  `column` int(3) NOT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ncategory_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=59 ;

CREATE TABLE IF NOT EXISTS `oc_ncategory_description` (
  `ncategory_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` text COLLATE utf8_bin NOT NULL,
  `meta_description` varchar(255) COLLATE utf8_bin NOT NULL,
  `meta_keyword` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ncategory_id`,`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `oc_ncategory_to_layout` (
  `ncategory_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `layout_id` int(11) NOT NULL,
  PRIMARY KEY (`ncategory_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `oc_ncategory_to_store` (
  `ncategory_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`ncategory_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `oc_ncomments` (
  `ncomment_id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `author` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `text` text COLLATE utf8_bin NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ncomment_id`),
  KEY `news_id` (`news_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=37 ;

CREATE TABLE IF NOT EXISTS `oc_news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(1) NOT NULL DEFAULT '0',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `acom` int(1) NOT NULL DEFAULT '0',
  `date_added` datetime DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`news_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

CREATE TABLE IF NOT EXISTS `oc_news_description` (
  `news_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `meta_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `meta_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`news_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `oc_news_related` (
  `news_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`news_id`,`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `oc_news_to_layout` (
  `news_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `layout_id` int(11) NOT NULL,
  PRIMARY KEY (`news_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `oc_news_to_ncategory` (
  `news_id` int(11) NOT NULL,
  `ncategory_id` int(11) NOT NULL,
  PRIMARY KEY (`news_id`,`ncategory_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `oc_news_to_store` (
  `news_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`news_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DELETE FROM `oc_url_alias` WHERE `query` = "news/headlines";
INSERT INTO `oc_url_alias` (query, keyword) VALUES ('news/headlines', 'articles-headlines');

###########################################################
#### Start 1.5.4:BC1
ALTER TABLE `oc_product_option_value` ADD `sku` varchar(64) COLLATE utf8_bin NOT NULL AFTER `option_value_id`;

# REMEMBER TO ADD ROW config_anonymous_review IN setting!!!!

ALTER TABLE `oc_product_image` ADD `video` varchar(255) COLLATE utf8_bin DEFAULT NULL AFTER `image`;

ALTER TABLE `oc_product_option_value` ADD `ean` varchar(64) COLLATE utf8_bin NOT NULL AFTER `sku`;

ALTER TABLE `oc_banner_image_description` ADD `description` text COLLATE utf8_bin NOT NULL AFTER `title`;

ALTER TABLE `oc_banner_image` ADD `sort_order` int(3) NOT NULL AFTER `image`;

ALTER TABLE `oc_information_description` ADD `category` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `language_id`;

ALTER TABLE `oc_information` ADD `menu` int(1) NOT NULL DEFAULT '0' AFTER `information_id`; 

#### Start 1.5.4:BC1.2

ALTER TABLE `oc_category_description` ADD `meta_title` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `meta_keyword`;
ALTER TABLE `oc_product_description` ADD `meta_title` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `meta_keyword`;
ALTER TABLE `oc_ncategory_description` ADD `meta_title` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `meta_keyword`;
ALTER TABLE `oc_news_description` ADD `meta_title` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `meta_key`;

ALTER TABLE `oc_information_description` ADD `meta_title` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `description`;
ALTER TABLE `oc_information_description` ADD `meta_description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `meta_title`;
ALTER TABLE `oc_information_description` ADD `meta_keyword` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' AFTER `meta_description`;

#### Start 1.5.4:BC1.2.1

CREATE TABLE IF NOT EXISTS `oc_sage_stock_item` (
  `stock_item_id` int(11) NOT NULL,
  `stock_item_code` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `stock_item_name` text COLLATE utf8_bin NOT NULL,
  `data` blob,
  `product_id` int(11) NOT NULL,
  `product_option_value_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_processed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`stock_item_id`),
  KEY `product_id` (`product_id`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `oc_sage_order` (
  `sage_id` int(11) NOT NULL,
  `sage_reference` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `sage_status` text COLLATE utf8_bin NOT NULL,
  `data` blob,
  `order_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_processed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`sage_id`),
  KEY `order_id` (`order_id`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

#### Start 1.5.4:BC1.2.2

ALTER TABLE `oc_category` ADD `googlebase_text` varchar(255) COLLATE utf8_bin DEFAULT NULL AFTER `date_modified`;
ALTER TABLE `oc_category` ADD `googlebase_xml` varchar(255) COLLATE utf8_bin DEFAULT NULL AFTER `googlebase_text`;

#### Start 1.5.4:BC1.2.3

ALTER TABLE `oc_affiliate` ADD `account_commission` decimal(4,2) NOT NULL DEFAULT '0.00' AFTER `commission`;
ALTER TABLE `oc_affiliate` MODIFY `payment` varchar(10) COLLATE utf8_bin NOT NULL;
ALTER TABLE `oc_affiliate_transaction` ADD `customer_id` int(11) DEFAULT NULL AFTER `affiliate_id`; 

CREATE TABLE IF NOT EXISTS `oc_country_to_ip` (
  `ip` varchar(40) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `iso_code_2` varchar(2) NOT NULL,
  `iso_code_3` varchar(3) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ip`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

#### Start 1.5.4:BC1.2.4

ALTER TABLE `oc_order_history` ADD `notes` TEXT NOT NULL AFTER `comment` ;

#### Start 1.5.4:BC1.2.5

ALTER TABLE `oc_return` ADD `price` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' AFTER `model`;
ALTER TABLE `oc_return` ADD `refund_amount` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' AFTER `quantity`;

#### Start 1.5.4:BC1.2.6

ALTER TABLE `oc_category` ADD `is_filter` tinyint(1) NOT NULL DEFAULT 0 AFTER `sort_order`;
ALTER TABLE `oc_category` ADD `members_only` tinyint(1) NOT NULL AFTER `is_filter`;
ALTER TABLE `oc_category` ADD `date_start` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' AFTER `members_only`;
ALTER TABLE `oc_category` ADD `date_end` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' AFTER `date_start`;

#### Start 1.5.4:BC1.2.7

ALTER TABLE `oc_customer` ADD `dob` DATE NOT NULL DEFAULT '0000-00-00 00:00:00'  AFTER `fax`;

#### Start 1.5.4:BC1.2.8

ALTER TABLE `oc_customer` ADD `title` varchar(9) COLLATE utf8_bin NOT NULL DEFAULT ''  AFTER `store_id`;

#### Start 1.5.4:BC1.2.9

ALTER TABLE `oc_product_description` ADD `brief_summary` varchar(255) NOT NULL AFTER `description`;

#### Start 1.5.4.1:BC1.2.10 

CREATE TABLE IF NOT EXISTS `oc_category_filter` (
  `category_id` int(11) NOT NULL,
  `filter_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`filter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `oc_filter_group` (
  `filter_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`filter_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `oc_filter_group_description` (
  `filter_group_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`filter_group_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `oc_filter` (
  `filter_id` int(11) NOT NULL AUTO_INCREMENT,
  `filter_group_id` int(11) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`filter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `oc_filter_description` (
  `filter_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `filter_group_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`filter_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `oc_product_filter` (
  `product_id` int(11) NOT NULL,
  `filter_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`filter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

#### Start 1.5.4:BC1.2.11

ALTER TABLE `oc_return` ADD `new_order_id` int(11) NOT NULL AFTER `refund_amount`;

#### Start 1.5.4:BC1.2.12
--
-- Table structure for table `oc_syspro_tax_codes`
--

CREATE TABLE IF NOT EXISTS `oc_syspro_tax_code` (
  `tax_code` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tax_name` text COLLATE utf8_bin NOT NULL,
  `tax_rate` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `filename` text COLLATE utf8_bin NOT NULL,
  `data` blob,
  `tax_class_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_processed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tax_code`),
  KEY `tax_class_id` (`tax_class_id`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `oc_syspro_stock_item`
--

CREATE TABLE IF NOT EXISTS `oc_syspro_stock_item` (
  `stock_item_code` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `stock_item_name` text COLLATE utf8_bin NOT NULL,
  `filename` text COLLATE utf8_bin NOT NULL,
  `data` blob,
  `product_id` int(11) NOT NULL,
  `product_option_value_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_processed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`stock_item_code`),
  KEY `product_id` (`product_id`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table structure for table `oc_syspro_order`
--

CREATE TABLE IF NOT EXISTS `oc_syspro_order` (
  `order_id` int(11) NOT NULL,
  `syspro_status` text COLLATE utf8_bin NOT NULL,
  `filename` text COLLATE utf8_bin NOT NULL,
  `data` blob,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_processed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`order_id`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

#### Start 1.5.4:BC1.2.13

ALTER TABLE `oc_review` ADD `reply` text NOT NULL AFTER `rating`;

#### Start 1.5.4:BC1.2.13

ALTER TABLE `oc_banner_image` ADD `status` TINYINT(1) NOT NULL DEFAULT 1 AFTER `sort_order`;

#### Start 1.5.4:BC1.2.14

ALTER TABLE `oc_url_alias` ADD `language_id` int(11) NOT NULL AFTER `keyword`;

ALTER TABLE `oc_url_alias` ADD INDEX `query` (`query`); 
ALTER TABLE `oc_url_alias` ADD INDEX `keyword` (`keyword`);

ALTER TABLE `oc_product` ADD INDEX `model` (`model`);

ALTER TABLE `oc_product_option` ADD INDEX `product_option_product_id` (`product_id`, `option_id`);
ALTER TABLE `oc_product_option_value` ADD INDEX `product_option_product_option_id` (`product_option_id`, `product_id`);

ALTER TABLE `oc_filter_description` ADD INDEX `name` (`name`, `filter_group_id`);
ALTER TABLE `oc_filter_description` ADD INDEX `filter_group_id` (`filter_group_id`);

ALTER TABLE `oc_option_value_description` ADD INDEX `option_id` (`option_id`, `name`);

#### Start 1.5.4:BC1.2.15

ALTER TABLE `oc_order` ADD INDEX `customer_group_id` (`customer_group_id`);

ALTER TABLE `oc_order_option` ADD INDEX `order_product_id` (`order_product_id`);
ALTER TABLE `oc_order_option` ADD INDEX `order_id` (`order_id`);

ALTER TABLE `oc_order_product` ADD INDEX `order_id` (`order_id`);

#### Start 1.5.4:BC1.2.16

ALTER TABLE `oc_product` ADD `sale` TINYINT(1) NOT NULL DEFAULT '0' AFTER sort_order;
ALTER TABLE `oc_customer` MODIFY `salt` varchar(60) NOT NULL;

#### Start 1.5.4:BC1.2.17

ALTER TABLE `oc_url_alias` ADD `language_id` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `keyword`;
ALTER TABLE `oc_url_alias` ADD  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

#### Start 1.5.4:BC1.2.18

CREATE TABLE `oc_redeem` (
  `redeem_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL,
  `status` tinyint(1) NOT NULL,
  `redeem` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`redeem_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE oc_product ADD redeem tinyint(1) DEFAULT '0' AFTER shipping
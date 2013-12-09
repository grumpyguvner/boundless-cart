<?php
/**
 * p3html - html/tb oc helper class
 *
 * @author maks feltrin - pine3ree  <pine3ree(at)gmail(dot)com>
 * @copyright pine3ree 2012
 */
class p3html
{
	public static function p3_stylesheet($theme)
	{
		$stylesheet = 'stylesheet';
		if ($theme) $stylesheet .= '-'.$theme;

		return $stylesheet;
	}

	public static function tb_sort_icon($sort, $order, $dbfield, $baseIcon='arrow-combo', $ascIcon='up-dir', $descIcon='down-dir')
	{
		return ($sort == $dbfield) ?
			'<i class="icon-'.((strtolower($order)=='asc')?$ascIcon:$descIcon).'"></i>'
			: '<i class="icon-'.$baseIcon.'"></i>';
	}

	public static function tb_sort_heading($title, $link, $sort, $order, $dbfield, $icons=array('base'=>'arrow-combo','asc'=>'up-dir','desc'=>'down-dir'))
	{
		if ($icons)
		{
			$baseIcon =	isset($icons['base']) ? $icons['base']	: 'arrow-combo';
			$ascIcon	= isset($icons['asc'])	? $icons['asc']		: 'up-dir';
			$descIcon	= isset($icons['desc']) ? $icons['desc']	: 'down-dir';

			$sort_icon = ' '.self::tb_sort_icon($sort, $order, $dbfield, $baseIcon, $ascIcon, $descIcon);
		}
		else $sort_icon = null;

		return '<a href="'.$link.'">'.$title.$sort_icon.'</a>';
	}

	public static function sort_class($sort, $order, $dbfield, $baseClass='', $ascClass='', $descClass='')
	{
		$sortClass = '';

		if ($sort == $dbfield) {
			$sortClass = (strtolower($order)=='asc') ? $ascClass : $descClass;
			if (!$sortClass) {
				$sortClass = strtolower($order);
			}
		}

		if ($baseClass) {
			return $sortClass ? "$baseClass $baseClass-$sortClass" : $baseClass;
		}

		return $sortClass;
	}

	public static function options($items, $current=null, $valueKey=null, $labelKey=null, $addSlashes=false, $optionValueKey=null)
	{
		$html = '';

		if (is_array($current)) {
			$current = ($valueKey and array_key_exists($valueKey, $current)) ? $current[$valueKey] : null;
		}	elseif(is_object($current)){
			$current = ($valueKey and isset($current->$valueKey)) ? $current->$valueKey : null;
		}

		if (!$labelKey) {
			$labelKey = $valueKey;
		}

		if($valueKey)
		{
			foreach ($items as $item)
			{
				$value = ($optionValueKey and isset($item[$optionValueKey])) ? $item[$optionValueKey] : $item[$valueKey];
				$label = $addSlashes ? addslashes($item[$labelKey]) : $item[$labelKey];
				$selected = (!is_null($current) and $current==$item[$valueKey]) ? ' selected="selected"' : '';

				$html .= '<option value="'.$value.'"'.$selected.'>'.$label.'</option>';
			}
		}
		else
		{
			foreach ($items as $item)
			{
				$value = $item;
				$label = $addSlashes ? addslashes($item) : $item;
				$selected = ($current==$item) ? ' selected="selected"' : '';

				$html .= '<option value="'.$value.'"'.$selected.'>'.$label.'</option>';
			}
		}

		return $html;
	}

	public static function oc_layout_options($layouts, $current=null, $addSlashes=false)
	{
		return self::options($layouts, $current, 'layout_id', 'name', $addSlashes);
	}

	public static function oc_store_options($stores, $current=null, $addSlashes=false)
	{
		return self::options($stores, $current, 'store_id', 'name', $addSlashes);
	}

	public static function oc_template_options($templates, $current=null, $addSlashes=false)
	{
		return self::options($templates, $current, null, null, $addSlashes);
	}

	public static function oc_banner_options($banners, $current=null, $addSlashes=false)
	{
		return self::options($banners, $current, 'banner_id', 'name', $addSlashes);
	}

	public static function oc_order_status_options($order_statuses, $current=null, $addSlashes=false)
	{
		return self::options($order_statuses, $current, 'order_status_id', 'name', $addSlashes);
	}

	public static function oc_stock_status_options($stock_statuses, $current=null, $addSlashes=false)
	{
		return self::options($stock_statuses, $current, 'stock_status_id', 'name', $addSlashes);
	}

	public static function oc_return_status_options($return_statuses, $current=null, $addSlashes=false)
	{
		return self::options($return_statuses, $current, 'return_status_id', 'name', $addSlashes);
	}

	public static function oc_return_actions_options($return_actions, $current=null, $addSlashes=false)
	{
		return self::options($return_actions, $current, 'return_action_id', 'name', $addSlashes);
	}

	public static function oc_return_reason_options($return_reasons, $current=null, $addSlashes=false)
	{
		return self::options($return_reasons, $current, 'return_reason_id', 'name', $addSlashes);
	}

	public static function oc_return_action_options($return_actions, $current=null, $addSlashes=false)
	{
		return self::options($return_actions, $current, 'return_action_id', 'name', $addSlashes);
	}

	public static function oc_voucher_theme_options($voucher_themes, $current=null, $addSlashes=false)
	{
		return self::options($voucher_themes, $current, 'voucher_theme_id', 'name', $addSlashes);
	}

	public static function oc_weight_class_options($weight_classes, $current=null, $addSlashes=false)
	{
		return self::options($weight_classes, $current, 'weight_class_id', 'title', $addSlashes);
	}

	public static function oc_length_class_options($length_classes, $current=null, $addSlashes=false)
	{
		return self::options($length_classes, $current, 'length_class_id', 'title', $addSlashes);
	}

	public static function oc_tax_class_options($tax_classes, $current=null, $addSlashes=false)
	{
		return self::options($tax_classes, $current, 'tax_class_id', 'title', $addSlashes);
	}

	public static function oc_tax_rate_options($tax_rates, $current=null, $addSlashes=false)
	{
		return self::options($tax_rates, $current, 'tax_rate_id', 'name', $addSlashes);
	}

	public static function oc_tax_rule_options($language, $current=null, $key=null, $labels=null, $addSlashes=false)
	{
		if (!$key) $key = 'based';

		$options = array(
			array($key=>'shipping', 'label'=>isset($labels['shipping']) ? $labels['shipping'] : $language->get('text_shipping')),
			array($key=>'payment',	'label'=>isset($labels['payment'])	? $labels['payment']	: $language->get('text_payment')),
			array($key=>'store',		'label'=>isset($labels['store'])		? $labels['store']		: $language->get('text_store')),
		);

		return self::options($options, $current, $key, 'label', $addSlashes);
	}

	public static function oc_rate_type_options($language, $current=null, $key=null, $addSlashes=false)
	{
		if (!$key) $key = 'type';

		$options = array(
			array($key=>'P', 'label'=>$language->get('text_percent')),
			array($key=>'F',	'label'=>$language->get('text_amount')),
		);

		return self::options($options, $current, $key, 'label', $addSlashes);
	}


	public static function oc_manufacturer_options($manufacturers, $current=null, $addSlashes=false)
	{
		return self::options($manufacturers, $current, 'manufacturer_id', 'name', $addSlashes);
	}

	public static function oc_language_code_options($languages, $current=null, $addSlashes=false)
	{
		return self::options($languages, $current, 'code', 'name', $addSlashes);
	}

	public static function oc_currency_code_options($currencies, $current=null, $addSlashes=false)
	{
		return self::options($currencies, $current, 'code', 'title', $addSlashes);
	}

	public static function oc_country_options($countries, $current=null, $addSlashes=false)
	{
		return self::options($countries, $current, 'country_id', 'name', $addSlashes);
	}

	public static function oc_zone_options($zones, $current=null, $addSlashes=false)
	{
		return self::options($zones, $current, 'zone_id', 'name', $addSlashes);
	}

	public static function oc_geo_zone_options($geo_zones, $current=null, $addSlashes=false)
	{
		return self::options($geo_zones, $current, 'geo_zone_id', 'name', $addSlashes);
	}

	public static function oc_customer_group_options($customer_groups, $current=null, $addSlashes=false)
	{
		return self::options($customer_groups, $current, 'customer_group_id', 'name', $addSlashes);
	}

	public static function oc_user_options($users, $current=null, $addSlashes=false)
	{
		return self::options($users, $current, 'user_id', 'username', $addSlashes);
	}

	public static function oc_user_group_options($user_groups, $current=null, $addSlashes=false)
	{
		return self::options($user_groups, $current, 'user_group_id', 'name', $addSlashes);
	}

	public static function oc_information_options($informations, $current=null, $addSlashes=false)
	{
		return self::options($informations, $current, 'information_id', 'title', $addSlashes);
	}

	public static function oc_category_options($categories, $current=null, $addSlashes=false)
	{
		return self::options($categories, $current, 'category_id', 'name', $addSlashes);
	}

	public static function oc_addresses_options($addresses, $current=null, $addSlashes=false)
	{
		if(!isset($addresses) or !is_array($addresses) or !count($addresses)) {
			return null;
		}

		$n=0;
		foreach ($addresses as $address)
		{
			$options[$n]['address_id'] = $address['address_id'];
			$options[$n]['label'] = $address['firstname'] . ' ' . $address['lastname'] . ', ' . $address['address_1'] . ', ' . $address['city'] . ', ' . $address['country'];

			$n++;
		}
		return self::options($options, $current, 'address_id', 'label', $addSlashes);
	}

	public static function oc_position_options($language, $current=null, $addSlashes=false)
	{
		$options = array(
			array('position'=>'content_banner', 'name'=>$language->get('text_content_banner')),
			array('position'=>'content_top', 'name'=>$language->get('text_content_top')),
			array('position'=>'content_bottom', 'name'=>$language->get('text_content_bottom')),
			array('position'=>'column_left', 'name'=>$language->get('text_column_left')),
			array('position'=>'column_right', 'name'=>$language->get('text_column_right')),
		);

		return self::options($options, $current, 'position', 'name', $addSlashes);
	}

	public static function oc_bool_options($language, $current=null, $key=null, $addSlashes=false, $lang_keys=null)
	{
		if (!$key) {
			$key = 'id';
		}

		$lang_key_1 = isset($lang_keys[1]) ? $lang_keys[1] : 'text_yes';
		$lang_key_0 = isset($lang_keys[0]) ? $lang_keys[0] : 'text_no';

		$options = array(
			array("$key"=>1, 'label'=> $addSlashes ? addcslashes($language->get($lang_key_1)) : $language->get($lang_key_1)),
			array("$key"=>0, 'label'=> $addSlashes ? addcslashes($language->get($lang_key_0)) : $language->get($lang_key_0)),
		);

		return self::options($options, $current, $key, 'label');
	}

	public static function oc_status_options($language, $current=null, $key='status', $addSlashes=false)
	{
		$lang_keys = array(
			0 => 'text_disabled',
			1 => 'text_enabled',
		);
		return self::oc_bool_options($language, $current, $key, $addSlashes, $lang_keys);
	}

	public static function oc_opened_options($language, $current=null, $key='opened', $addSlashes=false)
	{
		$lang_keys = array(
			0 => 'text_unopened',
			1 => 'text_opened',
		);
		return self::oc_bool_options($language, $current, $key, $addSlashes, $lang_keys);
	}

	public static function oc_bool_radio_buttons($language, $name,  $current, $key, $labelCssClass='')
	{
		$html = '';

		if (!$key) $key = $name;

		if (is_array($current)) {
			$current = ($key and array_key_exists($key, $current)) ? $current[$key] : null;
		}	elseif(is_object($current)){
			$current = ($key and isset($current->$key)) ? $current->$key : null;
		}

		$options = array(
			array("$name"=>1, 'label'=> $language->get('text_yes')),
			array("$name"=>0, 'label'=> $language->get('text_no')),
		);

		$labelCssClass = $labelCssClass ? ' class="'.$labelCssClass.'"' : '';

		foreach($options as $option)
		{
			$value = $option[$name];
			$label = $option['label'];
			$checked = ($current==$value) ? ' checked="checked"' : '';

			$html .= '<label'.$labelCssClass.'><input type="radio" name="'.$name.'" value="'.$value.'"'.$checked.'> '.$label.'</label>';
		}

		return $html;
	}

	public static function tb_bool_radio_buttons($language, $name, $current, $key=null)
	{
		return self::oc_bool_radio_buttons($language, $name, $current, $key, 'radio inline');
	}

	public static function tb_toggle_button($name, $current=null, $key=null, $value=1, $containerCssClass='toggle-button', $container='div')
	{
		if (!$key) $key = $name;

		if (is_array($current)) {
			$current = ($key and array_key_exists($key, $current)) ? $current[$key] : null;
		}	elseif(is_object($current)){
			$current = ($key and isset($current->$key)) ? $current->$key : null;
		}

		$checked = ($current==$value) ? ' checked="checked"' : '';

		return '<'.$container.' class="'.$containerCssClass.'"><input type="checkbox" name="'.$name.'"value="'.$value.'"'.$checked.'></'.$container.'>';
	}

	public static function tb_bool_buttons_radio($language, $name, $current=null, $key=null, $options=null)
	{
		$id = str_replace('_', '-', $name);

		$html = '<div class="btn-group btn-group-bool" data-toggle="buttons-radio" data-bool-name="'.$name.'">';

		if (!$key) $key = $name;

		if (is_array($current)) {
			$current = ($key and array_key_exists($key, $current)) ? $current[$key] : null;
		}	elseif(is_object($current)){
			$current = ($key and isset($current->$key)) ? $current->$key : null;
		}

		$true = isset($options['true']) ? $options['true'] : 1;
		$false = isset($options['false']) ? $options['false'] : 0;

		$options = array(
			array(
				'value' => $true,
				'label' => $language->get('text_yes'),
				'btnType' => 'success',
				'iconType' => 'ok',
				'dataBoolValue' => 'true',
			),
			array(
				'value' => $false,
				'label' => $language->get('text_no'),
				'btnType' => 'danger',
				'iconType' => 'cancel',
				'dataBoolValue' => 'false',
			),
		);

		foreach ($options as $option)
		{
			$value = $option['value'];
			$label = $option['label'];
			$dataBoolValue = $option['dataBoolValue'];
			$btnType = $option['btnType'];
			$iconType = $option['iconType'];

			$class = "btn";
			if ($current==$value) $class .= " btn-$btnType active";

//			$html .= '<button type="button" class="'.$class.'" value="'.$value.'" data-bool-value="'.$dataBoolValue.'"><i class="icon-'.$iconClass.'"></i></button>';
			$html .= '<button type="button" class="'.$class.'" value="'.$value.'" data-bool-value="'.$dataBoolValue.'" id="'.$name . $value .'">'.$label.'</button>';
		}

		$html .= '</div>';
		$html .= '<input type="hidden" name="'.$name.'" value="'.$current.'">';

//		$html .= '<noscript>';
//		$html .= self::oc_bool_radio_buttons($language, $name, $current, $key);
//		$html .= '</noscript>';

		return $html;
	}

	public static function tb_bool_buttons_checkbox($language, $name, $checked, $value=1)
	{
		$id = str_replace('_', '-', $name);

		$html = '<div class="btn-group btn-group-checkbox" data-toggle="buttons-radio" data-checkbox-name="'.$name.'">';

		$options = array(
			array(
				'value' => true,
				'label' => $language->get('text_yes'),
				'btnType' => 'success',
				'iconType' => 'ok',
				'dataCheckedStatus' => 'checked',
			),
			array(
				'value' => false,
				'label' => $language->get('text_no'),
				'btnType' => 'danger',
				'iconType' => 'cancel',
				'dataCheckedStatus' => 'unchecked',
			),
		);

		foreach ($options as $option)
		{
			$label = $option['label'];
			$dataCheckedStatus = $option['dataCheckedStatus'];
			$btnType = $option['btnType'];
			$iconType = $option['iconType'];

			$class = "btn";
			if ($checked==$option['value']) $class .= " btn-$btnType active";

			$html .= '<button type="button" class="'.$class.'" data-checked-status="'.$dataCheckedStatus.'">'.$label.'</button>';
		}

		$html .= '</div>';
		$html .= '<input type="checkbox" name="'.$name.'" value="'.$value.'"'.($checked?' checked="checked"':null).' style="visibility:hidden;">';

		return $html;
	}

	public static function oc_sign_prefix_options($current, $key)
	{
		$options = array(
			array("$key"=>'+', 'label'=> '+'),
			array("$key"=>'-', 'label'=> '-'),
		);

		return self::options($options, $current, $key, 'label');
	}
	/*
	public static function js_tb_confirm_dialog($language, $selector, $event, $action, $confirmBtnType='danger')
	{
		$html =
		'<div class="modal hide fade" id="confirm-dialog" role="dialog" aria-labelledby="data-confirm-label">'.
			'<div class="modal-header">'.
				'<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>'.
				'<h3 id="data-confirm-label">'.addslashes($action).'?</h3>'.
			'</div>'.
			'<div class="modal-body">'.
				'<p>'.addslashes($language->get('text_confirm')).'</p>'.
			'</div>'.
			'<div class="modal-footer">'.
				'<a href="#" data-dismiss="modal" id="confirm-dialog-cancel" class="btn" aria-hidden="true">Cancel</a>'.
				'<a href="#" data-dismiss="modal" id="confirm-dialog-confirm" class="btn btn-'.$confirmBtnType.'">Confirm</a>'.
			'</div>'.
		'</div>';

		$js =
		'$(\''.$selector.'\').'.$event.'(function(e){'.
			'$(\'body\').append(\''.$html.'\');'.
			'$(\'#confirm-dialog\').modal({show:true});'.
			'e.preventDefault();'.
			'return false;'.
		'});';

		return $js;
	}
	*/

	public static function tb_bool_icon($status, $text=null, $extraClass=null, $icon=array(1=>'check',0=>'cross'))
	{
		$status = (int)$status;
		$title = isset($text[$status]) ? $text[$status] : null;
		$class = 'text-'.($status ? 'success' : 'warning');
		if ($extraClass) $class .= " $extraClass";

		return '<span class="'.$class.'"'.($title?' title="'.$title.'"':'').'>'.'<i class="icon-'.$icon[$status].'"></i></span>';
	}

	public static function tb_status_icon($status, $text=null, $extraClass=null, $icon=array(1=>'check',0=>'cross'))
	{
		$status = (int)$status;
		$title = isset($text[$status]) ? $text[$status] : null;
		$class = 'icon-'.$icon[$status];
		if ($extraClass) $class .= " $extraClass";

		return '<i class="'.$class.'"'.($title?' title="'.$title.'"':'').'></i>';
	}

	public static function tb_status_label($status, $title)
	{
		$status = (int)$status;
		return '<span class="label label-'.($status ? 'success' : 'warning').'">'.
			self::tb_status_icon($status, $title, 'visible-phone').
			'<span class="hidden-phone">'.$title.'</span>'.
			'</span>';
	}

	public static function tb_date_input($name, $value='', $id=null, $icon=null)
	{
		$html = '';

		if ($icon===true) $icon = 'calendar';

		if ($icon) $html .= '<div class="input-append date">';
		$html .= '<input type="text"'.($name?' name="'.$name.'"':'').' value="'.$value.'"'.($id?' id="'.$id.'"':'').' class="date input-small">';
		if ($icon) $html .= '<span class="add-on"><i class="icon-'.$icon.'"></i></span></div>';

		return $html;
	}

	public static function tb_time_input($name, $value='', $id=null, $icon=null)
	{
		$html = '';

		if ($icon===true) $icon = 'clock';

		if ($icon) $html .= '<div class="input-append time bootstrap-timepicker-component">';
		$html .= '<input type="text"'.($name?' name="'.$name.'"':'').' value="'.$value.'"'.($id?' id="'.$id.'"':'').' class="time timepicker-default input-mini">';
		if ($icon) $html .= '<span class="add-on"><i class="icon-'.$icon.'"></i></span></div>';

		return $html;
	}

	public static function tb_datetimecombo_input($name, $value='', $id=null, $icons=null)
	{
		$idDate = $id ? "$id-date" : null;
		$idTime = $id ? "$id-time" : null;

		if ($icons===true) {
			$iconDate = 'calendar';
			$iconTime = 'clock';
		}
		else {
			$iconDate = isset($icons['date']) ? $icons['date'] : null;
			$iconTime = isset($icons['time']) ? $icons['time'] : null;
		}

		$html = '<div class="datetime-combo">';

		$html .= '<input type="hidden"'.($id?' id="'.$id.'"':'').' name="'.$name.'" value="'.$value.'" class="datetime">';

		$time = strtotime($value);

		$html .= self::tb_date_input(null, date('Y-m-d', $time), $idDate, $iconDate);
		$html .= '&nbsp;';
		$html .= self::tb_time_input(null, date('H:i:s', $time), $idTime, $iconTime);

		$html .= '</div>';

		return $html;
	}

	public static function tb_alert($type, $content=null, $dismiss=true, $class=null, $container='div')
	{
		if (!trim($content)) return '';

		$attrClass = strtolower("alert alert-$type");
		if ($class) {
			$attrClass = "$attrClass $class";
		}
		if ($dismiss){
			$content = '<button type="button" class="close" data-dismiss="alert">×</button>'.$content;
		}

		return "<$container class=\"$attrClass\">$content</$container>";
	}

	public static function tb_breadcrumbs($breadcrumbs)
	{
		if (!$breadcrumbs) return '';

		$html = '<ul class="breadcrumb">';

		$count=count($breadcrumbs);
		$index=0;
    foreach ($breadcrumbs as $breadcrumb)
		{
			$active = $index==$count-1;
			$html .= '<li'.($active?' class="active"':'').'><a href="'.$breadcrumb['href'].'">'.$breadcrumb['text'].'</a>';
			if ($index<$count-1) {
				$html .=  ' <span class="divider">/</span> ';
			}
			$html .= '</li>';
			$index++;
		}

		$html .= '</ul>';

		return $html;
	}

	public static function oc_action_link($action, $class=null)
	{
		return '<a href="'.$action['href'].'"'.($class?' class="'.$class.'"':'').' title="'.$action['text'].'">'.$action['text'].'</a>';
	}
	public static function oc_action_links($item, $class=null)
	{
		$links = null;
		foreach ($item['action'] as $action) {
			$links[] = self::oc_action_link($action, $class);
    }
		return implode(' ', $links);
	}

	public static function tb_action_button($action, $size='small', $type=null, $language=null)
	{
		$class = strtolower("btn btn-$size");
		if ($type) $class .= strtolower(" btn-$type");

		$icon = null;

		if ($language) {
			$icon = self::tb_btn_icon($action['text'], $language);
		}

		return '<a href="'.$action['href'].'"'.($class?' class="'.$class.'"':'').' title="'.$action['text'].'">'.
			($icon ? '<i class="icon-'.$icon.' visible-phone"></i> ' : null).$action['text'].'</a>';
	}

	public static function tb_action_buttons($item, $size='small', $type=null, $language=null)
	{
		$buttons = array();
		if (isset($item['action'])) {
			foreach ($item['action'] as $action) {
                            if ($action['href'] != '') {
				$btnSize = isset($action['size']) ? $action['size'] : $size;
				$btnType = isset($action['type']) ? $action['type'] : $type;
				$buttons[] = self::tb_action_button($action, $btnSize, $btnType, $language);
                            }
			}
    }
		else {
			return '';
		}
		return trim(implode(' ', $buttons));
	}

	public static function oc_ajax_button($label, $onclick, $id=null, $class=null, $labelClass=null)
	{
		$class = $class ? "button $class" : 'button';
		$title = strip_tags($label);
		return '<a onclick="'.$onclick.'"'.($id?' id="'.$id.'"':null).' class="'.$class.'" title="'.$title.'">'.$label.'</a>';
	}

	public static function oc_form_button($label, $onclick, $class=null)
	{
		return self::oc_ajax_button($label, $onclick, null, $class);
	}

	public static function tb_ajax_button($label, $onclick, $type=null, $size=null, $icon=null, $id=null, $labelClass=null)
	{
		$class = 'btn';
		if ($type) $class = "$class btn-$type";
		if ($size) $class = "$class btn-$size";
		if ($labelClass) $label = "<span class=\"$labelClass\">$label</span>";
		if ($icon) $label = "<i class=\"icon-$icon\"></i> $label";
		return self::oc_ajax_button($label, $onclick, $id, $class, $labelClass);
	}

	public static function tb_form_button($label, $onclick, $type=null, $icon=null, $id=null)
	{
		return self::tb_ajax_button($label, $onclick, $type, null, $icon, $id);
	}

	public static function tb_form_button_location($label, $location, $type=null, $icon=null)
	{
		return self::tb_form_button($label, "location = '$location'", $type, $icon);
	}

	public static function tb_form_button_insert($label, $insert)
	{
		return self::tb_form_button_location($label, $insert, null, 'plus');
	}

	public static function tb_form_button_cancel($label, $cancel)
	{
		return self::tb_form_button_location($label, $cancel, null, null);
	}

	public static function tb_form_button_submit($label, $selector='form', $type=null, $icon=null)
	{
		return self::tb_form_button($label, "$('$selector').submit();", $type, $icon);
	}

	public static function tb_form_button_delete($label, $selector='form')
	{
		return self::tb_form_button_submit($label, $selector, 'danger', 'trash');
	}

	public static function tb_form_button_save($label, $selector='form')
	{
		return self::tb_form_button_submit($label, $selector, 'success', 'ok');
	}

	public static function tb_form_button_apply($label, $selector='form')
	{
		return self::tb_form_button($label, "$('#action_apply').val(1);$('$selector').submit();", 'primary', 'ok');
	}

	public static function tb_btn_icon($label, $language)
	{
		if ($label==$language->get('button_insert'))						return 'plus';
		if ($label==$language->get('button_delete'))						return 'trash';
		if ($label==$language->get('button_save'))							return 'save';
		if ($label==$language->get('button_cancel'))						return '';
		if ($label==$language->get('button_clear'))							return 'plus';
		if ($label==$language->get('button_close'))							return 'cancel';
		if ($label==$language->get('button_filter'))						return 'filter';
		if ($label==$language->get('button_send'))							return 'forward';
		if ($label==$language->get('button_edit'))							return 'edit';
		if ($label==$language->get('button_copy'))							return 'copy';
		if ($label==$language->get('button_back'))							return 'plus';
		if ($label==$language->get('button_remove'))						return 'minus';
		if ($label==$language->get('button_backup'))						return 'plus';
		if ($label==$language->get('button_restore'))						return 'ccw';
		if ($label==$language->get('button_upload'))						return 'upload';
		if ($label==$language->get('button_submit'))						return 'plus';
		if ($label==$language->get('button_invoice'))						return 'print';
		if (
			$label==$language->get('button_add_address')
			or $label==$language->get('button_add_attribute')
			or $label==$language->get('button_add_banner')
			or $label==$language->get('button_add_product')
			or $label==$language->get('button_add_voucher')
			or $label==$language->get('button_add_option')
			or $label==$language->get('button_add_option_value')
			or $label==$language->get('button_add_discount')
			or $label==$language->get('button_add_special')
			or $label==$language->get('button_add_image')
			or $label==$language->get('button_add_geo_zone')
			or $label==$language->get('button_add_history')
			or $label==$language->get('button_add_transaction')
			or $label==$language->get('button_add_total')
			or $label==$language->get('button_add_reward')
			or $label==$language->get('button_add_route')
			or $label==$language->get('button_add_rule')
			or $label==$language->get('button_add_module')
			or $label==$language->get('button_add_link')
		)																												return 'plus';
		if ($label==$language->get('button_update_total'))			return 'refresh';
		if ($label==$language->get('button_approve'))						return 'check';
		if ($label==$language->get('button_reset'))							return 'ccw';

		if ($label==$language->get('text_view'))								return 'eye';
		if ($label==$language->get('text_edit'))								return 'pencil';

		if ($label==$language->get('text_install'))							return 'ok';
		if ($label==$language->get('text_uninstall'))						return 'trash';

		return null;
	}

	public static function oc_ckeditor_replace($name, $token)
	{
		static $setup = true;

		$js = null;

		if ($setup)
		{
			$js .= "\n
				var ckeditor_filebrowserBrowseUrl				=	'index.php?route=common/filemanager&token=$token';\n
				var ckeditor_filebrowserImageBrowseUrl	= 'index.php?route=common/filemanager&token=$token';\n
				var ckeditor_filebrowserFlashBrowseUrl	= 'index.php?route=common/filemanager&token=$token';\n
				var ckeditor_filebrowserUploadUrl				= 'index.php?route=common/filemanager&token=$token';\n
				var ckeditor_filebrowserImageUploadUrl	= 'index.php?route=common/filemanager&token=$token';\n
				var ckeditor_filebrowserFlashUploadUrl	= 'index.php?route=common/filemanager&token=$token';\n
				\n";
			$setup = false;
		}

		$js .=
		"CKEDITOR.replace('$name', {\n
			filebrowserBrowseUrl: ckeditor_filebrowserBrowseUrl,\n
			filebrowserImageBrowseUrl: ckeditor_filebrowserImageBrowseUrl,\n
			filebrowserFlashBrowseUrl: ckeditor_filebrowserFlashBrowseUrl,\n
			filebrowserUploadUrl: ckeditor_filebrowserUploadUrl,\n
			filebrowserImageUploadUrl: ckeditor_filebrowserImageUploadUrl,\n
			filebrowserFlashUploadUrl: ckeditor_filebrowserFlashUploadUrl\n
		});\n";

		return $js;
	}

	//----------------------------------------------------------------------------
	// ORDER STATUS LABEL
	//----------------------------------------------------------------------------
	public static function order_status_label_for_order_id($controller, $order_id)
	{
		$order_status_label = null;

		if ($order_id) {
			if (!$controller->model_localisation_order_status_label) {
				$controller->load->model('localisation/order_status_label');
			}
			$label = $controller->model_localisation_order_status_label->getOrderStatusLabelForOrderId($order_id);
			$order_status_label = isset($label['label']) ? $label['label'] : null;
		}

		return $order_status_label;
	}

	public static function set_order_status_label_for_orders($controller, &$orders)
	{
		if ($orders) {
			if (!$controller->model_localisation_order_status_label) {
				$controller->load->model('localisation/order_status_label');
			}
			$controller->model_localisation_order_status_label->setOrderStatusLabelsForOrders($orders);
		}
	}
	//----------------------------------------------------------------------------


	//----------------------------------------------------------------------------
	// UTILS
	//----------------------------------------------------------------------------
	public static function slugify($text)
	{
		if (!$text) return '';

		$text = preg_replace('/[^A-Za-z0-9\-]/', '-', $text);
		$text = preg_replace('/(\-)+/', '-', $text);

		return trim($text, '-');
	}

	public static function is_mobile()
	{
		$useragent=$_SERVER['HTTP_USER_AGENT'];
		return (preg_match('/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|opera tablet|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i',$useragent)||preg_match('/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i',substr($useragent,0,4)));
	}
	//----------------------------------------------------------------------------
}


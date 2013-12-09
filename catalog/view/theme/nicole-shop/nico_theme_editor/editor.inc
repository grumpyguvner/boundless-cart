<link class="_editor_css" href='catalog/view/theme/nicole-shop/nico_theme_editor/editor_settings.css' rel='stylesheet' type='text/css'>
<?php
/*
 * Nico open cart theme editor module
 * Copyright Tunaru Nicoleta
 * All rights reserved
 */

define('DEMO', false);


require_once(DIR_SYSTEM . 'library/user.php');
$user = new User($this->registry);
define('HAS_PERMISSION', $user->hasPermission('modify', 'design/layout'));
$dirname = dirname(__FILE__);

if (HAS_PERMISSION || DEMO)
{
	include(dirname(__FILE__) . '/settings.inc');

	if ($_POST && HAS_PERMISSION)
	{
		if (isset($_POST['_nico_save_theme']))
		{
			unset($_POST['_nico_save_theme']);
			
			if (!isset($_nico_settings)) $_nico_settings = array();
			
			unset($_nico_settings['slider_text']);
			$_nico_settings = array_merge_recursive($_nico_settings, $_POST);
			
			$css = '';
			foreach($_nico_settings['options'] as $selector => &$data)
			{
				$attributes = '';
				foreach ($data as $attribute => &$value)
				{
					if (is_array($value)) 
					{
						$value = end($value);
						//$_nico_settings['colors'][$selector][$attribute] = $value;
					}
					$attributes .= $attribute . ':' . $value .';';
				}
				if ($attributes) $css .= $selector . '{' . $attributes . "}\n";
			}			
			
			foreach($_nico_settings['colors'] as $selector => $data)
			{
				$attribute = key($data);
				$value = $data[$attribute];
				if (is_array($value)) 
				{
					$value = end($value);
					$_nico_settings['colors'][$selector][$attribute] = $value;
				}
				$css .= $selector . '{' . $attribute . ':' . $value . "}\n";
			}

			$fonts = array();
			foreach($_nico_settings['fonts'] as $selector => &$font)
			{
				if (is_array($font['font-family'])) 
				{
					$font['font-family'] = end($font['font-family']);
				}
				$font_family = $font['font-family'];
				
				if (is_array($font['size'])) 
				{
					$font['size'] = end($font['size']);
				}
				$font_size = $font['size'];
				
				if ($font_size) $font_size = ';font-size:' . $font_size . 'px';
				if ($font_family)
				{
					$css .= $selector . '{font-family:\''. $font_family . "'$font_size}\n";
					$fonts[] = urlencode($font_family);
				}
			}

			if ($_nico_settings['background-image'] && $_nico_settings['background-image'] != 'disabled')
			{	
				if (is_array($_nico_settings['background-image'])) 
				{
					$_nico_settings['background-image'] = end($_nico_settings['background-image']);
				}

				$css .= 'body { background-image: '. urldecode($_nico_settings['background-image']) . "};\n\n";	
			}
			
			foreach($_nico_settings['sliders'] as $page => &$sliders)
			{
				foreach($sliders as $slider => &$options)
				{
					if ($slider == 'active')
					{
						if (is_array($options)) 
						{
							$options = end($options);
						}
					} else
					foreach($options as $_name => &$data)
					{
						if (is_array($data)) 
						{
							$data = end($data);
							//$_nico_settings['sliders'][$page][$slider][$_name] = $data;
						}
					}
				}
			}
			
			foreach($_nico_settings['settings'] as $selector => &$data)
			{
				if (is_array($data)) 
				{
					$data = end($data);
					//$_nico_settings['settings'][$selector] = $data;
				}
			}			
			
			foreach($_nico_settings['styles'] as $group => &$css_file)
			{
				if (is_array($css_file)) 
				{
					$css_file = end($css_file);
					//$_nico_settings['styles'][$group] = $css_file;
				}
			}			
			
			
			if ($fonts)
			{
				$fonts = array_unique($fonts);
				$css = '@import url(https://fonts.googleapis.com/css?family=' . implode( '|', $fonts) . ");\n\n" . $css;	
			}
			

			file_put_contents(dirname(__FILE__) . '/editor_settings.css', html_entity_decode($css));
			file_put_contents(dirname(__FILE__) . '/settings.inc', 
			'<?php $_nico_settings  = ' . var_export($_nico_settings, true) . ';');
//			die('saved');
			
		} else if (isset($_POST['_nico_reset_theme']))
		{
			file_put_contents($dirname . '/editor_settings.css', '');
			file_put_contents($dirname. '/settings.inc', '');
//			die('saved');
		}
	}
	
	include('nico_config.inc');
	$editor_path = 'catalog/view/theme/nicole-shop/nico_theme_editor/';
?>	
<link href='<?php echo $editor_path;?>editor_panel.css' rel='stylesheet' type='text/css'>
<script>
var _nico_demo = <?php if (DEMO || !HAS_PERMISSION) echo 'true'; else echo 'false';?>
</script>
<script type="text/javascript" src="<?php echo $editor_path;?>colorpicker/js/colorpicker.js"></script>
<link rel="stylesheet" href="<?php echo $editor_path;?>colorpicker/css/colorpicker.css" type="text/css" />
<script src="<?php echo $editor_path;?>editor.js"></script>

	<div id="nico_theme_editor">
		<a href="#" id="show_hide_editor" class="no_mobile">Customize theme</a>

		<a href="#" id="nico_save_settings" class="no_mobile">Save settings</a>
		<div id="nico_zoom"  class="no_mobile">
			<a href="#" id="nico_zoom_bottomscreen" title="Bottom screen">Bottom screen</a>
			<a href="#" id="nico_zoom_halfscreen" title="Half screen">Half screen</a>
			<a href="#" id="nico_zoom_fullscreen" title="Full screen">Full screen</a>
		</div>
		
		<a href="#" id="nico_reset" class="no_mobile">Reset to default theme settings</a>

		<ul class="nico_tabs">
			<li class="selected">Styles</li>
			<li>Colors</li>
			<li>Fonts</li>
			<li>Sliders &amp; Gallery</li>
			<li>Background patterns</li>
			<li>Theme options</li>
			<li>Theme settings</li>
			<li>Home slider text</li>
		 </ul>
		 
		
	 <div class="nico_tab">
		 <div>
			<?php 
			$current_group = '';
			$pattern_dir = $dirname . '/styles';
			if (is_dir($pattern_dir)) {
				if ($dh = opendir($pattern_dir)) 
				{
					while (($file = readdir($dh)) !== false) 
					{
						if ($file[0] != '.' && strrpos($file, '.css') != false) 
						{
							if (!preg_match('@([a-zA-Z_]+)-([a-zA-Z_]+)\.css@', $file, $matches)) continue;
							
							$group = $matches[1];
							$group_title = ucfirst(str_replace('_', ' ', $matches[1]));
							$_name = str_replace('_', ' ', $matches[2]);
							$image = str_replace('.css', '.png', $file);
							$_nico_styles[$group][] = array('name' => $_name, 'image' => $image, 'file' => $file);
						}
					}
					closedir($dh);
					ksort($_nico_styles);
				 }	
				 
				 foreach($_nico_styles as $group => $_nico_styles)
				 {
							?>  <div style="display:inline-block;margin-right:10px;">
								<h2><span><?php echo ucfirst(str_replace('_', ' ',$group));?></span></h2>
								 <div class="style">
									 <div class="value <?php echo $group;?>" file="" group="<?php echo $group;?>"css=""></div>
									 <div class="name">Default style</div>
								</div>
					<?php foreach ($_nico_styles as $style) 
					{?>
					 <div class="style">
						 <div class="value <?php echo $group;?>" group="<?php echo $group;?>" file="<?php echo $style['file'];?>" css="<?php echo $editor_path . 'styles/' . $style['file'];?>" style="background-image:url('<?php echo $editor_path . 'styles/' . $style['image']?>');"></div>
						 <div class="name"><?php echo ucfirst($style['name']);?></div>
					</div>
					<?php } ?></div><?php } }?>			 
			</div>
		 </div>				 
		 
		 <div class="nico_tab">
			 <div>
<?php foreach ($nico_colors as $_name => $options) {
			if (is_array($options))
			{?>			 
			 <div class="color">
				 <div class="name"><?php echo $_name;?></div>
				 <div class="value" selector="<?php echo $options[0];?>" attribute="<?php echo $options[1];?>"></div>
			 </div>
<?php } else { ?><h2><span><?php echo $options;?></span></h2><?php } }?> 
			</div>
		 </div>
		 <div class="nico_tab">
			<div>
<?php foreach ($nico_fonts as $_name => $option) {			
			if (!empty($option))
			{?>			 
			 <div class="font">
				 <div class="name"><?php echo $_name;?></div>
				 <div class="value">
					 <select class="_font_select" selector="<?php echo $option;?>">
					 </select>
					 <select class="_font_select_size" selector="<?php echo $option;?>">
					 </select>
				 </div>
			 </div>
<?php } else { ?><h2><span><?php echo $_name;?></span></h2><?php } }?> 
			</div>
		 </div>
		 
		 

	
		 	<div class="nico_tab sliders">
			<div>
				<?php $_first = array();foreach($nico_sliders as $page => $sliders) 
				{
				?>
					<h2><?php echo $page;?></h2>
					<div>
				<?php 
				    foreach($sliders as $slider => $options)
				    {
					   ?>
					   <div class="label_option">
					   <input type="radio" name="<?php echo $page;?>" _name="<?php echo $page;?>" page="<?php echo $page;?>" 
					   value="<?php echo $slider;?>" id="<?php echo $page . '_' . $slider;?>"
					   <?php if ((isset($_nico_settings['sliders'][$page]['active']) && $_nico_settings['sliders'][$page]['active'] == $slider) || (!isset($_nico_settings['sliders'][$page]['active']) && !isset($_first[$page]))) {echo 'checked="checked"';};?>>
					   <label for="<?php echo $page . '_' . $slider;?>"><?php echo $slider;?></label>
					   </div>
						   <div class="slider_container"<?php if ((isset($_nico_settings['sliders'][$page]['active']) && $_nico_settings['sliders'][$page]['active'] == $slider) || (!isset($_nico_settings['sliders'][$page]['active']) && !isset($_first[$page]))) {$_first[$page] = true;echo ' style="display:block"';};?>>
						   <?php
						   foreach($options as $_name => $option)
						   { ?>
								 <div class="slider">
									 <div class="name"><?php echo $_name;?></div>
									 <div class="value">
									<?php switch ($option['type']) {
									case 'text':
									case 'href':?>
										<input type="text" name="<?php echo $page . '['  . $slider . '[' . $option['name'] . ']]' ;?>" _name="<?php echo $option['name'];?>"
										slider="<?php echo $slider;?>" page="<?php echo $page?>"
										value="<?php if (isset($_nico_settings['sliders'][$page][$slider][$option['name']])) 
												echo $_nico_settings['sliders'][$page][$slider][$option['name']]; else echo $option['default']; ?>"/>
								<?php  break;
									case 'color':?>
										<div class="color">
										<div class="value" selector="" slider="<?php echo $slider;?>" page="<?php echo $page?>"
												slider="<?php echo $slider;?>" page="<?php echo $page?>"
												_name="<?php echo $option['name'];?>"
												attribute="<?php if (isset($_nico_settings['sliders'][$page][$slider][$option['name']])) 
												echo $_nico_settings['sliders'][$page][$slider][$option['name']]; else echo $option['default'];?>">
										</div>
										</div>
									<?php break;
										  case 'textarea': 
									?>
										<textarea name="<?php echo $page . '['. $slider . '[' . $_name . ']]';?>" _name="<?php echo $_name;?>"> slider="<?php echo $slider;?>" page="<?php echo $page?>"
										if (isset($_nico_settings['sliders'][$page][$slider][$option['name']])) 
										echo $_nico_settings['sliders'][$page][$slider][$option['name']];?></textarea>
									<?php break;
										  case 'select': 
									?>
									
										<select name="<?php echo $page . '['. $slider . '[' . $_name . ']]';?>" _name="<?php echo $option['name'];?>" slider="<?php echo $slider;?>" page="<?php echo $page?>">
										<?php foreach ($option['options'] as $opt) { ?>
										<option value="<?php echo $opt;?>"
										<?php if ((isset($_nico_settings['sliders'][$page][$slider][$option['name']]) && 
										 $_nico_settings['sliders'][$page][$slider][$option['name']] == $opt) || $opt == $option['default'])  echo 'selected';?>
										 ><?php echo $opt;?></option>
										 <?php } ?>
										</select>
									<?php break;
										  case 'bool': 
									?>
										<input type="radio" name="<?php echo $page . '['. $slider . '[' . $option['name'] . ']]';?>" _name="<?php echo $option['name'];?>" id="<?php echo $page . '_' . $_name . '_' . $option['name'] . '_yes';?>" 
										value="true" slider="<?php echo $slider;?>" page="<?php echo $page?>"
										<?php if ((isset($_nico_settings['sliders'][$page][$slider][$option['name']]) 
												&& $_nico_settings['sliders'][$page][$slider][$option['name']] != 'false') 
												|| (isset($option['default']) && $option['default'] != 'false')) 
												echo 'checked="true"';?>/>
										<label for="<?php echo $page . '_' . $_name . '_' . $option['name'] . '_yes';?>">yes</label>

										<input type="radio" name="<?php echo $page . '['. $slider . '[' . $option['name'] . ']]';?>" _name="<?php echo $option['name'];?>" id="<?php echo $page . '_' . $_name . '_' . $option['name'] . '_no';?>" 
										value="false" slider="<?php echo $slider;?>" page="<?php echo $page?>"
										<?php if ((isset($_nico_settings['sliders'][$page][$slider][$option['name']]) 
												&& $_nico_settings['sliders'][$page][$slider][$option['name']] == 'false')
												|| (isset($option['default']) && $option['default'] == 'false')) 
												echo 'checked="true"';?>/>
										<label for="<?php echo $page . '_' . $_name . '_' . $option['name'] . '_no';?>" >no</label>
									<?php break;
									   }
									?>
									 </div>
								 </div>
						   <?php
						   } ?>
						   </div>
						  <?php 
					   }?></div>
				<?php } ?>
		 </div>
		</div>

		
		 <div class="nico_tab">
			 <div>
			 <div class="pattern">
				 <div class="name">Disable background pattern</div>
				 <div class="value" file="disable"></div>
			</div>
			<?php 
			$pattern_dir = $dirname . '/patterns';
			if (is_dir($pattern_dir)) {
				if ($dh = opendir($pattern_dir)) 
				{
					while (($file = readdir($dh)) !== false) 
					{
						$_name = str_replace(array('_', '-', '.png'), ' ', $file);
						if ($file[0] != '.') {
			?>
			 <div class="pattern">
				 <div class="name"><?php echo ucfirst($_name);?></div>
				 <div class="value" file="<?php echo $file;?>" style="background-image:url('<?php echo $editor_path . '/patterns/' . $file?>');"></div>
			</div>
<?php } } }  closedir($dh); }?>			 
			Patterns from <a href="http://subtlepatterns.com/">subtlepatterns.com</a>
			</div>
		 </div>				 
		 
		 <div class="nico_tab">
			<div>
<?php foreach ($nico_options as $_name => $options) {
				if (is_array($options))
			{?>			 
			<div class="option">
				 <div class="name"><?php echo $_name;?></div>
				<select class="value" selector="<?php echo $options[0];?>" attribute="<?php echo $options[1];?>">
					<?php foreach ($options[2] as $title => $value) {?>			 				 
					<option value="<?php echo $value;?>">
						<?php echo $title;?>
					</option>
					<?php }?>			 			 						
				</select>
			</div>
<?php } else { ?><h2><span><?php echo $options;?></span></h2><?php } }?> 
		 </div>
	</div>
	
	 <div class="nico_tab">
			<div>
<?php foreach ($nico_settings as $_name => $setting) {
			if (is_array($setting))
			{?>			 
			 <div class="setting">
				 <div class="name"><?php echo $_name;?></div>
				 <div class="value">
				<?php switch ($setting[2]) {
			    case 'text':
			    case 'href':?>
					<input type="text" name="<?php echo $setting[1];?>" selector="<?php echo $setting[0];?>"  attribute="<?php echo $setting[2];?>"
					value="<?php if (isset($_nico_settings['settings'][$setting[1]])) 
							echo $_nico_settings['settings'][$setting[1]];?>"/>
				<?php break;
				 	  case 'textarea': 
				?>
					<textarea name="<?php echo $setting[1];?>" selector="<?php echo $setting[0];?>" attribute="<?php echo $setting[2];?>"><?php 
					if (isset($_nico_settings['settings'][$setting[1]])) 
					echo $_nico_settings['settings'][$setting[1]];?></textarea>
				<?php break;
				 	  case 'checkbox': 
				?>
					<input type="checkbox" name="<?php echo $setting[1];?>" selector="<?php echo $setting[0];?>"  attribute="<?php echo $setting[2];?>"
					<?php if (isset($_nico_settings['settings'][$setting[1]]) 
							&& $_nico_settings['settings'][$setting[1]] != 'false') 
							echo 'value="true" checked="checked"'; else echo 'value="false"';?>/>
				<?php break;
				 	  case 'select': 
				?>
					<select name="<?php echo $setting[1];?>" selector="<?php echo $setting[0];?>"  attribute="<?php echo $setting[2];?>">
					<?php 
						foreach($setting[3] as $_name => $value)
						{?>
							<option value="<?php echo $value;?>"<?php if (isset($_nico_settings['settings'][$setting[1]]) 
							&& $_nico_settings['settings'][$setting[1]] == $value) echo ' selected';?>><?php echo $_name;?></option>
						<?php	
						}
					?>
					</select>
				<?php break;
				   }
				?>
				 </div>
			 </div>
<?php } else { ?><h2><span><?php echo $setting;?></span></h2><?php } }?> 
		 </div>
	</div>
	
	
	
	
	 <div class="nico_tab">
			<div id="nico_slides">
				<div class="slider_text_btns">
					<a id="nico_add_slide" href="#">+ Add new slide text</a>
					<a id="nico_remove_slide"  href="#">- Remove last slide text</a>
				</div>
			
<?php if (isset($_nico_settings['slider_text']) && array($_nico_settings['slider_text'])) foreach ($_nico_settings['slider_text'] as $index => $slide) { ?>
			 <div class="slider_text">
				 <div class="value">
					<table>
					<tr>
						<td><label>Title</label></td>
						<td><input type="text" name="slider_title" value="<?php echo $slide['title'];?>"/></td>
					</tr>
					<tr>
						<td><label>Subtitle</label></td>
						<td><input type="text" name="slider_subtitle" value="<?php echo $slide['subtitle'];?>"/></td>
					</tr>
					<tr>
						<td><label>Description</label></td>
						<td><textarea name="slider_description"><?php if (isset($slide['description'])) echo $slide['description'];?></textarea></td>
					</tr>
					</table>
				 </div>
			 </div>
<?php }?>
		 </div>
	</div>
</div>


<div class="nico_status">
	<?php if (DEMO) {?>Saving is disabled in the DEMO version!<?php } else {?>Saving ... <?php }?>
</div>
<?php
}
?>

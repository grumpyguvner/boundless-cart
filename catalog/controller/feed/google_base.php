<?php 
class ControllerFeedGoogleBase extends Controller {
	public function index() {
            
            
		if ($this->config->get('google_base_status')) { 
			$output  = '<?xml version="1.0" encoding="UTF-8" ?>';
			$output .= '<rss version="2.0" xmlns:g="http://base.google.com/ns/1.0">';
            $output .= '<channel>';
			$output .= '<title>' . $this->config->get('config_name') . '</title>'; 
			$output .= '<description>' . $this->config->get('config_meta_description') . '</description>';
			$output .= '<link>' . HTTP_SERVER . '</link>';
			
			$this->load->model('catalog/category');
			
			$this->load->model('catalog/product');
			
			$this->load->model('tool/image');
			
                        $exclude_products = $this->config->get('google_base_product_excluded');
                        
                        if (!is_array($exclude_products)) {
                            $exclude_products = array();
                        }
                        
			$products = $this->model_catalog_product->getProducts();
			
			foreach ($products as $product) {
                            if(!in_array($product['product_id'], $exclude_products)) {
				$googlebase = $this->model_catalog_product->getProductGoogleBaseCategories($product['product_id']);
                                
				if ($product['description'] && $googlebase) {
					$output .= '<item>';
					$output .= '<title>' . $this->clean_description($product['name']) . '</title>';
					$output .= '<link>' . $this->url->link('product/product', 'product_id=' . $product['product_id']) . '</link>';
					$output .= '<description>' . $this->clean_description(html_entity_decode($product['description'])) . '</description>';
					if ($product['manufacturer'])
                                        {
                                            $output .= '<g:brand>' . $this->clean_description($product['manufacturer']) . '</g:brand>';
                                        }
					$output .= '<g:condition>new</g:condition>';
					$output .= '<g:id>' . $product['product_id'] . '</g:id>';
					
					if ($product['image']) {
						$output .= '<g:image_link>' . $this->model_tool_image->resize($product['image'], 500, 500) . '</g:image_link>';
					} else {
						$output .= '<g:image_link>' . $this->model_tool_image->resize('no_image.jpg', 500, 500) . '</g:image_link>';
					}
					
					$output .= '<g:mpn>' . $product['model'] . '</g:mpn>';

					$supported_currencies = array('USD', 'EUR', 'GBP');

                    if (in_array($this->currency->getCode(), $supported_currencies)) {
                        $currency = $this->currency->getCode();
                    } else {
                        $currency = ($this->config->get('google_base_status')) ? $this->config->get('google_base_status') : 'USD';
                    }
									
					if ((float)$product['special']) {
                        $output .= '<g:price>' .  $this->currency->format($this->tax->calculate($product['special'], $product['tax_class_id']), $currency, false, false) . '</g:price>';
                    } else {
                        $output .= '<g:price>' . $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id']), $currency, false, false) . '</g:price>';
                    }
                    $output .= '<g:google_product_category>' . ($googlebase['googlebase_xml'] ? $googlebase['googlebase_xml'] : $this->clean_description($googlebase['googlebase_text'])) . '</g:google_product_category>';
			   
					$categories = $this->model_catalog_product->getCategories($product['product_id']);

 					$cnt = 0;                   
					foreach ($categories as $category) {
						$path = $this->getPath($category['category_id']);
						
						if ($path) {
							$string = '';
							
							foreach (explode('_', $path) as $path_id) {
								$category_info = $this->model_catalog_category->getCategory($path_id);
								
								if ($category_info) {
									if (!$string) {
										$string = $category_info['name'];
									} else {
										$string .= ' > ' . $category_info['name'];
									}
								}
							}

                                                        //google has a limit of 10 product_type elements						 
							if ($cnt<10) $output .= '<g:product_type>' . $this->clean_description($string) . '</g:product_type>';
							$cnt++;
						}
					}
					
					$output .= '<g:quantity>' . $product['quantity'] . '</g:quantity>';
					$output .= '<g:upc>' . $product['upc'] . '</g:upc>'; 
					$output .= '<g:weight>' . $this->weight->format($product['weight'], $product['weight_class_id']) . '</g:weight>';
					$output .= '<g:availability>' . ($product['quantity'] ? 'in stock' : 'out of stock') . '</g:availability>';
					$output .= '</item>';
				}
                        }
			}
			
			$output .= '</channel>'; 
			$output .= '</rss>';	
			
                        $this->response->addHeader('Content-Type: application/xml');
			$this->response->setOutput($output);
		}
	}
	
	protected function getPath($parent_id, $current_path = '') {
		$category_info = $this->model_catalog_category->getCategory($parent_id);
	
		if ($category_info) {
			if (!$current_path) {
				$new_path = $category_info['category_id'];
			} else {
				$new_path = $category_info['category_id'] . '_' . $current_path;
			}	
		
			$path = $this->getPath($category_info['parent_id'], $new_path);
					
			if ($path) {
				return $path;
			} else {
				return $new_path;
			}
		}
	}		
function clean_description($str)
{
    $return = '';
    $length = strlen($str);
    $invalid = array_flip(array("\xEF\xBF\xBF" /* U-FFFF */, "\xEF\xBF\xBE" /* U-FFFE */));

    for ($i=0; $i < $length; $i++)
    {
        $c = ord($str[$o=$i]);

        if ($c < 0x80) $n=0; # 0bbbbbbb
        elseif (($c & 0xE0) === 0xC0) $n=1; # 110bbbbb
        elseif (($c & 0xF0) === 0xE0) $n=2; # 1110bbbb
        elseif (($c & 0xF8) === 0xF0) $n=3; # 11110bbb
        elseif (($c & 0xFC) === 0xF8) $n=4; # 111110bb
        else continue; # Does not match

        for ($j=++$n; --$j;) # n bytes matching 10bbbbbb follow ?
            if ((++$i === $length) || ((ord($str[$i]) & 0xC0) != 0x80))
                continue 2
        ;

        $match = substr($str, $o, $n);

        if ($n === 3 && isset($invalid[$match])) # test invalid sequences
            continue;

        $return .= $match;
    }

    $return = preg_replace('/[^\pL\pN\pP\pS\pZ]/u', ' ', htmlspecialchars(strip_tags($str)));
    return $return;
}
}
?>
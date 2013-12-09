<?php
class ControllerNewsArticle extends Controller {
	public function index() {
		$this->load->language('news/article');
		
		$this->load->model('catalog/news');
		
		$this->load->model('catalog/ncomments');
		
		$this->load->model('tool/image');
		
		$this->data['breadcrumbs'] = array();
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);
			$this->load->model('catalog/ncategory');	
		
		if (isset($this->request->get['ncat'])) {
			$ncat = '';
				
			foreach (explode('_', $this->request->get['ncat']) as $ncat_id) {
				if (!$ncat) {
					$ncat = $ncat_id;
				} else {
					$ncat .= '_' . $ncat_id;
				}
				
				$ncategory_info = $this->model_catalog_ncategory->getncategory($ncat_id);
				
				if ($ncategory_info) {
					$this->data['breadcrumbs'][] = array(
						'text'      => $ncategory_info['name'],
						'href'      => $this->url->link('news/ncategory', 'ncat=' . $ncat),
						'separator' => $this->language->get('text_separator')
					);
				}
			}
		} else {
		$this->data['breadcrumbs'][] = array(
						'text'      => $this->language->get('button_news'),
						'href'      => $this->url->link('news/headlines'),
						'separator' => $this->language->get('text_separator')
		);
			
		}
                
                $limit = $this->config->get('config_catalog_limit');
                
                if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else { 
			$page = 1;
		}
		
		if (isset($this->request->get['news_id'])) {
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_review'] = $this->language->get('entry_comment');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');
		$this->data['text_note'] = $this->language->get('text_note');
		$this->data['nocomment'] = $this->language->get('nocomment');
		$this->data['writec'] = $this->language->get('writec');
		$this->data['text_wait'] = $this->language->get('text_wait');
		$this->data['text_send'] = $this->language->get('bsend');
		$this->data['title_comments'] = sprintf($this->model_catalog_ncomments->getTotalNcommentsByNewsId($this->request->get['news_id']));
		$this->data['text_coms'] = $this->language->get('title_comments');
                $this->data['text_recent_articles'] = $this->language->get('text_recent_articles');
                $this->data['text_view_product_info'] = $this->language->get('text_view_product_info');
		
		$this->data['news_id'] = $this->request->get['news_id'];
			
			$news_info = $this->model_catalog_news->getNewsStory($this->request->get['news_id']);
			
			if ($news_info) {
				$this->document->setTitle($news_info['meta_title'] ? $news_info['meta_title'] : $news_info['title']); 
				$this->document->setDescription($news_info['meta_desc']);
                                $this->document->setKeywords($news_info['meta_key']);
                                
                                $this->document->addLink($this->url->link('news/article', 'news_id=' . $this->request->get['news_id']), 'canonical');
				
				$this->data['breadcrumbs'][] = array(
                                    'text'      => $news_info['title'],
                                    'href'      => $this->url->link('news/article', 'news_id=' .  $this->request->get['news_id']),      		
                                    'separator' => $this->language->get('text_separator')
                            );	
			
				$this->data['news_info'] = $news_info;
				
				$this->data['heading_title'] = $news_info['title'];
				
				$this->data['acom'] = $news_info['acom'];
				
				$this->data['description'] = html_entity_decode($news_info['description']);
				
				$this->data['date_added'] = date($this->language->get('date_format_short'), strtotime($news_info['date_added']));
				
				$this->data['button_news'] = $this->language->get('button_news');
				
				$this->data['button_cart'] = $this->language->get('button_cart');
				
				$this->data['news_prelated'] = $this->language->get('news_prelated');
                                
                                $this->data['news_recent'] = $this->language->get('news_recent');
                                
                                $this->data['button_back'] = $this->language->get('button_back');
                                
                                $this->data['button_more'] = $this->language->get('button_more');
				
		    $this->data['products'] = array();
			
			$related = $this->model_catalog_news->getProductRelated($this->request->get['news_id']);
			
			foreach ($related as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
				} else {
					$image = false;
				}
				
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
						
				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}
				
				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}
                                
				$idcategory = $this ->model_catalog_product->getCategories($result['product_id']);
                                
                                foreach ($idcategory as $categoryid) {
                                    if ($categoryid['category_id']) {
                                        $idcat = $categoryid['category_id'];
                                    }
                                }
                                
				$this->data['products'][] = array(
					'product_id'     => $result['product_id'],
					'thumb'   	 => $image,
					'name'    	 => $result['name'],
					'price'   	 => $price,
					'special' 	 => $special,
					'rating'         => $rating,
					'reviews'        => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href'    	 => $this->url->link('product/product', 'path=' . $idcat . '&product_id=' . $result['product_id']),
				);
			
                        }
                        
                        $data = array(
				'start'           => ($page - 1) * $limit,
				'limit'           => $limit 
			);
                        if ($this->config->get('bnews_image_width')) {
                            $bwidth = $this->config->get('bnews_image_width');
			} else {
                            $bwidth = 136;
			}
			
			if ($this->config->get('bnews_image_height')) {
                            $bheight = $this->config->get('bnews_image_height');
			} else {
                            $bheight = 136;
			}
                        
                        $this->data['rarticles'] = array();
                        
                        $news_total = $this->model_catalog_news->getTotalNews($data);
			$rnews = $this->model_catalog_news->getNewsNoTestimonials($data);
			
                        if ($news_total >= 1) {
                            foreach ($rnews as $rarticle) {
                                    if ($rarticle['image']) {
                                            $image = $this->model_tool_image->resize($rarticle['image'], $bwidth, $bheight);
                                    } else {
                                            $image = false;
                                    }
                                    
                                    $this->data['rarticles'][] = array(
                                            
                                            'article_id'  => $rarticle['news_id'],
                                            'name'        => $rarticle['title'],
                                            'acom'        => $rarticle['acom'],
                                            'thumb'       => $image,
                                            'description' => utf8_substr(strip_tags(html_entity_decode($rarticle['description'], ENT_QUOTES, 'UTF-8')), 0, 60) . '..',
                                            'date_added' => date($this->language->get('date_format_short'), strtotime($rarticle['date_added'])),
                                            'total_comments' => $this->model_catalog_ncomments->getTotalNcommentsByNewsId($rarticle['news_id']),
                                            'href'        => $this->url->link('news/article' . '&news_id=' . $rarticle['news_id'])
                                    );
                            }
                        }
                        else {
                            $this->data['rarticles'][] = array();
                        }
                        
			if ($this->config->get('bnews_thumb_width')) {
            $bwidth = $this->config->get('bnews_thumb_width');
			} else {
			$bwidth = 230;
			}
			
			if ($this->config->get('bnews_thumb_height')) {
            $bheight = $this->config->get('bnews_thumb_height');
			} else {
			$bheight = 230;
			}
				
				if ($news_info['image']) {
				$this->data['thumb'] = $this->model_tool_image->resize($news_info['image'], $bwidth, $bheight);
				$this->data['popup'] = $this->model_tool_image->resize($news_info['image'], 600, 600);
			   } else {
				$this->data['thumb'] = '';
				$this->data['popup'] = '';
			   }
				
				$this->data['news'] = $this->url->link('news/headlines');
				if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else {
				$page = 1;
			}
				
				$this->data['comment'] = array();
		
		        $comment_total = $this->model_catalog_ncomments->getTotalNcommentsByNewsId($this->request->get['news_id']);
			
		        $results = $this->model_catalog_ncomments->getCommentsByNewsId($this->request->get['news_id'], ($page - 1) * 10, 10);
      		
		        foreach ($results as $result) {
        	    $this->data['comment'][] = array(
        		'author'     => $result['author'],
				'text'       => strip_tags($result['text']),
        		'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
        	     );
				}
                        $pagination = new Pagination();
		        $pagination->total = $comment_total;
		        $pagination->page = $page;
		        $pagination->limit = 10; 
		        $pagination->text = $this->language->get('text_pagination');
		        $pagination->url = $this->url->link('news/article', 'news_id=' . $this->request->get['news_id'] . '&page={page}');
			    $this->data['pagination'] = $pagination->render();
                        
                        if ($pagination->getPrevLink())
                        {
                            $this->document->addLink($pagination->getPrevLink(), 'prev');
                        }
                        if ($pagination->getNextLink())
                        {
                            $this->document->addLink($pagination->getNextLink(), 'next');
                        }
				
				
				
				$this->setTemplate('news/article.tpl');
				
				$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
			
				$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));

			} else {
				$this->document->setTitle = $this->language->get('text_error');
				
				$this->data['breadcrumbs'][] = array(
        		'text'      => $news_info['title'],
				'href'      => $this->url->link('news/article', 'news_id=' .  $this->request->get['news_id']),      		
        		'separator' => $this->language->get('text_separator')
      		);	
			
				$this->data['heading_title'] = $this->language->get('text_error');
				
				$this->data['text_error'] = $this->language->get('text_error');
				
				$this->data['button_continue'] = $this->language->get('button_continue');
				
				$this->data['continue'] = $this->url->link('common/home');
				
				$this->setTemplate('error/not_found.tpl');
					
				$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);

				$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
			}
		
		}
	}
	public function writecomment() {
		$this->load->language('news/article');
		
		$this->load->model('catalog/ncomments');
		
		$json = array();
		
		if ((strlen(utf8_decode($this->request->post['name'])) < 3) || (strlen(utf8_decode($this->request->post['name'])) > 25)) {
			$json['error'] = $this->language->get('error_name');
		}
		
		if ((strlen(utf8_decode($this->request->post['text'])) < 25) || (strlen(utf8_decode($this->request->post['text'])) > 1000)) {
			$json['error'] = $this->language->get('error_text');
		}

		if (!isset($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
			$json['error'] = $this->language->get('error_captcha');
		}
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && !isset($json['error'])) {
			$this->model_catalog_ncomments->addComment($this->request->get['news_id'], $this->request->post);
			
			$json['success'] = $this->language->get('text_success');
		}
	
		
		$this->response->setOutput(json_encode($json));
	}
	
	public function captcha() {
		$this->load->library('captcha');
		
		$captcha = new Captcha();
		
		$this->session->data['captcha'] = $captcha->getCode();
		
		$captcha->showImage();
	}

}
?>

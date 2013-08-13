<?php
/* NOTICE OF LICENSE
 *
 * This source file is subject to a commercial license from SARL SMC
 * Use, copy, modification or distribution of this source file without written
 * license agreement from the SARL SMC is strictly forbidden.
 * In order to obtain a license, please contact us: olivier@common-services.com
 * ...........................................................................
 * INFORMATION SUR LA LICENCE D'UTILISATION
 *
 * L'utilisation de ce fichier source est soumise a une licence commerciale
 * concedee par la societe SMC
 * Toute utilisation, reproduction, modification ou distribution du present
 * fichier source sans contrat de licence ecrit de la part de la SARL SMC est
 * expressement interdite.
 * Pour obtenir une licence, veuillez contacter la SARL SMC a l'adresse: olivier@common-services.com
 * ...........................................................................
 * @package    Amazon Market Place
 * @copyright  Copyright (c) 2011-2011 S.A.R.L SMC (http://www.common-services.com)
 * @copyright  Copyright (c) 2011-2011 Olivier B.
 * @author     Olivier B.
 * @license    Commercial license
 * Support by mail  :  olivier@common-services.com
 * Support on forum :  delete
 * Skype : delete13_fr
 * Phone : +33.970465505
 */
 
class ControllerExtensionAmazon extends Controller {
	public function index() {
		$this->load->language('extension/amazon');

		$this->document->setTitle($this->language->get('heading_title'));

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['heading_title'] = $this->language->get('heading_title');


		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		if (isset($this->session->data['error'])) {
			$this->data['error'] = $this->session->data['error'];

			unset($this->session->data['error']);
		} else {
			$this->data['error'] = '';
		}

		$this->load->model('setting/extension');

		$extensions = $this->model_setting_extension->getInstalled('amazon');

		foreach ($extensions as $key => $value) {
			if (!file_exists(DIR_APPLICATION . 'controller/amazon/' . $value . '.php')) {
				$this->model_setting_extension->uninstall('amazon', $value);

				unset($extensions[$key]);
			}
		}

		$this->data['extensions'] = array();

		$files = glob(DIR_APPLICATION . 'controller/amazon/*.php');

		if ($files) {
			foreach ($files as $file) {
				$extension = basename($file, '.php');

				$this->load->language('amazon/' . $extension);

				$action = array();
                $image = $extension . '.png' ;

				if (!in_array($extension, $extensions)) {
					$action[] = array(
						'text' => $this->language->get('text_install'),
						'href' => $this->url->link('extension/amazon/install', 'token=' . $this->session->data['token'] . '&extension=' . $extension, 'SSL')
					);
				} else {
					$action[] = array(
						'text' => $this->language->get('text_edit'),
						'href' => $this->url->link('amazon/' . $extension . '', 'token=' . $this->session->data['token'], 'SSL')
					);

					$action[] = array(
						'text' => $this->language->get('text_uninstall'),
						'href' => $this->url->link('extension/amazon/uninstall', 'token=' . $this->session->data['token'] . '&extension=' . $extension, 'SSL')
					);
				}
				$this->data['extensions'][] = array(
					'name'   => $this->language->get('heading_title'),
					'status' => $this->config->get('status') ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
					'href' => $this->url->link('amazon/' . $extension . '', 'token=' . $this->session->data['token'], 'SSL'),
                    'image' => $image
				);
			}
		}

		$this->template = 'extension/amazon.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

	public function install() {
    	if (!$this->user->hasPermission('modify', 'extension/amazon')) {
      		$this->session->data['error'] = $this->language->get('error_permission');

			$this->redirect($this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'));
    	} else {
			$this->load->model('setting/extension');

			$this->model_setting_extension->install('amazon', $this->request->get['extension']);

			$this->load->model('user/user_group');

			$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'amazon/' . $this->request->get['extension']);
			$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'amazon/' . $this->request->get['extension']);

			require_once(DIR_APPLICATION . 'controller/amazon/' . $this->request->get['extension'] . '.php');
			
			$class = 'Controlleramazon' . str_replace('_', '', $this->request->get['extension']);
			$class = new $class($this->registry);
			
			if (method_exists($class, 'install')) {
				$class->install();
			}
		
			$this->redirect($this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}

	public function uninstall() {
    	if (!$this->user->hasPermission('modify', 'extension/amazon')) {
      		$this->session->data['error'] = $this->language->get('error_permission'); 
			
			$this->redirect($this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'));
    	} else {		
			$this->load->model('setting/extension');
			$this->load->model('setting/setting');
			
			$this->model_setting_extension->uninstall('amazon', $this->request->get['extension']);

			$this->model_setting_setting->deleteSetting($this->request->get['extension']);

			require_once(DIR_APPLICATION . 'controller/amazon/' . $this->request->get['extension'] . '.php');

			$class = 'Controlleramazon' . str_replace('_', '', $this->request->get['extension']);
			$class = new $class($this->registry);

			if (method_exists($class, 'uninstall')) {
				$class->uninstall();
			}

			$this->redirect($this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}
}
?>
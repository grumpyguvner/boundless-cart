<?php
class ControllerAccountRedeem extends Controller {
    
	public function redeem() {

		$this->load->model('account/redeem');
		
		if (isset($this->request->get['code'])) {
			$code = $this->request->get['code'];
		} else {
			$code = 0;
		}
		
		$redeem_info = $this->model_account_redeem->getRedeemByCode($code);
		
		if ($redeem_info) {
			$file = DIR_DOWNLOAD . 'voucher-'.$redeem_info['code'].'.pdf';
			$mask = basename('voucher-'.$redeem_info['code'].'.pdf');

			if (!headers_sent()) {
				if (file_exists($file)) {
					header('Content-Type: application/octet-stream');
					header('Content-Description: File Transfer');
					header('Content-Disposition: attachment; filename="' . ($mask ? $mask : basename($file)) . '"');
					header('Content-Transfer-Encoding: binary');
					header('Expires: 0');
					header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
					header('Pragma: public');
					header('Content-Length: ' . filesize($file));
					
					readfile($file, 'rb');
					
					exit;
				} else {
					exit('Error: Could not find file ' . $file . '!');
				}
			} else {
				exit('Error: Headers already sent out!');
			}
		} else {
			$this->redirect($this->url->link('account/account', '', 'SSL'));
		}
	}
}
?>
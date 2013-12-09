<?php
class ModelLocalisationOrderStatusLabel extends Model
{
	public function editOrderStatusLabels($data)
	{
		if (!$this->dbTableExists()) return null;

		$this->db->query("DELETE FROM " . DB_PREFIX . "order_status_label WHERE 1");

		if ($data) foreach ($data['order_status_labels'] as $order_status_label)
		{
			if ( isset($order_status_label['order_status_id'])
				and ((int)$order_status_label['order_status_id']>0)
				and isset($order_status_label['label'])
				and trim($order_status_label['label'])
			)
			{
				$sql = "
					INSERT INTO " . DB_PREFIX . "order_status_label
					SET
						order_status_id = '" . (int)$order_status_label['order_status_id'] . "',
						label = '" . trim($this->db->escape($order_status_label['label'])) . "'
				";
				$this->db->query($sql);
			}
		}

		$this->cache->delete('order_status_label');
	}

	public function deleteOrderStatusLabels()
	{
		if (!$this->dbTableExists()) return null;

		$this->db->query("DELETE FROM " . DB_PREFIX . "order_status_label WHERE 1");
		$this->cache->delete('order_status_label');
	}

	public function getOrderStatusLabel($order_status_id)
	{
		if (!$this->dbTableExists()) return null;

		$query = $this->db->query("
			SELECT * FROM " . DB_PREFIX . "order_status_label
			WHERE order_status_id = '" . (int)$order_status_id . "'
		");

		return $query->row;
	}

	public function getOrderStatusLabelForOrderId($order_id)
	{
		if (!$this->dbTableExists()) return null;

		$query = $this->db->query("SELECT order_status_id FROM `" . DB_PREFIX . "order` WHERE order_id = " .(int)$order_id);

		$order_status_id = $query->num_rows ? (int)$query->row['order_status_id'] : 0;

		return $order_status_id ? $this->getOrderStatusLabel($order_status_id) : null;
	}

	public function getOrderStatusLabels()
	{
		if (!$this->dbTableExists()) return null;

		$order_status_labels = $this->cache->get('order_status_label');

		if (!$order_status_labels)
		{
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_status_label");

			$rows = $query->rows;

			if ($rows) foreach ($rows as $row) {
				$order_status_labels[$row['order_status_id']] = $row['label'];
			}

			$this->cache->set('order_status_label', $order_status_labels);
		}

		return $order_status_labels;
	}

	public function setOrderStatusLabels(&$order_statuses=null)
	{
		if (!$this->dbTableExists()) {
			foreach ($order_statuses as $n=>$order_status) {
				$order_statuses[$n]['label'] = '';
			}
			return;
		}

		$order_status_labels = $this->getOrderStatusLabels();

		if (is_array($order_statuses))
		{
			foreach ($order_statuses as $n=>$order_status) {
				$order_status_id = (int)$order_status['order_status_id'];
				$order_statuses[$n]['label'] = isset($order_status_labels[$order_status_id]) ? $order_status_labels[$order_status_id] : '';
			}
		}
	}

	public function setOrderStatusLabelsForOrders(&$orders=null)
	{
		if (!$this->dbTableExists()) {
			foreach ($orders as $n=>$order) {
				$orders[$n]['order_status_label'] = '';
			}
			return;
		}

		$order_status_labels = $this->getOrderStatusLabels();

		$orderIdList = array();

		if (is_array($orders))
		{
			foreach ($orders as $order) {
				$orderIdList[] = (int)$order['order_id'];
			}
			$orderIdList = array_unique($orderIdList);
			$orderIdListSQL = '('.implode(',', $orderIdList).')';

			$query = $this->db->query("SELECT order_id, order_status_id FROM `" . DB_PREFIX . "order` WHERE order_id IN $orderIdListSQL");
			$rows = $query->rows;

			$order_statuses = array();
			foreach ($rows as $row) {
				$order_id = (int)$row['order_id'];
				$order_statuses[$order_id] = (int)$row['order_status_id'];
			}

			foreach($orders as $n=>$order) {
				$order_id = (int)$order['order_id'];
				$order_status_id = isset($order_statuses[$order_id]) ? $order_statuses[$order_id] : 0;
				$orders[$n]['order_status_id'] = $order_status_id;
				$orders[$n]['order_status_label'] = isset($order_status_labels[$order_status_id]) ? $order_status_labels[$order_status_id] : '';
			}
		}
	}

	public function getOrderStatusLabelOptions($selected=null, $allowEmpty=true)
	{
		$options=array();

		if ($allowEmpty) {
			$options[0] = '---';
		}
		$options['default'] = 'Default';
		$options['success'] = 'Success';
		$options['warning'] = 'Warning';
		$options['important'] = 'Important';
		$options['info'] = 'Info';
		$options['inverse'] = 'Inverse';

		$html = '';

		foreach ($options as $value=>$label) {
			$html .= '<option value="'.$value.'"'.(($selected==$value)?' selected="selected"':null).'>'.$label.'</option>';
		}

		return $html;
	}

	public function dbTableExists($forceCheck=false)
	{
		static $exists = null;

		if ($forceCheck or ($exists===null)) {
			$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX. "order_status_label'");
			$exists = (bool)$query->num_rows;
		}
		return $exists;
	}

	public function createDbTable($insertDefaultValues=true)
	{
		if (!$this->dbTableExists())
		{
			$dbPrefix = DB_PREFIX;

			$sql =  <<<EOT
CREATE TABLE IF NOT EXISTS `{$dbPrefix}order_status_label` (
  `order_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(16) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`order_status_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
EOT;

		$this->db->query($sql);

			if ($insertDefaultValues)
			{
				$this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "order_status_label`");

				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(7, 'inverse')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(9, 'inverse')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(13, 'success')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(5, 'success')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(8, 'important')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(14, 'inverse')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(10, 'important')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(1, 'warning')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(15, 'info')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(2, 'info')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(11, 'success')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(12, 'default')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(3, 'success')");
				$this->db->query("INSERT INTO `" . DB_PREFIX . "order_status_label` (`order_status_id`, `label`) VALUES(16, 'default')");
			}
		}
	}

	public function canCreateDbTables($forceCheck=false)
	{
		static $check = null;
		if ($forceCheck or ($check===null)) {
			$pattern = '/GRANT (ALL PRIVILEGES|.*CREATE.*) ON (\*\.\*|.?'.DB_DATABASE.'.?\..*) TO (.?'.DB_USERNAME.'.?\@.*).*/i';
			//$test = "GRANT CREATE, CREATE TEMPORARY TABLES ON `".DB_DATABASE."`.* TO '".DB_USERNAME."'.'@'localhost'";
			//$test = preg_replace('/CREATE TEMPORARY TABLES/i', '', $test);
			//var_dump(preg_match($pattern, $test));
			$query = $this->db->query("SHOW GRANTS");
			$rows = $query->rows;
			foreach ($rows as $row) {
				foreach ($row as $key=>$grants) {
					$grants = preg_replace('/CREATE TEMPORARY TABLES/i', '', $grants);
					$check = (bool) preg_match($pattern, $grants);
					if ($check) break 2;
				}
			}
		}
		return $check;
	}
}

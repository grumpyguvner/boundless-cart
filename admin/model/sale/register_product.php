<?php

class ModelSaleRegisterProduct extends Model {
	public function getRegistered() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "register_product");

		return $query->rows;
	}
}
?>
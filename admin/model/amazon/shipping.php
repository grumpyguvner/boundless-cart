<?php
class ModelAmazonShipping extends Model {

	public function orderExists($amazon_order_id)
    {
        $query = $this->db->query('SELECT order_id from `'.DB_PREFIX.'order` where `amazon_order_id`="' . $amazon_order_id . '"') ;

        return( isset($query->row['order_id']) &&  ! empty($query->row['order_id']) ? $query->row['order_id'] : false);
	}

    private function _insert($query, $data)
    {
        $sql = '' ;

        foreach($data as $field => $value)
        {
          if ( empty($value) )   continue ;

          if ( is_numeric($value) )
            $sql .= " " . $field . "=" . $this->db->escape($value) . "," ;
          else
            $sql .= " " . $field . "='" . $this->db->escape($value) . "'," ;
        }
        $sql = rtrim($sql, ',') ;

        if ( ! ($result = $this->db->query($query . $sql)) ) return(false) ;

        return( $this->db->getLastId() ) ;
    }

    public function addOrderHistory($subtotal)
    {
        $sql = 'INSERT INTO `'.DB_PREFIX.'order_history` set' ;

        return(self::_insert($sql, $subtotal)) ;
    }

}
?>
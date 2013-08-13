<?php
class ModelAmazonCategories extends Model {

	public function getCategoryList()
    {
        $sql = 'SELECT * from `'.DB_PREFIX.'amazon_categories`' ;

        if ( ! $query = $this->db->query($sql) ) return(false) ;

        $result = '' ;
        foreach($query->rows as $category)
            $result .= $category['category_id'] . ',' ;
        $result = rtrim($result, ',') ;

        return($result) ;
	}
}
?>
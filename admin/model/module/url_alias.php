<?php
class ModelModuleUrlAlias extends Model {
	public function addUrlAlias($data) {
            
            $data['keyword'] = $this->seoUrl($data['keyword']);
            
            if ($data['keyword'])
            {
                $url_alias_info = $this->getUrlAlias($data['keyword']);

                if ($url_alias_info)
                {
                    $this->db->query("UPDATE " . DB_PREFIX . "url_alias SET keyword = '" . $this->db->escape($data['keyword']) . "', query = '" . $this->db->escape($data['query']) . "', language_id = '" . (int)$data['language_id'] . "' WHERE keyword = '" . $this->db->escape($data['keyword']) . "'");
                } else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET keyword = '" . $this->db->escape($data['keyword']) . "', query = '" . $this->db->escape($data['query']) . "', language_id = '" . (int)$data['language_id'] . "'");
                }

                $this->cache->delete('url');
            //} else {
            //    $this->deleteUrlAliasByQuery($data['query'], $data['language_id']);
            }
	}
	
	public function deleteUrlAliasByQuery($query, $language_id = null) {
            $sql = "UPDATE " . DB_PREFIX . "url_alias SET query = '' WHERE query = '" . $this->db->escape($query) . "'";
            
            if (!is_null($language_id))
            {
                $sql .= " and language_id = " . (int) $language_id;
            }
            
            $this->db->query($sql);
            
            $this->cache->delete('url');
	}
		
	public function getUrlAlias($keyword) {
            
            $keyword = $this->seoUrl($keyword);
            
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($keyword) . "'");

            return $query->row;
	}
        
        public function seoUrl($string) {
            //Unwanted:  {UPPERCASE} ; / ? : @ & = + $ , . ! ~ * ' ( )
            $string = strtolower($string);
            //Strip any unwanted characters
            $string = preg_replace("/[^a-z0-9_\s-\.]/", "", $string);
            //Clean multiple dashes or whitespaces
            $string = preg_replace("/[\s-]+/", " ", $string);
            //Convert whitespaces and underscore to dash
            $string = preg_replace("/[\s_]/", "-", $string);
            return $string;
        }
}
?>
<?php
include_once('zencart_core.php');

class ModelToolZencartTestimonials extends ModelToolZencart {

    function import() {
        $this->debugMode = $this->config->get('zencart_products_debug');

        if (!$this->cacheZencartData())
            return false;

        $this->debug("Import Complete");
        return true;
    }

    function cacheZencartData($forceRefresh = false) {

        $this->debug("fetching testimonials from zencart");
        $aTestimonials = $this->dbQF->Execute('SELECT * FROM testimonials_manager ORDER BY date_added');
        
        $cnt = 1;
        if ($aTestimonials->RecordCount() > 0) {
            while (!$aTestimonials->EOF) {
                $this->debug("=================================================================================================");
                $this->debug("processing testimonial ".$aTestimonials->fields['testimonials_name']);

                $data = array();
                
                $data['status'] = $aTestimonials->fields['status'];
                $data['acom'] = 0;
                $data['date_added'] = $aTestimonials->fields['date_added'];
                $data['sort_order'] = $cnt++;
                
                $sql = "INSERT INTO `" . DB_PREFIX . "news` "
                    . "SET status = '" . $this->db->escape($data['status']) . "', "
                    . "acom = '" . $this->db->escape($data['acom']) . "', "
                    . "date_added = '" . $this->db->escape($data['date_added']) . "', "
                    . "sort_order = '" . $this->db->escape($data['sort_order']) . "' ";
                $this->db->query($sql);
                
                $news_id = $this->db->getLastId();
                
                $data = array();
                
                $data['language_id'] = $this->languageId;
                $data['title'] = $aTestimonials->fields['testimonials_name'];
                $data['description'] = $aTestimonials->fields['testimonials_html_text'];
                
                $sql = "INSERT INTO `" . DB_PREFIX . "news_description` "
                    . "SET news_id = '" . (int)$news_id . "', "
                    . "language_id = '" . $this->db->escape($data['language_id']) . "', "
                    . "title = '" . $this->db->escape($data['title']) . "', "
                    . "description = '" . $this->db->escape($data['description']) . "' ";
                $this->db->query($sql);
                
                $data = array();
                
                $data['ncategory_id'] = $this->tableLookUp(DB_PREFIX . "ncategory_description", 'ncategory_id', array('name' => 'Testimonials', 'language_id' => $this->languageId));
                
                $sql = "INSERT INTO `" . DB_PREFIX . "news_to_ncategory` "
                    . "SET news_id = '" . (int)$news_id . "', "
                    . "ncategory_id = '" . (int)$data['ncategory_id'] . "' ";
                $this->db->query($sql);
                
                $this->debug("=================================================================================================");
                
                $aTestimonials->MoveNext();
            }
        }

        return true;
    }

}

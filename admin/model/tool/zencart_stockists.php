<?php
include_once('zencart_core.php');

class ModelToolZencartStockists extends ModelToolZencart {

    function import() {
        $this->debugMode = $this->config->get('zencart_products_debug');
        
        $this->truncate();

        if (!$this->cacheZencartData())
            return false;

        $this->debug("Import Complete");
        return true;
    }

    function truncate() {
        
            $this->debug("truncating tables");
            
            $this->db->query("TRUNCATE `" . DB_PREFIX . "store_locations`");
    }

    function cacheZencartData($forceRefresh = false) {

        $this->debug("fetching stockists from zencart");
        $aStockist = $this->dbQF->Execute('SELECT * FROM stockists ORDER BY s_id');
        
        $cnt = 1;
        if ($aStockist->RecordCount() > 0) {
            while (!$aStockist->EOF) {
                $this->debug("=================================================================================================");
                $this->debug("processing stockist ".$aStockist->fields['s_name']);

                $data = array();
                
                $data['Name'] = $aStockist->fields['s_name'];
                $data['Details'] = $aStockist->fields['s_description'];
                
                $address = array();
                if ($aStockist->fields['s_address1']) $address[] = $aStockist->fields['s_address1'];
                if ($aStockist->fields['s_address2']) $address[] = $aStockist->fields['s_address2'];
                if ($aStockist->fields['s_address3']) $address[] = $aStockist->fields['s_address3'];
                if ($aStockist->fields['s_address4']) $address[] = $aStockist->fields['s_address4'];
                if ($aStockist->fields['s_country']) $address[] = $aStockist->fields['s_country'];
                if ($aStockist->fields['s_postcode']) $address[] = $aStockist->fields['s_postcode'];
                
                $data['Address'] = implode(",\n", $address);
                $data['Email'] = $aStockist->fields['s_email'];
                $data['Phone'] = $aStockist->fields['s_phone1'];
                if ($aStockist->fields['s_phone_2']) $data['Phone'] .= ', ' . $aStockist->fields['s_phone_2'];
                $data['SpecialOffers'] = '';
                $data['Timing'] = '';
                $data['sort_order'] = $cnt++;
                $data['lon'] = $aStockist->fields['s_lng'];
                $data['lat'] = $aStockist->fields['s_lat'];
                if ($aStockist->fields['s_market']) $data['Details'] .= "<p>" . $aStockist->fields['s_market'] . '</p>';
                if ($aStockist->fields['s_website']) $data['Details'] .= '<p><a href="http://' . $aStockist->fields['s_website'] . '" target="_blank">' . $aStockist->fields['s_website'] . '</a></p>';
                
                $sql = "INSERT INTO `" . DB_PREFIX . "store_locations` "
                    . "SET Name = '" . $this->db->escape($data['Name']) . "', "
                    . "Details = '" . $this->db->escape(trim($data['Details'])) . "', "
                    . "Address = '" . $this->db->escape($data['Address']) . "', "
                    . "Email = '" . $this->db->escape($data['Email']) . "', "
                    . "Phone = '" . $this->db->escape($data['Phone']) . "', "
                    . "SpecialOffers = '" . $this->db->escape($data['SpecialOffers']) . "', "
                    . "Timing = '" . $this->db->escape($data['Timing']) . "', "
                    . "sort_order = '" . $this->db->escape($data['sort_order']) . "', "
                    . "lon = '" . $this->db->escape($data['lon']) . "', "
                    . "lat = '" . $this->db->escape($data['lat']) . "' ";
                $this->db->query($sql);
                
                $this->debug("=================================================================================================");
                
                $aStockist->MoveNext();
            }
        }

        return true;
    }

}

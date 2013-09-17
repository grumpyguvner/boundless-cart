<?php

class ModelToolSealskinzB2b extends Model {

    function runSchedulerOperation() {
                $this->import();
    }

    function import($importRefs = array()) {

        //Prevent php from timing out during import
        set_time_limit(0);
        
        if (!empty($importRefs) && !is_array($importRefs))
            $importRefs = enforce_array ($importRefs);
        foreach ($importRefs as $key => $value) {
            if ($value=="")
                unset ($importRefs[$key]);
        }

        $this->log->write("Begining import of store_location information from B2B");
        if (!$this->cacheB2BData($importRefs)) {
            $this->log->write("Unable to fetch data from B2B, aborting.");
            return false;
        }

        $store_location_id = 0;
        $myStoreIds = array(); //Use this as a collection of id's created/ updated when you determine which records to delete
        $error = false;
        // Check & update existing record cache
        $sql = "SELECT * FROM `" . DB_PREFIX . "b2b_stockist` 
                        WHERE IFNULL(TIMESTAMPDIFF(MINUTE, date_processed, date_modified),1) > 0
                     ORDER BY stockist_id";
        $result = $this->db->query($sql);
        if ($result->rows) {
            foreach ($result->rows as $row) {
                
                // Check to see if stockist already exists and update details
                // If stockist doesn't exist then insert a new one
                $store_item = unserialize($row['data']);
                $store_location_id = $this->createLocation($row['stockist_id'], $store_item);
                
                // Update cache table with id from stockist table
                if ($store_location_id) {
                    $this->log->write("updating sage cache data");
                    $sql = "UPDATE `" . DB_PREFIX . "b2b_stockist` SET date_processed = NOW(), store_location_id = " . $store_location_id . " WHERE stockist_id = " . (int) $row['stockist_id'];
                    $this->db->query($sql);
                }
                
            }

        }
        // only delete old stockists if no errors were encountered
        if ($error) {
            $this->log->write("Errors were encountered whilst importing store_locations.");
            return false;
        }

        $this->log->write("Import Complete");
        return true;
    }

    private function cacheB2BData($importRefs = array(), $forceRefresh = false) {
        
        if (!empty($importRefs) && !is_array($importRefs))
            $importRefs = enforce_array ($importRefs);

        $this->log->write("Fetching cache of store_location header information from B2B");
        // Since it takes around 60 minutes to fetch all of the data from sage
        // we don't normally want to be running this more than once per day.
        if (!count($importRefs) && !$forceRefresh) {
            $sql = "SELECT TIMESTAMPDIFF(MINUTE, date_modified, NOW()) AS last_run FROM `" . DB_PREFIX . "b2b_stockist` ORDER BY date_modified LIMIT 1";
            $result = $this->db->query($sql);
            if ($result->num_rows && (int) $result->row['last_run'] < 1440) {
                $this->log->write("oldest record in the cache is less than a day old so not refreshing cache.");
                return true;
            }
        }
        if ($forceRefresh) 
            $this->log->write("force refreshing cache.");
        if (count($importRefs)) 
            $this->log->write("importing: " . implode(", ", $importRefs));

        // Load XML Feed to fetch detail
        $this->load->helper('fetchxml');

        // Check for records
        // Load XML Feed
        $xml = new fetchXml();
        $response = $xml->get_array("http://" . $this->config->get('b2b_server_url'));
        if (empty($response))
            return false;
        
        $cache_items = $response['stockists'];
        foreach ($cache_items as $key => $value) {
            if (!count($importRefs) || in_array($value['id'], $importRefs)) {
                $sql = "INSERT INTO `" . DB_PREFIX . "b2b_stockist` (`stockist_id`, `stockist_name`, `data`, `date_added`, `date_modified`)
                                    VALUES ( " . (int) $value['id'] . ",'" . $this->db->escape($value['name']) . "','" . $this->db->escape(serialize($value)) . "', NOW(), NOW())
                               ON DUPLICATE KEY UPDATE
                                    `stockist_id` = " . (int) $value['id'] . ", 
                                    `stockist_name` = '" . $this->db->escape($value['name']) . "', 
                                    `data` = '" . $this->db->escape(serialize($value)) . "', 
                                    `date_modified` = NOW()
                               ";
                $this->db->query($sql);
            }
            
//            $this->fetchB2BData($value['id']);
        }

        return true;
    }

    private function createLocation($existing_id, $cache_item) {
        //if (!is_array($cache_item) || !array_key_exists("code", $cache_item))
        //    return false;
        
        //We only create a new store_location the first time it is encountered as 
        // many fields will be controlled via backoffice and we dont want to overwrite.
        $this->load->model('module/store_locations');
        $store_location_info = $this->model_module_store_locations->getLocation($existing_id);
        
        //If we have found a store_location then we need to update
        if ($store_location_info) {
            
            $store_location_info['Name'] = $cache_item['name'];
            $store_location_info['Address'] = $cache_item['address_1'].', '.$cache_item['address_2'].', '.$cache_item['city'].', '.$cache_item['postcode'].', '.$cache_item['country'];
            $store_location_info['Email'] = $cache_item['email'];
            $store_location_info['Phone'] = $cache_item['telephone'];
            $store_location_info['Website'] = $store_location_info['Website'];
            $store_location_info['Details'] = $store_location_info['Details'];
            $store_location_info['SpecialOffers'] = $store_location_info['SpecialOffers'];
            $store_location_info['Timing'] = $store_location_info['Timing'];
            $store_location_info['sort_order'] = $store_location_info['sort_order'];
            $store_location_info['lon'] = $store_location_info['lon'];
            $store_location_info['lat'] = $store_location_info['lat'];
            
            //Load all existing data for store_location
            $store_location_info['location_image'] = $this->model_module_store_locations->getLocationImages($existing_id);
            
            $this->log->write($cache_item['name'] . "(" . $existing_id . ") being updated");
            $this->model_module_store_locations->editLocation($store_location_info, $existing_id);
            return $existing_id;
            
        } else {
            
            // if store_location doesn't exist then create it
            $store_location_info = array(
                'Name' => $cache_item['name'],
                'Address' => $cache_item['address_1'].', '.$cache_item['address_2'].', '.$cache_item['city'].', '.$cache_item['postcode'].', '.$cache_item['county'],
                'Email' => $cache_item['email'],
                'Phone' => $cache_item['telephone'],
                'Website' => '',
                'Details' => '',
                'SpecialOffers' => '',
                'Timing' => '',
                'sort_order' => '',
                'lon' => '',
                'lat' => '',
            );
            
            $this->log->write($cache_item['description'] . "(" . $existing_id . ") being added");
            $existing_id = $this->model_module_store_locations->addLocation($store_location_info);
            return $existing_id;
        }

        return false;
    }
}

?>

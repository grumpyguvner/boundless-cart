<?php

class ModelToolSysproOrderStatuses extends Model {

    private $languageId = 0;
    
    private $size_option_id = 0;
    
    private function getDefaultLanguageId() {
        $code = $this->config->get('config_language');
        $sql = "SELECT language_id FROM `" . DB_PREFIX . "language` WHERE code = '$code'";
        $result = $this->db->query($sql);
        $this->languageId = 1;
        if ($result->rows) {
            foreach ($result->rows as $row) {
                $this->languageId = $row['language_id'];
                break;
            }
        }
        return $this->languageId;
    }

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

        $this->log->write("Begining import of order statuses from Syspro");
        if (!$this->cacheSysproData($importRefs)) {
            $this->log->write("Unable to fetch data from Syspro, aborting.");
            return false;
        }

        $this->languageId = $this->getDefaultLanguageId();

        // Check & update existing record cache
        $sql = "SELECT * FROM `" . DB_PREFIX . "syspro_order` 
                        WHERE IFNULL(TIMESTAMPDIFF(MINUTE, date_processed, date_modified),1) > 0
                     ORDER BY order_id";
        $result = $this->db->query($sql);
        if ($result->rows) {
            foreach ($result->rows as $row) {

		$order_id = $row['order_id'];
		$order_status_id = 0;

		$sql = "SELECT * FROM `" . DB_PREFIX . "order` 
		                WHERE order_id = '" . $order_id . "'";
		$rs_order = $this->db->query($sql);
		if ($rs_order->rows) {
			
			switch (strtolower((string) $row['status'])) {
				case "in warehouse":
					$order_status_id = $this->getOrderStatusId("Processing");
					break;
				case "dispatched":
					$order_status_id = $this->getOrderStatusId("Dispatched");
					break;
				default:
		        		$this->log->write("unable to update status for " . $row['order_id'] . ":" . $row['status'] . " - status not recognised!");
					//Ignore all other statuses
					$order_status_id = 0;
			}
			
		        if ($order_id && $order_status_id) {

			    $data = array();
			    $data['order_status_id'] = $order_status_id;
			    $data['notify'] = 1;
			    $data['notes'] = "status update received from syspro";

			    $this->load->model('sale/order');
//		       	    $this->model_sale_order->addOrderHistory($order_id, $data);

		            $this->log->write("updating syspro cache data");
		            $sql = "UPDATE `" . DB_PREFIX . "syspro_order` SET date_processed = NOW(), status = " . $order_status_id . " WHERE order_id = '" . $order_id . "'";
		            $this->db->query($sql);
		        }

		} else {
		        $this->log->write("unable to update status for " . $row['order_id'] . ":" . $row['status'] . " - order not found!!");
		}

                

                
            }

        }

        if ($error) {
            $this->log->write("Errors were encountered whilst importing order statuses.");
            return false;
        }

        $this->log->write("Import Complete");
        return true;
    }

    private function cacheSysproData($importRefs = array(), $forceRefresh = false) {
        
        if (!empty($importRefs) && !is_array($importRefs))
            $importRefs = enforce_array ($importRefs);

        $this->log->write("Fetching cache of order status information from Syspro");

        if ($forceRefresh) 
            $this->log->write("force refreshing cache.");
        if (count($importRefs)) 
            $this->log->write("importing: " . implode(", ", $importRefs));

        foreach (glob($this->config->get('syspro_input_folder') . "/b2c-order_confirmed_*.xml") as $filename) {
            $this->log->write("importing: " . basename($filename));

            $response = fopen($filename, "r");
            if ($response) {
                $xml = simplexml_load_file($filename);

                //Convert the XML into a useable array
                foreach ($xml->children() as $second_gen) {
                    switch (strtolower((string) $second_gen->getName())) {
                        case "debug":
                            //Ignore
                            break;
                        case "update":
                            $order_status = $second_gen;
			    $order_id = (int) substr($order_status->WebOrder,2);
                            if (!count($importRefs) || in_array((string)$order_id, $importRefs)) {
                                // Create a record if one doesn't already exist for this stock item
                                $sql = "INSERT INTO `" . DB_PREFIX . "syspro_order` (`order_id`, `filename`, `data`, `date_added`, `date_modified`)
                                                    VALUES ( '" . $order_id . "', '" . $this->db->escape((string)basename($filename)) . "', '" . $this->db->escape($order_status->asXML()) . "', NOW(), NOW())
                                               ON DUPLICATE KEY UPDATE
                                                                    `filename` = '" . $this->db->escape((string)basename($filename)) . "', 
                                                                    `data` = '" . $this->db->escape($order_status->asXML()) . "', 
                                                                    `date_modified` = NOW()
                                               ";
                                $this->db->query($sql);
                            }
		    }

                }
            }
            
//            if (copy($filename, $this->config->get('syspro_processed_folder') . "/" .basename($filename)))
//                unlink ($filename);
        }
        
        return true;
    }

    private function fetchSysproData($order_id, $forceRefresh = false) {

        $sql = "SELECT 
                        `" . DB_PREFIX . "syspro_order`.*, 
                        TIMESTAMPDIFF(MINUTE, date_processed, date_modified) AS last_modified, 
                        TIMESTAMPDIFF(MINUTE, date_processed, NOW()) AS last_run 
                FROM `" . DB_PREFIX . "syspro_order` WHERE order_id = '" . strtoupper($this->db->escape((string)$order_id)) . "'";
        $result = $this->db->query($sql);

        $order_status = array();

        $response =  $result->rows[0]['data'];
        
        if (!$response == 0) {
            $xml = simplexml_load_string($response);
            
            //Convert the XML into a useable array
                        foreach ($xml->children() as $third_gen) {
                            if ($third_gen->count() > 0) {
                                foreach ($third_gen->children() as $fourth_gen) {
                                    switch (strtolower((string) $third_gen->getName())) {
                                        case "pricebands":
                                            $order_status[strtolower((string) $third_gen->getName())][strtolower((string) $fourth_gen->attributes()->name)] = (float) $fourth_gen;
                                            break;
                                        default:
                                            $order_status[strtolower((string) $third_gen->getName())][strtolower($fourth_gen->getName())] = (string) $fourth_gen;
                                    }
                                }

                            } else {
                                switch (strtolower((string) $third_gen->getName())) {
                                    case "sysproorder":
                                        //Treat as integers
                                        $order_status[strtolower((string) $third_gen->getName())] = (int) $third_gen;
                                        break;

                                    case "sparenumber1":
                                        //Treat as numbers
                                        $order_status[strtolower((string) $third_gen->getName())] = (float) $third_gen;
                                        break;

                                    case "sparebit1":
                                        //Treat as booleans
                                        $order_status[strtolower((string) $third_gen->getName())] = (boolean)(int) $third_gen;
                                        break;

                                    default:
                                        //Treat everything else as a string
                                        $order_status[strtolower((string) $third_gen->getName())] = (string) $third_gen;
                                        break;
                                }
                            }
                        }

            }
        
        return $order_status;

    }

    private function getOrderStatusId($status = "") {
	    $sql = "SELECT order_status_id FROM `" . DB_PREFIX . "order_status` WHERE name = '" . $status . "' AND language_id = '" . (int)$this->languageId . "'";
	    $result = $this->db->query($sql);
	    if ($result->rows) {
		return (int) $result->rows[0]['order_status_id'];
	    }

        return false;
    }
}
?>

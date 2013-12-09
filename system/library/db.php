<?php

include DIR_SYSTEM . 'library/log.php';

class DB {
	private $driver;
        
        private $audit;
	private $auditLevel = 1; // 1 == not selects, 2 == all;
	private $auditStats = false;
        
        private $auditUsername = "unknown";
	
	public function __construct($driver, $hostname, $username, $password, $database) {
		if (file_exists(DIR_DATABASE . $driver . '.php')) {
			require_once(DIR_DATABASE . $driver . '.php');
		} else {
			exit('Error: Could not load database file ' . $driver . '!');
		}
                
                $this->audit = new Log(date("Y-m-d") . "-audit.log");
				
		$this->driver = new $driver($hostname, $username, $password, $database);
	}
		
  	public function query($sql) {
            if ($this->auditLevel)
            {
                if ($this->auditLevel == 2 || strpos($sql, "SELECT ", 0) === FALSE) {

                    if ($this->auditStats)
                    {
                        $msc = microtime(true);

                        $query = $this->driver->query($sql, $this->auditUsername);

                        $msc = microtime(true)-$msc;
                        $stats = ':'.round($msc,4).' seconds';

                        if (strpos(trim($sql), "SELECT ", 0) === 0)
                        {
                            $stats .= ':' . $query->num_rows . ' rows';
                        }

                        $this->audit->write($this->auditUsername . "[" . $_SERVER['REMOTE_ADDR'] . "]:" . $sql . $stats);

                        return $query;

                    } else {
                        $this->audit->write($this->auditUsername . "[" . $_SERVER['REMOTE_ADDR'] . "]:" . $sql);
                    }
                }
            }
            
            return $this->driver->query($sql, $this->auditUsername);
  	}
	
	public function escape($value) {
		return $this->driver->escape($value);
	}
	
  	public function countAffected() {
		return $this->driver->countAffected();
  	}

  	public function getLastId() {
		return $this->driver->getLastId();
  	}
        
        public function setAuditUsername($username) {
            $this->auditUsername = $username;
        }
        
	public function setAudit($audit_level, $audit_stats) {
            $this->auditLevel = $audit_level;
            $this->auditStats = $audit_stats;
	}
}
?>
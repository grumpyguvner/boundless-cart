<?php
class Cache { 
	private $expire;
	private $queue;
        
       public function __construct ($expire = 3600)
       {
           $this->expire = $expire;
           $this->queue = false;
       }

	public function get($key) {
            if ($this->queue === false)
            {
		$files = glob(DIR_CACHE . 'cache.' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.*');

		if ($files) {
			$cache = file_get_contents($files[0]);
			
			$data = unserialize($cache);
			
			foreach ($files as $file) {
				$time = substr(strrchr($file, '.'), 1);

      			if ($time < time()) {
					if (file_exists($file)) {
						unlink($file);
					}
      			}
    		}
			
			return $data;			
		}
            }
	}

  	public function set($key, $value) {
            if ($this->queue === false)
            {
                $this->delete($key);

                $file = DIR_CACHE . 'cache.' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.' . (time() + $this->expire);

                $handle = fopen($file, 'w');

                fwrite($handle, serialize($value));

                fclose($handle);
            }
    
  	}
	
  	public function delete($key) {
            if (is_array($this->queue))
            {
                $this->queue[] = $key;
            } else {
		$files = glob(DIR_CACHE . 'cache.' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.*');
		
		if ($files) {
    		foreach ($files as $file) {
      			if (file_exists($file)) {
					unlink($file);
				}
    		}
		}
            }
  	}
        
  	public function setQueue($queue = false) {
            $this->flushQueue();
            
            if ($queue)
            {
                $this->queue = array();
            } else {
                $this->queue = false;
            }
  	}
        
  	public function flushQueue() {
            if (is_array($this->queue)) 
            {
                foreach ($this->queue as $key)
                {
                    $this->delete($key);
                }
            }
  	}

        function __destruct() {
            $this->flushQueue();
        }
}
?>
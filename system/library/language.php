<?php
class Language {
    private $default = 'english';
    private $directory;
    private $theme = array('default');
    private $data = array();
    private $db;
    private $config;
    private $language_manager = false;

    public function __construct($directory, $registry = null) {
        
        if (!is_null($registry))
        {
            $this->config = $registry->get('config');
            $this->db = $registry->get('db');
            
            if ($this->config->get("config_base_template") && !in_array($this->config->get("config_base_template"), $this->theme)) 
            {
                $this->theme[] = $this->config->get("config_base_template");
            }
            if ($this->config->get("config_template") && !in_array($this->config->get("config_template"), $this->theme)) 
            {
                $this->theme[] = $this->config->get("config_template");
            }
            $this->language_manager = ($this->config->get("language_manager_status")) ? true : false;
        }
        
        $this->directory = $directory;
    }

    public function get($key) {
        return (isset($this->data[$key]) ? $this->data[$key] : $key);
    }

    public function load($filename) {
        
        $files = array(DIR_LANGUAGE . $this->default . '/' . $filename . '.php',
                       DIR_LANGUAGE . $this->directory . '/' . $filename . '.php');
        
        foreach ($this->theme as $theme)
        {
            $files[] = DIR_TEMPLATE . $theme . "/language/" . $this->directory . '/' . $filename . '.php';
        }
        
        foreach ($files as $file)
        {
            if (file_exists($file)) {
                $_ = array();

                require($file);

                $this->data = array_merge($this->data, $_);
            }
        }
        
        if ($this->language_manager)
        {
            $sql  = "SELECT name, value "
                  . "FROM `".DB_PREFIX."language_manager` "
                  . "WHERE directory = '" . $this->db->escape($this->directory) . "' "
                  . "AND filename = '" . $this->db->escape($filename) . "'";
            $query = $this->db->query($sql);
            if ($query->num_rows > 0)
            {
                foreach ($query->row as $row)
                {
                    $this->data[$row['name']] = $row['value'];
                }
            }
        }
        
        return $this->data;
    }
}
?>
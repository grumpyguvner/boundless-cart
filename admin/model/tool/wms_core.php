<?php

ini_set('max_execution_time', 0);

static $config = NULL;
static $log = NULL;

// Error Handler
function error_handler_for_wms($errno, $errstr, $errfile, $errline) {
    global $config;
    global $log;

    switch ($errno) {
        case E_NOTICE:
        case E_USER_NOTICE:
            $errors = "Notice";
            break;
        case E_WARNING:
        case E_USER_WARNING:
            $errors = "Warning";
            break;
        case E_ERROR:
        case E_USER_ERROR:
            $errors = "Fatal Error";
            break;
        default:
            $errors = "Unknown";
            break;
    }

    if (($errors == 'Warning') || ($errors == 'Unknown')) {
        return true;
    }

    if ($config->get('config_error_display')) {
        echo '<b>' . $errors . '</b>: ' . $errstr . ' in <b>' . $errfile . '</b> on line <b>' . $errline . '</b>';
    }

    if ($config->get('config_error_log')) {
        $log->write('PHP ' . $errors . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
    }

    return true;
}

function fatal_error_shutdown_handler_for_wms() {
    $last_error = error_get_last();
    if ($last_error['type'] === E_ERROR) {
        // fatal error
        error_handler_for_wms(E_ERROR, $last_error['message'], $last_error['file'], $last_error['line']);
    }
}

/**
 * File contains just the base class
 *
 * @package classes
 * @copyright Copyright 2003-2009 Zen Cart Development Team
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: class.base.php 14535 2009-10-07 22:16:19Z wilt $
 */

/**
 * abstract class base
 *
 * any class that wants to notify or listen for events must extend this base class
 *
 * @package classes
 */
class base {

    /**
     * method used to an attach an observer to the notifier object
     * 
     * NB. We have to get a little sneaky here to stop session based classes adding events ad infinitum
     * To do this we first concatenate the class name with the event id, as a class is only ever going to attach to an
     * event id once, this provides a unigue key. To ensure there are no naming problems with the array key, we md5 the unique
     * name to provide a unique hashed key. 
     * 
     * @param object Reference to the observer class
     * @param array An array of eventId's to observe
     */
    function attach(&$observer, $eventIDArray) {
        foreach ($eventIDArray as $eventID) {
            $nameHash = md5(get_class($observer) . $eventID);
            base::setStaticObserver($nameHash, array('obs' => &$observer, 'eventID' => $eventID));
        }
    }

    /**
     * method used to detach an observer from the notifier object
     * @param object
     * @param array
     */
    function detach($observer, $eventIDArray) {
        foreach ($eventIDArray as $eventID) {
            $nameHash = md5(get_class($observer) . $eventID);
            base::unsetStaticObserver($nameHash);
        }
    }

    /**
     * method to notify observers that an event as occurred in the notifier object
     * 
     * @param string The event ID to notify for
     * @param array paramters to pass to the observer, useful for passing stuff which is outside of the 'scope' of the observed class.
     */
    function notify($eventID, $paramArray = array()) {
        $observers = & base::getStaticObserver();
        if (!is_null($observers)) {
            foreach ($observers as $key => $obs) {
                if ($obs['eventID'] == $eventID) {
                    $obs['obs']->update($this, $eventID, $paramArray);
                }
            }
        }
    }

    function & getStaticProperty($var) {
        static $staticProperty;
        return $staticProperty;
    }

    function & getStaticObserver() {
        return base::getStaticProperty('observer');
    }

    function & setStaticObserver($element, $value) {
        $observer = & base::getStaticObserver();
        $observer[$element] = $value;
    }

    function & unsetStaticObserver($element) {
        $observer = & base::getStaticObserver();
        unset($observer[$element]);
    }

}

/**
 * Queryfactory - A simple database abstraction layer
 *
 */
class queryFactory extends base {

    var $link, $count_queries, $total_query_time;

    function queryFactory() {
        $this->count_queries = 0;
        $this->total_query_time = 0;
    }

    function connect($zf_host, $zf_user, $zf_password, $zf_database, $zf_pconnect = 'false', $zp_real = false) {
        $this->database = $zf_database;
        $this->user = $zf_user;
        $this->host = $zf_host;
        $this->password = $zf_password;
        $this->pConnect = $zf_pconnect;
        $this->real = $zp_real;
        if (!function_exists('mysql_connect'))
            die('Call to undefined function: mysql_connect().  Please install the MySQL Connector for PHP');
        $connectionRetry = 10;
        while (!isset($this->link) || ($this->link == FALSE && $connectionRetry != 0)) {
            $this->link = @mysql_connect($zf_host, $zf_user, $zf_password, true);
            $connectionRetry--;
        }
        if ($this->link) {
            if (@mysql_select_db($zf_database, $this->link)) {
                if (defined('DB_CHARSET') && version_compare(@mysql_get_server_info(), '4.1.0', '>=')) {
                    @mysql_query("SET NAMES '" . DB_CHARSET . "'", $this->link);
                    if (function_exists('mysql_set_charset')) {
                        @mysql_set_charset(DB_CHARSET, $this->link);
                    } else {
                        @mysql_query("SET CHARACTER SET '" . DB_CHARSET . "'", $this->link);
                    }
                }
                $this->db_connected = true;
                return true;
            } else {
                $this->set_error(mysql_errno(), mysql_error(), $zp_real);
                return false;
            }
        } else {
            $this->set_error(mysql_errno(), mysql_error(), $zp_real);
            return false;
        }
    }

    function selectdb($zf_database) {
        @mysql_select_db($zf_database, $this->link);
    }

    function prepare_input($zp_string) {
        if (function_exists('mysql_real_escape_string')) {
            return mysql_real_escape_string($zp_string, $this->link);
        } elseif (function_exists('mysql_escape_string')) {
            return mysql_escape_string($zp_string, $this->link);
        } else {
            return addslashes($zp_string);
        }
    }

    function close() {
        @mysql_close($this->link);
    }

    function set_error($zp_err_num, $zp_err_text, $zp_fatal = true) {
        $this->error_number = $zp_err_num;
        $this->error_text = $zp_err_text;
        if ($zp_fatal && $zp_err_num != 1141) { // error 1141 is okay ... should not die on 1141, but just continue on instead
            $this->show_error();
            die();
        }
    }

    function show_error() {
        if ($this->error_number == 0 && $this->error_text == DB_ERROR_NOT_CONNECTED && !headers_sent() && file_exists('nddbc.html'))
            include('nddbc.html');
        echo '<div class="systemError">';
        echo $this->error_number . ' ' . $this->error_text;
        echo '<br />in:<br />[' . (strstr($this->zf_sql, 'db_cache') ? 'db_cache table' : $this->zf_sql) . ']<br />';
        if (defined('IS_ADMIN_FLAG') && IS_ADMIN_FLAG == true)
            echo 'If you were entering information, press the BACK button in your browser and re-check the information you had entered to be sure you left no blank fields.<br />';
        echo '</div>';
    }

    function Execute($zf_sql, $zf_limit = false, $zf_cache = false, $zf_cachetime = 0) {
        // bof: collect database queries
        if (defined('STORE_DB_TRANSACTIONS') && STORE_DB_TRANSACTIONS == 'true') {
            global $PHP_SELF, $box_id, $current_page_base;
            if (strtoupper(substr($zf_sql, 0, 6)) == 'SELECT' /* && strstr($zf_sql,'products_id') */) {
                $f = @fopen(DIR_FS_SQL_CACHE . '/query_selects_' . $current_page_base . '_' . time() . '.txt', 'a');
                if ($f) {
                    fwrite($f, "\n\n" . 'I AM HERE ' . $current_page_base . /* zen_get_all_get_params() . */ "\n" . 'sidebox: ' . $box_id . "\n\n" . "Explain \n" . $zf_sql . ";\n\n");
                    fclose($f);
                }
                unset($f);
            }
        }
        // eof: collect products_id queries
        global $zc_cache;
        if ($zf_limit) {
            $zf_sql = $zf_sql . ' LIMIT ' . $zf_limit;
        }
        $this->zf_sql = $zf_sql;
        if ($zf_cache AND $zc_cache->sql_cache_exists($zf_sql) AND !$zc_cache->sql_cache_is_expired($zf_sql, $zf_cachetime)) {
            $obj = new queryFactoryResult;
            $obj->cursor = 0;
            $obj->is_cached = true;
            $obj->sql_query = $zf_sql;
            $zp_result_array = $zc_cache->sql_cache_read($zf_sql);
            $obj->result = $zp_result_array;
            if (sizeof($zp_result_array) > 0) {
                $obj->EOF = false;
                while (list($key, $value) = each($zp_result_array[0])) {
                    $obj->fields[$key] = utf8_encode($value);
                }
                return $obj;
            } else {
                $obj->EOF = true;
            }
        } elseif ($zf_cache) {
            $zc_cache->sql_cache_expire_now($zf_sql);
            $time_start = explode(' ', microtime());
            $obj = new queryFactoryResult;
            $obj->sql_query = $zf_sql;
            if (!$this->db_connected) {
                if (!$this->connect($this->host, $this->user, $this->password, $this->database, $this->pConnect, $this->real))
                    $this->set_error('0', DB_ERROR_NOT_CONNECTED);
            }
            $zp_db_resource = @mysql_query($zf_sql, $this->link);
            if (!$zp_db_resource)
                $this->set_error(@mysql_errno(), @mysql_error());
            if (!is_resource($zp_db_resource)) {
                $obj = null;
                return true;
            }
            $obj->resource = $zp_db_resource;
            $obj->cursor = 0;
            $obj->is_cached = true;
            if ($obj->RecordCount() > 0) {
                $obj->EOF = false;
                $zp_ii = 0;
                while (!$obj->EOF) {
                    $zp_result_array = @mysql_fetch_array($zp_db_resource);
                    if ($zp_result_array) {
                        while (list($key, $value) = each($zp_result_array)) {
                            if (!preg_match('/^[0-9]/', $key)) {
                                $obj->result[$zp_ii][$key] = $value;
                            }
                        }
                    } else {
                        $obj->Limit = $zp_ii;
                        $obj->EOF = true;
                    }
                    $zp_ii++;
                }
                while (list($key, $value) = each($obj->result[$obj->cursor])) {
                    if (!preg_match('/^[0-9]/', $key)) {
                        $obj->fields[$key] = utf8_encode($value);
                    }
                }
                $obj->EOF = false;
            } else {
                $obj->EOF = true;
            }
            $zc_cache->sql_cache_store($zf_sql, $obj->result);
            $time_end = explode(' ', microtime());
            $query_time = $time_end[1] + $time_end[0] - $time_start[1] - $time_start[0];
            $this->total_query_time += $query_time;
            $this->count_queries++;
            return($obj);
        } else {
            $time_start = explode(' ', microtime());
            $obj = new queryFactoryResult;
            if (!$this->db_connected) {
                if (!$this->connect($this->host, $this->user, $this->password, $this->database, $this->pConnect, $this->real))
                    $this->set_error('0', DB_ERROR_NOT_CONNECTED);
            }
            $zp_db_resource = @mysql_query($zf_sql, $this->link);
            if (!$zp_db_resource)
                $this->set_error(@mysql_errno($this->link), @mysql_error($this->link));
            if (!is_resource($zp_db_resource)) {
                $obj = null;
                return true;
            }
            $obj->resource = $zp_db_resource;
            $obj->cursor = 0;
            if ($obj->RecordCount() > 0) {
                $obj->EOF = false;
                $zp_result_array = @mysql_fetch_array($zp_db_resource);
                if ($zp_result_array) {
                    while (list($key, $value) = each($zp_result_array)) {
                        if (!preg_match('/^[0-9]/', $key)) {
                            $obj->fields[$key] = utf8_encode($value);
                        }
                    }
                    $obj->EOF = false;
                } else {
                    $obj->EOF = true;
                }
            } else {
                $obj->EOF = true;
            }

            $time_end = explode(' ', microtime());
            $query_time = $time_end[1] + $time_end[0] - $time_start[1] - $time_start[0];
            $this->total_query_time += $query_time;
            $this->count_queries++;
            return($obj);
        }
    }

    function ExecuteRandomMulti($zf_sql, $zf_limit = 0, $zf_cache = false, $zf_cachetime = 0) {
        $this->zf_sql = $zf_sql;
        $time_start = explode(' ', microtime());
        $obj = new queryFactoryResult;
        $obj->result = array();
        if (!$this->db_connected) {
            if (!$this->connect($this->host, $this->user, $this->password, $this->database, $this->pConnect, $this->real))
                $this->set_error('0', DB_ERROR_NOT_CONNECTED);
        }
        $zp_db_resource = @mysql_query($zf_sql, $this->link);
        if (!$zp_db_resource)
            $this->set_error(mysql_errno(), mysql_error());
        if (!is_resource($zp_db_resource)) {
            $obj = null;
            return true;
        }
        $obj->resource = $zp_db_resource;
        $obj->cursor = 0;
        $obj->Limit = $zf_limit;
        if ($obj->RecordCount() > 0 && $zf_limit > 0) {
            $obj->EOF = false;
            $zp_Start_row = 0;
            if ($zf_limit) {
                $zp_start_row = zen_rand(0, $obj->RecordCount() - $zf_limit);
            }
            $obj->Move($zp_start_row);
            $obj->Limit = $zf_limit;
            $zp_ii = 0;
            while (!$obj->EOF) {
                $zp_result_array = @mysql_fetch_array($zp_db_resource);
                if ($zp_ii == $zf_limit)
                    $obj->EOF = true;
                if ($zp_result_array) {
                    while (list($key, $value) = each($zp_result_array)) {
                        $obj->result[$zp_ii][$key] = $value;
                    }
                } else {
                    $obj->Limit = $zp_ii;
                    $obj->EOF = true;
                }
                $zp_ii++;
            }
            $obj->result_random = array_rand($obj->result, sizeof($obj->result));
            if (is_array($obj->result_random)) {
                $zp_ptr = $obj->result_random[$obj->cursor];
            } else {
                $zp_ptr = $obj->result_random;
            }
            while (list($key, $value) = each($obj->result[$zp_ptr])) {
                if (!preg_match('/^[0-9]/', $key)) {
                    $obj->fields[$key] = utf8_encode($value);
                }
            }
            $obj->EOF = false;
        } else {
            $obj->EOF = true;
        }


        $time_end = explode(' ', microtime());
        $query_time = $time_end[1] + $time_end[0] - $time_start[1] - $time_start[0];
        $this->total_query_time += $query_time;
        $this->count_queries++;
        return($obj);
    }

    function insert_ID() {
        return @mysql_insert_id($this->link);
    }

    function metaColumns($zp_table) {
        $res = @mysql_query("select * from " . $zp_table . " limit 1", $this->link);
        $num_fields = @mysql_num_fields($res);
        for ($i = 0; $i < $num_fields; $i++) {
            $obj[strtoupper(@mysql_field_name($res, $i))] = new queryFactoryMeta($i, $res);
        }
        return $obj;
    }

    function get_server_info() {
        if ($this->link) {
            return mysql_get_server_info($this->link);
        } else {
            return UNKNOWN;
        }
    }

    function queryCount() {
        return $this->count_queries;
    }

    function queryTime() {
        return $this->total_query_time;
    }

    function perform($tableName, $tableData, $performType = 'INSERT', $performFilter = '', $debug = false) {
        switch (strtolower($performType)) {
            case 'insert':
                $insertString = "";
                $insertString = "INSERT INTO " . $tableName . " (";
                foreach ($tableData as $key => $value) {
                    if ($debug === true) {
                        echo $value['fieldName'] . '#';
                    }
                    $insertString .= $value['fieldName'] . ", ";
                }
                $insertString = substr($insertString, 0, strlen($insertString) - 2) . ') VALUES (';
                reset($tableData);
                foreach ($tableData as $key => $value) {
                    $bindVarValue = $this->getBindVarValue($value['value'], $value['type']);
                    $insertString .= $bindVarValue . ", ";
                }
                $insertString = substr($insertString, 0, strlen($insertString) - 2) . ')';
                if ($debug === true) {
                    echo $insertString;
                    die();
                } else {
                    $this->execute($insertString);
                }
                break;
            case 'update':
                $updateString = "";
                $updateString = 'UPDATE ' . $tableName . ' SET ';
                foreach ($tableData as $key => $value) {
                    $bindVarValue = $this->getBindVarValue($value['value'], $value['type']);
                    $updateString .= $value['fieldName'] . '=' . $bindVarValue . ', ';
                }
                $updateString = substr($updateString, 0, strlen($updateString) - 2);
                if ($performFilter != '') {
                    $updateString .= ' WHERE ' . $performFilter;
                }
                if ($debug === true) {
                    echo $updateString;
                    die();
                } else {
                    $this->execute($updateString);
                }
                break;
        }
    }

    function getBindVarValue($value, $type) {
        $typeArray = explode(':', $type);
        $type = $typeArray[0];
        switch ($type) {
            case 'csv':
                return $value;
                break;
            case 'passthru':
                return $value;
                break;
            case 'float':
                return (!zen_not_null($value) || $value == '' || $value == 0) ? 0 : $value;
                break;
            case 'integer':
                return (int) $value;
                break;
            case 'string':
                if (isset($typeArray[1])) {
                    $regexp = $typeArray[1];
                }
                return '\'' . $this->prepare_input($value) . '\'';
                break;
            case 'noquotestring':
                return $this->prepare_input($value);
                break;
            case 'currency':
                return '\'' . $this->prepare_input($value) . '\'';
                break;
            case 'date':
                return '\'' . $this->prepare_input($value) . '\'';
                break;
            case 'enum':
                if (isset($typeArray[1])) {
                    $enumArray = explode('|', $typeArray[1]);
                }
                return '\'' . $this->prepare_input($value) . '\'';
            case 'regexp':
                $searchArray = array('[', ']', '(', ')', '{', '}', '|', '*', '?', '.', '$', '^');
                foreach ($searchArray as $searchTerm) {
                    $value = str_replace($searchTerm, '\\' . $searchTerm, $value);
                }
                return $this->prepare_input($value);
            default:
                die('var-type undefined: ' . $type . '(' . $value . ')');
        }
    }

    /**
     * method to do bind variables to a query
     * */
    function bindVars($sql, $bindVarString, $bindVarValue, $bindVarType, $debug = false) {
        $bindVarTypeArray = explode(':', $bindVarType);
        $sqlNew = $this->getBindVarValue($bindVarValue, $bindVarType);
        $sqlNew = str_replace($bindVarString, $sqlNew, $sql);
        return $sqlNew;
    }

    function prepareInput($string) {
        return $this->prepare_input($string);
    }

}

class queryFactoryResult {

    function queryFactoryResult() {
        $this->is_cached = false;
    }

    function MoveNext() {
        global $zc_cache;
        $this->cursor++;
        if ($this->is_cached) {
            if ($this->cursor >= sizeof($this->result)) {
                $this->EOF = true;
            } else {
                while (list($key, $value) = each($this->result[$this->cursor])) {
                    $this->fields[$key] = utf8_encode($value);
                }
            }
        } else {
            $zp_result_array = @mysql_fetch_array($this->resource);
            if (!$zp_result_array) {
                $this->EOF = true;
            } else {
                while (list($key, $value) = each($zp_result_array)) {
                    if (!preg_match('/^[0-9]/', $key)) {
                        $this->fields[$key] = utf8_encode($value);
                    }
                }
            }
        }
    }

    function MoveNextRandom() {
        $this->cursor++;
        if ($this->cursor < $this->Limit) {
            $zp_result_array = $this->result[$this->result_random[$this->cursor]];
            while (list($key, $value) = each($zp_result_array)) {
                if (!preg_match('/^[0-9]/', $key)) {
                    $this->fields[$key] = utf8_encode($value);
                }
            }
        } else {
            $this->EOF = true;
        }
    }

    function RecordCount() {
        return @mysql_num_rows($this->resource);
    }

    function Move($zp_row) {
        global $db;
        if (@mysql_data_seek($this->resource, $zp_row)) {
            $zp_result_array = @mysql_fetch_array($this->resource);
            while (list($key, $value) = each($zp_result_array)) {
                $this->fields[$key] = utf8_encode($value);
            }
            @mysql_data_seek($this->resource, $zp_row);
            $this->EOF = false;
            return;
        } else {
            $this->EOF = true;
            $db->set_error(mysql_errno(), mysql_error());
        }
    }

}

class queryFactoryMeta {

    function queryFactoryMeta($zp_field, $zp_res) {
        $this->type = @mysql_field_type($zp_res, $zp_field);
        $this->max_length = @mysql_field_len($zp_res, $zp_field);
    }

}

/* * ************* database functions *********** */

function dbconnect() {
    global $sys_dbhost, $sys_dbuser, $sys_dbpass, $sys_dbname, $query_count, $connectStatus;
    mysql_connect($sys_dbhost, $sys_dbuser, $sys_dbpass);
    $query_count++;
    @mysql_select_db($sys_dbname) or die("Unable to select database");
    $connectStatus = true;
}

function query_db($query) {
    global $sqlQLog, $connectStatus;
    if ($connectStatus <> true) {
        dbconnect();
    }
    $sqlQLog[] = $query;
    return @mysql_query($query);
}

function create_array($type, $table, $fields, $criteria, $output_type = "default", $key = "", $value = "") {
    $data = array();
    $error = 'Array Creation Error';
    $sql = 'SELECT ' . $type . ' ' . $fields . ' FROM ' . $table . ' ' . $criteria;
    //echo $sql;
    $result = query_db($sql) or die($error . '<br /><small>( ' . $sql . ' )<br />( ' . mysql_error() . ' )</small>');

    if ($result != false && $result != $error) {
        while ($dataset = mysql_fetch_assoc($result)) {
            switch ($output_type) {
                case 'default': $data[] = $dataset;
                    break;
                case 'single': $data = $dataset;
                    break;
                case 'sequence': $data[] = $dataset[$key];
                    break;
                case 'key': $data[$dataset[$key]][] = $dataset;
                    break;
                case 'single key': $data[$dataset[$key]] = $dataset;
                    break;
                case 'single key value': $data[$dataset[$key]] = $dataset[$value];
                    break;
                case 'multi':
                    $keys = explode(",", $key);

                    foreach ($keys as $k) {
                        $kData = explode(":", $k);
                        if ($kData[1] <> 0) {
                            $l = $dataset[$kData[1]];
                        } else {
                            $l = null;
                        }
                        $data[$dataset[$kData[0]]][$dataset[$kData[1]]][] = $dataset;
                    }
                    break;
            }
        }
        mysql_free_result($result);
    } else {
        $data[] = $error;
    }
    return $data;
}

function seoUrl($string) {
    //Unwanted:  {UPPERCASE} ; / ? : @ & = + $ , . ! ~ * ' ( )
    $string = strtolower($string);
    //Strip any unwanted characters
    $string = preg_replace("/[^a-z0-9_\s-]/", "", $string);
    //Clean multiple dashes or whitespaces
    $string = preg_replace("/[\s-]+/", " ", $string);
    //Convert whitespaces and underscore to dash
    $string = preg_replace("/[\s_]/", "-", $string);
    return $string;
}

function grab_image($url, $saveto) {
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_BINARYTRANSFER, 1);
    $raw = curl_exec($ch);
    curl_close($ch);
    if (file_exists($saveto)) {
        unlink($saveto);
    }
    $fp = fopen($saveto, 'x');
    fwrite($fp, $raw);
    fclose($fp);
}

class ModelToolWMS extends Model {

    public $debugMode = false;
    public $languageId = 0;
    public $languageFr = 0;
    public $size_option_id = 0;

    function __construct($registry) {
        parent::__construct($registry);

        // we use our own error handler
        global $config;
        global $log;
        $config = $this->config;
        $log = $this->log;

        set_error_handler('error_handler_for_wms', E_ALL);
        register_shutdown_function('fatal_error_shutdown_handler_for_wms');

        $this->debug("initializing database");

        $sys_dbhost = $this->config->get('wms_host');
        $sys_dbuser = $this->config->get('wms_user');
        $sys_dbpass = $this->config->get('wms_password');
        $sys_dbname = $this->config->get('wms_name');

        $this->dbQF = new queryFactory();
        if (!$this->dbQF->connect($sys_dbhost, $sys_dbuser, $sys_dbpass, $sys_dbname, false, false)) {
            //    echo "No Connection';
            die('No Database Connection');
        }
        $this->debug("database initialized");

        $this->languageId = $this->getDefaultLanguageId();
        $this->languageFr = 2;
    }

    protected function debug($message) {
        if ($this->debugMode) {
            $this->log->write($message);
            echo $message . "<br/>\n";
        }
    }

    protected function getDefaultLanguageId() {
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

    protected function runSchedulerOperation() {
        
    }

    protected function tableLookUp($table, $return, $search) {

        $sql = 'SELECT ' . $return . ' as value FROM ' . $table;

        $implode = array();

        foreach ($search as $field => $value) {
            $implode[] = $field . " = '" . $this->db->escape($value) . "'";
        }
        if (!empty($implode))
            $sql .= " WHERE " . implode(' AND ', $implode);

        $sql .= ' LIMIT 1';

        $result = $this->db->query($sql);

        if ($result->num_rows) {
            return $result->row['value'];
        }
        return 0;
    }

}

<?php
class ModelToolContentEmbed extends Model {
    function convert_placeholders ($text) {
        preg_match_all('%\[(.*)\]%isU', $text, $matches);
        foreach ($matches[0] as $key => $match)
        {
            $replacement = false;
            
            $placeholder = explode(':', $matches[1][$key]);
            
            switch ($placeholder[0])
            {
                case 'module':
                    
                    $module = strtok($placeholder[1], '?');
                    $query = strtok('?');

                    parse_str(html_entity_decode($query), $args);
                    
                    $action = new Action('common/content_embed');
                    
                    if (file_exists($action->getFile())) {
                        require_once($action->getFile());

                        $class = $action->getClass();

                        $controller = new $class($this->registry);

                        $replacement = $controller->index('module/' . $module, $args);
                    }
                    
                    break;
            }
            
            if ($replacement !== false) $text = str_replace($match, $replacement, $text);
        }
        return $text;
    }
    
    private function execute($child, $args = array()) {
        
        $action = new Action($child, $args);
        
        if (file_exists($action->getFile())) {
            require_once($action->getFile());

            $class = $action->getClass();

            $controller = new $class($this->registry);

            if (is_callable(array($controller, $action->getMethod()))) {
                return call_user_func_array(array($controller, $action->getMethod()), $action->getArgs());
            } else {
                return false;
            }
        }

        return false;
    }
}